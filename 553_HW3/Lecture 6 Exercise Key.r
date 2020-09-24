#========================================
#Lecture 7, FISH553 Advanced R
#Likelihood profiles, confidence intervals,
#use of uniroot and mle2
#Trevor A. Branch, tbranch@uw.edu
#========================================

#The NLL code 
VB.NLL <- function(Linfinity, K, sigma) {
   gender <- "Male"
   LA <- read.csv(file="Data//LengthAge.csv")
   ages <- LA[LA$Gender==gender,]$Ages
   lengths <- LA[LA$Gender==gender,]$Lengths
   model.predL <- Linfinity*(1-exp(-K*ages))
   ndata <- length(ages)
   NLL <- -sum(dnorm(x=lengths, 
                     mean=model.predL,sd=sigma,log=TRUE))
   return(NLL)
}
#model fitting
require(bbmle)
MLE.res <- mle2(minuslogl=VB.NLL, 
     start=list(Linfinity=50, K=0.2, sigma=10), 
     method="L-BFGS-B", 
     lower=list(Linfinity=20, K=0.02, sigma=0.1),
     upper=list(Linfinity=500, K=1, sigma=100))
(bestNLL <- -1*logLik(MLE.res)[1])   #because returns log likelihood 
coef(MLE.res)   #best model estimates

#========In-class exercise 1: likelihood profile============
#=======for males=========================================
Linf.values <- seq(80,130,1)  #sequence of values for Linf

nLinf <- length(Linf.values)
profNLL <- rep(NA,length=nLinf)
ylim <- c(180, 230)
for (i in 1:nLinf) {
   temp <- mle2(minuslogl=VB.NLL, 
                   start=list(K=0.2, sigma=10), 
                   method="L-BFGS-B", 
                   lower=list(K=0.02, sigma=0.1),
                   upper=list(K=1, sigma=100),
                   fixed=list(Linfinity=Linf.values[i]))
   profNLL[i] <- -1*logLik(temp)[1]
   plot(x=Linf.values, y=profNLL, type="o", lwd=2, cex=1, pch=19, 
        xlab="Linfinity (cm)", ylab="Profile -lnL", ylim=ylim)
   if (i %% 10 ==0) {
     print(paste(i, nLinf, Linf.values[i]))
   }
}
#temp
#length(coef(temp))
#AIC = 2*length(coef(temp)) -2*logLik(temp)[1]
#AIC

plot(x=Linf.values, y=profNLL, type="o", lwd=2, cex=1, pch=19, 
     xlab="Linfinity (cm)", ylab="Profile -lnL")
plot(x=Linf.values, y=profNLL-bestNLL, type="o", lwd=2, cex=1, pch=19, 
     xlab="Linfinity (cm)", ylab="Profile -lnL")
plot(x=Linf.values, y=profNLL-bestNLL-1.92, type="o", lwd=2, cex=1, pch=19, 
     xlab="Linfinity (cm)", ylab="Profile -lnL")
abline(h=0, lty=2, lwd=2)


#========in-class exercise 2: uniroot and CI====================
#======MALES====================================
#model fitting
require(bbmle)
MLE.res <- mle2(minuslogl=VB.NLL, 
                start=list(Linfinity=50, K=0.2, sigma=10), 
                method="L-BFGS-B", 
                lower=list(Linfinity=20, K=0.02, sigma=0.1),
                upper=list(Linfinity=500, K=1, sigma=100))

VB.uni <- function(Linfinity, bestNLL, targetNLL=1.92) {
   temp <- mle2(minuslogl=VB.NLL, 
        start=list(K=0.2, sigma=10), 
        method="L-BFGS-B", 
        lower=list(K=0.02, sigma=0.1),
        upper=list(K=1, sigma=100),
        fixed=list(Linfinity=Linfinity))
   tempNLL <- -1*logLik(temp)[1]
   return(tempNLL-bestNLL-targetNLL)
}
#check to make sure we are bracketing the function
#should return zero where 1.92 units from bestNLL
(bestNLL <- -1*logLik(MLE.res)[1])   #because returns log likelihood 
coef(MLE.res)   #best model estimates
VB.uni(Linfinity=97, bestNLL=bestNLL, targetNLL=1.92)
VB.uni(Linfinity=98, bestNLL=bestNLL, targetNLL=1.92)
VB.uni(Linfinity=99, bestNLL=bestNLL, targetNLL=1.92)
VB.uni(Linfinity=100, bestNLL=bestNLL, targetNLL=1.92)
VB.uni(Linfinity=101, bestNLL=bestNLL, targetNLL=1.92)
#by trial and error this is the lower 95% bound
VB.uni(Linfinity=98.5788, bestNLL=bestNLL, targetNLL=1.92)

#call uniroot
uniroot(f=VB.uni, lower=80, upper=coef(MLE.res)[1], 
        bestNLL=bestNLL, targetNLL=1.92)
uniroot(f=VB.uni, lower=coef(MLE.res)[1], upper=150, 
        bestNLL=bestNLL, targetNLL=1.92)





#========likelihood profile for FEMALES================
VB.NLL.female <- function(Linfinity, K, sigma) {
   gender <- "Female"
   LA <- read.csv(file="Data//LengthAge.csv")
   ages <- LA[LA$Gender==gender,]$Ages
   lengths <- LA[LA$Gender==gender,]$Lengths
   model.predL <- Linfinity*(1-exp(-K*ages))
   ndata <- length(ages)
   NLL <- -sum(dnorm(x=lengths, 
                     mean=model.predL,sd=sigma,log=TRUE))
   return(NLL)
}
MLE.res.female <- mle2(minuslogl=VB.NLL.female, 
                start=list(Linfinity=50, K=0.2, sigma=10), 
                method="L-BFGS-B", 
                lower=list(Linfinity=20, K=0.02, sigma=0.1),
                upper=list(Linfinity=500, K=1, sigma=100))
(bestNLL.female <- -1*logLik(MLE.res.female)[1])   #because returns log likelihood 

Linf.values.female <- seq(60,110,1)  #sequence of values for Linf

nLinf <- length(Linf.values.female)
profNLL.female <- vector(length=nLinf)
for (i in 1:nLinf) {
   temp <- mle2(minuslogl=VB.NLL.female, 
                start=list(K=0.2, sigma=10), 
                method="L-BFGS-B", 
                lower=list(K=0.02, sigma=0.1),
                upper=list(K=1, sigma=100),
                fixed=list(Linfinity=Linf.values.female[i]))
   profNLL.female[i] <- -1*logLik(temp)[1]
}

plot(x=Linf.values.female, y=profNLL.female, type="o", lwd=2, cex=1, pch=19, 
     xlab="Linfinity (cm)", ylab="Profile -lnL")

#plot both profiles together to compare -- do they overlap???
plot(x=Linf.values, y=profNLL-bestNLL-1.92, type="o", lwd=2, cex=1, pch=19, 
     xlab="Linfinity (cm)", ylab="Profile -lnL", xlim=c(75,110), ylim=c(-2,2))
lines(x=Linf.values.female, y=profNLL.female-bestNLL.female-1.9, type='o', col=2, pch=19)
abline(h=0, lty=2, lwd=2)
legend(x='bottom', legend=c('Males', 'Females'), pch=19, col=c(1,2))


