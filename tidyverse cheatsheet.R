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

## dplyr::Manipulate data using %>%
# subset data using select()
# analogous to base::subset() and other indexing strategies
newfishData <- fishData %>%
  select(weight, condition)

# analogous functions to base::grep() ?

# filter by condition using filter()
# analogous to base::subset() and other indexing strategies
newfishData <- fishData %>%
   filter(length < 100)

# hold filters constant using group_by()
# analogous to writing base::subset() to an object
# group_by() converts a tbl into a grouped tbl, so filtering selections are automatically accounted for other dplyr/tidyverse functions
bySp_fishData <- fishData %>%
   group_by(Species)
bySp_fishData %>% summarize(meanLength.mm=mean(Length.mm),
                            SDLength.mm=mean(Length.mm)) # will report mean and SD length by Species
ungroup() # removes the grouping selections from a tbl


# change data, add columns, and preserve existing columns with mutate()
# analogous to creating new columns with equations, but more compact
newfishData <- fishData %>%
   mutate(fatness = weight/length)
# transmute() does the same but replaces columns
# PRIORITY:: learn how to use case_when and if_when arguments: https://dplyr.tidyverse.org/reference/mutate.html

# changing order of rows by values of selected columns using arrange()
# analogous to base::order() or sort()
newfishData <- fishData %>%
   arrange(cat2, cat1,
     desc(cat3), # orders in descending order
     .by_group=T/F, # 'T' will prioritize by grouping variable that is specified first
   )
# where .by_group is relevant
by_cyl <- mtcars %>% group_by(cyl)
                 %>% arrange(desc(wt), .by_group=T)

# arrange across the table
newfishData <- fishData %>%
   arrange(across(starts_with("Temp"), desc))


# get summary statistics with summarize()
# analogous to base::apply, tapply(), colMeans() or rowMeans()
slow <- slow %>%
   group_by(Species, Time) %>% # holds filters for summaries constant
   summarize(meanwellness=mean(Wellness), SDwellness=sd(Wellness),
   n=n()) # this writes columns with summary data
  # Center: mean(), median()
  # Spread: sd(), IQR(), mad()
  # Range: min(), max(), quantile()
  # Position: first(), last(), nth(),
  # Count: n(), n_distinct()
  # Logical: any(), all()
