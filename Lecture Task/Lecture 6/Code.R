#DATAFRAME
names = c("Carol", "Mike", "John")
gender = c("Female", "Male", "Male")
height = c(160, 175, 173)
weight = c(49, 89, 77)
age = c(35,36,41)
df = data.frame(names, gender, height, weight, age)
View(df)

df[1,3]
df[1:2,1:3]

View(height)
View(df)

df["height"]
df["gender"]
df$gender

df[1:2]
df[c(1,2)]

df[df$names == "Mike",]
df[df$age>35,]
df[df$height>170 & df$weight>80,]
df[df$gender == "Male",]


#ADD NEW ROWS
newdf= rbind(df,data.frame(names = "Suuria", gender = "Female", height = 156, weight = 56, age = 23 ))
print(newdf)
print(df)

newDf = rbind(df, data.frame(names = c("Suuria","Malik"), gender = c("Female","Male"), height = c(156,169), weight = c(56,81), age = c(23, 28)))
print(newDf)
View(newDf)

#MERGE
gender = c("Female", "Male", "Male","Female","Male")
height = c(160, 175, 173,156,169)
weight = c(49, 89, 77,56,81)
age = c(35, 36, 41,23, 28)
names =c("Carrol","Mike","John","Suuria","Malik")
df1 = data.frame(names,gender,height,weight,age)

states = c("Selangor","Perak","Melaka")
names = c("Carrol","John","Malik")
df2 = data.frame(names, states)
dfMerge= merge(df1, df2, by = "names", all= TRUE)
View(dfMerge)
print(dfMerge)

df1 -> df
df -> df1

newDf2 = newDf[-2,]
View(newDf2)

newDf3 = newDf
newDf3[1, "age"] <- 30

newDf4 = newDf
newDf4[,-4]



#IMPORT DATAFRAME
getwd()
data_cv <- read.csv("C:/Users/aqila/Desktop/UTP/DATA SCIENCE/my_covid.csv")
summary(data_cv)

newdf <- data_cv[-seq(10, 13), ]
View(newdf)

write.csv(newdf, "C:/Users/aqila/Desktop/UTP/DATA SCIENCE/my_covid.csv")
newdf <- data_cv[-c(10, 13, 7, 4), ]
write.csv (newdf, " C:/Users/aqila/Desktop/UTP/DATA SCIENCE/my_covid.csv")

a<-c(1:5, rep(NA,3),6:10)
a

sum(a)

b <- a[!is.na(a)]
b
sum(b)

a<-c(seq(1,10,3), rep(NA,4), seq(10,2,-2))
a

a[is.na(a)]<-0
a

a<-c(seq(1,10,3), rep(NA,4), seq(10,2,-2))
a

a[is.na(a)]<- mean(a,na.rm = TRUE)
a



df <- read.csv("C:/Users/aqila/Desktop/UTP/DATA SCIENCE/NAexample.csv")
df
is.na(df)
is.na(df["VarA"])
mean(df$VarA)
mean(na.omit(df$VarA))

df$VarA[is.na(df$VarA)] <- sd(na.omit(df$VarA))


#REMOVE BAD VALUES
df_raw <- read.csv("C:/Users/aqila/Desktop/UTP/DATA SCIENCE/file1.csv")
df_cleaned <- df_raw
df_logrm <- data.frame(TagsValue=character(), Definition=character(), Value=character())
rows_to_remove <- c()


for (i in 1:nrow(df_raw))
{
  if (df_raw[i, 2] == "Bad value" && df_raw[i, 3] == "Garbage")
  {
    rows_to_remove <- c(rows_to_remove, i)
    # Log the removed bad values
    df_logrm <- rbind(df_logrm, c(df_raw[i, 1], df_raw[i, 2],df_raw[i, 3]))
    # Save the index for the rows to be removed
  }
}

df_cleaned <- df_cleaned[-rows_to_remove, ]
View(df_cleaned)
View (df_logrm)