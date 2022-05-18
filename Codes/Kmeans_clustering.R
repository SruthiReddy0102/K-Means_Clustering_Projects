install.packages("plyr")
library(plyr)
x <-  runif(50) # generating 50 random numbers
x
y <-  runif(50) # generating 50 random numbers 
y

data <- cbind(x, y) 
plot(data)

install.packages("animation")
library(animation)

km <- kmeans.ani(data, 3)
km$centers

# kmeans clustering
km <- kmeans(data, 3) 
str(km)


library(readxl)
input <- read_excel(file.choose())
mydata <- input[, -2]

# Normalize the data
normalized_data <- scale(mydata[, 2:7])

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
final <- data.frame(fit$cluster, mydata) # Append cluster membership

aggregate(mydata[, 2:7], by = list(fit$cluster), FUN = mean)
