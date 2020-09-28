# TIDYVERSE CHEAT SHEET

library(tidyverse)

# readr::Importing Data
fishData <- read_csv(file="speciesData.csv",
                     col_types="ddddddci" # a compacted character string for specifying data types for each column
                   )

# dplyr accepts dataframes or tables
data.frame(x=,
           y=,
           cat1=as.factor())

## tidyr::Wrangling Data

## Pivot/reshape data
# increases rows and decreases columns with pivot_longer [formerly gather()]
pivot_longer(data=,
             cols=, # columns to pivot into a wider format
             names_to=, # specifies name of column created from data
             values_to=, # type of data to transform rows to
             names_prefix=,
)

# make more columns within table with pivot_wider() [formerly spread()]
pivot_wider()

# ______ data with melt()
melt()

# splitting and combining character columns
separate(data=, # data frame
         col=, # column name representing current variable
         into=, # names of columns to receive new data
         sep="", # how to seperate current variable (char, number, or symbol)
         remove=T/F, # T: remove input column
)

extract()

# dropping values or NAs from columns
drop_na(cols,
  <tidy_select> # optional argument modifer that specifies which columns to search for NAs https://tidyr.tidyverse.org/reference/tidyr_tidy_select.html
  )
fishData %>% drop_na(SpeciesCode) # e.g., drop all NAs from SpeciesCode column



##dplyr::Manipulate data using %>%
# subset data using select()
# analogous to base::subset() and other indexing strategies
newfishData <- fishData %>%
  select(weight, condition)
fishData_nocondition <- fishData %>%
  select(-condition) # can use minus signs to remove columns

# analogous functions to base::grep() ?

# filter by row data using filter()
# analogous to base::subset() and other indexing strategies
newfishData <- fishData %>%
   filter(length < 100, Species="gorbuscha")
newfishData <- fishData %>%
   filter(length < 100 | Age != "adult") # can stack Boolean logic with base operators


# >2 filters within the same column
Sebastes <- c("melanops", "caurinus", "mystinus", "paucispinis", "pinniger", "diaconus",
              "diploproa","flavidus")
SebastesData <- fishData %>%
    filter(Genus %in% Sebastes) # '%in%' comparison operator is a compressed if_else() function
nonSebastesData <- fishData %>%
    filter(
      !(Genus %in% Sebastes) # can use '!' to exclude selected Sebastes genera
    )

# hold filters constant using group_by()
# analogous to writing base::subset() to an object
# group_by() converts a tbl into a grouped tbl, so filtering selections are automatically accounted for other dplyr/tidyverse functions
bySp_fishData <- fishData %>%
   group_by(Species)
bySp_fishData %>% summarize(meanLength.mm=mean(Length.mm),
                            SDLength.mm=mean(Length.mm)) # will report mean and SD length by Species
ungroup() # removes the grouping selections from a tibble


# change data, add columns, and preserve existing columns with mutate()
# analogous to creating new columns with equations, but more compact
newfishData <- fishData %>%
   mutate(fatness = weight/length,
          fatfish = fatness >= 1.1) # Boolean column returns logical T/F's
# transmute() does the same but replaces columns


#  if_else() to create T/F columns and factors based on conditions
if_else(condition=, true=, false=) # 'true' and 'false' arguments pass values if condition=T/F, respectively; length(values0)==length(condition)
# e.g.,
SebastesData <- fishData %>%
    mutate(isSebastes = if_else(Genus == "Sebastes", TRUE, FALSE)
         # 'isSebastes' is a new column with T/F data for each row
            lifestage = if_else(length>200, 'Spawner', 'Subadult')
           )

# use '&' and '|' for multiple filters for tidyverse::if_else
fishData %>%
    mutate(Estuary.res = if_else(station=="Estuary" & length>100, TRUE, FALSE))


# generalized n-branched control flow statement in tidyverse::case_when()
SebastesData <- fishData %>%
    mutate(sizeclass = case_when(
      length < 10 ~ 'post-larval', # tilde '~' is a shortened if statement
      length < 100 ~ 'yearling',
      TRUE ~ 'subyearling' # safety net for leftover values
            )
      )


# changing order of rows by values of selected columns using arrange()
# analogous to base::order() or sort()
newfishData <- fishData %>%
   arrange(cat2, cat1,
     desc(cat3), # orders in descending order
   )
   #  .by_group=T will prioritize by grouping variable that is specified first
by_cyl <- mtcars %>% group_by(cyl)
                 %>% arrange(desc(wt), .by_group=T)

# arrange across the table
newfishData <- fishData %>%
   arrange(across(starts_with("Temp"), desc))

# extract one column as vector with pull()
studyperiod <- fishData %>%
    pull(Year)

# get summary statistics with summarize()
# creates a new tibble with specified stats
# analogous to base::apply, tapply(), colMeans() or rowMeans() or pipping subset data into mean()
slowsummary <- slow %>%
   group_by(Species, Time) %>% # split data into subsets
   summarize(meanwellness=mean(Wellness), SDwellness=sd(Wellness),
   n=n()) # this writes columns with summary data
  # Center: mean(), median()
  # Spread: sd(), IQR(), mad()
  # Range: min(), max(), quantile()
  # Position: first(), last(), nth(),
  # Count: n(), n_distinct()
  # Logical: any(), all()
