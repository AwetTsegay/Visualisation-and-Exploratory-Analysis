#CS4250/CS5250: Lab Worksheet 4 - Data wrestling

planet <- read.csv("cheat.csv")
str(planet)
fix(planet)

planet$name <- as.factor(planet$name)
planet$ring <- as.factor(planet$ring)
planet$magnetic <- as.factor(planet$magnetic)

str(planet)
fix(planet)
names(planet)

planetsonly <- subset(planet, name != "MOON" )

library(ggplot2)
p <- ggplot(planet, aes(x=distancefromsun,y=orbitperiod)) + 
  geom_point()
p
p + scale_x_log10() + scale_y_log10()
p <- ggplot(planet, aes(x=distancefromsun, y=orbitperiod, label=name)) + 
  geom_point() + scale_x_log10() + scale_y_log10() + 
  geom_text(hjust=0,size=3)
p
p <- ggplot(planet, aes(x=distancefromsun,y=orbitperiod,label=name)) + 
  geom_point() + scale_x_log10() + scale_y_log10() + 
  geom_text(hjust=0,nudge_x=0.05,size=3)
p

planet <- planet[ planet$name != "MOON",] 
planetsonly <- subset(planet, name != "MOON" )

str(planet)
p <- ggplot(planet, aes(x=distancefromsun,y=orbitperiod,label=name)) + 
  geom_point() + scale_x_log10() + scale_y_log10() + 
  geom_text(hjust=0,nudge_x=0.05,size=3)
p


x <- c(1.1, 3.3, 7)
ls()
rm(x)
newframe <- subset(oldframe, logical-index-expression)




