# Load the dataset
data <- read.csv(file.choose())
View(data)

# Exploratory data analysis:
# 1. Measures of central tendency
# 2. Measures of dispersion
# 3. Third moment business decision
# 4. Fourth moment business decision
# 5. Probability distributions of variables 
# 6. Graphical representations (Histogram, Box plot, Dot plot, Stem & Leaf plot, Bar plot, etc.)

summary(data)
attach(data)

# Graphical representations (Histogram, Box plot, Dot plot, Stem & Leaf plot, Bar plot, etc.)

# Box plot Representation

boxplot(Murder, col = "dodgerblue4",main = "Murder")
boxplot(Assault, col = "dodgerblue4",main = "Assault")
boxplot(UrbanPop, col = "dodgerblue4",main = "UrbanPop")
boxplot(Rape, col = "red", horizontal = T,main = "Rape")

# Histogram Representation

hist(Murder,col = "blue", main = "Murder" )
hist(Assault,col = "blue", main = "Assault")
hist(UrbanPop,col = "blue", main = "UrbanPop")
hist(Rape,col = "blue", main = "Rape")


# Normalize the data
normalized_data <- scale(data[, 2:5])

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
final <- data.frame(fit$cluster, data) # Append cluster membership

aggregate(data[, 2:5], by = list(fit$cluster), FUN = mean)
