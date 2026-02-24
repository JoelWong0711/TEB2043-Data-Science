# ================================
# ADVANCED DATA CLEANING SCRIPT
# ================================

# Load required libraries
library(dplyr)
library(stringr)
library(tidyr)
library(lubridate)
library(readr)

# =========================================
# 1. CUSTOM INGESTION (Handle mixed delimiters)
# =========================================
raw_lines <- readLines(file.choose(), encoding = "latin1")
header <- str_trim(str_split(raw_lines[1], ",")[[1]])

# Use a functional approach instead of a manual loop for better memory handling
processed_rows <- lapply(raw_lines[-1], function(line) {
  line <- str_trim(line)
  if (line == "") return(NULL)
  
  # UNIFIED DELIMITER FIX: Convert pipes to commas so we have a standard format
  line_standardized <- str_replace_all(line, "\\|", ",")
  
  # Split by comma (Note: This assumes no commas inside quotes)
  row_data <- str_trim(str_split(line_standardized, ",")[[1]])
  
  # Adjust length to match header
  if (length(row_data) < length(header)) {
    row_data <- c(row_data, rep(NA, length(header) - length(row_data)))
  } else if (length(row_data) > length(header)) {
    row_data <- row_data[1:length(header)]
  }
  return(row_data)
})

# Remove NULLs and bind
df <- as.data.frame(do.call(rbind, Filter(Negate(is.null), processed_rows)), 
                    stringsAsFactors = FALSE)
colnames(df) <- header

# =========================================
# 2. STANDARDIZE NA VALUES
# =========================================

df <- df %>%
  mutate(across(everything(), ~na_if(str_trim(.), ""))) %>%
  mutate(across(everything(), ~na_if(., "NA"))) %>%
  mutate(across(everything(), ~na_if(., "null")))

# =========================================
# 3. PRIMARY KEY CLEANING
# =========================================

df <- df %>%
  mutate(Student_ID = as.integer(str_extract(Student_ID, "\\d+"))) %>%
  filter(!is.na(Student_ID)) %>%
  distinct(Student_ID, .keep_all = TRUE)

# =========================================
# 4. CLEAN NUMERIC VARIABLES
# =========================================

df <- df %>%
  
  # Clean Age
  mutate(Age = as.numeric(str_extract(Age, "\\d+"))) %>%
  
  # Remove unrealistic ages (<15 or >100)
  mutate(Age = ifelse(Age < 15 | Age > 100, NA, Age)) %>%
  
  # Impute Age using Median
  mutate(Age = replace_na(Age, round(median(Age, na.rm = TRUE)))) %>%
  
  # Clean Total Payments (remove currency symbols)
  mutate(Total_Payments = as.numeric(str_replace_all(Total_Payments, "[^0-9.]", ""))) %>%
  
  # Remove negative payments
  mutate(Total_Payments = ifelse(Total_Payments < 0, NA, Total_Payments)) %>%
  
  # Impute Payments using Median
  mutate(Total_Payments = replace_na(Total_Payments, median(Total_Payments, na.rm = TRUE)))

# =========================================
# 5. CLEAN CATEGORICAL VARIABLES
# =========================================

df <- df %>%
  
  # Standardize Names
  mutate(
    First_Name = str_to_title(First_Name),
    Last_Name  = str_to_title(Last_Name)
  ) %>%
  mutate(
    First_Name = replace_na(First_Name, "Unknown"),
    Last_Name  = replace_na(Last_Name, "Unknown")
  ) %>%
  
  # Clean Gender
  mutate(Gender = str_to_upper(substr(Gender, 1, 1))) %>%
  mutate(Gender = case_when(
    Gender == "M" ~ "Male",
    Gender == "F" ~ "Female",
    TRUE ~ "Unknown"
  )) %>%
  
  # Clean Course (Regex Standardization)
  mutate(Course = case_when(
    str_detect(Course, regex("Learn", ignore_case = TRUE)) ~ "Machine Learning",
    str_detect(Course, regex("Dev", ignore_case = TRUE)) ~ "Web Development",
    str_detect(Course, regex("Analy", ignore_case = TRUE)) ~ "Data Analytics",
    str_detect(Course, regex("Sci", ignore_case = TRUE)) ~ "Data Science",
    str_detect(Course, regex("Secur", ignore_case = TRUE)) ~ "Cyber Security",
    TRUE ~ "Undeclared"
  ))

