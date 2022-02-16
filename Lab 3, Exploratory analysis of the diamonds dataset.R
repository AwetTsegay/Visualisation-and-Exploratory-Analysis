#CS5250: Lab Worksheet 3 - Exploratory analysis of the diamonds data set
#--use this to update all the packages -- update.packages(ask=FALSE)
library(ggplot2)
#If p is a ggplot object, you can add a title with:
p + ggtitle("My title here")
p + xlab("x axis label") + ylab("y axis label")

help("diamonds")
str(diamonds)
dim(diamonds)
head(diamonds)
names(diamonds)

p <- ggplot(diamonds,
            aes(x=1:nrow(diamonds), y=price)) + 
  geom_point()
p

p + scale_x_continuous(limits=c(43700,44100))
?scale_x_continuous
p <- ggplot(diamonds,aes(x=1:nrow(diamonds), 
                         y=price)) + 
  geom_point()+scale_y_log10()
p 
p+ ylab("log10(price)")+xlab("The number of rows")+
  ggtitle("Plot of logged price Vs the physical ordering of the data")

p+ ylab("log10(price)")+xlab("The number of rows")+
  ggtitle("Plot of logged price Vs the physical ordering of the data and scaled")+
  scale_x_continuous(limits=c(43700,44100))

?scale_x_continuous

p + ylab("log10(price)")+scale_x_continuous(limits=c(43700,44100))

p <- ggplot( diamonds[43700:44100, ], 
             aes(x=43700:44100,y=price)) + 
  geom_point()
p
#Add titles and axis labels to these graphs and save them into your worksheet. 
p + ggtitle("ggplot of diamonds dataset") + xlab("diamonds[43700:44100]") + ylab("price")
###############################################################################


#2.2 Checking consistency of x, y, and z measurements with weight (carat)
p <- ggplot(diamonds,aes(x=x*y*z, y=carat)) + geom_point()
p
p+scale_x_log10()+scale_y_log10()+xlab("volume (x*y*z)")+ylab("weight (carat)")+
  ggtitle("Scatterplot of x*y*z Vs carat")
which.max(diamonds)
?which.max()
#2.3 Studying the distributions of the variables
#Letâ€™s start with weight (measured in carats): 
p <- ggplot(diamonds, aes(x=carat)) + geom_histogram()
p
?geom_histogram
diamond$carat

geom_histogram(center=0.01,binwidth=0.01)

p <- ggplot(diamonds,aes(x=carat, fill=clarity)) +
  geom_histogram(center=0.01,binwidth=0.01) 
p
?scale_x_continuous
#The seq function
?seq

caratbreaks <- seq(0.2,5.2,by=0.1)
p + scale_x_continuous(breaks=caratbreaks)

caratbreaks <- seq(0.2,1.5,by=0.1)
p + scale_x_continuous(breaks=caratbreaks)+ylab("Number of diamonds")

#2.4 Checking the distribution of prices
p <- ggplot(diamonds,aes(x=price, fill=clarity)) + geom_histogram()
p
p+geom_histogram(binwidth=300)

p <- ggplot(diamonds,aes(x=price, fill=clarity)) + geom_histogram(binwidth=300)
p
p + scale_x_continuous(minor_breaks=seq(500,15000, by=100), limits=c(1000,2000))

p <- ggplot(diamonds,aes(x=price, fill=clarity)) + geom_histogram(binwidth=300)+
  scale_x_continuous(minor_breaks=seq(500,15000, by=100), limits=c(1000,2000))
p

# Q3. How is weight (in carats) related to price? 
#Produce a scatterplot of price versus weight in carats.
#3.1 According to Messingâs theory, price is proportional to exp( C x weight1/3). Is this
#plausible? 
aes(x=carat^(1/3), y=price)
p <- ggplot(diamonds,aes(x=carat^(1/3), y=price)) + geom_point()
p
p+scale_y_log10()+ylab("log10(price)")

#3.2 Might a power law fit the data better? 
p <- ggplot(diamonds,aes(x=carat, y=price)) + geom_point()
p
p+scale_x_log10()+scale_y_log10()+xlab("log10(carat)")+ylab("log10(price)")

#Q4. What are the distributions of clarity, colour, and cut? 
ggplot(diamonds, aes(x=color)) + geom_bar()+
  ggtitle("\n                    Distributions of color")+
  xlab("Levels of color")+
  ylab("Numbers of diamonds")

ggplot(diamonds, aes(x=clarity)) + geom_bar()+
  ggtitle("\n                    Distributions of  clarity")+
  xlab("Levels of  clarity")+
  ylab("Numbers of diamonds")

ggplot(diamonds, aes(x=cut)) + geom_bar()+
  ggtitle("\n                    Distributions of cut")+
  xlab("Levels of cut")+
  ylab("Numbers of diamonds")

# Q5. How do clarity, colour, and cut affect price? 
# 5.1 First try: boxplots of price versus clarity
ggplot(diamonds, aes(x=clarity, y=price)) + geom_boxplot()+
  xlab("Levels of clarity")+
  ggtitle("\n             boxplots of price versus clarity")

ggplot(diamonds, aes(x=colour, y=price)) + geom_boxplot()+
  ggtitle("boxplots of price versus clarity")

