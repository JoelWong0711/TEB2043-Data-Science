#create vector
name <- c("Anastasia", "Dima", "Michael", "Matthew", "Laura", "Kevin", "Jonas", "Emily")
score <- c(12.5, 9.0, 16.5, 12.0, 9.0, 8.0, 19.0, 14.5)
attempts <- c(1, 3, 2, 3, 2, 1, 2, 1)
qualify <- c("yes", "no", "yes", "no", "no", "no", "yes", "yes")

#store data into data frame
student_data <- data.frame(name = as.factor(name),score,attempts,qualify)

print(student_data)

str(student_data)

nrow(student_data)
ncol(student_data)

summary(student_data)
