scores <- c(33, 24, 54, 94, 16, 89, 60, 6, 77, 61, 13, 44, 26, 24, 73, 73, 90, 39, 90, 54)

pass_status <- scores > 49
cat(pass_status)

A <- sum(scores >= 90 & scores <= 100)
B <- sum(scores >= 80 & scores <= 89)
C <- sum(scores >= 70 & scores <= 79)
D <- sum(scores >= 60 & scores <= 69)
E <- sum(scores >= 50 & scores <= 59)
F <- sum(scores <= 49)

cat("\n\n")
cat("Grade A:", A, "\n")
cat("Grade B:", B, "\n")
cat("Grade C:", C, "\n")
cat("Grade D:", D, "\n")
cat("Grade E:", E, "\n")
cat("Grade F:", F, "\n")
