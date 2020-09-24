N0 <- 10
r <- 0.2
K <- 100

tmax <- 20
years <- seq(from=0, to=tmax)

#create object to store
logisticPop <- rep(x=NA, times = length(years))

# insert year 0 population
logisticPop[1] <- N0

for (i in 1:tmax) {
  n.t <- logisticPop[i]
  n.t.plus.1 <- n.t + n.t * r * (1- n.t/K)
logisticPop[i+1] <- n.t.plus.1
}

plot(logisticPop, type = "l")
