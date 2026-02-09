# Given vector
V1 <- c(2,3,1,5,4,6,8,7,9)

# Create Matrix-1
Matrix1 <- matrix(V1, nrow = 3, ncol = 3)
rownames(Matrix1) <- c("R1", "R2", "R3")
colnames(Matrix1) <- c("C1", "C2", "C3")
print(Matrix1)

# Transpose to create Matrix-2
Matrix2 <- t(Matrix1)
rownames(Matrix2) <- c("R1", "R2", "R3")
colnames(Matrix2) <- c("C1", "C2", "C3")
print(Matrix2)

# Matrix operations
Matrix1 + Matrix2     # Addition
Matrix1 - Matrix2     # Subtraction
Matrix1 * Matrix2     # Multiplication (element-wise)
Matrix1 / Matrix2     # Division (element-wise)

