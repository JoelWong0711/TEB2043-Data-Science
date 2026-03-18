#MULTIPLE LINEAR REGRESSIONS
#--1 MTCars Dataset-------------------------------------------------------------
data(mtcars)
head(mtcars)
str(mtcars)
model <- lm(mpg ~ hp + wt + cyl, data = mtcars)
summary(model)
View(mtcars)

#train, test, model and predict
data.train2<- mtcars[1:22,]
data.test2<- mtcars[23:32,]

relation <-lm(mpg ~ hp +wt+cyl, data = data.train2)
summary(relation)

a <- data.frame(hp = data.test2$hp, wt = data.test2$wt, cyl = data.test2$cyl)
result <- predict(relation, a)
print(round(result, digits = 2))

#MAPE
mape <- mean(abs((data.test$mpg - result)/ data.test$mpg )*100)
paste("The error - MAPE is: ", round(mape,digit=2),"%")

#--2 Class Activity-------------------------------------------------------------
ozone =c(11, 11, 11, 12, 12, 13, 13, 13, 13, 14)
solar = c(290, 44, 320, 149, 120, 137, 112, 27, 238, 274)
wind = c(9.2, 9.7, 16.6, 12.6, 11.5, 10.3, 11.5, 10.3, 12.6, 10.9)
temp = c(66, 62, 73, 74, 73, 76, 71, 76, 64, 68)

dfquality = data.frame(ozone, solar, wind, temp)
View(dfquality)

ozoneQ <- lm(ozone ~ solar + wind + temp, data = dfquality)

data.train3<- dfquality[1:7,]
data.test3<- dfquality[8:10,]

relationO <-lm(ozone ~ solar + wind + temp, data = data.train3)
summary(relation)

oo <- data.frame(solar = data.test3$solar, wind = data.test3$wind, temp = data.test3$temp)
resultsO <- predict(relationO, oo)
print(round(resultsO, digits = 2))