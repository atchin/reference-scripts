# Name: Alanna Greene
# Homework 4

# Question 1a
cards <- function(ndraws=10000) {
  deck <- paste(rep(c("2", "3", "4", "5", "6", "7", "8", "9", "10", "Jack", "Queen", "King", "Ace"), 4))
  hands <- 0
  for (i in 1:ndraws) {
    newhand <- sample(x=deck,
                      size=7,replace=F)
    if (sum(newhand=="Ace")==4){
      hands <- hands+1
    }
  }
  return(hands/ndraws)
  cat("Probability of", ncard, card, ":", (sum(hands)/niter),"%", "\n")
  cat("Number of hands with", ncard, card, ":", sum(hands), "\n")
}
cards(ndraws=10000)

# Question 1b
playercards <- function(ndraws=10000, nplayers) {
  deck <- paste(rep(c("2", "3", "4", "5", "6", "7", "8", "9", "10", "Jack", "Queen", "King", "Ace"), 4))
  naces <- 0
  for (i in 1:ndraws) {
    newhand <- sample(x=deck,
                      size=7*nplayers,replace=F)
    for(j in 1:nplayers){
      playercards <- newhand[(7*j-6):(7*j)]
      if (sum(playercards=="Ace")==4){
        naces <- naces+1
      }
    }
  }
  return(naces/ndraws)
}

playercards(ndraws=1000000, nplayers = 7)

# Question 2
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
