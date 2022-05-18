# Load the dataset
library(readxl)
Airline <- read_excel(file.choose())
View(Airline)

# Removing unnecessary columns
Data <- Airline[2:12]
View(Data)
str(Data)

summary(Data)

# Normalize the data
normalized_data <- scale(Data[, 1:11]) # As we already removed ID column so all columns need to normalize

summary(normalized_data)

# Elbow curve to decide the k value
twss <- NULL
for (i in 2:12) {
  twss <- c(twss, kmeans(normalized_data, centers = i)$tot.withinss)
}
twss

# Look for an "elbow" in the scree plot
plot(2:12, twss, type = "b", xlab = "Number of Clusters", ylab = "Within groups sum of squares")
title(sub = "K-Means Clustering Scree-Plot")


# 4 Cluster Solution
fit <- kmeans(normalized_data, 4) 
str(fit)
fit$cluster
final <- data.frame(fit$cluster, Data) # Append cluster membership

aggregate(Data[, 1:11], by = list(fit$cluster), FUN = mean)
