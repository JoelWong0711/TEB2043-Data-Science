# Get strings
str1 <- readline("Enter first string: ")
str2 <- readline("Enter second string: ")

# Compare (case-insensitive)
if (tolower(str1) == tolower(str2)) {
  cat("Both strings are the SAME")
} else {
  cat("Both strings are DIFFERENT")
}
