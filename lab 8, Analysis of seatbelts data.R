#CS4250/CS5250: Lab Worksheet 8 - Analysis of seatbelts data

install.packages("datasets")
library(datasets)
data()
str(Seatbelts)

seatbelts <- as.data.frame(Seatbelts)
str(seatbelts)
names(seatbelts)

install.packages("ggplot2")
library(ggplot2)
rownums <- 1:nrow(seatbelts)
p <- ggplot( seatbelts, aes(x=rownums, y=drivers) ) + geom_line()+
  annotate("rect", xmin =170, xmax =200, ymin =1000, ymax =2500 , fill = "skyblue")+
  ggtitle("Plot of drivers vs time, and a shaded rectangle for period the law was introduced")
p

which.max(seatbelts$law)
?which.max
#-----------------------------------------------------------------
library(datasets)
seatbelts <- as.data.frame(Seatbelts)
library(ggplot2)

lawbefore <-filter(Seatbelts,seatbelts$law ==0)
lawafter <- filter(Seatbelts,seatbelts$law!=0)
ggplot(seatbelts, aes(x=factor(law), y =DriversKilled)) +
  geom_boxplot(fill = "skyblue") +stat_boxplot(geom = "errorbar", width = 0.5)+
  theme_grey()+ylab ("Monthly Driver Mortality")+
  xlab("Before(0) and after(1) seatbelt law introduced")+
  ggtitle("                  Boxplot of before and after seatbelt legislation was introduced")
#-------------------------------
ggplot(seatbelts, aes(x=factor(law), y =drivers)) +
  geom_boxplot(fill = "skyblue") +stat_boxplot(geom = "errorbar", width = 0.5)+
  theme_grey()+ylab ("Monthly Driver Mortality or badly injured")+
  xlab("Before(0) and after(1) seatbelt law introduced")+
  ggtitle("                  Boxplot of before and after seatbelt legislation was introduced")
#-------------------------------
ggplot(seatbelts, aes(x=factor(law), y =front)) +
  geom_boxplot(fill = "skyblue") +stat_boxplot(geom = "errorbar", width = 0.5)+
  theme_grey()+ylab ("Monthly front-seat passengers killed or badly injured")+
  xlab("Before(0) and after(1) seatbelt law introduced")+
  ggtitle("                  Boxplot of before and after seatbelt legislation was introduced")
#-------------------------------
ggplot(seatbelts, aes(x=factor(law), y =rear)) +
  geom_boxplot(fill = "skyblue") +stat_boxplot(geom = "errorbar", width = 0.5)+
  theme_grey()+ylab ("rear-seat passengers killed or severely injured each month")+
  xlab("Before(0) and after(1) seatbelt law introduced")+
  ggtitle("                  Boxplot of before and after seatbelt legislation was introduced")
####################################################################
#Ratio of (driver+front)/rear
seatbelts <- as.data.frame(Seatbelts)
rownums <- 1:nrow(seatbelts)
ratio <- (seatbelts$drivers+seatbelts$front)/seatbelts$rear
ggplot( seatbelts, aes(x=rownums, y= ratio)) + geom_line()+
  annotate("rect", xmin =170, xmax =200, ymin =4, ymax =9, fill = "skyblue")+
  ylab("Ratio of (drivers + front)/rear")+
  ggtitle("Plot of drivers vs time, and a shaded rectangle for period the law was introduced")
#-------------------------------------------
###########################################################################
#https://rstudio-pubs-static.s3.amazonaws.com/299410_b53f8eb11f984db7862bd004e5ccf611.html

library(datasets)
data(Seatbelts)
Seatbelts <- data.frame(Year=floor(time(Seatbelts)),
                        Month=factor(cycle(Seatbelts),
                                     labels=month.abb), Seatbelts)
str(Seatbelts)
head(Seatbelts)
Law0Sub <-filter(Seatbelts,Seatbelts$law ==0)
Law1Sub <- filter(Seatbelts,Seatbelts$law!=0)

summary(Law0Sub)
summary(Law1Sub)
sd (Law0Sub$DriversKilled)
sd(Law1Sub$DriversKilled)
Bluebox <-ggplot(Seatbelts, aes(x=factor(law), y =DriversKilled)) +
  geom_boxplot(fill = "skyblue") +theme_grey()+ylab ("Monthly Driver Mortality")+
  xlab("Before and after law introduced")
Bluebox

##############################################################
##Summarising by year (you need to do some work)
#https://www.kaggle.com/jamesdlawrence/seatbelts-friend-or-foe
Seatbelts.df <- as.data.frame(Seatbelts)
Seatbelts.df$time <- time(Seatbelts)
Seatbelts.df$year <- floor(Seatbelts.df$time)
Seatbelts.df$Month <- round(12*(Seatbelts.df$time - Seatbelts.df$year))
head(Seatbelts.df)

plot_ly(Seatbelts.df,x=time,y=kms,type="line") %>%
  layout(title="Distance driven by month")
plot(stl1 <- stl(Seatbelts[,"kms"],"periodic"))

plot_ly(as.data.frame(stl1$time.series[1:12,]),x=1:12,y=seasonal) %>%
  layout(xaxis = list(title = "Month"),title="Seasonal distance driven by time of year")

plot_ly(Seatbelts.df,x=time,y=drivers/kms,type="line") %>%
  layout(title="Casualty rate",yaxis=list(title="driver casualties per (million?) km"))
plot(stl2 <- stl(Seatbelts[,"drivers"]/Seatbelts[,"kms"],"periodic"))

plot_ly(as.data.frame(stl2$time.series[1:12,]),x=1:12,y=seasonal) %>%
  layout(xaxis = list(title = "Month"),title="Seasonal casualty rate by time of year")

#----------------------------------------
library(plyr)
x <- 1:12
mynewyearfactor<-1:12# <- cut(x, breaks = 1))

seatbeltsbyyear <- ddply( seatbelts, .(mynewyearfactor), summarise, 
                          drivers.y = mean(drivers), front.y = mean(front), rear.y=mean(rear), 
                          kms.y=mean(kms) )

seatbeltsbyyear
# Other investigations















