# Load dataset
data("mtcars")

# View structure
str(mtcars)

# Select one numeric variable for normalization example (mpg)
x <- mtcars$mpg

# Log transformation
log_x <- log(x)

# View result
log_x

# Standard scaling
standard_x <- scale(x)

# View result
standard_x

# Min-max scaling
minmax_x <- (x - min(x)) / (max(x) - min(x))

# View result
minmax_x

# Comparison table
result <- data.frame(
  Original = x,
  Log = log_x,
  Standard = as.vector(standard_x),
  MinMax = minmax_x
)

head(result)

