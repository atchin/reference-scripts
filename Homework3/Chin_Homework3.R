# Name: Andrew Chin
# Homework 3


#==Question 1a
setwd("C:\\Users\\Andrew Chin\\Documents\\UW AU19\\FISH 552_3\\FISH.552_workspace\\Homework3")

mack.black <- read.table(file="MACKBLACK.txt", col.names = c("Year", "spawners", "recruits", "catch", "fishMortality"), na.strings = ".")
save(mack.black, file="mack.black.RData")
mack.ices <- read.table("MACKICES.txt",  col.names = c("Year", "spawners", "recruits", "catch", "fishMortality"), na.strings = ".")
save(mack.ices, file="mack.ices.RData")
mack.nafo <- read.table("MACKNAFO.txt",  col.names = c("Year", "spawners", "recruits", "catch", "fishMortality"), na.strings = ".")
save(mack.nafo, file="mack.nafo.RData")


#==Question 1b
intersect(mack.black$Year, mack.nafo$Year)
mack.partial <- merge(mack.black, mack.nafo, by.x = "Year", by.y = "Year", suffixes = c(".black", ".nafo"))
head(mack.partial, n=2)

#==Question 1c
mack <- merge(mack.partial, mack.ices, by="Year", suffixes = c(".black", ".ices"))
str(mack)

#==Question 1d
colnames(mack)[10:13] <- c("spawners.ices", "recruits.ices", "catch.ices", "fishMortality.ices")
labels(mack)

#==Question 1e
matplot(x=mack$Year, 
        y=cbind(mack$spawners.black, mack$spawners.nafo, mack$spawners.ices),
        type = "l",
        lty = c(2,2,2),
        col = c("black", "red", "green"),
        xlab = "Years", ylab = "Spawner Biomass (thousands of tons)",
        main = "Atlantic mackerel")
legend(x="topleft", 
       legend =c("Black Sea", "NAFO", "ICES"),
       lty = c(2,2,2),
       col = c("black", "red", "green"),
       bty = "n")

#==Question 2a
dateTemp <- seq.Date(from = as.Date("1/1/2010", format="%m/%d/%Y"), to = as.Date("6/30/2010", format="%m/%d/%Y"), by = "day")
length(dateTemp)
set.seed(c(40, 42, 51, 55, 58, 62))
rnorm(mean = c(40, 42, 51, 55, 58, 62), sd=5, n=length(dateTemp))
# rnorm(meanTemps, mean = meanTemps, sd=5, n=181)
# temp1 <- merge(x=c(jan <- as.data.frame(rnorm(mean = 40, sd = 5, n = 31), col.names = names("temp")), as.data.frame(rnorm(mean = 42, sd = 5, n = 28)), as.data.frame(rnorm(mean = 51, sd = 5, n = 31)), as.data.frame(rnorm(mean = 55, sd = 5, n = 30)), as.data.frame(rnorm(mean = 58, sd = 5, n = 31)), as.data.frame(rnorm(mean = 62, sd = 5, n = 30))))
# head(temp1, n=3)

temperature <- data.frame(dateTemp, round(rnorm(mean = c(40, 42, 51, 55, 58, 62), sd=5, n=length(dateTemp)),0))
# tapply to apply rnorm to each date?
colnames(temperature)[1:2] <- c("date", "temp")
head(temperature, n=2)

#==Question 2b
temperature$month <- months(temperature$date)
tapply(X = temperature$temp, INDEX=temperature$month, FUN=mean)
print("They are not the same at all")

#==Question 2c
temperature$date[which(duplicated(temperature$temp))]



#==Question 2d
obsDate <- seq.Date(from=as.Date("1/1/2010", format="%m/%d/%Y"), to=as.Date("7/31/2010", format="%m/%d/%Y"), by=2)

length(obsDate)
# #use this value for the length of the dataset

obsCond <- factor(rep(1:3, length.out = length(obsDate)), levels = c(1,2,3), labels=(c("sunny", "cloudy", "partly cloudy")))
obsCond
observations <- cbind.data.frame(obsDate, obsCond)
colnames(observations)[1:2] <- c("date", "condition")
head(observations, n=3)

observations$wind <- rnorm(n = length(obsDate), mean = 5, sd = 3)
head(observations, n=3)
observations$wind[which(observations$wind < 0)] <- 0
any(observations$wind < 0)

#==Question 2e
weather <- merge(observations, temperature, by="date")
head(weather)


#==Question 2f
max.col(weather)
#       doesn't work with non-numerical vectors
# max(weather$wind)
# max(weather$temp)

apply(X=weather, MARGIN=2, FUN=max)
# date    condition         wind         temp        month 
# "2010-06-30"      "sunny" "12.2012151"   "66.79915"        "May" 

tapply(X=weather$condition, INDEX=weather$condition, FUN=length)
        # sunny        cloudy partly cloudy
        # 31            30            30
