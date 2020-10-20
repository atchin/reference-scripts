## could culverts be symbolized in GIS or if data manip in R is necessary
## ULTIMATE GOAL:: create a GIS layer for Non Fish-Bearing (NFB) and NO Crossing/NO Channel (NOC) sites
## Data workflow:
# 1. extract data from character strings
# 2. filter data based on NFB/NOC criteria (either presence of character string or T/F)
#    2b. includes a multi-tiered filter
# 3. subset data tbls for both NFB and NOC sites

# install.packages("tidyverse")
library(tidyverse)
# data <- read_csv('data.csv')
data <- read_csv("OneMoreTime_new.csv")
str(data)
glimpse(data)

## identify NFB and NO Crossing/NO Channel (NOC) sites
condition <-'No Channel|No Crossing' # no channel OR no crossing, to be used later
data2 <- data %>%
          mutate(NFB_logi = str_detect(Title, 'NFB'), # new columns with logical data (TRUE/FALSE) for whether they are NFB/NOC or not
                 nocrossing_logi = str_detect(Title, condition)) %>%
          drop_na(NFB_logi) %>% # remove NA rows since it screws up the if-else loop
          rename(Comments = Description) %>% # rename columns
          rename(Description = Title)
glimpse(data2) # check
View(data2) # ok but really check for real this time


######### old NFB filter and pull (removed since this didn't differentiate between NFB sites with or without channels) #########
# NFBdata <- data %>%
#          mutate(is_NFB = str_detect(Title, 'NFB')) %>%
#          filter(is_NFB==TRUE) %>%
#          rename(Comments = Description) %>% # rename columns
#          rename(Description = Title)
# head(NFBdata$Description, 10) # check again
# View(NFBdata) # ok but really check for real this time
#######

# filter for NFB+channel & NFB+NOC using control flow (case_when, if-else loops+map2?)
# create custom is-else function to sort based on conditions
sortingbinfunc <- function(xNFB,yNOC){
     if (xNFB==F && yNOC==T) {
          status <- 'NOC'
     } else if (xNFB==T && yNOC==T) {
          status <- 'NOC'
     } else if (xNFB==T && yNOC==F) {
          status <- 'NFB'
     } else {
          status <- NA
     }
     return(status)
}
# test function
# xtest <- F
# ytest <- T
# sortingbinfunc(xtest, ytest)

# create new column
data2 <- data2 %>% mutate(
        sortingbin = unlist(map2(NFB_logi, nocrossing_logi, sortingbinfunc))
               )
glimpse(data2) # check
View(data2) # ok but really check for real this time


# filter, subset columns, and export
NFBdata <- data2 %>%
          filter(sortingbin=='NFB') %>%
          select(`Date Created`, Latitude, Longitude, Description, Comments) # reorder columns
glimpse(NFBdata) # check
View(NFBdata) # doublecheck

# do it again
NOCdata <- data2 %>%
        filter(sortingbin=='NOC') %>%
        select(`Date Created`, Latitude, Longitude, Description, Comments) # reorder columns
glimpse(NOCdata) # check
View(NOCdata) # doublecheck

# export
write_csv(NFBdata, "NFB_Kitsap.csv")
write_csv(NOCdata, "NoCrossingorChannel_Kitsap.csv")
