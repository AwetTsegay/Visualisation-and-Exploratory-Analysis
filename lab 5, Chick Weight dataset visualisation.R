#CS4250/CS5250: Lab Worksheet 5 - Chick Weight data set
install.packages("datasets") 
library(datasets)
data()
fix(ChickWeight)
str(ChickWeight)
names(ChickWeight)
#It's annoying that some of the names are capitalized 
#and some are not. 
# We can fix this and have everything lower case: 
chickweight <- ChickWeight
names(chickweight) <- tolower(names(chickweight))
?tolower
str(chickweight)
names(chickweight)

boxplot(weight~time, data = chickweight, 
        xlab="time", ylab="weight")
?boxplot
#=============== Subset data #=====================
#If we only want the weights of each chick on day 21, 
# we can subset the data:
cw21 <- subset(chickweight, time == 21)
summary(cw21)
?summary
?subset
is.na(chickweight)
?is.na
anyNA(chickweight, recursive = FALSE)
# find how many chicks on diet 1 have weights over 250 on day 21:
cw21.subset2 <- cw21[(cw21$diet == "1" & cw21$weight >= 250), ]
cw21.subset2
cw21.subset3 <- cw21[ ,(cw21$diet == "1" & cw21$weight >= 250)]
cw21.subset3 
#=========================================================
#================= Using plyr package #===================
?plyr
install.packages("plyr")
library(plyr) 
library(ggplot2)

p <- ggplot(chickweight,aes(x=time,y=weight, 
                            colour=diet, 
                            group=chick)) + geom_line()
p
?ggplot
#Let's summarise to mean weight for each diet on each day

chicksummary1 <- ddply( chickweight, .(diet,time), summarise,
                        meanweight=mean(weight) )
str(chicksummary1) 
names( chicksummary1)
chicksummary1
?ddply
p <- ggplot( chicksummary1, aes(x=time,y=meanweight,colour=diet)) +
  geom_line()
p
p + scale_y_log10()+ylab("log of meanweight")

#------------------------------------------------------------
#================== Challenges: #=====================
cw21 <- subset(chickweight, time == 21)
cw1 <- subset(chickweight, diet == 1 )
summary(cw1)
cw21.subset2 <- cw21[(cw21$diet == "1"),]
cw21.subset2

#Challenges:
?datasets
library(datasets)
library(plyr) 
library(ggplot2)
names(ChickWeight)
dim(ChickWeight)
fix(ChickWeight)
ChickWeight
# weight - a numeric value giving the body weight of the chick (gm). 
# Time - the number of days since birth when the measurement was made. 
# Chick - a unique identifier for the chick. 
# Diet - indicating which experimental diet the chick received.

#1.
#a) How many chicks were fed each diet?
chickweight <- ChickWeight
names(chickweight) <- tolower(names(chickweight))

chicksummary2a <- ddply( chickweight, .(diet), 
                         summarise,
                         numberofchick=max(chick))
chicksummary2a

#b How many chicks, fed each diet, died early? 
# Which day did they die?
chicksummary1b <- ddply( chickweight, .(diet), summarise,
                         lastday=max(time),
                         numberofchick=max(chick))
chicksummary1b                

#Q2
p <- ggplot(chickweight, aes(x=time, y=weight, colour=diet)) +
  geom_point()

p+facet_grid(diet~.)
?geom_point()
?facet_grid

#Q3
ggplot(chickweight, aes(x=time,y=weight, 
                        colour=diet, group=chick))+ 
  geom_boxplot()+
  scale_x_continuous(breaks = NULL)
?geom_boxplot()
?scale_x_continuous

