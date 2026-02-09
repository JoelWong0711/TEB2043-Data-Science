# Get input
weight <- as.numeric(readline("Enter your weight (kg): "))
height <- as.numeric(readline("Enter your height (m): "))

# Calculate BMI
bmi <- weight / (height^2)

# Logical conditions
underweight <- bmi < 18.5
normal <- bmi >= 18.5 & bmi < 25
overweight <- bmi >= 25 & bmi < 30
obese <- bmi >= 30

# Display result
cat("Underweight:", underweight, "\n")
cat("Normal:", normal, "\n")
cat("Overweight:", overweight, "\n")
cat("Obese:", obese, "\n")
