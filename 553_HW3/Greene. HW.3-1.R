#Alanna Greene
#Homework 3
#Fish 553

#Q1 a 
 rickerdata<-read.csv("Downloads/HW3+Skeena+sockeye.csv")
 View(rickerdata)
 
 Ricker.curve<- function(Ricker.a, Ricker.b, sigma, filename) {
   rickerdata<- read.csv(file=filename)
   recruits<- (Ricker.a* rickerdata$Spawners) *exp(-Ricker.b*rickerdata$Spawners)
   nlgl_R <- -sum(dnorm(x= rickerdata$Recruits, mean=recruits, sd=sigma, log=TRUE))
   return(nlgl_R)
 }

 Ricker.curve(Ricker.a=5, Ricker.b=0.001, sigma=1000, filename ="Downloads/HW3+Skeena+sockeye.csv")

install.packages("bbmle")
require("bbmle")
 rickerlog<-mle2(minuslogl=Ricker.curve,
      start=list(Ricker.a=5, Ricker.b=0.001, sigma=1000),
      method="Nelder-Mead",
      data= list(filename= "Downloads/HW3+Skeena+sockeye.csv"))
 
 #Q2
 BevertonHolt<- function(BHa, BHb, sigma, filename) {
   BHdata<- read.csv(file=filename)
   bhR<- (BHa*BHdata$Spawners)/(BHb +BHdata$Spawners)
   nlgl_BH <- -sum(dnorm(x= BHdata$Recruits, mean=bhR, sd=sigma, log=TRUE))
   return(nlgl_BH)
 }
 
 BevertonHolt(BHa=5000, BHb= 1000, sigma = 1000, filename ="Downloads/HW3+Skeena+sockeye.csv")
 
 BevHlog<-mle2(minuslogl=BevertonHolt,
      start=list(BHa=5, BHb=0.001, sigma=1000),
      method="L-BFGS-B",
      data= list(filename= "Downloads/HW3+Skeena+sockeye.csv"))
 
 
 #Q3
 AIC<-function(lnL, p, n) {
   AIC<- 2*lnL+ 2*p + (2*p*(p+1))/(n-p-1)
   return(AIC)
 }
 
 AIC(lnL= -logLik(rickerlog), p= 3, n= length(rickerdata$Spawners))
 #RICKER: negative log- liklihood= -357.91, AIC= 722.4031, ***"better fit model"***
 
 AIC(lnL= -logLik(BevHlog), p= 3, n= length(rickerdata$Spawners))
 
 #BEVERTON-HOLT: negative log-liklihood= -358.31 , AIC= 723.215