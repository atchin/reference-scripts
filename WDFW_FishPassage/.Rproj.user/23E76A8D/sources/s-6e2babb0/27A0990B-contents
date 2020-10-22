library(tidyverse)
Kitsap <- read.csv('ForReal.csv', header=T)
str(Kitsap)
head(Kitsap)

# make $Date.Created as a date variable by splitting the dates as character string and coverting into a 'Date' data type
head(Kitsap$Date.Created)
# [1] "2020-08-24T10:55:52-07:00"
# [2] "2020-08-25T14:32:33-07:00"
# [3] "2020-07-28T12:43:09-07:00"
# [4] "2020-07-29T10:03:51-07:00"
# [5] "2020-07-29T11:25:03-07:00"
# [6] "2020-07-29T13:20:39-07:00"

dates <- unlist(strsplit(Kitsap$Date.Created, "T")) # unlisting doubled up on the objects?  every odd object is a date I want to pull out
dateindex <- seq(from=1, to=394, by=2) # use seq() as an index
dates[dateindex] # check if extracted dates correctly

# create data frame to parse
newKitsap <- data.frame(Title=Kitsap$Title,
                          Date=as.Date(dates[dateindex]),
                          Lat=Kitsap$Latitude,
                          Long=Kitsap$Longitude)
str(newKitsap)
head(newKitsap)

## EXTRACT and CREATE
# use grep() on csv to identify particular characteristics for special layers

grep("NFB", csvfile$column)

# create new columns for data, such as NFB sites

# use if loops?

## FORMAT
# format parsable .csv files to delineate shape file attributes 
# what do shape files/imported csv files look like for ArcGIS?

## EXPORT
# write and export csv