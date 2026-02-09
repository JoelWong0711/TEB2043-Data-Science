# Given data
age <- c(55,57,56,52,51,59,58,53,59,55,60,60,60,60,52,55,56,51,60,
         52,54,56,52,57,54,56,58,53,53,50,55,51,57,60,57,55,51,50,57,58)

# Convert to factor
age_factor <- factor(age)

# Levels of factor
levels(age_factor)

# Frequency of each age
table(age_factor)

# Divide into 5 ranges
age_range <- cut(age,
                 breaks = c(50, 52, 54, 56, 58, 60),
                 include.lowest = TRUE,
                 right = TRUE)

# Frequency by age range
table(age_range)


