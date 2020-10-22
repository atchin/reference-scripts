# Name: Andrew Chin
# Homework 1

setwd("~/UW AU19/FISH 552_3/FISH.552_workspace/Homework1")

#==Question 1a.
seq(from=-1, to=1, length.out=100)
x <- seq(from=-1, to=1, length.out=100)
x


#==Question 1b.
y <- exp(x/2)
y


#==Question 1c.
which(y>1)
sum(y>1)


#==Question 1d.
size <- as.factor(rep(c("Small", "Medium", "Large"), each=5))
is.factor(size)
size
mode(size)


#==Question 1e.
# factor(rep("Unknown", each=2))
#  c(rep(c("Small", "Medium", "Large"), each=5),
#   (rep("Unknown", each=2))) 
# factor(c(rep(c("Small", "Medium", "Large"), each=5),
#          rep("Unknown", each=2))) 
  # save strings for future reference

observedSize <- factor(c(rep(c("Small", "Medium", "Large"), each=5),rep("Unknown", each=2)))
observedSize
is.factor(observedSize)

#--

#==Question 2a.
fishPassage <- read.csv("fishPassage.csv", header=T)
labels(fishPassage)


#==Question 2b.
# fishPassage$Wild.Steelhead #NA's found
# fishPassage$Wild.Steelhead <- na.pass(fishPassage$Wild    .Steelhead)
# max(fishPassage$wild.Steelhead, na.rm=T) 
#       doesn't work; returning "-Inf"

# fishPassage$Wild.Steelhead[!is.na(fishPassage$Wild.Steelhead)]
#       what are the elements that are not NA?
# 
# max(fishPassage$Wild.Steelhead[!is.na(fishPassage$Wild.Steelhead)])     
#       what is the maximum number of wild steelhead?

which.max(fishPassage$Wild.Steelhead[!is.na(fishPassage$Wild.Steelhead)]) 
#           which element is the max number?   
#           **save string for future reference

# subset(fishPassage, Dam=="BON", Wild.Steelhead) # also works

# subset Bonneville
BON.fishPassage <- fishPassage[fishPassage$Dam=="BON",]
head(BON.fishPassage)
BON.fishPassage

# year of max wild steelhead passage
which.max(BON.fishPassage$Wild.Steelhead[!is.na(BON.fishPassage$Wild.Steelhead)])
max(BON.fishPassage$Wild.Steelhead[!is.na(BON.fishPassage$Wild.Steelhead)])
BON.fishPassage$Year[which.max(BON.fishPassage$Wild.Steelhead[!is.na(BON.fishPassage$Wild.Steelhead)])]

# year of min wild steelhead passage
min(BON.fishPassage$Wild.Steelhead[!is.na(BON.fishPassage$Wild.Steelhead)])
which.min(BON.fishPassage$Wild.Steelhead
          [!is.na(BON.fishPassage$Wild.Steelhead)])
BON.fishPassage$Year[which.min(BON.fishPassage$Wild.Steelhead[!is.na(BON.fishPassage$Wild.Steelhead)])]


#==Question 2c.
labels(BON.fishPassage)
BON.fishPassage[BON.fishPassage$Year=="2007",3:11]
sum(BON.fishPassage[BON.fishPassage$Year=="2007",3:11])


#==Question 2d.
fishPassage1995BON <- BON.fishPassage[BON.fishPassage$Year >= 1995,]
fishPassage1995BON


#==Question 2e.
dim(fishPassage1995BON)
matrix(
  c(fishPassage1995BON$Coho.Adult, 
    fishPassage1995BON$Coho.Jack, 
    fishPassage1995BON$Coho.Jack/fishPassage1995BON$Coho.Adult),
  nrow=13, ncol=3)
cohoPassage <- matrix(
  c(fishPassage1995BON$Coho.Adult,
    fishPassage1995BON$Coho.Jack, 
    fishPassage1995BON$Coho.Jack/fishPassage1995BON$Coho.Adult),
  nrow=13, ncol=3)
cohoPassage
colnames(cohoPassage) <- c("coho adult", "coho jack", "jack:adult")
cohoPassage


#==Question 2f.
colMeans(cohoPassage)


#==Question 2g.
round(colMeans(cohoPassage), digits = 2)


#==Question 2h.
fishPassage$Chinook.Adult
which.max(fishPassage$Chinook.Adult[!is.na(fishPassage$Chinook.Adult)])
fishPassage[which.max(fishPassage$Chinook.Adult[!is.na(fishPassage$Chinook.Adult)]),]