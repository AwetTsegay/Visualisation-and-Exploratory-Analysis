### lab 1 - Exercise

# For this exercise we are using the iris data set available in R.

# 1. Make a scatter plot of sepal length vs. petal length for the three species. Make a single plot 
# that shows the data for all three species at once, in different colours.

library(ggplot2)
names(iris)
head(iris, 10)
ggplot(iris, aes(x=Sepal.Length, y=Petal.Length, color=Species)) + geom_point()

ggplot(iris, aes(x=Sepal.Width, y=Petal.Width, color=Species)) + geom_point()

# 2. Now try to show the data for all three species at once, in different colours and shapes.

ggplot(iris, aes(x=Sepal.Length, y=Petal.Length, shape=Species, color=Species)) + 
  geom_point()

# 3. Finally, add a fitted least squares line (straight black line) to each group of points.

ggplot(iris, aes(x=Sepal.Length, y=Petal.Length, color=Species)) + geom_point() + 
  geom_smooth(aes(group=Species), method='lm', color='black', formula=y~x, se=F)


