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

write_csv(data, "data.csv")

# using here()
library(here)
inventory <- read_csv(here('data//WDFW-Salmonid_Stock_Inventory_Populations.csv'))

********************************************
********************************************
## tidyr::Exploring Data

********************************************
head()
glimpse()
ode(), class(), dim(), and length()
dim() # returns length of dataframes;
      # can be dim(vector)[1]; [1] for rows, [2] for columns

attributes() # retrieves the attributes of a data frame
unique() # retrieves unique elements within a vector
summary() # returns statistical summaries of each column within dataset
str() #STRucture of the dataset; includes heads of columns

purrr::map(data, class) # what type are the data?

max()/min() #maximum/minimum value in vector
which.max()/which.min() #identifies which index has max/min

mean()

# exploring data with logicals; returns indices
sum() # return sample size that fulfills condition
any() # do any elements fulfill condition?
which() # which elements fulfill condition?
all() # return all elements that fulfill condition

# placing these logicals within hard brackets return associated values; useful for extraction and substituting values
data[any(data>5),"col3"] # can use indices, Boolean logic, or row/column names to call data

# use plot() to explore data


********************************************
********************************************
## tidyr::Wrangling Data

********************************************
#### Pivot/reshape data
# Why pivot data?
#  pivot_wider() groups columns together and makes plotting multiple variables on the same plot in ggplot more simple
# also, pivoting back and forth can help clean up one variable that is expressed across multiple columns (e.g., presence/absence data across regions, when these regions can be grouped)

# increases rows and decreases columns with pivot_longer [formerly gather()]
pivot_longer(data=,
             cols=, # columns to pivot into a wider format
             names_to=, # specifies name of column created from data
             values_to=, # type of data to transform rows to
             names_prefix=,
             values_drop_na=T/F # if TRUE, drops NAs and prevents double-counting
)
# 'Long' data has a 'value' column for different variables
# year  column   value
# 2014  length    500
# 2014  weight    1200
# 2014  age       10
# 2015  d13C      -22.35


# make more columns within table with pivot_wider() [formerly spread()]
pivot_wider()
# year  length   weight   age   d13C
# 2014  500       1200     10   -22.35

# Example: Genetic Stock ID for salmon



********************************************
# ______ data with melt()
melt()

********************************************
********************************************
## tidyr::Data cleaning
# Questions to ask:
# Which data do we need for our analysis?
# Do we need to create any new variables?
# Are the data of the correct type?
# Do we need to combine dataframes?
# Do the data need to be reshaped?
# Are there missing data?

# change data type with as.*** series
purrr::map(data, class)
data %>% mutate(var1 = as.numeric(var1))

# rename columns with rename()
# will be used during subsetting data
rename(data, new_name = old_name)


********************************************
# splitting and combining character columns
separate(data=, # data frame
         col=, # column name representing current variable
         into=, # names of columns to receive new data
         sep="", # how to seperate current variable (char, number, or symbol)
         remove=T/F, # T: remove input column
)

extract()

********************************************
# dropping values or NAs from columns
drop_na(cols,
  <tidy_select> # optional argument modifer that specifies which columns to search for NAs https://tidyr.tidyverse.org/reference/tidyr_tidy_select.html
  )
fishData %>% drop_na(SpeciesCode) # e.g., drop all NAs from SpeciesCode column



********************************************
********************************************
##dplyr::Manipulate data using %>% pipeline operator

********************************************
# subset data using select()
# analogous to base::subset() and other indexing strategies
newfishData <- fishData %>%
  select(weight, condition)
fishData_nocondition <- fishData %>%
  select(-condition) # can use minus signs to remove columns



********************************************
# extract one column as vector with pull()
studyperiod <- fishData %>%
    pull(Year)

# analogous functions to base::grep() is stringr::select_str()


********************************************
# filter by row data using filter()
# analogous to base::subset() and other indexing strategies
bigpinksalmon <- fishData %>%
   filter(length < 100 & Species=="gorbuscha")
newfishData <- fishData %>%
   filter(length < 100 | Age != "adult") # can stack Boolean logic with base operators; '|' for OR and '&' for AND

# more complex filters
newfishData <- fishData %>%
  filter((Species=='tshawytscha' | Species=='kitsutch') & (Condition=='Poor' | Condition=='Good'))

