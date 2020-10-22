# Name: Andrew Chin
# Homework 3

Skeena.sockeye <- read.csv(file = "C:\\Users\\Andrew Chin\\Documents\\UW AU19\\FISH 552_3\\FISH.552_workspace\\553_HW3\\HW3 Skeena sockeye.csv", header=T)

#==Question 1
# Ricker curve (Ricker 1954)
# R = a*S*exp(-b*S)
# R: recruits, S: spawners, a and b are growth parameters to estimate

Ricker.curve <- function(Ricker.a, Ricker.b, sigma, filename) {
   fishData <- read.csv(file = filename, header = T)
   spawners <- fishData[,"Spawners"]
   recruits <- fishData[,"Recruits"]
   nspawners <- length(spawners)
   eggcarton <- vector(length=nspawners)
   modelRicker <- Ricker.a*spawners*exp(-Ricker.b*spawners)
   Ricker.MLE <- -sum(dnorm(x=recruits, mean = modelRicker, sd=sigma, log=TRUE))
   cat("estimated MLE", Ricker.MLE)
}

Ricker.curve(Ricker.a = 5, Ricker.b = 0.001, sigma = 1000, filename = "C:\\Users\\Andrew Chin\\Documents\\UW AU19\\FISH 552_3\\FISH.552_workspace\\553_HW3\\HW3 Skeena sockeye.csv")

library("bbmle")
require("bbmle")
Ricker.MLE <- mle2(minuslogl = Ricker.curve,
         start = list(Ricker.a = 5, Ricker.b = 0.001, sigma = 1000), 
         method = "Nelder-Mead",
         data = list(filename = "C:\\Users\\Andrew Chin\\Documents\\UW AU19\\FISH 552_3\\FISH.552_workspace\\553_HW3\\HW3 Skeena sockeye.csv"))
Ricker.MLE


#==Question 2
# Beverton-Holt curve (Beverton & Holt 1957)
# R = (a*S)/(b+S)

BevertonHolt <- function(BHa, BHb, sigma, filename) {
   fishData <- read.csv(file = filename, header = T)
   spawners <- fishData[,"Spawners"]
   recruits <- fishData[,"Recruits"]
   nspawners <- length(spawners)
   eggcarton <- vector(length=nspawners)
   modelBH <- (BHa*spawners)/(BHb+spawners)
   BH.MLE <- -sum(dnorm(x=recruits, mean = modelBH, sd=sigma, log=TRUE))
   cat("estimated MLE", BH.MLE)
}

BevertonHolt(BHa = 5000, BHb = 1000, sigma = 1000, filename = "C:\\Users\\Andrew Chin\\Documents\\UW AU19\\FISH 552_3\\FISH.552_workspace\\553_HW3\\HW3 Skeena sockeye.csv")

library("bbmle")
require("bbmle")
BevertonHolt.MLE <- mle2(minuslogl = BevertonHolt,
         start = list(BHa = 5000, BHb = 1000, sigma = 1000),
         method = "L-BFGS-B",
         lower = list(BHa = 1000, BHb = 500, sigma = 500),
         upper = list(BHa = 9000, BHb = 1500, sigma = 1500),
         data = list(filename = "C:\\Users\\Andrew Chin\\Documents\\UW AU19\\FISH 552_3\\FISH.552_workspace\\553_HW3\\HW3 Skeena sockeye.csv"))
BevertonHolt.MLE


#==Question 3
# Akaike Information Criterion
# AIC = -2*lnL + 2p + (2p*(p+1)/(n-p-1))

AIC <- function(lnL, p, n) {
   AIC <- 2*lnL + 2*p + ((2*p*(p+1))/(n-p-1))
   return(AIC)
}

# Ricker
AIC(lnL = 357.91, p = 3, n = length(Skeena.sockeye$Year))
# negative-log likelihood: 357.91, AIC: 722.4054

# Beverton-Holt
AIC(lnL = 358.31, p = 3, n = length(Skeena.sockeye$Year))
# negative-log likelihood: 358.31, AIC = 723.2054

# Ricker model is the best fit