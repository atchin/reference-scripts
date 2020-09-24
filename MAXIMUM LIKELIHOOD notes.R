# MAXIMUM LIKELIHOOD + in-class exercises

# using the Von Bertalanffy Growth model, which predicts a fish's length at a specific age

# model equations are hypotheses
# parameters =/= likelihood


L = Linf (1- exp[-K*a])+e, e~N(0,sigma^2)

Length and age (a) are observed data
Linf and K(appa) are model parameters
e(psilion) and signma are errors - in both environment and data collection (aka process error)
      - error hedges our bets and justifies uncertainty and imperfect sampling

setwd("C:\\Users\\Andrew Chin\\Documents\\UW AU19\\FISH 552_3\\FISH.552_workspace\\553_HW2")



function(Linfinity, K, gender, filename, ...) {
   read.csv(filename, header=T)
   
}

# finding Maximum Likelihood Estimates (MLE)

for every data point, calculate the likeligoos from a normal distribution given predicted valyes and a standard deviation

MLE output parameters