#Loading  all Libraries
library(rpart)
library(maptree)
library(faraway)
library(dplyr)
library(ggplot2)
library(ggcorrplot)
library(psych)
library(corrplot)

#US wage data
data("uswages")
summary(uswages[,c(1:3)])
#Correlation between Education, Experience, Wage
M <- cor(uswages[,c(1:3)])
corrplot(M, method = 'number') # colorful number

#Boxplot for wage, education and experience
boxplot(uswages$wage,
        ylim = c(0,3000),
        xlab = 'Boxplot for US Wages')
boxplot(uswages$educ,
        xlab = 'Boxplot for Education')
boxplot(uswages$exper,
        xlab = 'Boxplot for Experience')

# Histogram for US Wage
hist(uswages$wage,
     xlim = c(0,4000),
     xlab = 'Wage (Dollar Amount)',
     main= 'US Wages')

#histogram associated with education
hist(uswages$educ,
     xlab = 'Education (In Years)',
     main= 'Wage vs Education')

#histogram associated with education
hist(uswages$exper,
     xlab = 'Experience (In Years)',
     main= ' Wage vs Experience')

# Base R plot 
plot(uswages$educ,uswages$wage,
     type = 'p', col = 'red',
     xlab = 'Education',
     ylab = 'Wage',
     main = 'Wage vs Education')

plot(uswages$exper,uswages$wage,
     type = 'p', col = 'blue',
     xlab = 'Experience',
     ylab = 'Wage',
     main = 'Wage vs Experience')

#Fitting the linear regression on US Wages data
lm.wage<-lm(wage~educ + exper, data=uswages)
summary(lm.wage)$coefficients
par(mfrow= c(2,2))
plot(lm.wage)

predict(lm.wage)
data(uswages)
reg.dat<-uswages
reg.dat<- reg.dat[, c('wage', 'educ', 'exper')]

reg.dat$reg.predict<-lm.wage$fitted.values
write.csv(reg.dat, file= "PredictedData.csv")

## SSE Calculation for regression model
cat("The SSE of linear regression model is: ")
wage.sse<- sum((fitted(lm.wage) - uswages$wage)^2)
wage.sse

#############Tree Model######################
tree.dat<-uswages
tree.dat<- tree.dat[, c('wage', 'educ', 'exper')]
head(tree.dat)

#Tree
tree=rpart(wage~.,data=tree.dat)
tree
summary(tree)
plot(tree)
draw.tree (tree, cex=1.2,nodeinfo=TRUE, cases="obs",digits=1, print.levels=TRUE,new=TRUE)


#Pruning
pruned=clip.rpart(tree,best=7)
pruned

draw.tree (pruned, cex=.7, 
           nodeinfo=TRUE, units="wage",
           cases="obs",
           digits=1, print.levels=TRUE,
           new=TRUE)

#Predicting Tree Values
tree.pred<-predict(pruned)
tree.dat$tree.pred<-tree.pred
write.csv(tree.dat, file= "Predictedtree.dat.csv")
#SSE for Tree model
SSE.tree=sum((tree.dat$wage -tree.dat$tree.pred)^2)
SSE.tree