# >2 string filters within the same column
Sebastes <- c("melanops", "caurinus", "mystinus", "paucispinis", "pinniger", "diaconus", "diploproa", "flavidus")
SebastesData <- fishData %>%
    filter(Species %in% Sebastes) # '%in%' comparison operator is a compressed if_else() function
nonSebastesData <- fishData %>%
    filter(!(Species %in% Sebastes)) # can use '!' to exclude selected Sebastes species
# searching for key words within strings requires a more complex tidyerse::stringr code


********************************************
# hold filters constant using group_by()
# analogous to writing base::subset() to an object
# group_by() converts a tbl into a grouped tbl, so filtering selections are automatically accounted for other dplyr/tidyverse functions
bySp_fishData <- fishData %>%
   group_by(Species)
bySp_fishData %>% summarize(meanLength.mm=mean(Length.mm),
                            SDLength.mm=mean(Length.mm)) # will report mean and SD length by Species

# group by the sum using base::aggregate()
escapementtrend_byspecies <- aggregate(x=PSHCescapement$`abundance quantity`,
    by=list(year=PSHCescapement$year, species=PSHCescapement$species.x, production=PSHCescapement$`production type`),
    FUN=sum)

ungroup() # removes the grouping selections from a tibble


********************************************
# remove duplicate rows based on columns with distinct(); a little more precise than dplyr::select()

fishData %>%
  distinct(year, stock, region, .keep_all=T/F # if TRUE, keeps all variables of the selected data within the tbl
  ) %>% # removes duplicate rows of the tbl using the 'year' and 'stock' variables
  filter(region=="SEAK") # can be paired with splyr::filter() to subset data

********************************************
# change data structure, add columns, and preserve existing columns with mutate()
# analogous to creating new columns with equations, but more compact
# transmute() does the same but replaces columns
newfishData <- fishData %>%
   mutate(fatness = weight/length,
          fatfish = fatness >= 1.1,
          sumlength = length1 + length2) # Boolean column returns logical T/F's

# change data type from character string to factor
data <- data %>%
  mutate(cate2_reordered = factor(cate2, levels = c("factor3", "factor2", "factor4", "factor1")))

# running similar mutate() operations using across()
across(targeted_columns, # a vector of column names as characters
       operations) # the R function used
vec <- c('length','weight','age','d13C','d15N')
newfishData <- fishData %>%
      mutate(
            across(vec, as.numeric))
# selection helpers in across(), which work with character strings:
starts_with()
ends_with()
contains()
sat_results <- sat_results %>%
    mutate(across(contains("Avg. Score"), as.numeric)) # this mutate call is seperate from others

********************************************
# vectorized "if-else" within tidyverse::if_else() (no loops required!)
if_else(condition=,
        true=, false=) # 'true' and 'false' arguments pass values if condition=T/F, respectively; length(values0)==length(condition)

# e.g.,
SebastesData <- fishData %>%
    mutate(isSebastes = if_else(Genus == "Sebastes", TRUE, FALSE)
         # 'isSebastes' is a new column with T/F data for each row
            lifestage = if_else(length>200, 'Spawner', 'Subadult')
           )

# use '&' and '|' for multiple filters for tidyverse::if_else
fishData %>%
    mutate(Estuary.res = if_else(station=="Estuary" & length>100, TRUE, FALSE))


********************************************
# generalized n-branched control flow statement in tidyverse::case_when()
SebastesData <- fishData %>%
    mutate(sizeclass = case_when(
      length < 10 ~ 'post-larval', # tilde '~' is a shortened if statement
      length < 100 ~ 'yearling',
      TRUE ~ 'subyearling' # safety net for leftover values
            )
      )


********************************************
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


********************************************
********************************************
# get summary statistics with summarize()

# creates a new tibble with specified stats
# analogous to base::apply, tapply(), colMeans() or rowMeans() or pipping subset data into mean()
slowsummary <- slow %>%
   group_by(Species, Time) %>% # split data into subsets
   summarize(meanwellness=mean(Wellness),
             SDwellness=sd(Wellness),
             n=n()) # n is the number of observations in group_by
  # Center: mean(), median()
  # Spread: sd(), IQR(), mad()
  # Range: min(), max(), quantile()
  # Position: first(), last(), nth(),
  # Count: n(), n_distinct()
  # Logical: any(), all()
