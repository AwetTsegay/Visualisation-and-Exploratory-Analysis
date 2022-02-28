# CS4250/CS5250: Lab Worksheet 7 - Simpson's paradox and mosaic plots
# The UC Berkeley (UCB) admissions data
install.packages("vcd")
install.packages("vcdExtra")
library(vcd)
library(vcdExtra)

library(gcookbook)
library(datasets)

drugz <- data.frame(expand.grid(treatment=c("drugz","placebo"),
                                result=c("sicker","better")),count=c(20,60,80,40))
drugz                                                                                  
drugztable <- xtabs(formula = count ~ treatment + result, data = drugz)
drugztable
mosaic(~treatment+result, drugztable,shade=TRUE,split_vertical=c(FALSE,TRUE))
#
GSS <- data.frame(expand.grid(sex=c("female", "male"),party=c("dem", "indep", "rep")),
                  count=c(279,165,73,47,225,191)) 
GSS
gsstable <- xtabs( formula = count ~ sex + party, data = GSS)
dimnames(gsstable)
gsstable
mosaic( ~party + sex, data=gsstable, highlighting=TRUE,highlighting_fill=terrain.colors(3))
mosaic( ~party + sex, data=gsstable, shade=TRUE)
#
#
Titanic
mosaic(~Survived, data=Titanic, split_vertical=c(TRUE),
       highlighting_fill=c("grey","green"), highlighting=TRUE)

mosaic(~Survived + Class, data=Titanic, split_vertical=c(TRUE,FALSE,FALSE),
       highlighting_fill=rev(terrain.colors(2,alpha=1)),highlighting=TRUE)

mosaic(~Survived + Sex, data=Titanic[,,"Adult",], split_vertical=c(TRUE,FALSE),
       highlighting_fill=rev(terrain.colors(2)), highlighting=TRUE)

mosaic(~Survived + Class + Sex, data=Titanic, split_vertical=c(TRUE,FALSE,FALSE),
       highlighting_fill=rev(terrain.colors(2,alpha=1)),highlighting=TRUE)

#
dimnames(Titanic)
Titanic[ , , "Child", ]

mosaic(~Survived + Class + Sex, data=Titanic[,,"Child",],
       split_vertical=c(TRUE,FALSE,FALSE), highlighting_fill=rev(terrain.colors(2)),
       highlighting=TRUE)

mosaic(~Survived + Class + Sex, data=Titanic[,,"Child",],
       split_vertical=c(TRUE,FALSE,FALSE, FALSE), highlighting_fill=rev(terrain.colors(2)),
       highlighting=TRUE)

mosaic(~Sex + Class, data=Titanic[,,"Adult",], split_vertical=c(TRUE,FALSE),
       highlighting_fill=rev(heat.colors(2)), highlighting=TRUE)

mosaic(~Age + Class, data=Titanic, split_vertical=c(TRUE,FALSE),
       highlighting_fill=rev(heat.colors(2)), highlighting=TRUE)
####################################################################
#
UCBAdmissions
dimnames(UCBAdmissions)

mosaic( ~Admit + Gender + Dept, data=UCBAdmissions, highlighting=TRUE,
        highlighting_fill=terrain.colors(2))

mosaic( ~Admit + Dept + Gender, data=UCBAdmissions, highlighting=TRUE,
        highlighting_fill=terrain.colors(2),split_vertical=c(TRUE,FALSE,FALSE))