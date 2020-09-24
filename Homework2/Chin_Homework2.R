# Name: Andrew Chin
# Homework 2


datasets::beaver1
head(beaver1)
?beaver1

#==Question 1a
beaversmean <- tapply(X=beaver1$temp, INDEX=beaver1$activ, FUN=mean)


#==Question 1b
length(beaver1)
beaver1$obsNum <- 1:nrow(beaver1)
labels(beaver1)
plot("l", x=beaver1$obsNum, y=beaver1$temp, xlab = "observation #", ylab="temperature", main="Beaver 1 body temperature", yaxs = "i", xaxt="n", ylim =c(36.3,37.6), yaxt = "n")
axis(side=1, at=c(1,20,40,60,80,100))
axis(side=1, at =c(114))
axis(side=2, at = c(36.4,36.6,36.8,37.0,37.2,37.4))
abline(h = beaversmean[1], lty = 2, lwd = 1, col = "grey")
abline(h = beaversmean[2], lty = 3, lwd = 1, col="grey")
points(x= beaver1$obsNum[which(beaver1$activ == "1")], beaver1$temp[which(beaver1$activ == "1")], cex = 1.25, pch = 19, col = "green")
legend("topleft", c("inside mean temperature" ,"outside mean temperature"), lty=c(2,3), bty = "n", col="grey")

#==Question 1c
beaver2 <-rbind(beaver1,c(346,2220,37.3,1,83))
beaver2$obsNum[83:114] <- 84:115

#==Question 1d
beaversmean2 <- tapply(X=beaver2$temp, INDEX=beaver2$activ, FUN=mean)
beaversmean[2] - beaversmean2[2]
print("The average temp increased 0.01095238 degrees")

#==Question 2a
library(MASS)
head(crabs)
crabs <- crabs
tapply(crabs$FL, crabs$sp, mean)
tapply(crabs$FL, crabs$sp, sd)

#==Question 2b
#Create a new variable that incorporates crab species and sex
spsex <- crabs$sp:crabs$sex

#==Question 2c
levels(spsex) <- c("Blue Female","Blue Male","Orange Female","Orange Male")
levels(spsex)
spsex

#==Question 2d
tapply(crabs$FL, spsex, mean)

#==Question 2e
crab.count <- table(spsex)
crab.count

#==Question 2d
plot(crabs$CW,crabs$FL, col = c("Blue","Orange")[unique(crabs$sp)],
     cex =1.2, pch = c(17,18)[unique(crabs$sex)],
     xlab = "Carapace Width",
     ylab = "Frontal Lobe Length")


#==Plot HW exercise
# Plot the two plots in the same figure as a multi-panel plot arranged in one row. Use mfrow.
par(mfrow=c(1,2))
plot("l", x=beaver1$obsNum, y=beaver1$temp, xlab = "observation #", ylab="temperature", main="Beaver 1 body temperature", yaxs = "i", xaxt="n", ylim =c(36.3,37.6), yaxt = "n")
axis(side=1, at=c(1,20,40,60,80,100))
axis(side=1, at =c(114))
axis(side=2, at = c(36.4,36.6,36.8,37.0,37.2,37.4))
abline(h = beaversmean[1], lty = 2, lwd = 1, col = "grey")
abline(h = beaversmean[2], lty = 3, lwd = 1, col="grey")
points(x= beaver1$obsNum[which(beaver1$activ == "1")], beaver1$temp[which(beaver1$activ == "1")], cex = 1.25, pch = 19, col = "green")
legend("topleft", c("inside mean temperature" ,"outside mean temperature"), lty=c(2,3), bty = "n", col="grey")
plot(crabs$CW,crabs$FL, col = c("Blue","Orange")[unique(crabs$sp)],
     cex =1.2, pch = c(17,18)[unique(crabs$sex)],
     xlab = "Carapace Width",
     ylab = "Frontal Lobe Length")

# Plot the two plots in the same figure as a multi-panel plot arranged in one column. Use mfrow .
par(mfrow=c(2,1))
plot("l", x=beaver1$obsNum, y=beaver1$temp, xlab = "observation #", ylab="temperature", main="Beaver 1 body temperature", yaxs = "i", xaxt="n", ylim =c(36.3,37.6), yaxt = "n")
axis(side=1, at=c(1,20,40,60,80,100))
axis(side=1, at =c(114))
axis(side=2, at = c(36.4,36.6,36.8,37.0,37.2,37.4))
abline(h = beaversmean[1], lty = 2, lwd = 1, col = "grey")
abline(h = beaversmean[2], lty = 3, lwd = 1, col="grey")
points(x= beaver1$obsNum[which(beaver1$activ == "1")], beaver1$temp[which(beaver1$activ == "1")], cex = 1.25, pch = 19, col = "green")
legend("topleft", c("inside mean temperature" ,"outside mean temperature"), lty=c(2,3), bty = "n", col="grey")
plot(crabs$CW,crabs$FL, col = c("Blue","Orange")[unique(crabs$sp)],
     cex =1.2, pch = c(17,18)[unique(crabs$sex)],
     xlab = "Carapace Width",
     ylab = "Frontal Lobe Length")

# Repeat step 2 with mfcol.
par(mfcol=c(1,2))
plot("l", x=beaver1$obsNum, y=beaver1$temp, xlab = "observation #", ylab="temperature", main="Beaver 1 body temperature", yaxs = "i", xaxt="n", ylim =c(36.3,37.6), yaxt = "n")
axis(side=1, at=c(1,20,40,60,80,100))
axis(side=1, at =c(114))
axis(side=2, at = c(36.4,36.6,36.8,37.0,37.2,37.4))
abline(h = beaversmean[1], lty = 2, lwd = 1, col = "grey")
abline(h = beaversmean[2], lty = 3, lwd = 1, col="grey")
points(x= beaver1$obsNum[which(beaver1$activ == "1")], beaver1$temp[which(beaver1$activ == "1")], cex = 1.25, pch = 19, col = "green")
legend("topleft", c("inside mean temperature" ,"outside mean temperature"), lty=c(2,3), bty = "n", col="grey")
plot(crabs$CW,crabs$FL, col = c("Blue","Orange")[unique(crabs$sp)],
     cex =1.2, pch = c(17,18)[unique(crabs$sex)],
     xlab = "Carapace Width",
     ylab = "Frontal Lobe Length")

# Repeat step 3 with mfcol.
par(mfcol=c(2,1))
par(col.axis="red")
plot("l", x=beaver1$obsNum, y=beaver1$temp, xlab = "observation #", ylab="temperature", main="Beaver 1 body temperature", yaxs = "i", xaxt="n", ylim =c(36.3,37.6), yaxt = "n")
axis(side=1, at=c(1,20,40,60,80,100))
axis(side=1, at =c(114))
axis(side=2, at = c(36.4,36.6,36.8,37.0,37.2,37.4))
abline(h = beaversmean[1], lty = 2, lwd = 1, col = "grey")
abline(h = beaversmean[2], lty = 3, lwd = 1, col="grey")
points(x= beaver1$obsNum[which(beaver1$activ == "1")], beaver1$temp[which(beaver1$activ == "1")], cex = 1.25, pch = 19, col = "green")
legend("topleft", c("inside mean temperature" ,"outside mean temperature"), lty=c(2,3), bty = "n", col="grey")
plot(crabs$CW,crabs$FL, col = c("Blue","Orange")[unique(crabs$sp)],
     cex =1.2, pch = c(17,18)[unique(crabs$sex)],
     xlab = "Carapace Width",
     ylab = "Frontal Lobe Length")

