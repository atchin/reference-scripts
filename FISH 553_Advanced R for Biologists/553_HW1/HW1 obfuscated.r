#Question 1, homework 1
#rewrite this code including better indentation, comments, 
#and meaningful variable and function names, so that its use 
#can be better understood.

O<-function(l,O,...){
   o<-par("usr")
   O0<-o[1]+O[1]*diff(o[1:2])
   o0<-o[3]+O[2]*diff(o[3:4])
   text(x=O0,y=o0,l=l,...)
   }
plot(1,1);O(l="(a)",O=c(.05,.95))