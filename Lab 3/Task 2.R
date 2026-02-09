student <- list(
  Name = c("Robert", "Hemsworth", "Scarlett", "Evans", "Pratt","Larson", "Holland", "Paul", "Simu", "Renner"),
  Score = c(59, 71, 83, 68, 65, 57, 62, 92, 92, 59)
)

highest <- max(student$Score)
lowest <- min(student$Score)
average <- mean(student$Score)
highest_name <- student$Name[student$Score == highest]
lowest_name <- student$Name[student$Score == lowest]


cat("Highest score:", highest, "\n")
cat("Student(s):", highest_name, "\n\n")

cat("Lowest score:", lowest, "\n")
cat("Student(s):", lowest_name, "\n\n")

cat("Average score:", average, "\n")
