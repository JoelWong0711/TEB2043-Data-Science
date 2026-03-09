data(AirPassengers)

#sum of 1949,1950,1951
sum_1949 <- sum(head(AirPassengers,12))
sum_1950 <- sum(AirPassengers[13:24])
sum_1951 <- sum(AirPassengers[25:36])

#pie chart
x <- c(sum_1949,sum_1950,sum_1951)
labels <- c('1949','1950','1951')
piepercent<- round(100*x/sum(x), 1)
pie(x, labels = piepercent, main = "Sum of Year 1949,1950 & 1951", col = rainbow(length(x)))
legend("topright", c("1949","1950","1951"), cex= 0.8,fill = rainbow(length(x)))

#graph
months <- month.abb

plot(AirPassengers[1:12],
     type = "b",
     xaxt = "n",
     xlab = "Month",
     ylab = "Passengers",
     main = "Air Passengers in 1949")

axis(1, at = 1:12, labels = months)

data_1949 <- AirPassengers[1:12]