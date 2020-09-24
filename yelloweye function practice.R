setwd("~/UW AU19/FISH 552_3/FISH.552_workspace/Data")
Yelloweye <- read.csv("YERockfish.csv", header=T)

head(Yelloweye)


length_means <- tapply(X=Yelloweye$length, 
                    INDEX=Yelloweye$maturity, FUN=mean)
length_means
age_means <- tapply(X=Yelloweye$age, 
                    INDEX=Yelloweye$maturity, FUN=mean)
age_means
plot(x=Yelloweye$age, y=Yelloweye$length,
     xlab = "Age", ylab = "Length")
abline(h=length_means["Immature"])
abline(h=length_means["Mature"])

length.age.mat <- function(length, age, maturity){
length_means <- tapply(X=length, 
                       INDEX=maturity, FUN=mean)
print(length_means) #convert the 'global' arguments to 'local' arguments
age_means <- tapply(X=age, 
                    INDEX=maturity, FUN=mean)
print(age_means) #convert the 'global' arguments to 'local' arguments
plot(x=age, y=length,
     xlab = "Age", ylab = "Length")
abline(h=length_means["Immature"])
abline(h=length_means["Mature"])
}

# test it out!
length.age.mat(length = Yelloweye$length, age = Yelloweye$age, maturity = Yelloweye$maturity)
