# Importing Required Packages
import pandas as pd
import matplotlib.pylab as plt
from sklearn.cluster import	KMeans

# Importing the data
data = pd.read_csv("C:/Data Science/Assignments/Module-K-Means/Codes/crime_data.csv")

# Renaming the column names
data.columns = 'State','Murder', 'Assault', 'UrbanPop','Rape'
data.describe()


# Normalization function 
def norm_func(i):
    x = (i-i.min())	/ (i.max()-i.min())
    return (x)

# Normalized data frame (considering the numerical part of data)
df_norm = norm_func(data.iloc[:, 1:])
df_norm.describe()

###### scree plot or elbow curve ############
TWSS = []
k = list(range(2, 8))

for i in k:
    kmeans = KMeans(n_clusters = i)
    kmeans.fit(df_norm)
    TWSS.append(kmeans.inertia_)
    
TWSS

# Scree plot 
plt.plot(k, TWSS, 'ro-');plt.xlabel("No_of_Clusters");plt.ylabel("total_within_SS")

# Selecting 3 clusters from the above scree plot which is the optimum number of clusters 
model = KMeans(n_clusters = 3)
model.fit(df_norm)

model.labels_ # getting the labels of clusters assigned to each row 
mb = pd.Series(model.labels_)  # converting numpy array into pandas series object 
data['clust'] = mb # creating a  new column and assigning it to new column 

data.head()
df_norm.head()

data = data.iloc[:,[5,0,1,2,3,4]]
data.head()

data.iloc[:, 2:6].groupby(data.clust).mean()

data.to_csv("Kmeans_Crime.csv", encoding = "utf-8")

import os
os.getcwd()
