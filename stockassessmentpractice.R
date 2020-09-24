library(tidyverse)
# load in stock assessment survey data
setwd("C:\\Users\\Andrew Chin\\Documents\\General_R_workspace\\reference scripts")

# read in data
fishData <- read_csv(file="speciesData.csv", col_types="ddddddci") # compact string for data types. also SpeciesCode would technically be a factor???
# Warning: 87 parsing failures.
problems(fishData)
str(fishData)
# clean up the data...how?
trimData <- fishData %>% drop_na(SpeciesCode) # guess that worked! dropped NAs from SpeciesCode bc an "NA" in the SpeciesCode is a useless data point

# read in fish codes
fishCodes <- read_csv("speciesCode.csv")
# 3 parsing errors present
fishCodes <- fishCodes[,1:3]

# match up codes with species names
# need to create a loop? or is there a function for this
ndata <- length(trimData$SpeciesCode)

namecarton <- data.frame(Scientific=rep(NA, times=ndata),
           Common=rep(NA,times=ndata))
namecarton[1,1:2] <- fishCodes[which(fishCodes[,1] == trimData$SpeciesCode[1]),2:3] # check if core code works

# loop to match codes with scientific/common names
for (i in 1:ndata){
   namecarton[i,] <- fishCodes[which(fishCodes[,1] == trimData$SpeciesCode[i]),2:3]
}
head(namecarton) # success!

# append new data columns to fishData
trimData[9:10] <- cbind(namecarton)
glimpse(trimData)

# explore data - # of data pts per species, etc.
unique(trimData$Common)
# use dplyr::summarize and write summary table

### PLOTS TO MAKE
# average length / weight of species

# length:weight relationships with lm/fitting model

# variation between trip numbers in biodiversity and length+weight

# zoom in on Sebastes
