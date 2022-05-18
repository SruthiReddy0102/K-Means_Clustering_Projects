# Load the dataset
Insurance <- read.csv(file.choose())
View(Insurance)

# Exploratory data analysis:
# 1. Measures of central tendency
# 2. Measures of dispersion
# 3. Third moment business decision
# 4. Fourth moment business decision
# 5. Probability distributions of variables 
# 6. Graphical representations (Histogram, Box plot, Dot plot, Stem & Leaf plot, Bar plot, etc.)

summary(Insurance)
attach(Insurance)

# Graphical representations (Histogram, Box plot, Dot plot, Stem & Leaf plot, Bar plot, etc.)

# Box plot Representation

boxplot(Premiums.Paid, col = "dodgerblue4",main = "Premium Paid")
boxplot(Claims.made, col = "dodgerblue4",main = "Claims")
boxplot(Days.to.Renew, col = "dodgerblue4",main = "Days to Renew Insurance")
boxplot(Income, col = "red", horizontal = T,main = "Income")

# Histogram Representation

hist(Premiums.Paid,col = "blue", main = "Premium Paid" )
hist(Claims.made,col = "blue", main = "Claims")
hist(Days.to.Renew, col = "blue",main = "Days to Renew Insurance")
hist(Income,col = "blue", main = "Income")



# Normalize the data
normalized_data <- scale(Insurance[, 1:5])

summary(normalized_data)

install.packages("plyr")
library(plyr)

# Elbow curve to decide the k value
twss <- NULL
for (i in 2:8) {
  twss <- c(twss, kmeans(normalized_data, centers = i)$tot.withinss)
}
twss

# Look for an "elbow" in the scree plot
plot(2:8, twss, type = "b", xlab = "Number of Clusters", ylab = "Within groups sum of squares")
title(sub = "K-Means Clustering Scree-Plot")


# 3 Cluster Solution
fit <- kmeans(normalized_data, 3) 
str(fit)
fit$cluster
final <- data.frame(fit$cluster, Insurance) # Append cluster membership

aggregate(Insurance[, 2:5], by = list(fit$cluster), FUN = mean)
