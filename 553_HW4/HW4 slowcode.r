#Question 2
#SLOW VERSION of code
func1 <- function(xvec) {
   nitems <- length(xvec)
   sumofdata <- 0
   for (i in 1:nitems) {
      sumofdata <- sumofdata + xvec[i]
   }
   mean.is <- sumofdata/nitems
   print(mean.is) #just checking interim output
   return(mean.is)
}

func2 <- function(xarray) {
   ncols <- ncol(xarray)
   nrows <- nrow(xarray)
   results <- vector(length=ncols)
   for (i in 1:ncols) {
      temp.data <- xarray[1:nrows,i]
      mean.of.data <- func1(temp.data)
      results[i] <- mean.of.data
   }
   print(results)
   num.bigger <- 0
   for (j in 1:ncols) {
      if (results[j] > 0) {
         num.bigger <- num.bigger + 1
      }
   }  
   prop.bigger <- num.bigger/ncols
   return(prop.bigger)
}
niter <- 1000
xarray <- matrix(data=rnorm(niter),ncol=100)
func2(xarray=xarray)
