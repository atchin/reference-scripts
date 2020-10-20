

tidyverse::purrr::map()
map() # vectorizes custom functions
# takes two inputs:
# 1) a vector or list and
# 2) a function to apply on this vector/list

# will take each element of the input vector or list, apply the function to each element, and will return a list. If we code the diagram above, we get:

outputs <- map(inputs, custom_function)

##### how is purrr::map() different from tidyr::case_when()?
# case_when() assigns factors and character labels

# map() is more customizable since you can add your own functions
#    numerical output, transform and manipulate data better
# pair with map() functions with mutate(unlist()) to replicate case_when()




# integrating into tidyr::mutate()
custom_function <- function(...) {
        THE FUNCTION
      if () {} else{}, etc.
}
data <- data %>%
    mutate(function_output = unlist(map(input, custom_function)))



# there's a whole rainbow of map() functions in tidyverse::purrr
purrr::map2(   # handles two inputs
            inputs_first, inputs_second)

# Two inputs vectors
inputs_first <- 1:5
inputs_second <- 6:10
# Function to vectorize
add_two_values <- function(x, y) {
    return(x + y)
}
outputs <- map2(inputs_first, inputs_second, add_two_values)

purrr::pmap() # stand for a variable number of inputs
 # There are other map() variations that can return vectors instead. For these variations, you have to specify what kind of vector it will be, whether it is a character vector or a double vector. You'll learn more about these specific variations in a future mission,
