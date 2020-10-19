# if-loops / control flow


# check if data are correct before proceeding with analysis

# conditions must evaluate to Boolean T/F vectors
if (condition1) {
   # if condition1 == TRUE, then this code will run
} else {
   # if condition1 == FALSE, then move to condition2
}

# e.g.,
if (fish="Sebastes melanops") {
  Ntplus1.melanops <- (melanops.a*melanops.b*Nt)-(melanops.d*Nt)
} else {
  Ntplus1.caurinus <-
  (caurinus.a*caurinus.b*Nt)-(caurinus.d*Nt)
}

if (nrow(recent_grads) > 1000) {
   data_size <- 'Large'
} else {
   data_size <- 'Small'
}

# vectorized "if-else" within tidyverse::if_else() (no loops required!)
if_else(condition=,
        true=, false=) # 'true' and 'false' arguments pass values if condition=T/F, respectively; length(values0)==length(condition)

# e.g.,
SebastesData <- fishData %>%
  mutate(isSebastes = if_else(Genus == "Sebastes", TRUE, FALSE)
      # 'isSebastes' is a new column with T/F data for each row
         lifestage = if_else(length>200, 'Spawner', 'Subadult')
        )

# multiple if-else branches
if (condition1) {
  # condition1==TRUE, output1
} else if (condition2) {
  # condition2==TRUE, output2
} else {
  # condition2==FALSE, output3
}

# generalized multi-branched control flow statement in tidyverse::case_when()
SebastesData <- fishData %>%
  mutate(sizeclass = case_when(
         length < 10 ~ 'post-larval', # tilde '~' is a shortened if statement
         length < 100 ~ 'yearling',
         TRUE ~ 'subyearling' # safety net for leftover values
  )
)


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

# multiple conditions within if-else
# best to put more specific conditions higher in an if-else chain
if (condition1 == 'cate1' && condition2 > 100) {  # '&&' == AND
  output1                                         # '||' == OR
} else {
  output2
}

# use '&' and '|' for tidyverse::if_else
fishData %>%
  mutate(Estuary_res = if_else(station=="Estuary" & length>100, TRUE, FALSE))



# switch statements - useful for multiple nested if-else statements/or passed arguments
# i.e.,
 if option1 {

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
