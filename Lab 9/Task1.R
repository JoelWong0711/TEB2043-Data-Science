# Load dataset
data("ToothGrowth")

# View dataset structure
str(ToothGrowth)

# Convert dose to numeric if needed (already numeric in ToothGrowth)
# Select numeric variables only
numeric_data <- ToothGrowth[, c("len", "dose")]

# Compute correlation matrix
cor_matrix <- cor(numeric_data)

# Display correlation
cor_matrix

# Load package
library(corrplot)

# Plot heatmap
corrplot(cor_matrix, 
         method = "color",
         addCoef.col = "black",
         tl.col = "black",
         tl.srt = 45)
