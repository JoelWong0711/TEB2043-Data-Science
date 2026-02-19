# Input year from user
year <- as.integer(readline(prompt = "Enter a year: "))

# Check leap year condition
if ((year %% 4 == 0 & year %% 100 != 0) | (year %% 400 == 0)) {
  cat(year, "is a Leap Year\n")
} else {
  cat(year, "is NOT a Leap Year\n")
}