# These exercises were adapted from R-exercises.com

####################

#                  #

#    Exercise 1    #

#                  #

####################

# Create a function that given a data frame and a vector, will add a the vector (if the vector length match with the rows number of the data frame)

# as a new variable to the data frame. 


Id<-rep(c(1,2,3,4),each=3)
Letter<-rep(letters[1:3],4)
x<-seq(1,43,along.with=Id)
y<-seq(-20,0,along.with=Id)
M<-data.frame(Id,Letter,x,y)

ADD_COL<-function(M,v) {
  if(nrow(M)==length(v))
    M<-cbind(M,v)
  return(M)
}

z<-seq(1,100,along.with=Id)
M<-ADD_COL(M,z)

u<-c(1:10)
M<-ADD_COL(M,u)


w<-seq(0,20,along.with=Id)
M<-ADD_COL(M,w)

M
##    Id Letter         x          y   v         v
## 1   1      a  1.000000 -20.000000   1  0.000000
## 2   1      b  4.818182 -18.181818  10  1.818182
## 3   1      c  8.636364 -16.363636  19  3.636364
## 4   2      a 12.454545 -14.545455  28  5.454545
## 5   2      b 16.272727 -12.727273  37  7.272727
## 6   2      c 20.090909 -10.909091  46  9.090909
## 7   3      a 23.909091  -9.090909  55 10.909091
## 8   3      b 27.727273  -7.272727  64 12.727273
## 9   3      c 31.545455  -5.454545  73 14.545455
## 10  4      a 35.363636  -3.636364  82 16.363636
## 11  4      b 39.181818  -1.818182  91 18.181818
## 12  4      c 43.000000   0.000000 100 20.000000
####################

#                  #

#    Exercise 2    #

#                  #

####################

#Consider a data frame df:

Id<-c(1:10)
Age<-c(14,12,15,10,23,21,41,56,78,12)
Sex<-c('F','M','M','F','M','F','M','M','F','M')
Code<-letters[1:10]
df<-data.frame(Id,Age,Sex,Code)
#Create a function that, given a data frame and two indexes, exchanges two values of the Code variable with each other. 

#For example, if the index is 1 and 3, you assign:#df[1,'Code']=df[3,'Code']

#df[3,'Code']=df[1,'Code']


change<-function(df,a,b) {
  aux<-df[a,'Code']
  df[a,'Code']<-df[b,'Code']
  df[b,'Code']<-aux
  return(df)
}

df<-change(df,1,3)
df<-change(df,7,2)
df<-change(df,5,10)
df
##    Id Age Sex Code
## 1   1  14   F    c
## 2   2  12   M    g
## 3   3  15   M    a
## 4   4  10   F    d
## 5   5  23   M    j
## 6   6  21   F    f
## 7   7  41   M    b
## 8   8  56   M    h
## 9   9  78   F    i
## 10 10  12   M    e
####################

#                  #

#    Exercise 3    #

#                  #

####################

# Consider two variables x,y and a data frame df:

#  x,y integer

# A<-c(1:10)

# B<-seq(100,10,-10)

# H<-seq(-200,-50,along.with=B)

# df<-data.frame(A,B,H)

# Create a function that given a data frame df calculate a new variable 'SUM_x_y'(If x=2 and y=3, then the new variable will be 'SUM_2_3', 

# if x=4 and y=10, then the new variable will be 'SUM_4_10'),such that for each row 'i' is:

#  sum(x*df[1:i,1])+sum(y*df[1:i,2])


A<-c(1:10)
B<-seq(100,10,-10)
H<-seq(-200,-50,along.with=B)
df<-data.frame(A,B,H)

NEWDF<-function(df,x,y) {
  for (i in 1:nrow(df)) {
    df[i,4]<-sum(x*df[1:i,1])+sum(y*df[1:i,2])
  }
  names(df)[4]<-paste('SUM',x,y,sep='_')
  return(df)
}

NEWDF(df,3,6)
##     A   B          H SUM_3_6
## 1   1 100 -200.00000     603
## 2   2  90 -183.33333    1149
## 3   3  80 -166.66667    1638
## 4   4  70 -150.00000    2070
## 5   5  60 -133.33333    2445
## 6   6  50 -116.66667    2763
## 7   7  40 -100.00000    3024
## 8   8  30  -83.33333    3228
## 9   9  20  -66.66667    3375
## 10 10  10  -50.00000    3465
NEWDF(df,7,5)
##     A   B          H SUM_7_5
## 1   1 100 -200.00000     507
## 2   2  90 -183.33333     971
## 3   3  80 -166.66667    1392
## 4   4  70 -150.00000    1770
## 5   5  60 -133.33333    2105
## 6   6  50 -116.66667    2397
## 7   7  40 -100.00000    2646
## 8   8  30  -83.33333    2852
## 9   9  20  -66.66667    3015
## 10 10  10  -50.00000    3135
####################

#                  #

#    Exercise 4    #

#                  #

####################

#Create a function that given a numeric vector, sort this in ascending order and duplicate it by two.


FUNVector1<-function(v) {
  v<-sort(v)*2
  return(v)
}
v<-c(2,4,1,7,3,2,7,9)
FUNVector1(v)
## [1]  2  4  4  6  8 14 14 18
####################

#                  #

#    Exercise 5    #

#                  #

####################

# Create a function that given a vector alpha numeric, keep only the numbers, and apply the function created on exercise 4.

