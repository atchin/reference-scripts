# while-loops
# used for when we are searching for a condition/threshold to be met (e.g., when does a population fall below a certain threshold?)
# useful for optimization and simulation

# Example: given a 9% death rate, when does the population fall below 500?
Ninit <- 10000
polar.loop <- function(N=Ninit, year = 2015){
   while(N>500) { # while condition == TRUE, then
      N <- N*0.91
      year <- year+1
   } # loop ends when condition == FALSE
   return(year)
}
# press <ESC> to exit infinite while-loops

# indexed while-loop for pre-determined vectors
# set up vector, condition, and index
nums <- 1:10
is_condition_met <- FALSE
i <- 1

# Loop execution
while (!is_condition_met) { # condition evaluates to TRUE, then runs the loop
  current_num <- nums[i] # Grab a number using the index
  is_condition_met <- current_num > 7 # Recheck the condition - is current_num > 7 ? If current_num > 7 == FALSE, then loop again
  # while-condition must be adjusted otherwise the while-loop will loop forever

  i = i + 1 # Increase the index
}

while() {

  }
