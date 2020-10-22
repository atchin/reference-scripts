# WORKING WITH STRINGS
tidyverse::stringr # https://www.rdocumentation.org/packages/stringr/versions/1.4.0

str_sub(words, 1, 9) # 1st argument: string we want to obtain the substring; 2nd argument: start indexing; 3rd: end indexing

str_to_lower() / str_to_upper()
colnames(table1) <- str_to_lower(colnames(table1))



********************************************
# removing white-space - trimming
str_trim(stringname, side="left/right/both")

# adding white-space or other characters - padding
str_pad(stringname, width=, # width defines how long the output of the str_pad() should be
side="left/right/both", pad="")
recent_grads <- recent_grads %>%
    mutate(formatted_major_code = str_pad(major_code, width=7, side="left", pad="0"))


# splits sentences or phrases into individual strings
str_split(sentence, " ") # 2nd argument is the spacing provided
# OUTPUT: list
unlist(str_split(sentence, " ")) # OUTPUT as vector

# concatenates string vector together
str_c(words, collapse=" ")


********************************************
#### Regular Expressions: searching for strings
# needs: 1. text, and the 2. search pattern to look for
str_detect(stringname, "wordtosearchfor")
# OUTPUT: returns a TRUE/FALSE vector
recent_grads <- recent_grads %>%
           mutate(is_arts = str_detect(Major, "ARTS")) # returns a T/F vector
# search for multiple strings
str_detect(cate1, 'condition1|condition2') # '|' == OR
# analogous to grep()


str_replace() # like CTRL+F
str_replace(review2, pattern = "enjy", replacement = "enjoy")
str_replace(review3, pattern="%", replacement="")
# only replaces first instance of a pattern in a string
str_replace_all() # replaces all instances