# For example, if the input is a vector <code>w="a" "v" "7" "4" "q"</code> , the function will return <code>w=8 14</code>.


FUNVector2=function(w) {
  w<-as.numeric(w[-which(w %in% letters)])
  print(w)
  w<-FUNVector1(w)
  return(w)
}

a<-c('a','v',4,7,'q')
a<-FUNVector2(a)
a
## [1]  8 14
b<-c(letters[1:23],10:1,letters[24:26],11:22)
b<-FUNVector2(b)
b
##  [1]  2  4  6  8 10 12 14 16 18 20 22 24 26 28 30 32 34 36 38 40 42 44
####################

#                  #

#    Exercise 6    #

#                  #

####################

# Create a function that given a string 

# ST='NAME: Maria /COUNTRY:uruguay /EMAIL: mariaUY@gmail.com'

# return a data.frame

#      [,1]      [,2]              

# [1,] "NAME"    " Maria "         

# [2,] "COUNTRY" "uruguay "        

# [3,] "EMAIL"   " mariaUY@gmail.com"

# 

ST<-'NAME: Maria /COUNTRY:uruguay /EMAIL: mariaUY@gmail.com'
DF<-function(ST) {
  A<-unlist(strsplit(ST,'/'))
  M<-rbind(unlist(strsplit(A[1],':')),unlist(strsplit(A[2],':')),unlist(strsplit(A[3],':')))
  return(M)
}
M<-DF(ST)
M
##      [,1]      [,2]                
## [1,] "NAME"    " Maria "           
## [2,] "COUNTRY" "uruguay "          
## [3,] "EMAIL"   " mariaUY@gmail.com"
####################

#                  #

#    Exercise 7    #

#                  #

####################

# Consider a vector:

 ST<-c('NAME:Maria /COUNTRY:uruguay /EMAIL:mariaUY@gmail.com','NAME:Paul/COUNTRY:UK /EMAIL:PaulUK@gmail.com','NAME:Jhon /COUNTRY:USA /EMAIL:JhonUSA@gmail.com','NAME:Carlos /COUNTRY:Spain /EMAIL:CarlosSP@gmail.com')

# Create a function that given a vector string ST return a matrix:

#     [,1]      [,2]                [,3]               [,4]                [,5]                

# [1,] "NAME"    "Maria "            "Paul"             "Jhon "             "Carlos "           

# [2,] "COUNTRY" "uruguay "          "UK "              "USA "              "Spain "            

# [3,] "EMAIL"   "mariaUY@gmail.com" "PaulUK@gmail.com" "JhonUSA@gmail.com" "CarlosSP@gmail.com"


ST<-c('NAME:Maria /COUNTRY:uruguay /EMAIL:mariaUY@gmail.com','NAME:Paul/COUNTRY:UK /EMAIL:PaulUK@gmail.com','NAME:Jhon /COUNTRY:USA /EMAIL:JhonUSA@gmail.com',
     'NAME:Carlos /COUNTRY:Spain /EMAIL:CarlosSP@gmail.com')
DF2<-function(V) {
  M<-DF(V[1])
  for (i in 2:length(V)) {
    M<-cbind(M,DF(V[i])[,2])
  }
  return(M)
}
DF2(ST)
##      [,1]      [,2]                [,3]               [,4]               
## [1,] "NAME"    "Maria "            "Paul"             "Jhon "            
## [2,] "COUNTRY" "uruguay "          "UK "              "USA "             
## [3,] "EMAIL"   "mariaUY@gmail.com" "PaulUK@gmail.com" "JhonUSA@gmail.com"
##      [,5]                
## [1,] "Carlos "           
## [2,] "Spain "            
## [3,] "CarlosSP@gmail.com"
####################

#                  #

#    Exercise 8    #

#                  #

####################

#Create a function that given a numeric vector X returns the digits 0 to 9 that are not in X


DIGITS<-function(X) {
  b<-0:9
  Y<-b[!b%in%a]
  return(Y)
}
a<-c(1,5,3,8)
DIGITS(a)
## [1] 0 2 4 6 7 9
####################

#                  #

#    Exercise 9    #

#                  #

####################

#Create a function that given two strings, check if one is an anagram of another.

library('stringr')
library('stringi')
ANAGRAM<-function(a,b) {
  x<-unlist(stri_extract_all(a, regex=c('\\p{L}')))
  y<-unlist(stri_extract_all(b, regex=c('\\p{L}')))
  if (length(x)==length(y)) {
    cond<-unique(x%in%y==y%in%x)
    cat('anagram:',ifelse(length(x)==length(y) & length(cond)==1,ifelse(cond==TRUE,TRUE,FALSE),FALSE))
  }
  if (length(x)!=length(y)) {
    cat('anagram: FALSE')
  }
}
a<-'serpent'
b<-'present'
ANAGRAM(a,b)
## anagram: TRUE
x<-'married'
y<-'admirer'
ANAGRAM(x,y)
## anagram: TRUE
x<-'Deduction'
y<-'Discounted'
ANAGRAM(x,y)
## anagram: FALSE
####################

#                  #

#    Exercise 10   #

#                  #

####################

#Create a function that given one word, return the position of word's letters on letters vector.


ORDERWORD <- function(a) {
  x<-unlist(stri_extract_all(a, regex=c('\\p{L}')))
  POSITION<-which(letters%in%x)
  return(POSITION)
}
a<-'hello'
ORDERWORD(a)
## [1]  5  8 12 15