## CREATING FUNCTIONS



newFunction <- function(xvec, yvec, ...) {
#                     xvec and yvec are arguments that you can pass to the function newFunction
#                     ellipses (...) means that base arguments can be plugged in
    xvec <- xvec-mean(xvec)
    yvec <- yvec-mean(yvec) #this what the argument does when you pass it values [e.g., xvec=XX returns XX-mean(XX)]
    plot(x=xvec, y=yvec, ...) # this will generate a plot as well
    return(cor(x=xvec, y=yvec)) # this returns a correlation value
}

xx <- seq(from=1, to=100,by=1)
yy <- 0.2 + xx*0.5 + rnorm(n=length(xx),mean=0,sd=5)
newFunction(xvec = xx, yvec = yy, main="newFunction")
