# n-class Exercise 2: Functions
#######Exercise 1
# Create a function that given a data frame and a vector, will add a the vector (if the vector length matches with the rows number of the data frame)
# as a new variable to the data frame.


#######Exercise 2
# Consider a data frame df:
# Id<-c(1:10)
# Age<-c(14,12,15,10,23,21,41,56,78,12)
# Sex<-c('F','M','M','F','M','F','M','M','F','M')
# Code<-letters[1:10]
# df<-data.frame(Id,Age,Sex,Code)


# Create a function that, given a data frame and two indices (i.e., try creating some arguments named df, index.a, and index.b), exchanges two values of the Code variable with each other. Hint: Give your df columns names to help keep track.
# For example, if the index is 1 and 3, you assign:
# df[1,'Code']<-df[3,'Code']
# df[3,'Code']<-df[1,'Code']

#######Exercise 3
# Consider two variables x,y and a data frame df:
# x,y integer
# 
# A<-c(1:10)
# B<-seq(100,10,-10)
# H<-seq(-200,-50,along.with=B)
# df<-data.frame(A,B,H)

# Create a function that given a data frame df calculates a new variable 'SUM_x_y'(e.g., If x=2 and y=3, then the new variable will be 'SUM_2_3',
# if x=4 and y=10, then the new variable will be 'SUM_4_10'. HINT: ?paste and for loop). Each row 'i' should be equal to:
# sum(x*df[1:i,1])+sum(y*df[1:i,2])


########Exercise 4
# Create a function that takes a numeric vector, sorts the vector in ascending order and multiplies the values by two.



######Exercise 5
# Create a function that takes a vector of alpha numerics, keeps only the numbers and applies the function created in exercise 4 to those numbers. Hints: functions like %in% or match.
# For example, if the input is a vector w<-"a" "v" "7" "4" "q" , the function should return w=8 14.



######Exercise 6
# Create a function that given a string
# ST<-'NAME: Maria /COUNTRY:uruguay /EMAIL: mariaUY@gmail.com'
# return a matrix. Hints: ?unlist, ?strsplit
# [,1] [,2]
# [1,] "NAME" " Maria "
# [2,] "COUNTRY" "uruguay "
# [3,] "EMAIL" " mariaUY@gmail.com"


#######Exercise 7
# Consider a vector:
# ST<-c('NAME:Maria /COUNTRY:uruguay /EMAIL:mariaUY@gmail.com','NAME:Paul/COUNTRY:UK /EMAIL:PaulUK@gmail.com',
# 'NAME:Jhon /COUNTRY:USA /EMAIL:JhonUSA@gmail.com','NAME:Carlos /COUNTRY:Spain /EMAIL:CarlosSP@gmail.com')
# 
# Create a function that given a vector string ST return a matrix:
# [,1] [,2] [,3] [,4] [,5]
# [1,] "NAME" "Maria " "Paul" "Jhon " "Carlos "
# [2,] "COUNTRY" "uruguay " "UK " "USA " "Spain "
# [3,] "EMAIL" "mariaUY@gmail.com" "PaulUK@gmail.com" "JhonUSA@gmail.com" "CarlosSP@gmail.com"


############Exercise 8
# Create a function that takes a numeric vector X and returns the digits 0 to 9 that are not in X. If X<-0 2 4 8
# the function return 1 3 5 6 7 9


############Exercise 9
# Create a function that given two strings (one word each), check if one is an anagram of another (e.g., serpent and present should be true). Hints: check out the packages 'stringr' and 'stringi' and their function stri_extract_all()


########E###Exercise 10
# Create a function that takes one word and returns the position of word's letters in the letters vector. Hints: check out the packages 'stringr' and 'stringi' and their function stri_extract_all().
# For example, if the word is 'abc', the function will return 1 2 3.



# In-class Exercise 3: for loops
############Exercise 1
# 
# Using the following variables:
# x<-1
# i<-c(1:10)
# For this exercise, write a for() loop that increases x by two for each i.


###########Exercise 2
# Using the following variables:
# x<-1
# y<-40
# i<-c(1:10)
# For this exercise, write a for() loop that increases x by three and decreases y by two, for each i.


##########Exercise 3
# Using the following variables:
# a,b
# For this exercise, write a nested for() loop (where the outer for loop increases a from 2 to 8 by 1, and the
# inner for loop increases b from 1 to 6 by 1) that prints "a, ' less than ',b" if a<b.


#########Exercise 4
# Using the following variable:
# x<-c(2,4)
# For this exercise, type a while () loop that adds even numbers to x, while the length of x is less than 12.
# For example, in the first iteration you get x = 2,4,6, and the third x =2,4,6,8.
# 
#########Exercise 5
# Using the following variables:
# a<-15:10
# b<-20:15
# i <- 1
# j <- 6

# For this exercise, write a while() loop that creates the vector x=225 224 221 216 209 200 by using 'i' and 'j' to replicate the following:
# x[1]<-a[1]*b[6]
# x[2]<-a[2]*b[5]
# x[3]<-a[3]*b[5]
# .
# .
# x[6]<-a[6]*b[1]


#########Exercise 6
# Using the following variable:
# a<-1:10
# i<-1
# For this exercise, write a while() loop that creates a vector x=1 3 6 10 15 21 28 36 45 55 by using 'i' to replicate the following:
# x[1]<-a[1]
# x[2]<-a[1]+a[2]
# x[3]<-a[1]+a[2]+a[3]


#########Exercise 7
# Using the following variables:
# i<-10
# x<-10
# For this exercise, write a repeat() (hint: ?repeat, ?break) loop that when decreasing i computes x=x/i until i=0.


#########Exercise 8
# Using the following variables:
# x<-100
# y<-50
# i<-1
# For this exercise, write a repeat() loop that computes x<-x-i and y<-y+i until x<y.
# 
########Exercise 9
# Using the following variable:
# x<-as.Date("10/11/2017","%d/%m/%Y")
# For this exercise, write a repeat() loop that increases x until x is equal to 31/12/2017.


#######Exercise 10
# Using the following variable:
# x<-cbind(c(1,2,3,4,9,7,4,3),c(3,1,2,5,3,6,5,3))
# 
# For this exercise, type a for() loop that calculates y=3 8 18 44 126 140 100 84, by replicating the following:
# y[1]<-x[1,1]*x[1,2]
# y[2]<-x[2,1]*sum(x[1:2,2])
# y[3]<-x[3,1]*sum(x[1:3,2])
# .
# .
# .
# y[8]<-x[8,1]*sum(x[1:8,2])