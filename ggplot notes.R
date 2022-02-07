### Chapter 4 -- Notes

install.packages("ggplot2movies") 
library(ggplot2movies)
library(ggplot2)
names(movies)
dim(movies)
# Any operation can be applied to a facet (slice): 
# in this case, histograms
ggplot(movies) + geom_histogram(aes(x=rating, y=..density..)) #+ facet_wrap(~decade)

ggplot(movies) + geom_histogram(aes(x=rating, y=..density..)) + facet_wrap(~ decade)

# Two-way facets of mpg data: 
# 1.    mpg (in city) vs engine size,
# 2.   plotted in a facet grid of cylinder number vs class

ggplot(data=mpg) + geom_point(mapping=aes(x=displ, y=cty)) +
  facet_grid(cyl~class, margins=TRUE)

p <- ggplot(data=mpg) + geom_point(mapping=aes(x=displ, y=cty)) +
  facet_grid(cyl~class, margins=TRUE)
p
p + facet_grid( row_variable ~ column_variable )

# ==========================================================
# The ddply call has three parts:
ddply(datafm, .(Subject), function(df) data.frame(RT.mean=mean(df$RT)))
# Install and load plyr package.
install.packages("plyr")
library(plyr)

fruit <- data.frame(Region = c("Egham", "Egham", "Staines", "Staines", "Staines", "EGreen", "EGreen")
                    ,Product =c("Orange","Lemon","Carrot","Kiwi","Orange","Lemon","Carrot"), 
                    Sales=c(3,7,10,12,1,23,2))
fruit
print(fruit)
# Total fruit sales and no. of types of fruit sold by region: 
ddply(fruit, .(Region), 
       summarise, total=sum(Sales), typesoffruit=length(unique(Product))) 

length(unique(x))
mean(x)
sd(x)
median(x)
max(x)
min(x)
#
# Pipe operator: %>%
library(ggplot2)
head(diamonds)
# install.packages("tidyverse")
#library(tidyverse)
library(magrittr)

diamonds2<-diamonds %>% mutate(price_per_carat=price/carat)
diamonds2
by_clarity <- diamonds %>% summarise(mean = mean(price), 
                                     lq = quantile(price, 0.25), uq = quantile(price, 0.75) )

by_clarity
by_clarity <- diamonds %>% group_by(clarity) %>% summarise(n = n(), mean = mean(price), 
                                                           lq = quantile(price, 0.25), uq = quantile(price, 0.75) )


















