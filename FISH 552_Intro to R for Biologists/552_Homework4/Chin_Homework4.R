# Name: Andrew Chin
# Homework 4

#==Question 1a
set.seed(420)

randomCauchy <- rcauchy(n = 1000, location = 5, scale = 1)
summary(randomCauchy)

#==Question 1b
x <- seq(from = 0.01, to = 0.985, by = 0.025)

#==Question 1c
betaDensity <- dbeta(x, shape1 = 5, shape2 = 2)

#==Question 1d
betaDensityNorm <- betaDensity/sum(betaDensity)
sum(betaDensityNorm) == 1

#==Question 1e
lengths <- seq(from = 12, to = 90, by = 2)

#==Question 1f
length(betaDensityNorm)
length(lengths)
lengthsSample <- sample(lengths, replace =  T, size = 1000, prob = betaDensityNorm)

#==Question 1g
hist(lengthsSample, probability = T, main = "", xlab = "lengths", ylim = round(c(0, 0.05),2), xlim = c(0,100), col = "cornflowerblue", border = "black")
lines(density(lengthsSample), lwd = 2, col = "red")


#==Question 2a
Yelloweye <- read.csv("~//UW AU19//FISH 552_3//FISH.552_workspace//Homework4//YERockfish.csv", header = T)

head(Yelloweye)
 
#==Question 2b
# # Write components of function and outputs
# length_means <- tapply(X=Yelloweye$length, 
#                     INDEX=Yelloweye$maturity, FUN=mean)
# length_means
# age_means <- tapply(X=Yelloweye$age, 
#                     INDEX=Yelloweye$maturity, FUN=mean)
# age_means
# plot(x=Yelloweye$age, y=Yelloweye$length,
#      xlab = "Age", ylab = "Length")
# abline(h=length_means["Immature"])
# abline(h=length_means["Mature"])

 
length.age.mat <- function(length, age, maturity, ...){
length_means <- tapply(X=length, 
                        INDEX=maturity, FUN=mean)
age_means <- tapply(X=age, 
                    INDEX=maturity, FUN=mean)
print(list(c(length_means, age_means)))
plot(x=age, y=length,
    xlab = "Age", ylab = "Length", xlim = c(0,100), ylim = c(30,80), xaxs = "i", yaxs = "i", bty = "n", pch = 19, bg = "black")
abline(h=length_means["Immature"])
text(x = 60, y = length_means["Immature"]+2, labels = "Immature")
abline(h=length_means["Mature"], lty = "dashed", col = "blue")
text(x = 60, y = length_means["Mature"]+2, labels = "Mature")
 }

# test it out!
length.age.mat(length = Yelloweye$length, age = Yelloweye$age, maturity = Yelloweye$maturity, main = "Yelloweye")

#==Question 2c
Cabezon <- read.csv("~//UW AU19//FISH 552_3//FISH.552_workspace//Homework4//Cabezon.csv", header = T)
length.age.mat(length = Cabezon$length, age = Cabezon$age, maturity = Cabezon$maturity, xaxt = "n")

#==Question 2d
par(mfrow=c(1,2))
length.age.mat(length = Yelloweye$length, age = Yelloweye$age, maturity = Yelloweye$maturity)
mtext(text = "Yelloweye rockfish", side = 3, line = 1, outer = F)
length.age.mat(length = Cabezon$length, age = Cabezon$age, maturity = Cabezon$maturity, xaxt = "n")
mtext(text = "Cabezon", side = 3, line = 1, outer = F)
# I couldn't figure out how to make the ellipses argument work in the function

# dev.off()
