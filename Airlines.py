# Importing Required Packages
import pandas as pd
import numpy as np
import matplotlib.pylab as plt
from sklearn.cluster import	KMeans

# Importing Dataset
Airlines1 = pd.read_excel("C:/Data Science/Assignments/Module-K-Means/Codes/EastWestAirlines.xlsx")
Airlines1.describe()

# Removing unwanted columns
Airlines = Airlines1.drop(["ID#"], axis = 1)
Airlines.describe()

############Normalizing the data#################
def norm_func(i):
    x=(i-i.min()/i.std())
    return (x)

# Normalized data frame (considering the numerical part of data)
df_norm=norm_func(Airlines.iloc[:,0:])
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
Airlines['clust'] = mb # creating a  new column and assigning it to new column 

Airlines.head()
df_norm.head()

Airlines = Airlines.iloc[:,[11,0,1,2,3,4,5,6,7,8,9,10]]
Airlines.head()

Airlines.iloc[:, 1:12].groupby(Airlines.clust).mean()

Airlines.to_csv("Kmeans_Airlines.csv", encoding = "utf-8")

import os
os.getcwd()
