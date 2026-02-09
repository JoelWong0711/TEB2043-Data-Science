# Array 1: 4 columns, 2 rows, 3 tables
Array1 <- array(1:24, dim = c(2, 4, 3))

# Print Array1
Array1

# Second row of second matrix of Array1
Array1[2, , 2]

# Array 2: 2 columns, 3 rows, 5 tables
Array2 <- array(25:54, dim = c(3, 2, 5))

# Print Array2
Array2

# Element in 3rd row, 3rd column of 1st matrix
Array2[3, 2, 1]
