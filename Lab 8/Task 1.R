# ================================
# TITANIC DATA CLEANING SCRIPT
# ================================

# 1. Load Required Libraries
library(dplyr)
library(readr)

# 2. Load Dataset
df <- read.csv(file.choose())
View(df)

cat("Original Shape:", dim(df), "\n")
head(df)

# =================================
# 3. HANDLE MISSING VALUES
# =================================

# Fill Age with median
if("Age" %in% colnames(df)){
  df$Age[is.na(df$Age)] <- median(df$Age, na.rm = TRUE)
}

# Fill Embarked with mode
if("Embarked" %in% colnames(df)){
  mode_embarked <- names(sort(table(df$Embarked), decreasing = TRUE))[1]
  df$Embarked[is.na(df$Embarked)] <- mode_embarked
}

# Drop Cabin column (too many missing values)
if("Cabin" %in% colnames(df)){
  df <- df %>% select(-Cabin)
}

# =================================
# 4. REMOVE DUPLICATES
# =================================
df <- df %>% distinct()


# =================================
# 5. FIX DATA TYPES
# =================================

if("Survived" %in% colnames(df)){
  df$Survived <- as.factor(df$Survived)
}

if("Pclass" %in% colnames(df)){
  df$Pclass <- as.factor(df$Pclass)
}

if("Sex" %in% colnames(df)){
  df$Sex <- as.factor(df$Sex)
}

if("Embarked" %in% colnames(df)){
  df$Embarked <- as.factor(df$Embarked)
}


# =================================
# 6. FEATURE ENGINEERING
# =================================

if(all(c("SibSp","Parch") %in% colnames(df))){
  df <- df %>%
    mutate(
      FamilySize = SibSp + Parch + 1,
      IsAlone = ifelse(FamilySize == 1, 1, 0)
    )
}


# =================================
# 7. SAVE CLEANED DATA
# =================================
write.csv(df, "cleaned_titanic.csv")

cat("Cleaning Completed Successfully!\n")
cat("New Shape:", dim(df), "\n")

# =================================
# 8. FILTER DATA FOR INSIGHTS
# =================================
df %>%
  filter(Embarked == "C") %>%
  summarise(
    Total_C = n(),
    Survived_C = sum(Survived == 1),
    Survival_Rate = Survived_C / Total_C * 100,
    ThirdClass_Percentage = sum(Pclass == 3) / Total_C * 100
  )

# =================================
# 9. VISUALIZATION FOR INSIGHTS
# =================================
library(ggplot2)
library(dplyr)

df %>%
  filter(Embarked == "C") %>%
  ggplot(aes(x = factor(Survived), fill = factor(Survived))) +
  geom_bar() +
  labs(
    title = "Survival Distribution for Passengers Embarked at C",
    x = "Survival Status (0 = No, 1 = Yes)",
    y = "Number of Passengers",
    fill = "Survived"
  ) +
  theme_minimal()

df %>%
  filter(Embarked == "C") %>%
  ggplot(aes(x = factor(Pclass), fill = factor(Pclass))) +
  geom_bar() +
  labs(
    title = "Passenger Class Distribution for Embarked C",
    x = "Passenger Class",
    y = "Number of Passengers",
    fill = "Class"
  ) +
  theme_minimal()
