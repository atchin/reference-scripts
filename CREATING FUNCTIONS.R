## CREATING FUNCTIONS

newFunction <- function(xvec, yvec, ...) {
#` @param::xvec and @param::yvec are arguments that you can pass to the function newFunction
#` @param::ellipses (...) means that base arguments can be plugged in
    xvec <- xvec-mean(xvec)
    yvec <- yvec-mean(yvec) #this what the argument does when you pass it values [e.g., xvec=XX returns XX-mean(XX)]
    plot(x=xvec, y=yvec, ...) # this will generate a plot as well
    return(cor(x=xvec, y=yvec)) # this returns a correlation value
}

xx <- seq(from=1, to=100,by=1)
yy <- 0.2 + xx*0.5 + rnorm(n=length(xx),mean=0,sd=5)
newFunction(xvec = xx, yvec = yy, main="newFunction")


# integrating if-else values into functions, e.g.,
first_vec <- c(1, 5, 4, 2, 3, 7, 6)
second_vec <- c(9, 2, 1, 8, 3, 4, 5, 6, 10, 7, 12, 11)
third_vec <- c(8, 3, 5, 1, 7, 1, 10)

find_longer_vector <- function(vec1, vec2) {
    if (length(vec1) > length(vec2)) {
    return(print("First"))
     } else if (length(vec1) == length(vec2)) {
    return(print("Equal Length"))
    } else {
    return(print("Second"))
    }
}
first_vs_second <- find_longer_vector(vec1=first_vec,
                                      vec2=second_vec)
first_vs_third <- find_longer_vector(vec1=first_vec,
                                     vec2=third_vec)

new_add <- function(x, y, ...) {
    current_num = x + y
            for (num in list(...)) {
                current_num = current_num + num
            }
return(current_num)
}
new_add(1, 2, z = 3)
new_add(1, 2, z = 3, w = 4)


# using three-dot construct (...)
subtract_all <- function(x, ...) {
# 1. assign variables
current_num = x
# 2. run function
  for (num in list(...)) {
    current_num = current_num - num
  }
# 3. return value
return(current_num)
}
first_subtraction <- subtract_all(x=10,1,2,3)
second_subtraction <- subtract_all(x=100,71,22)

# functions within functions, and using three-dot constructs
clean_data <- function(data) {
  # Data cleaning code is contained in here
}
analyze_data <- function(data, analysis_parameters) {
  # This function takes clean data and does analysis on it
}
create_report <- function(analyzed_data, report_parameters) {
  # this function creates a nicely formatted report from the analysis
}

workflow <- function(data, ...) { # using ... produces a cleaner function
  varargs <- list(...) # store extra parameters in a list to access later

  final_report = data %>%
                    clean_data() %>% # pass data to arguments that aren't specified
                    analyze_data(analysis_parameters=varargs$analysis_parameters) %>%
                    create_report(report_parameters=varargs$report_parameters)
  return(final_report)
}
data <- read_csv("path//data.csv")
example <- workflow(data, analysis_parameters = "setting1".
                    report_parameters = "setting2")
