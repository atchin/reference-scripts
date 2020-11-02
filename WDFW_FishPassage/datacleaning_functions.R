## FUNCTIONS to pull out NFB and NA columns

# install.packages("tidyverse")
library(tidyverse)
library(here)
here() # infers and prints where R thinks the wd is; cleaner than hard coding setwd()

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


condition1 <-'No Channel|No Crossing' # define how NA sites were notated as 'No Channel|No Crossing' == 'No Channel' OR 'No Crossing'
condition2 <- 'No Site|Nothing'
NFB <- 'NFB'
# data <- read_csv('data.csv')
MooreChin_KitsapRaw <- read_csv(here("./data/OneMoreTime_new.csv")) # data from Natane/Andrew with 'data' folder
DurhamCoffman_KitsapRaw <- read_csv(here("./data/Kitsap_KenzieDan.csv")) # data from Kenzie/Dan
WilsonSnyder_JeffCoRaw <- read_csv(here(".data/TerryAll.csv")) # data from Terry/Dave

Kitsap2 <- NFB_and_NA_sorting(MooreChin_KitsapRaw, NFB, condition1)
Kitsap1 <- NFB_and_NA_sorting(MooreChin_KitsapRaw, NFB, condition2)
NFB_or_NA_Kitsap <- rbind(Kitsap1, Kitsap2)
write_csv(NFB_or_NA_Kitsap, "NFB_or_NA_Kitsap.csv")

JeffCo <- NFB_and_NA_sorting(WilsonSnyder_JeffCoRaw, NFB, condition1)
write_csv(JeffCo, 'NFB_or_NA_Jefferson.csv')
