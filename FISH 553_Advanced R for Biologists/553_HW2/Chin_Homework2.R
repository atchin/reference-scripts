# Name: Andrew Chin
# Homework 2

#==Question 1a
# length-weight equation: W(i) = a*L(i)^b

length.weight <- function(data, a, b, ...) {
   eggcarton <- length(data)
   modeled.weight <- vector(length = eggcarton)
   for (i in 1:eggcarton) { #store values in entire length vector
      modeled.weight[i] <- (a*(data[i]^b))/1000 # divide by 1000 since initial output was HUGE
   }
   cat("length(cm)", data, "\n", "weight(kg)", modeled.weight)
}

# old function
# Oldlength.weight <- function(data, a, b, ...) {
#    for (i in data) {
#       modeled.weight <- (a*(i^b))/1000 # divide by 1000 since initial output was HUGE
#    cat(i, modeled.weight, "\n")
#    }
# }


#orange roughy
roughy.length <- c(20,25,30,35,40)
roughy.age <- c(5,10,20,50,100)
roughy.a <- 0.0631
roughy.b <- 2.81
roughy.descrip <- "Orange roughy (Hoplostethus atlanticus) data; length (cm), age, a.parameter, b.parameter, age, K  = growth rate, Linf.cm = asymptotic max length (cm), l.age0 = length at age 0"
roughy <- list(meta=roughy.descrip, 
             length.cm=roughy.length,
             a.parameter=roughy.a, b.parameter=roughy.b,
             age=roughy.age,
             K=0.04, Linf.cm=40, L.age0=-2.7)
roughy

length.weight(data = roughy$length.cm, a = roughy$a.parameter, b = roughy$b.parameter)


#==Question 1b
# find estimated length from age
# L(i) = L(inf) * (1-exp[-K*(t(i)-t(0))])

age.length <- function(ages, K, Linf, age0, ...) {
      eggcarton <- length(ages)
      Von.Bert.growth <- vector(length = eggcarton)
   for (i in 1:eggcarton) {
      Von.Bert.growth[i] <- Linf*(1-exp(-K*(ages[i]-age0)))
   }
 cat("ages", ages, "\n", "modeled length(cm)", Von.Bert.growth)
}

age.length(ages = roughy$age, K = roughy$K, Linf = roughy$Linf.cm, age0 = roughy$L.age0)


#==Question 1c
# Total Weight = sum(# of fish@age a * weight@age a)

dummy.stock1 <- data.frame(
   Age = seq(1:7),
   catch.perAge = c(1000,800,700,500,450,300,100),
   wt.perAge.g = c(100,400,650,800,900,960,1000)
)
dummy.stock1

total.weight <- function(data, ...){
   eggcarton <- length(data$Age)
   biomass.perAge <- vector(length = eggcarton)
for (i in 1:eggcarton) {
      biomass.perAge[i] <- (data[data$Age==i,]$catch.perAge * 
             data[data$Age==i,]$wt.perAge.g)
         }
   cat("age class", data$Age, "\n", "biomass per age", biomass.perAge, "\n", '\n', "total biomass", "\n", sum(biomass.perAge))
}

total.weight(data=dummy.stock1)

#==Question 2

dummystock2 <- list(meta="dummy data for Question 2; age, abundance/age, 'A' growth parameter, 'B' growth parameter, K  = growth rate, Linf.cm = asymptotic max length (cm), l.age0 = length at age 0",
              age=seq(1:10),
              abundance = c(100,90,81,70,65,60,30,20,10,5),
              a.parameter=0.0631, b.parameter=2.81,
              K=0.04, Linf.cm=40, L.age0=-2.7)
dummystock2

# calculate:
weight.from.age <- function(ages, abundance, a, b, K, Linf, age0, ...) {
   # length @ age
      eggcarton <- length(ages)
      lengthfromAge <- vector(length = eggcarton)
   for (i in 1:eggcarton) {
      lengthfromAge[i] <- Linf*(1-exp(-K*(ages[i]-age0)))
   }
 cat("ages", ages, "\n", "modeled length(cm)", lengthfromAge)

      # Error in lengthFromAge[i] <- Linf * (1 - exp(-K * (i - age0))) :  replacement has length zero
   # cat("length from age", lengthFromAge)
   
   # weight @ age
   modeled.weight <- vector(length = eggcarton)
   for (i in 1:eggcarton) {
      modeled.weight[i] <- (a*(lengthfromAge[i]^b))/1000
   }
   cat("\n", "\n", "length from modeled weight", modeled.weight)
   
   # biomass per age, summed
   # Total Weight = sum(# of fish@age a * weight@age a)
   biomass.perAge <- vector(length = eggcarton)
   for (i in 1:eggcarton) {
      biomass.perAge[i] <- (abundance[i] * modeled.weight[i])
   }
   cat("\n", "\n", "biomass per age class", biomass.perAge, "\n", "\n", "total biomass", "\n", sum(biomass.perAge))
}

# total weight of all fish
weight.from.age(ages = dummystock2$age, abundance = dummystock2$abundance, a = dummystock2$a.parameter, b = dummystock2$b.parameter, K = dummystock2$K, Linf = dummystock2$Linf.cm, age0 = dummystock2$L.age0)