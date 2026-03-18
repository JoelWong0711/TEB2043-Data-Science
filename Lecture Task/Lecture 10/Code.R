#--CORRELATION COEFFICIENT------------------------------------------------------
x <- c(151, 174, 138, 186, 128, 136, 179, 163, 152, 131)
#data of weight
y <- c(63, 81, 56, 91, 47, 57, 76, 72, 62, 48)

data1=data.frame(x,y)
data1_train<-data1[1:7,]
data1_test<-data1[8:10,]

#apply the lm() function
relation <- lm(y~x, data1_train)
print(relation)

#correlation coefficient
a <- data.frame(x= data1_test$x)
result <-  predict(relation,a)
print(result)
#performance measurement
actuals_preds <- data.frame(cbind(actuals=data1_test$y, predicteds=result))
correlation_accuracy <- cor(actuals_preds)#
print(correlation_accuracy)

#--FEATURE SELECTION------------------------------------------------------------
#install package and import library
install.packages("lattice")
library(lattice)
#load data
data(environmental)
data <-environmental
head(data)

#correlation matrix of data, round each value to 2 decimal places
corr_mat <- round(cor(data),2)
head(corr_mat)

# Reshape correlation matrix
install.packages("reshape2")
library(reshape2)

melted_corr_mat <- melt(corr_mat)
View(melted_corr_mat)

# plotting the correlation heatmap
library(ggplot2)
ggplot(data = melted_corr_mat, aes(x = Var1, y = Var2, fill = value)) +  geom_tile() +geom_text(aes(label = round(value, 2)), color = "black", size = 4) +  scale_fill_gradient2(low = "blue", mid = "white", high = "red", midpoint = 0)