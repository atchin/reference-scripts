# Name: Andrew Chin
# Homework 1

setwd("~/UW AU19/FISH 552_3/FISH.552_workspace/553_HW1")

#==Question 1
caption <- function(label,coord,...) {
   fix.region <- par("usr") #par() indicates plotting region; is a vector
   xCoord <- fix.region[1]+coord[1]*diff(fix.region[1:2])
   yCoord <- fix.region[3]+coord[2]*diff(fix.region[3:4])
   text(x=xCoord,y=yCoord,label=label,...)
   }
plot(1,1)
caption(label = "(a)", coord=c(.05,.95))

#==Question 2a
# CL.theorem <- function(n, mean, sd, breaks, ...) {
#    set.seed(420)
#    rando <- rnorm(n=n, mean=mean, sd=sd)
#    rsample <- sample(rando, size = n)
#    plot(hist(rsample, breaks = breaks))
#    print(mean(rsample))
# }

CL.theorem <- function(n, mean, sd, breaks, ...) {
   # set.seed(420)
   # for (i in n) {
   rando <- rnorm(n=i, mean=mean, sd=sd)
   rsample <- sample(rando, size = i)
   plot(hist(rsample, breaks = breaks))
   print(mean(rsample))
   # }
}


#==Question 2b
# Nrandom <- c(5,10,20,30,50,100,500,1000,5000,10000)
# Nrandom

pdf(file = "HW1_Q2b.pdf", paper = "letter")

# CL.theorem(n=Nrandom, 
#            mean = 50,
#            sd = 2,
#            breaks = 5)
dev.off()

#==Question 2c
# using the apply function like using a loop?
pdf(file = "HW1_Q2c.pdf", paper = "letter")
apply(X = Nrandom, MARGIN = 1, FUN = CL.theorem, mean = 50,
                                                 sd = 2,
                                                 breaks = 5)
dev.off()
