# multiread_csv() reads in and combines multiple csvs from one folder
library(here)
library(tidyverse)
multiread_csv <- function(path="./data") { # path = folder path as a character string where multiple csv files are stored
        list.files(path=here(path), pattern="*.csv", full.names=T) %>% # list.file() lists csv's as a character string
            map_df(~read_csv(.))
        }
# e.g.,
library(here)
library(tidyverse)
here()
# "C:/Documents/CurrentWD"
combined <- multiread_csv(path="./dataishere") # "dataishere" is the name of the folder where the data is kept
View(combined)


# conditionsortingfunc() extracts data from character strings and sorts based on the extracted string
conditionsorting <- function(data, # data = tidyverse::tbl
   column, # column = tidyverse::tbl$column
   xcondition, ycondition) { # conditions as character strings to be extracted
  sortingfunc <- function(x,y){
     if (x==F && y==T) {
          status <- 'condition2'
     } else if (x==T && y==T) {
          status <- 'condition2'
     } else if (x==T && y==F) {
          status <- 'condition1'
     } else {
          status <- NA
     }
     return(status)
   }
   data2 <- data %>%
             mutate(x_logi = str_detect(column, x), # new columns with logical data (TRUE/FALSE) for either condition
                    y_logi = str_detect(column, y)) %>%
             drop_na(x_logi) %>% # remove actual NA rows since it screws up the if-else loop
             drop_na(y_logi) %>%
      mutate(x_or_y = unlist(map2(x_logi, y_logi, sortingfunc))) # apply sorting function
  return(data2)
}
