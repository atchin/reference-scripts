# LOOPS
# loops can be passed to functions in order to pass variables

# for-loops are useful for repetitive calls within a particular dataset
for (i in 1:100) {
   # do something
}
# "i" is used as a counter for either indices or characters

#loops in functions
loop.iris <- function (data=iris) {
   for (i in unique(data$Species)){
      meanSepalLength <- mean(data[data$Species==i,]$SepalLength)
      meanPetalLength <- mean(data[data$Species==i,]$PetalLength)
      cat(i, meanSepalLength, meanPetalLength, "\n") #\n puts a space values; cat() allows printing of multiple objects
   }
}

# why use for-loops rather than tapply()?
      # loops is more customizable and can run multiple functions

# most common way to use for-loops - extracting means from different categories

### create multiple "empty egg carton" vectors
species <- sort(unique(iris$Species)) # organize by unique species name
nspecies <- length(species) # how many species?
mean.lengths <- vector(length=nspecies) # empty vectors to store answers here

for (i in 1:nspecies) {
   species.data <- iris[iris$Species==species[i],] # pull data for seperate species based on rows
   plot(hist(species.data$Sepal.Length)) # plot the data
   mean.lengths[i] <- mean(species.data$Sepal.Length) # extract mean sepal length for this species
   print(mean.lengths[1])
   cat("Running Species", i, "\n")
}

# storing for-loop results as an object
#     this object can be used in other functions
General strategy:
   - find out how many loops occur (niter)
   - make a vector of values to loop over
   - make a results vector of length niter - an "empty egg carton"
   - loop the equation+dataset from i in 1:niter 
   - store values in vector

example:
mean.norm <- function(n=c(5,10,15,30,50,100)) {
   eggcarton <- length(n)
   values <- vector(length=eggcarton) # these two calls create the empty egg carton
   # to create the egg carton you HAVE to create an empty vector!!
   
   for (i in 1:eggcarton) { # the 1:niter is important; specifies the vector indices rather than total number of spaces
      values[i] <- sd(rnorm(n=n[i], mean=0, sd=1)) # this directs these results into the egg carton; brackets are SUPER IMPORTANT here!!
      # n[i] specifies the actual values that are in the indices
   }
   return(values)
}

# storing results in a matrix
mean.norm.lengths <- function(n=c(5,10,15,30,50,100),
                              nrep=100) {
   niter <- length(n)
   values <- matrix(nrow = nrep, ncol=niter) # egg carton
   for (i in i:nrep) { #this says: for each repetition of rnorm sampling, do:
      for (j in 1:niter) { #another for-loop that will create values
         values[i,j] <- sd(rnorm(n=n[j], mean=0, sd=1)) # this runs the rnorm test using each element in the vector, and directs it to store the value with the repetition number in the egg carton matrix
         # this loops through the columns first, before moving on to next row
      }
   }
}

# while-loops
# used for when we are searching for a condition/threshold to be met (e.g., when does a population fall below a certain threshold?)

# Example: given a 9% death rate, when does the population fall below 500?
polar.loop <- function(N, year = 2015){
   while(N>500) {
      N <- N*0.91
      year <- year+1
   }
   return(year)
}
# press <ESC> to exit infinite while-loops

# if-loops
# check if data are correct before proceeding with analysis
if (condition1) {
   #statements1
} else if (condition2){
   #statement2
} else {
   #statement3
}
# conditions must evaluate to Boolean T/F vectors

# if-else within if-else
if(condition1) {
   #statement1
} else {
   if (sum(condition2) > sum(condition3)) {
      print("condition2 is greater")
   } else {
      print("condition2 is less than or equal")
   }
}

# switch statements - useful for multiple nested if-else statements/or passed arguments
# i.e., if option1 {

} else (option2) {
   if (op)
}
funfun <- function(x, type) {
   return(switch(type,
                 mean = mean(x),
                 median = median(x),
                 trimmed(mean, x = 0.1),
                 "no function matches"))
}
x <- rnorm(10)
funfun <- (x, type = "mean")