ggplot(diamonds, aes(x=cut, y=price)) + geom_boxplot()+
  ggtitle("boxplots of price versus clarity")

ggplot(diamonds, aes(x=clarity, y=price)) + geom_boxplot()+
  stat_boxplot(geom = "errorbar", width = 0.5)+
  xlab("Levels of  clarity")

ggplot(diamonds, aes(x=clarity, y=price)) + geom_boxplot()+geom_violin()+
  xlab("Levels of  clarity")
##############################################################
ggplot(diamonds, aes(x=clarity, y=price)) + geom_boxplot()+
  stat_boxplot(geom = "errorbar", width = 0.5)+geom_violin()+
  ggtitle("\n                              Violin plots \n                of prices Vs level of clarity")+
  xlab("Levels of  clarity")

ggplot(diamonds, aes(x=color, y=price)) + geom_boxplot()+
  stat_boxplot(geom = "errorbar", width = 0.5)+geom_violin()+
  ggtitle("\n                              Violin plots \n                of prices Vs level of color")+
  xlab("Levels of color")

ggplot(diamonds, aes(x=cut, y=price)) + geom_boxplot()+
  stat_boxplot(geom = "errorbar", width = 0.5)+geom_violin()+
  ggtitle("\n                              Violin plots \n                of prices Vs level of cut")+
  xlab("Levels of cut")

#5.2 Does the distribution of clarity, colour, and cut change with carat-weight?
? quantile
?cut
quantile(diamonds$carat)

caratfactor <- cut(diamonds$carat, quantile(diamonds$carat), include.lowest=TRUE)
str(caratfactor)
diamonds$caratfactor <- caratfactor
str(diamonds)
ggplot(diamonds, aes(x=caratfactor, fill=clarity)) + geom_bar()
ggplot(diamonds, aes(x=caratfactor, fill=clarity)) + geom_bar(position="fill")
ggplot(diamonds, aes(x=clarity, fill=caratfactor)) + geom_bar(position="fill")

ggplot(diamonds, aes(x=price, fill=clarity)) + geom_bar(position="fill")
ggplot(diamonds,aes(x=price, fill=clarity)) + geom_histogram()

# 5.3 The effect of clarity, colour, and cut on price: second attempt
halfcaratdiamonds <- subset(diamonds,carat > 0.49 & carat < 0.55 )
onecaratdiamonds <- subset(diamonds, carat > 0.99 & carat < 1.2 )

ggplot(halfcaratdiamonds,aes(x=clarity,y=price)) + geom_boxplot()

ggplot(halfcaratdiamonds,aes(x=clarity,y=price)) + geom_boxplot()+
  stat_boxplot(geom = "errorbar", width = 0.5)+
  ggtitle("\n                     Boxplot of clarity Vs price \n              (when carat > 0.49 & carat < 0.55)")+
  ylab("price") + 
  xlab("Levels of clarity")

ggplot(halfcaratdiamonds,aes(x=color,y=price)) + geom_boxplot()+
  stat_boxplot(geom = "errorbar", width = 0.5)+
  ggtitle("\n                     Boxplot of color Vs price \n              (when carat > 0.49 & carat < 0.55)")+
  ylab("price") + 
  xlab("Levels of color")

ggplot(halfcaratdiamonds,aes(x=cut,y=price)) + geom_boxplot()+
  stat_boxplot(geom = "errorbar", width = 0.5)+
  ggtitle("\n                     Boxplot of cut Vs price \n              (when carat > 0.49 & carat < 0.55)")+
  ylab("price") + 
  xlab("Levels of cut")
###################################################################################
#Q6. Is there any interaction between clarity, colour and cut in
#determining the price?
?facet_grid
ggplot(subset(diamonds, carat >0.99 & carat < 1.2 & cut =="Ideal"), aes(x=clarity, y=price)) +
  geom_boxplot() + facet_grid(. ~ color) +scale_y_log10( )

#Step 1: subset the dataframe. 
diamondsonecarat <- subset(diamonds, carat > 0.99 & carat < 1.1 & cut=="Ideal")

install.packages("plyr")
library(plyr)
?ddply

d1cmeans <- ddply( diamondsonecarat, .(clarity, color), summarize, meanprice=mean(price))
str(d1cmeans)
ggplot(d1cmeans, aes(x=clarity, y=meanprice, color=color)) + geom_point() + scale_y_log10()

ggplot(d1cmeans, aes(x=clarity, y=meanprice, color=color, group=color)) + geom_point() +
  scale_y_log10() + geom_line()

caratbreaks <- seq(3000,16000,by=1000)

ggplot(d1cmeans, aes(x=clarity, y=meanprice, color=color, group=color)) + geom_point() +
  scale_y_log10(breaks=caratbreaks) + geom_line()+
  ggtitle("plot of price distributions for different clarities and for
different colours together.") + 
  xlab("clarity") + 
  ylab("the mean price of clarity and colour")

ggplot(d1cmeans, aes(x=carat, y=meanprice, color=color, group=color)) + geom_point() +
  scale_y_log10() + geom_line()

# Q7. Write down two questions that you could answer with these data,
#and use appropriate visualisations and summary statistics to answer
#them. 



