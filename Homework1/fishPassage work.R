# Name: Andrew Chin
# Homework 1, Part 2

fishPassage <- read.csv("fishPassage.csv", header=T)
labels(fishPassage)


#calculate the max and min of wild steelhead to pass Bonneville Dam, and specify in which year each occurred
fishPassage$Wild.Steelhead #NA's found
# fishPassage$Wild.Steelhead <- na.pass(fishPassage$Wild.Steelhead)
# max(fishPassage$wild.Steelhead, na.rm=T) # doesn't work; returning "-Inf"
fishPassage$Wild.Steelhead[!is.na(fishPassage$Wild.Steelhead)] #what are the values that exclude NA?
max(fishPassage$Wild.Steelhead[!is.na(fishPassage$Wild.Steelhead)])
which.max(fishPassage$Wild.Steelhead[!is.na(fishPassage$Wild.Steelhead)])

#subset Bonneville?
BON.fishPassage <- fishPassage[fishPassage$Dam=="BON",]
head(BON.fishPassage)
which.max(BON.fishPassage$Wild.Steelhead[!is.na(BON.fishPassage$Wild.Steelhead)])
max(BON.fishPassage$Wild.Steelhead[!is.na(BON.fishPassage$Wild.Steelhead)])
BON.fishPassage$Year[which.max(BON.fishPassage$Wild.Steelhead[!is.na(BON.fishPassage$Wild.Steelhead)])]
# maximum wild steelhead passage was in 2001, with 149,582 fish.

min(BON.fishPassage$Wild.Steelhead[!is.na(BON.fishPassage$Wild.Steelhead)])
which.min(BON.fishPassage$Wild.Steelhead[!is.na(BON.fishPassage$Wild.Steelhead)])
BON.fishPassage$Year[which.min(BON.fishPassage$Wild.Steelhead[!is.na(BON.fishPassage$Wild.Steelhead)])]
# 12 fish passed over Bonneville dam in 1996, the lowest on record.

# Calculate the total number of fish counted at Bonneville in 2007.
BON.fishPassage[BON.fishPassage$Year=="2007",3:11]
sum(BON.fishPassage[BON.fishPassage$Year=="2007",3:11])
#3,454,997 total fish, comprised of 8 species, passed over Bonneville in 2007.

# create a new data frame called "fishPassage1995BON" that contains only observations from Bonneville from 1995 onwards.
fishPassage1995BON <- BON.fishPassage[BON.fishPassage$Year >= 1995,]
fishPassage1995BON

# create a matrix with 3 columns from "fishPassage1995BON" that contains counts of coho adults, coho jacks, and ratios of coho jacks to adults. Name this matrix "cohoPassage."
dim(fishPassage1995BON)
matrix(c(fishPassage1995BON$Coho.Adult, fishPassage1995BON$Coho.Jack, fishPassage1995BON$Coho.Jack/fishPassage1995BON$Coho.Adult), nrow=13, ncol=3)
cohoPassage <- matrix(c(fishPassage1995BON$Coho.Adult, fishPassage1995BON$Coho.Jack, fishPassage1995BON$Coho.Jack/fishPassage1995BON$Coho.Adult), nrow=13, ncol=3)
cohoPassage
colnames(cohoPassage) <- c("coho adult", "coho jack", "jack:adult")
cohoPassage

# calculate the mean for each variable in "cohoPassage."
colMeans(cohoPassage)
# coho adult    coho jack   jack:adult 
# 8.371569e+04 5.489308e+03 9.241451e-02

# round the output of the means to two decimal places

