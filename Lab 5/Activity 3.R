# Input from user
num <- as.integer(readline(prompt = "Enter a number: "))

# Convert number to digits
digits <- as.numeric(strsplit(as.character(num), "")[[1]])

# Find number of digits
n <- length(digits)
print(n)

# Calculate sum of digits raised to power n
sum_power <- sum(digits^n)

# Check Armstrong condition
if (sum_power == num) {
  cat(num, "is an Armstrong number\n")
} else {
  cat(num, "is NOT an Armstrong number\n")
}
