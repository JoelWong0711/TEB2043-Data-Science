num <- as.integer(readline(prompt="Enter an integer: "))

# cube of the integer
for (i in 1:num){
  cat("Number is: ",i, "and cube of the ",i,"is",i^3,"\n" )
}