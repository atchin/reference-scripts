## FUNCTIONS to pull out NFB and NA columns

# install.packages("tidyverse")
library(tidyverse)

NFB_and_NA_sorting <- function( # this function returns a tbl with only NA and NFB sites
     data, NFBdescrip, NAdescrip) { # data = tbl; NFB/NAdescrip = keywords (in a string ('') format) to search for NFB or NA sites within the data; follows str_detect() syntax, use ?str_detect for documentation
     # create custom is-else function to sort based on conditions
     sortingbinfunc <- function(xNFB,yNA){
          if (xNFB==F && yNA==T) {
               status <- 'NA'
          } else if (xNFB==T && yNA==T) {
               status <- 'NA' # 'NA' as a character since NA w/o quotes means 'no data inputted' within R
          } else if (xNFB==T && yNA==F) {
               status <- 'NFB'
          } else {
               status <- 'assessed'
          }
          return(status)
     }

     ## identify NFB and NA sites
     data2 <- data %>%
               mutate(NFB_logi = str_detect(Title, NFBdescrip), # new columns with logical data (TRUE/FALSE) for whether they are NFB/NA or not
                      nocrossing_logi = str_detect(Title, NAdescrip)) %>%
               drop_na(NFB_logi) %>% # remove actual NA rows since it screws up the if-else loop
               rename(Comments = Description) %>% # rename columns
               rename(Description = Title)
     # create new column
     data2 <- data2 %>% mutate(
         NFB_or_NA = unlist(map2(NFB_logi, nocrossing_logi, sortingbinfunc))
               )

     # filter, subset columns, and export
     finaltbl <- data2 %>%
               filter(NFB_or_NA=='NFB' | NFB_or_NA == 'NA') %>%
               select(`Date Created`, Latitude, Longitude, NFB_or_NA, Description, Comments) # reorder columns
     return(finaltbl)
     # export
}


condition1 <-'No Channel|No Crossing' # define how NA sites were notated as
condition2 <- 'No Site|Nothing'
# data <- read_csv('data.csv')
MooreChin_Kitsapdata <- read_csv("OneMoreTime_new.csv") # data from Natane/Andrew
NFB_NA_MooreChin_Kitsap <- NFB_and_NA_sorting(MooreChin_Kitsapdata, 'NFB', condition1)  # 'No Channel|No Crossing' == 'No Channel' OR 'No Crossing'

write_csv()
