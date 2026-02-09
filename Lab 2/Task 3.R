# Get input
name <- readline("Enter your name: ")
phone <- readline("Enter your phone number: ")

# Convert name to uppercase
name_upper <- toupper(name)

# Extract phone digits
first3 <- substr(phone, 1, 3)
last4 <- substr(phone, nchar(phone) - 3, nchar(phone))

# Display result
cat("Name:", name_upper, "\n")
cat("Phone Number:", first3, "****", last4)
