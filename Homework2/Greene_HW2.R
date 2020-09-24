# Greene Alanna
# Homework 2

#==Question 1a
head(beaver1)
beaver1
beavermeans<-tapply(beaver1$temp, beaver1$activ, mean)
beavermeans

#==Question 1b
beaver1$obsv<-1:114
plot(x=beaver1$obsv,
         y= beaver1$temp,
         xlab = "observation #",
         ylab = "temperature",
         main = "Beaver 1 body temperature", 
         type = "l",
         xaxt= "n")
points(beaver1$obsv[beaver1$activ=="1"], beaver1$temp[beaver1$activ=="1"], pch= 16, col="green")
axis(side=1, at= seq(1, 114, 20), labels = c(1, 20, 40, 60, 80, 100))
axis(side=1, at= 114, labels = "114")
legend("topleft", c("inside mean temperature" ,"outside mean temperature"), lty=c(2,3), bty = "n", col="grey")
abline(h=beavermeans[1], lty=2, lwd=.5, col="grey")
abline(h=beavermeans[2], lty=3, lwd=.5, col="grey")
#==Question 1c
day<-346
time<-2220
temp<-37.3
activ<-1
obsv<-115
add<-c(day,time,temp,activ,obsv)
newbeaver<-data.frame(day,time,temp,activ,obsv)
View(newbeaver)
newbeaver<-rbind(beaver1, c(day, time, temp, activ, obsv))
tail(newbeaver)
#==Question 1d
tapply(newbeaver$temp, newbeaver$activ, mean)
tapply(beaver1$temp, beaver1$activ, mean)
# changed by 0.011

#==Question 2a 
library(MASS)
head(crabs)
View(crabs)
tapply(crabs$FL, crabs$sp, mean)
tapply(crabs$FL, crabs$sp, sd)

#==Question 2b
#this gives you a list of all 200 crabs, along with their sex and species 
spsex<-crabs$sp:crabs$sex
spsex

#==Question 2c
levels(spsex)
levels(spsex)<- c("Blue Female", "Blue Male", "Orange Female", "Orange Male")
levels(spsex)
spsex

#==Question 2d
tapply(crabs$FL, spsex, mean)

#==Question 2e 
crab.counts<-table(spsex)
crab.counts

#==Question 2f
plot(x=spsex, y=crabs$FL, xlab="Crab Species and Sex", ylab="Frontal Lobe Size", col=c("skyblue", "skyblue4", "orange3", "orangered"))

