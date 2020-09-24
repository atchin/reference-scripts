# SHAD STUFF

labels(BON.fishPassage)
BON.fishPassage <- fishPassage[fishPassage$Dam=="BON",]
BON.fishPassage[,c(1,11)]
plot(Shad~Year, data=BON.fishPassage, xlim=c(1939,2008), col="blue", xaxs="i", yaxs="i")


plot(Shad~Year, data=fishPassage, xlim=c(1939,2008), col="blue", xaxs="i", yaxs="i")
