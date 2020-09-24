# Name: Andrew Chin
# Homework 4

#==Question 1a
cards <- function(ndraws=10000) {
deck <- paste(rep(x=c("1","2","3","4","5","6","7","8","9","10","J","Q","K","A"), times=4))
fourAce <- 0
for (i in 1:ndraws) {
   hand <- sample(x = deck, size = 7,
                  replace = FALSE)
   if (sum(hand == "A")==4) {
      fourAce <- fourAce+1
    }
   }
   cat("Number of hands with 4 aces", ":", (sum(fourAce)), "\n")
   cat("Probability of 4 aces:", (sum(fourAce)/ndraws), "%", "\n")
}
cards(ndraws = 10000)

#==Question 1b
game <- function(ndraws=10000, nplayers) {
   deck <- paste(rep(x=c("1","2","3","4","5","6","7","8","9","10","J","Q","K","A"), times=4))
fourAce <- 0
for (i in 1:ndraws) {
   hands <- sample(x = deck, size = 7*nplayers,
                  replace = FALSE)
   for (j in 1:nplayers){
      playerhand <- hands[7*j-6:(7*j)]
   if (sum(playerhand == "A")==4) {
      fourAce <- fourAce+1
            }
      }
   
}
cat("Number of hands with 4 aces", ":", (sum(fourAce)), "\n")
cat("Probability of 4 aces:", (sum(fourAce)/ndraws), "%", "\n")
}
game(ndraws = 10000, nplayers = 7)


#==Question 2
install.packages("microbenchmark")
library(microbenchmark)

func1 <- function(xvec) {
   function(xvec)
   return(xvec)
}
microbenchmark(func1, 100)


func2 <- function(xarray) {
  num.bigger <- 0
  for (i in 1:ncol(xarray)) {
    colmean <- mean(xarray[,i])
    if(colmean >0) {
      num.bigger <- num.bigger + 1
    }
  }
  return(num.bigger/ncol(xarray))
}
niter <- 1000
xarray <- matrix(data=rnorm(niter),ncol=100)
func2(xarray=xarray)
require(microbenchmark)
microbenchmark(sum(colMeans(xarray)>0))