### Lab 1 - ggplot2

## Getting started 

install.packages("ggplot2")
install.packages("gcookbook")
library(ggplot2)
library(gcookbook)

## Introduction to ggplot2
help.search("geom_", package = "ggplot2")

#ggplot(data = <DATA>,
#       mapping = aes(<MAPPING>)) +
#  <GEOM_FUNCTION>(
#    stat = <STAT>,
#    position = <POSITION>
#  ) +
#  <COORDINATE_FUNCTION> +
#  <FACET_FUNCTION>

# ggplot syntax looks like this
ggplot(dataset, aes(xaxis, yaxis)) +
geom_something() +
geom_somethingElse()

## Task 1: the height weight data set

heightweight
str(heightweight)
?heightweight

p <- ggplot( heightweight, aes(x=ageYear, y=heightIn, color=sex))
class(p)
str(p)
p

ggsave()

p+ geom_point()
p + geom_point(size=1.0) 
p + geom_point(size=20.0)
p + geom_line()
p + geom_point() + geom_smooth()

names(heightweight) 

p <- ggplot( heightweight, aes(x=ageYear, y=weightLb, color=sex))
p + geom_point() + geom_smooth()

#bmi = 703 * weight/height^2
heightweight$heightIn
heightweight$heightIn^2 
heightweight$bmi <- 703 * heightweight$weightLb/heightweight$heightIn^2
heightweight$bmi

p <- ggplot( heightweight, aes(x=ageYear, y=bmi, color=sex))
p + geom_point() + geom_smooth()

###Task 2: the diamonds dataset
