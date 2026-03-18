#--Simple Linear Regression----------------------------------------------------- 
x <- c(151, 174, 138, 186, 128, 136, 179, 163, 152, 131)
y <- c(63, 81, 56, 91, 47, 57, 76, 72, 62, 48)

relation <- lm(y~x)
print(relation)

#try to find weight of person with 189 height
X_test <- data.frame(x = 189)
result <- predict(relation,X_test)
print(round(result, digit=2))

#--3 Plot Graph-----------------------------------------------------------------
plot(x,y,col = "blue",
     main = "Height & Weight Regression",
     abline(lm(y~x)), #adds regression line to the plot
     pch = 16,
     xlab = "Height in cm",
     ylab = "Weight in kg")

#--4 Training, Testing, Performance Analysis------------------------------------
data1 = data.frame(x,y)
data1_train <- data1[1:7, ]
data1_test <- data1[8:10, ]

relation <- lm(y~x, data1_train)
print(relation)

#make prediction
x_test <- data.frame(x = data1_test$x)
result <- predict(relation, x_test)
print(result)

actuals_preds <- data.frame(cbind(actuals=data1_test$y,predicteds=result))
mape <- mean(abs(actuals_preds$actuals- actuals_preds$predicteds )/actuals_preds$actuals)*100
paste("The error - MAPE is: ", round(mape,digit=2),"%")

#Case Study: Happiness_income
df<-read.csv("C:/Users/airah/Downloads/income_happiness.csv")

train_indices <- sample(1:nrow(df), size = 0.8 * nrow(df))
train_data <- df[train_indices, ]
test_data  <- df[-train_indices, ]

relation <- lm(happiness~income, data=train_data)
print(relation)

a <- data.frame(x=test_data$income)
colnames(a) <- "income" 
result <-  predict(relation,a)

plot(test_data$income,test_data$happiness,
     col="red",
     abline(lm(happiness~income, data=train_data)),
     pch = 16,xlab = "income",
     ylab = "happiness")

#--5 Class Activity-------------------------------------------------------------

expyears <- c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
monthsalary <- c(2500, 2700, 3000, 3400, 3900, 4400, 5000, 5600, 6200, 6900)

dfsimple <- data.frame(expyears, monthsalary)
View(dfsimple)

dfsimple_train <- dfsimple[1:7, ]
dfsimple_test <- dfsimple[8:10, ]

relationsimple <- lm(monthsalary ~ expyears, data = dfsimple_train)
print(relationsimple)

# Scatter Plot!!
simp <- data.frame(expyears = dfsimple_test$expyears)
resultsimple <- predict(relationsimple, simp)
print(resultsimple)

plot(dfsimple_test$expyears, dfsimple_test$monthsalary,
     main = "Monthly Salary by Experience Year",
     col="pink",
     pch = 19,
     xlab="Experience Years",
     ylab="Monthly Salary")

abline(relationsimple)