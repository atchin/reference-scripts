# These exercises were adapted from R-exercises.com

####################

#                  #

#    Exercise 1    #

#                  #

####################

#Using the following variables:

x<-1
i<-c(1:10)
#For this exercise, write a for() loop that increments x in two for each i.

x.seq <- c()
for (j in i) {
  x<-x+2
  x.seq[j] <- x
}  
x
x.seq
## [1] 21
####################

#                  #

#    Exercise 2    #

#                  #

####################

#Using the following variables:


x<-1
y<-40
i<-c(1:10)

#For this exercise, write a for() loop that increments x by three 

#and decrease y by two, for each i.

for (j in i) {
  x<-x+3
  y<-y-2
}
x
## [1] 31
y
## [1] 20
####################

#                  #

#    Exercise 3    #

#                  #

####################

# Using the following variables:

# # a,b

# 

# For this exercise, write a nested for() loop (where the outer for loop increment "a" from 2 to 8 by 1, and the # inner for loop increment "b" from 1 to 6 by 1) that print "a, ' less than 'b" if a<b.


 for (a in 2:8) {
   for (b in 1:6) {
     if (a<b)
       cat(a,'less than',b,'\n')
   }
 }
## 2 less than 3 
## 2 less than 4 
## 2 less than 5 
## 2 less than 6 
## 3 less than 4 
## 3 less than 5 
## 3 less than 6 
## 4 less than 5 
## 4 less than 6 
## 5 less than 6
####################

#                  #

#    Exercise 4    #

#                  #

####################

#Using the following variable:

x<-c(2,4)

#For this exercise, type a while () loop that adds even numbers to x, while the length of x is less than 12.

#For example, in the first iteration you get x = c (2,4,6), and the third x = (2,4,6,8).

i<-6
while (length(x)<12) {
  x<-c(x,i)
  i<-i+2
}
x
##  [1]  2  4  6  8 10 12 14 16 18 20 22 24
####################

#                  #

#    Exercise 5    #

#                  #

####################

#Using the following variable:

a<-15:10
b<-20:15
#For this exercise, type a while () loop that computes a vector

#x=225 224 221 216 209 200

#,such that 

# x[1]=a[1]*b[6]

# x[2]=a[2]*b[5]

# x[3]=a[3]*b[5]

x<-c()
i<-1
j<-6
while (i<7) {
  x[i]<-a[i]*b[j]
  i<-i+1
  j<-j-1
}

x
## [1] 225 224 221 216 209 200
####################

#                  #

#    Exercise 6    #

#                  #

####################


#Using the following variable:


a<-1:10
#For this exercise, type a while () loop that computes a vector<code> x=1  3  6 10 15 21 28 36 45 55 ,such that 

# x[1]=a[1]

# x[2]=a[1]+a[2]

# x[3]=a[1]+a[2]+a[3]

i<-1
x<-c()
while (i<=10) {
  x[i]<-sum(a[1:i])
  i<-i+1
}

####################

#                  #

#    Exercise 7    #

#                  #

####################


#Using the following variable:

i<-10
x<-10
#For this exercise, type a repeat () loop that decreasing i computes x=x/i until i=0.


repeat {
  x<-x/i
  print(x)
  i<-i-1
  if (i==0) {
    break
  }
}
## [1] 1
## [1] 0.1111111
## [1] 0.01388889
## [1] 0.001984127
## [1] 0.0003306878
## [1] 6.613757e-05
## [1] 1.653439e-05
## [1] 5.511464e-06
## [1] 2.755732e-06
## [1] 2.755732e-06
####################

#                  #

#    Exercise 8    #

#                  #

####################


#Using the following variable:

x<-100
y<-50
i<-1
#For this exercise, type a repeat () loop that incrementing i computes x=x/i and y=y*i until x<y.

repeat {
  x<-x-i
  y<-y+i
  if (x<y) {
    break
  }
}
x
## [1] 74
y
## [1] 76
####################

#                  #

#    Exercise 9    #

#                  #

####################


#Using the following variable:

x<-as.Date("10/11/2017","%d/%m/%Y")
#For this exercise, type a repeat () loop that increment x until x is equal to 31/12/2017.

y<-as.Date("31/12/2017","%d/%m/%Y")
repeat {
  x<-x+1
  if (x==y) {
    break
  }
}

####################

#                  #

#    Exercise 10   #

#                  #

####################

#Using the following variable:

x<-cbind(c(1,2,3,4,9,7,4,3),c(3,1,2,5,3,6,5,3))
# 

# For this exercise, type a for() loop that calculate y=3   8  18  44 126 140 100  84, such that


# y[1]=x[1,1]*x[1,2]

# y[2]=x[2,1]*sum(x[1:2,2])

# y[3]=x[3,1]*sum(x[1:3,2])

# .

# .

# .

# y[8]=x[8,1]*sum(x[1:8,2])


y<-c()
for (i in 1:nrow(x)) {
  y[i]<-x[i,1]*sum(x[1:i,2])
}
y
## [1]   3   8  18  44 126 140 100  84