#Lab 6 - Visualising Distribution
#Histograms
library(ggplot2)
help("mpg")

ggplot(data=mpg, mapping=aes(x=cty)) + geom_histogram()

ggplot(data=mpg, mapping=aes(x=cty)) + geom_histogram(binwidth=1.0)
ggplot(data=mpg, mapping=aes(x=cty)) + geom_histogram(binwidth=1.2)
ggplot(data=mpg, mapping=aes(x=cty)) + geom_histogram(binwidth=1.4)
ggplot(data=mpg, mapping=aes(x=cty)) + geom_histogram(binwidth=1.8)

#Density plot
ggplot(data=mpg, aes(x=cty)) + geom_density()

ggplot(data=mpg, aes(x=cty, fill = as.factor(cyl))) + geom_density(alpha = 0.5)

#Boxplot
ggplot(data=mpg, aes(as.factor(drv), cty)) + geom_boxplot()
ggplot(data=mpg, aes(as.factor(drv), cty)) + geom_boxplot(notch=TRUE)

ggplot(data=mpg, aes(as.factor(drv), cty)) + geom_boxplot(notch=FALSE)

#Violin plot
ggplot(data=mpg, aes(as.factor(drv), cty)) +
  geom_violin( trim = FALSE, draw_quantiles = c(0.25, 0.5, 0.75), alpha = 0.5 )

#Quantiles and quantile plot
quantile(mpg$cty, probs = c(.1, .3, .5, 1))

ggplot(data=mpg, mapping=aes(sample=cty)) + stat_qq(geom = 'point',distribution = 'qunif') + 
  labs(x='Quantile', y='City MPG', title='Quantile Plot, City MPG')

#Comparing two distributions
library(MASS) # for birthwt data set
library(plyr)
birthwt$smoke = plyr::mapvalues(birthwt$smoke, from = c(0,1), to = c("no","yes"))
birthwt$smoke                                                           

#Visualising the quantiles

ggplot(data = birthwt, mapping = aes(sample = bwt)) +
  stat_qq(geom='point', distribution='qunif') +facet_wrap("smoke") +
  labs(x='Quantiles', y='Birth Weight (g)', title = 'Quantile Plot, Birth Weight
       (Grouped by Smoking)')

# stat_qq() with mappings for both sample and color
ggplot(data = birthwt, mapping = aes(sample = bwt, color=smoke)) +
  stat_qq(distribution='qunif') + 
  labs(x='Quantiles', y='Birth Weight (g)', color = 'Smoking Status', title = 'Quantile Plot, Birth Weight (Grouped by Smoking)')

#Quantile-Quantile Plots
# select some quantiles to compute:
selected.quantiles = seq(from = 0, to = 1, length.out = 10)

# compute the quantiles at the selected values
q1 = with(birthwt, quantile( bwt[ smoke == 'no'], probs = selected.quantiles))
q2 = with(birthwt, quantile( bwt[ smoke == 'yes'], probs = selected.quantiles))
q1
q2
# print a little data frame showing the quantiles
data.frame(no.smoke = q1, yes.smoke = q2)

ggplot(mapping = aes(x=q1, y=q2)) + geom_point() + geom_abline(intercept=0,slope=1) +
  labs(x = 'smoke == no', y ='smoke == yes', title = 'QQ plot, Birth Weight grouped by Smoking Status')

# how big is the smaller group?
n.pts = with(birthwt, min( length(bwt[ smoke == 'no' ]), length(bwt[ smoke == 'yes']) ) )
n.pts    
# which quantiles should we plot in the QQ plot?
probs = seq(from = 0, to = 1, length.out = n.pts)
probs

# extract the quantiles
q1 = with(birthwt, quantile( bwt[ smoke == 'no'], probs = probs))
q1
q2 = with(birthwt, quantile( bwt[ smoke == 'yes'], probs = probs))
q2
# make a QQ plot
ggplot(mapping = aes(x=q1, y=q2)) + geom_point() + geom_abline(intercept=0, slope=1) +
  labs(x = 'smoke == no', y ='smoke == yes', title = 'QQ plot, Birth Weight grouped by Smoking Status')

#Built-in function in base graphics is convenient:
# qqplot() makes QQ plot from x and y vectors
# with() makes it more readable

with(birthwt, qqplot(x = bwt[ smoke == 'no'], y = bwt[ smoke == 'yes'], main='QQ plot'))
# abline() adds a reference line, with y intercept 0 and slope abline(0,1)

##################################################################
#Reading a QQ plot

#Theoretical QQ plot
#Let's compare the quantiles of birthwt$bwt to those of a Normal(0,1) distribution, in a QQ plot.

# which quantiles do we want to compare?
n.pts = length(birthwt$bwt)
n.pts
# we want to compare the quantile corresponding to each data point
probs = seq(from=0, to=1, length.out = n.pts)
probs
# get those quantiles from birthwt$bwt
q1 = quantile(birthwt$bwt, probs = probs)
q1
# get the same quantiles from a normal distribution (new function!)
q2 = qnorm(p = probs)
q2
# make the QQ plot
install.packages("plyr")
library(plyr)

q1 = with(birthwt, quantile( bwt[ smoke == 'no'], probs = probs))
q2 = with(birthwt, quantile( bwt[ smoke == 'yes'], probs = probs))

ggplot(mapping = aes(y=q1, x=q2)) + geom_point() +
  geom_abline(intercept=2944, slope=729) +
  labs(x = 'Normal Quantiles', y ='Birthweight', title = 'QQ plot, Birth Weight vs Normal Distribution') + 
  annotate(geom = 'text',  x= 0, y=1000, label='Ref. Line: y = 729 x + 2944', hjust=0)



bwt.standardized = with(birthwt, (bwt - mean(bwt))/sd(bwt))
ggplot(mapping=aes(sample = bwt.standardized)) +
  stat_qq(distribution='qnorm') +
  geom_abline(intercept=0, slope=1) +
  labs(x = 'Normal Quantiles', y ='Birthweight (standardized)',title = 'QQ plot, Birth Weight (standardized) vs Normal Distribution')

###################################################################
#Excises
#Generate a violin plot, boxplot, histogram, density plot, and quantile plot for the following data.
library(tibble)
help("tibble")

dogs <- tibble( breed = rep(c("beagle", "boxer", "bulldog"), each = 100),weight = c( rnorm(100, 24, 6), rnorm(100, 62.5, 12.5),rnorm(100, 45, 5)))
dogs
#violin plot
ggplot(data=dogs, aes(as.factor(breed), weight)) +
  geom_violin( trim = FALSE, draw_quantiles = c(0.25, 0.5, 0.75), alpha = 0.5 )
# boxplot
ggplot(data=dogs, aes(as.factor(breed), weight)) + geom_boxplot()
ggplot(data=dogs, aes(as.factor(breed), weight)) + geom_boxplot(notch=TRUE)
ggplot(data=dogs, aes(as.factor(breed), weight)) + geom_boxplot(notch=FALSE)

#histogram
ggplot(data=dogs,mapping=aes(x= weight)) + geom_histogram(binwidth=1.8)
ggplot(data=dogs,mapping=aes(x= breed)) + geom_histogram(binwidth=0.2)
#density plot
ggplot(data=dogs, aes(x=weight)) + geom_density()

ggplot(data=dogs, aes(x=weight, fill = as.factor(breed))) + geom_density(alpha = 0.5)
#quantile plot
ggplot(data=dogs, mapping=aes(sample=weight)) + stat_qq(geom = 'point',distribution = 'qunif') + 
  labs(x='Quantile', y='weight dogs', title='Quantile Plot, weight dogs')