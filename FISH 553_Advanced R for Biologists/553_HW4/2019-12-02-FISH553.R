## Exercise 1

f <- function(){
  return(10^3)
}

f()

g <- function(){
  return(f())
}

h <- function(){
  return(g())
}

i <- function(){
  return(h())
}

microbenchmark()
install.packages("microbenchmark")
library(microbenchmark)
?microbenchmark
#microbenchmark(10^3, f, g, h, i)
res <- microbenchmark(10^3, f(), g(), h(), i(), times=100)
plot(res, ylim=c(0,1000))
microbenchmark

res2 <- microbenchmark(10^3, f(), g(), h(), i(), times=500)
plot(res2, ylim=c(0,800))


## Exercise 2

?profile

slopes_function <- function(){
  
  slopes <- rep(NA, length=200)
  data <- read.csv("lecture7.csv", header=TRUE)
  for (i in 1:200) {
    one <- data[data$id==i,] 
    reg <- lm(y~x, data=one)
    slopes[i] <- coefficients(reg)[2]  
  }
}

#slopes_function()
Rprof()
slopes_function()
Rprof(NULL)
prof <- summaryRprof()
head(prof$by.total)


## Exercise 3

hindex <- function(citation.vec){
  #sorted.cites <- sort(citation.vec, decreasing=TRUE)
  h <- 0
  for (i in 1:length(citation.vec)){
    #print(i)
    #print(sorted.cites[i])
    h <- h + (i <= citation.vec[i])
  }
  return(h)
}

hindex(c(5,4,3,2,1,1,1,1))
hindex(c(10,6,6,6,6,6,6,6,6,6,6))

ices <- read.csv("ICES.csv")
cjfas <- read.csv("CJFAS.csv")

hindex.dist <- function(citation.vec, samples, niter){
  h.vector <- vector(length=niter)
  for (i in 1:niter){
    citation.sample <- sample(x=citation.vec, size=samples)
    sort(citation.sample, decreasing=TRUE)
    h.vector[i] <- hindex(citation.sample)
  }
  return(h.vector)
}

Y <- hindex.dist(ices$CitationsWOS,niter=1000, samples=100)
X <- hindex.dist(cjfas$CitationsWOS, niter=1000, samples=100)
CJFAS.better <- (X > Y)
pval <- sum(CJFAS.better)/1000

hist(Y)
hist(X)

