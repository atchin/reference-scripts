 # DATA MANIP

# TYPES OF DATA
Numeric (integers (1L), doubles)
Logical (Boolean, true/false)
Character (text or string data)

# TYPES OF DATA STRUCTURES
Vector: one-dimensional structure for storing values of SAME TYPE.
Matrix: two-dimensional structure for storing values of SAME TYPE.
Lists: multi-dimensional stucture for storing values of ANY DATA TYPE/OBJECT.
Dataframe: two-dimensional structure for storing values of ANY DATA TYPE/OBJECT.

DATAMANIP[DATAEXTRACTION

%>% # pipe operator makes code easier to read and follow; passes data on to the next function
c(4,56,100,3000) %>% sum()
data <- c(col1, col2) %>% cbind() %>% data[c(2,5,8),]

# ==================CREATING/IMPORTING DATA======================
data1 <- read.csv("data1.csv", header=T)
data2 <- read.table(file="data2.txt", col.names=c(), na.strings=".")
save(data2, file="data2.RData")

# dataframes hold onto multiple types of data of the same length in table format
data.frames(data1=,
            data2=,
            cat1=as.factor())


# lists can hold multiple types and lengths of data
roughy.length <- c(20,25,30,35,40)
roughy.age <- c(5,10,20,50,100)
roughy.a <- 0.0631
roughy.b <- 2.81
roughy.descrip <- "Orange roughy (Hoplostethus atlanticus) data; length (cm), age, a.parameter, b.parameter, age, K  = growth rate, Linf.cm = asymptotic max length (cm), l.age0 = length at age 0"
roughy <- list(meta=roughy.descrip,
             length.cm=roughy.length,
             a.parameter=roughy.a, b.parameter=roughy.b,
             age=roughy.age,
             K=0.04, Linf.cm=40, L.age0=-2.7)
# add new data to list
roughy[["gender ratio"]] <- gender_ratio
# call also nest lists within Lists
Speciesparameters <- list(roughy, Pat.Tooth, beltfish, snapper)

is.numeric() #Is the data numeric?
mode() #is the data numeric or text?
as. functions (as.character, as.numeric, as.logical, among others) #coerces objects from one type to another

# BOOLEAN LOGIC FOR EXTRACTION; extracting data based on conditions
& = AND for both elements
&& = AND but only works on single element
| = OR
|| = OR but only works on single element
! = exclude succeeding function
rain & !snow = only rain, and not snow
  >
  <
  >= # greater than or equal to

sort() # by data values, ascending/descending

# ==================DATA EXPLORATION======================

mode(), class(), dim(), and length()
dim() # returns length of dataframes;
      # can be dim(vector)[1]; [1] for rows, [2] for columns


attributes() # retrieves the attributes of a data frame
unique() # retrieves unique elements within a vector
summary() # returns statistical summaries of each column within dataset
str() #STRucture of the dataset; includes heads of columns

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


# common values between two datasources
intersect(station1, station2)

# use plot() to explore data


# =================DATA EXTRACTION (SUBSETTING DATA)===============
length() # returns number of elements in a vector
#create object with n samples
Nsample <- length(data)

1:dim(obs)[1] # another way to create sample number

# Organizing
sort()
order() # sorts data by indices
data[order(data$var1),] # calls for the actual data
table() # will extract counts by category; can name multiple factors to extract

grep("Sebastes", fishCode$Scientific, # pull all row elements that contain string "Sebastes", which are found in the Scientific column
     ignore.case=T/F, # ignore capitalization or not?
     value=T/F, # 'T' return values with matching elements; 'F' returns only the indices
     invert=T/F, # equivalent to '!', excluding values with character string
      )

chr1 <- unlist(strsplit(data, "e")) # strsplit() splits up character strings by a specific character; unlist() creates a vector out of the data
q <- seq(from, to, by) # data will be distributed among the other character strings (odds, evens, etc.); use seq() to pull out indices that contain desired data
chr1[q]  # can pull out odd/even/sequential data from vector



" In general, extraction uses hard brackets [] and logicals within them to pull out data "

# Extracting using indices
filename[ROW, COLUMN]
filename$COLUMNNAME[INDICES]
filename[,-1] # negative sign excludes column 1
filename[c(1,4),] # extract rows 1 and 4

# in Lists
roughy[c(-4,-5,-6)] # remove values from 4th through 6th positions

# Extracting by column names in BASE
filename[,c("col1", "col2")] # extract columns "col1" and "col2"


# Dealing with NA's
na.rm = T # an argument that removes NAs from calcs
filename[!is.na(filename)] # subset data that excludes NAs


data[which(var2 > 2)] # returns logical vector within data that fufills condition
data$var1[data$var1==""] #Data from single row/column
data$var1[data$var1=="",] #displays all other data associated with column


# extracting by condition (all columns)
# Create data frame from fishData with weight > 20 and with fair condition
fishData[fishData$weight > 20 & fishData$condition=="fair"]



# Exclude conditions by "!"
# exclude poor condition fish
fishData[!fishData$condition=="poor"]


# Pull data from one column based on condition from another column
compiledData <- object[object$logical1=="condition",]$var2 # pulls and groups var2 data based on multiple conditions
# this should be used for creating functions!!

compiledData <- object[object$logical1=="condition", c(3,6,7)]$var2 #refers to element columns
# this strategy can extract multiple columns and multiple conditions
# -c() can be used to exclude column
OR
subset(object, logical expression, variable selection)
poorfishWeight <- subset(fishData, condition=="Poor", weight)

# Retrieve data from multiple columns based on conditions
data1 <- subset(object, logical1, var1)
data2 <- subset(object, logical1, c(var1,var2))
data3 <- subset(object, logical1, var3)
compiledData <- cbind(data1, data2, data3)
# useful if subsetted data needs to be changed prior to compiling (?)


# ==================DATA MANIPULATION AND RESTRUCTURING========================
data1[1] <- newpoint
filename[1,2] <- "NEWVALUE" # change element in row 1, column 2 to "NEWVALUE"

# vectors to matrices
matrix(data=c(), nrow=, ncol=, byrow=T/F)
# adding data to fill column 1 is the default
newdata <- rbind(data1, data2) # combines data by row (from the bottom)
newdata <- cbind(data1, data2) # combines data by column (from the right)

names(vector) <- c("vector_names")
names(list) <-c("llst names") # assigns names to vectors or lists
vector1[c("name1","name3")] # calling these names within brackets retrieves data from vector
colnames(matrix) <- c("column_headers")
rownames(matrix) <- c("row_headers")

as. families # coerces data into specific formats



# creating factors from numbers
zone <- c(1,1,1,2,2,2,1,2,2,1)
zone.fac <- factor(zone, labels=c("demersal", "pelagic"))
zone.fac

# grouping data using factors - using categorical breaks
ages <- c(47, 14, 24, 33, 74)
cut(ages, breaks=c(0,18,65,Inf), #set whole range
    labels=c("Kid", "Adult", "Senior"))

numbs3 <- 1:100
cut(numbs3, breaks=3)

# built in constants
month.abb
month.name

# reordering functions
sort() # sorts the values within it from lowest to highest
rev() # insert functions that reverses the order
order() # returns the sort index (location) of each element from first to last
data[order(data$var1, data$var2, etc.), ] # show dataframe ordered by var1, then by var2, etc.

# repetitively apply a function to a variable
apply()
X = matrix to be used
MARGIN = 1=rows, 2=columns
FUN = an R function (can be user defined)
      extra arguments can be added to the FUN by a comma (e.g., FUN=mean, na.rm=T)

# means specifically
rowMeans()/colMeans()

tapply() # applies a function to each cell of an array based on a categorical variable
X = data to be grouped (columns of data)
INDEX = a list of factors/conditions to organize the data by
FUN = the function to be applied (mean, sd, etc.)
# e.g.:
  tapply(X=PlantGrowth$weight, INDEX = PlantGrowth$group, FUN=mean)


diff() #find differences between successive elements
X = a vector

# Combining two data sources - merging a common variable to observation
merge(station1, station2, by.x="time1", by.y="time2")
                            #by.x and by.y tells R which columns within each dataset to match


# Speed-testing; especially important for multiple functions that need to be run
system.time() # insert function here


# Formatting dates
as.Date('9/22/1993', format='%m/%d/%Y')
%d: day of the month (decimal)
%m: month (decimal)
%b: month (abbrev)
%B: month (full name)
%y: year (two digits)
%Y: year (four digits)

# extracting data from dates
weekdays(as.Date(""))
months(as.Date(""))
quarters(as.Date(""))
julian(as.Date("")) # number of days from Jan 1st

# sub-daily time scales
as.POSITXlt("1993-9-22 23:30:05")
POSIXct() # adds on local time zone

# many common functions can accept objects within the Date and POSIX classes
FUNction(as.Date(DATE1), as.Date(DATE2))

# differences in time can be expressed logically
Sys.time - t1

#changes in time in different units
difftime(Sys.time, t1, units="days")
