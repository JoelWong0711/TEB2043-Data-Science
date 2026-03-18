library(dplyr)
library(readr)

student_data <- read.csv("C:/Users/Joel Wong/Documents/TEB2043-Data-Science/Lecture Task/student_data.csv")

#intro
View(student_data)
summary(student_data)
head(student_data)
tail(student_data)

#filter
Student_fail<- student_data %>% filter(final_exam_mark< 40)
View(Student_fail)
#arrange
mydata1<- student_data %>% filter(final_exam_mark > 40) %>% arrange(desc(final_exam_mark))
View(mydata1)
#select
mydata <- student_data%>% select(student_id,coursework_mark, final_exam_mark)
View(mydata)
#mutate
mydata2 <- cbind(student_data , Total_Mark = (student_data $coursework_mark + student_data$final_exam_mark/200*100))
View(mydata2)

#descriptive analysis
str(iris) 

#histogram
hist(iris$Sepal.Length,
     main = "Histogram of Sepal Length",
     xlab = "Sepal Length (cm)",
     ylab = "Frequency",
     col = "lightblue",
     border = "black")

#boxplot
boxplot(Sepal.Length = Species,
        data = iris,
        main = "Sepal Length by Species",
        xlab = "Species",
        ylab = "Sepal Length (cm)",
        col =  c("lightgreen","lightblue","lightyellow"))


dfplayers <- read.csv("C:/Users/Joel Wong/Documents/TEB2043-Data-Science/Lecture Task/players.csv")
median_age <- median(dfplayers$Age, na.rm =TRUE)
dfplayers$Age[dfplayers$Age<18 | dfplayers$Age>38]<-median_age
View(dfplayers)

data<-c(30,24,26,28,29,28,27,26,32,34,13,15,14,31,29,28,24,25,30,34,35,27,30,34,44,48)
boxplot(data, main = "Boxplot")
