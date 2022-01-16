## CS5250: Lab Worksheet 0 - Introduction to R
# Type 'demo()' for some demos,
demo() 
# 'help()' for on-line help, or
#'help.start()' for an HTML browser interface to help.

help()
help.start()
q()

# Basic Commands
x <- 17.3
7*x
remove(x)

getwd() # Prints your working directory.

# Vectors
v <- c( 1.1, 2.2, 17.3, -23, 4, 0)
v
v[1]
v[2:5]
boolv <- v < 3
boolv 
v[ boolv ]
v[ v < 3 ]

# Lists
mylist <- list( alf=34, bert=c(2,3,4,5), 17.3, pain="wisdom tooth")
mylist
mylist$alf
mylist$pain
mylist[2]
class( mylist )
class( mylist[2] )

mylist[[2]]
class( mylist[[2]] )
class( mylist $bert )

mylist$bert <- NULL
mylist
mylist$bert

### Data Frames
mydf <- data.frame(row.names= c("alf","bert", "r2d2"),
                   sex=c("M","F","R"),
                   age=c(20,21,3) )
mydf
mydf[c(FALSE,TRUE,TRUE), ]
mydf
mydf$age
class( mydf)
class(mydf$sex)

mydf$sex<- as.factor(mydf$sex)
class(mydf$sex)

# Functions
area <- function(radius) {
  pi * radius^2
}
area(10)

# The Pipe: a tidy operator for functions
library(tidyr) # %>% originally from library(magrittr)
x <- rnorm(1000, mean = 100) # # 1,000 random normal draws
x
x %>% range
x %>% scale %>% abs %>% range %>% round(1)

y <- x %>% scale %>% abs %>% range %>% round(1)
y

### Loading data
read.table() 
write.table()
getwd()
setwd()

Auto <- read.table("Auto.txt")
fix(Auto)

tab <- read.table("Auto.data", sep=",", header=TRUE, comment.char="#",
                  na.strings="?", stringsAsFactors=FALSE,
                  quote="", fill=FALSE)
fix(tab)

Auto<-read.table("Auto.data", sep=",",header=T, na.strings="?", quote="")

Auto <- read.table("Auto.data", header=T, na.strings="?")
fix(Auto)
Auto<-na.omit(Auto)
dim(Auto)
names(Auto)

### Writing scripts in R
if (2 > 0) {
  i <- 2
  print (i)
}

source("script.R")

## Saving plots in R
jpeg("plot1.jpg")
cars<-c(1, 3, 6, 4, 9)
plot(cars, type="o", col="blue")
title(main="Autos", col.main="red", font.main=4)
dev.off()
