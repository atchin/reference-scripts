## Kenzie/Dan data
# install.packages("tidyverse")
library(tidyverse)

data <- read_csv("Kitsap_KenzieDan.csv")
str(data)
glimpse(data)

## identify NFB and NA sites
data2 <- data %>%
          mutate(NFB_logi = str_detect(c(Title, Description), 'NFB'), # see if this works
                 nocrossing_logi = str_detect(c(Title, Description), 'No Site'|'Nothing')) %>%
          drop_na(NFB_logi) # remove actual NA rows since it screws up the if-else loop
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
          status <- 'NA'
     } else if (xNFB==T && yNOC==T) {
          status <- 'NA' # 'NA' as a character since NA w/o quotes means 'no data inputted' within R
     } else if (xNFB==T && yNOC==F) {
          status <- 'NFB'
     } else {
          status <- 'assessed'
     }
     return(status)
}
# test function
# xtest <- F
# ytest <- T
# sortingbinfunc(xtest, ytest)

# create new column
data2 <- data2 %>% mutate(
        NFB_or_NA = unlist(map2(NFB_logi, nocrossing_logi, sortingbinfunc))
               )
glimpse(data2) # check
View(data2) # ok but really check for real this time


# filter, subset columns, and export
finaltbl <- data2 %>%
          filter(NFB_or_NA=='NFB' | NFB_or_NA == 'NA') %>%
          select(`Date Created`, Latitude, Longitude, NFB_or_NA, Title, Description) # reorder columns
glimpse(finaltbl) # check
View(finaltbl) # doublecheck

# export
write_csv(finaltbl, "NFB_or_NA_KenzieDan_Kitsap.csv")
