student$Chemistry <- c(59, 71, 83, 68, 65, 57, 62, 92, 92, 59)
student$Physics <- c(89, 86, 65, 52, 60, 67, 40, 77, 90, 61)

chem_fail <- sum(student$Chemistry <= 49)
phy_fail <- sum(student$Physics <= 49)

cat("Chemistry failures:", chem_fail, "\n")
cat("Physics failures:", phy_fail, "\n")

best_chem <- max(student$Chemistry)
best_phy <- max(student$Physics)

chem_topper <- student$Name[student$Chemistry == best_chem]
phy_topper <- student$Name[student$Physics == best_phy]

cat("Best Chemistry score:", best_chem, "by", chem_topper, "\n")
cat("Best Physics score:", best_phy, "by", phy_topper, "\n")