# =========================================
# 6. CLEAN DATE VARIABLE (Improved)
# =========================================

df <- df %>%
  mutate(Enrollment_Date = suppressWarnings(
    # Added 'mdY' and 'dmY' for 4-digit years (2023 vs 23)
    parse_date_time(Enrollment_Date, 
                    orders = c("ymd", "dmy", "mdy", "dby", "mdY", "dmY"))
  )) %>%
  mutate(Enrollment_Date = as.Date(Enrollment_Date))

# Check for rows that are STILL NA after the fix
na_dates_count <- sum(is.na(df$Enrollment_Date))
if(na_dates_count > 0) {
  cat(paste("\n⚠️ Warning:", na_dates_count, "rows have invalid or missing dates.\n"))
}

# =========================================
# 7. FINAL DATA VALIDATION CHECK
# =========================================

cat("Missing values per column:\n")
print(colSums(is.na(df)))

cat("\nStructure of cleaned dataset:\n")
str(df)

cat("\nSummary statistics:\n")
summary(df)

# =========================================
# 8. EXPORT CLEANED DATA
# =========================================

write.csv(df, "Final_Cleaned_Dataset.csv", row.names = FALSE)

cat("\n✅ Dataset successfully cleaned and saved as 'Final_Cleaned_Dataset.csv'\n")

# =========================================
# 9. VISUALIZATION SECTION
# =========================================
library(ggplot2)
library(scales)

# 1. Course Distribution (Bar Chart)
ggplot(df, aes(x = reorder(Course, Course, function(x)-length(x)), fill = Course)) +
  geom_bar() +
  labs(title = "Student Distribution by Course", x = "Course", y = "Count") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  guides(fill = "none")

# 2. Age Distribution (Histogram)
ggplot(df, aes(x = Age)) +
  geom_histogram(binwidth = 2, fill = "skyblue", color = "white") +
  geom_vline(aes(xintercept = median(Age)), color = "red", linetype = "dashed") +
  labs(title = "Age Distribution of Students", subtitle = "Red line represents median age", x = "Age", y = "Frequency") +
  theme_minimal()

# 3. Enrollment Trends (Time Series)
df_trends <- df %>%
  mutate(Month = floor_date(Enrollment_Date, "month")) %>%
  group_by(Month) %>%
  summarise(Count = n())

ggplot(df_trends, aes(x = Month, y = Count)) +
  geom_line(color = "teal", size = 1) +
  geom_point() +
  scale_x_date(date_labels = "%b %Y", date_breaks = "1 month") +
  labs(title = "Monthly Enrollment Trends", x = "Month", y = "New Enrollments") +
  theme_minimal()

# 4. Gender Distribution (Pie Chart)
gender_df <- df %>% 
  group_by(Gender) %>% 
  summarise(count = n()) %>%
  mutate(perc = count / sum(count))

ggplot(gender_df, aes(x = "", y = perc, fill = Gender)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar("y", start = 0) +
  theme_void() +
  geom_text(aes(label = percent(perc)), position = position_stack(vjust = 0.5)) +
  labs(title = "Student Gender Breakdown")

# 5. Financial Overview (Boxplot)
ggplot(df, aes(x = Course, y = Total_Payments, fill = Course)) +
  geom_boxplot() +
  scale_y_continuous(labels = dollar_format()) +
  labs(title = "Payment Distribution per Course", x = "Course", y = "Total Payments") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  guides(fill = "none")

