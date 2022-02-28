library(dplyr)
library(ggplot2)
library(tidyverse)
library(plotrix)
library(RColorBrewer)
library(purrr)
library(cluster)
library(factoextra)
library(gridExtra)
library(grid)
library(NbClust)
library(FactoMineR)


cstmrs<-read.table("sc.csv",header=T,sep=",")
names(cstmrs)
str(cstmrs)
head(cstmrs)
summary(cstmrs)
summary(cstmrs$Age)
summary(cstmrs$Annual.Income..k..)
summary(cstmrs$Spending.Score..1.100.)
sd(cstmrs$Age)
sd(cstmrs$Annual.Income..k..)
sd(cstmrs$Spending.Score..1.100.)
sum(is.na(cstmrs))



plot(factor(cstmrs$Gender), main = "Gender Comparison",
     xlab = "Genders", ylab = "Frequency",col=brewer.pal(n = 3, name = "Pastel1"))

tb<-table(cstmrs$Gender)
pct<-round(tb/sum(tb)*100)
lbls<-paste(c("Female","Male")," ",pct,"%",sep = "")

pie3D(tb ,labels=lbls,main = "Gender Comparison",
     col=brewer.pal(n = 3, name = "Pastel1"))


hist(cstmrs$Age, freq = TRUE, main = "Histogram of age class",
     xlab = "Age class", ylab = "Frequency",col=brewer.pal(n = 5, name = "Pastel1"),labels=TRUE)

boxplot(cstmrs$Age, freq = TRUE, main = "Boxplot for descriptive analysis of Age",
     ylab = "Age class",col=brewer.pal(n = 5, name = "Pastel1"),labels=TRUE)

hist(cstmrs$Spending.Score..1.100., freq = TRUE, main = "Histogram of Spending Score",
     xlab = "Spending score class", ylab = "Frequency",col=brewer.pal(n = 5, name = "Pastel1"),labels=TRUE)

boxplot(cstmrs$Spending.Score..1.100., freq = TRUE, main = "Boxplot for descriptive analysis of Spending Score",
        ylab = "Spending score class",col=brewer.pal(n = 5, name = "Pastel1"),labels=TRUE)

plot(density(cstmrs$Annual.Income..k..), main = "Density Plot for Annual Income",
     xlab = "Annual Income Class", ylab = "Density",col=brewer.pal(n = 3, name = "Pastel1"))
polygon(density(cstmrs$Annual.Income..k..), col="red", border="blue")

cstmrs
data1<-cstmrs[,5:6]
data1



nb <- NbClust(data1, distance = "euclidean", min.nc = 2,
              max.nc = 10, method = "kmeans")

set.seed(123)

ks <- 1:10
tot_within_ss <- sapply(ks, function(k) {
  cl <- kmeans(data1, k, nstart = 100)
  cl$tot.withinss
})
# plot "the elbow method"
plot(ks, tot_within_ss, type = "b",
     xlab="Number of clusters k",
     ylab="Total within-clusters sum of squares")

#plot the elbow method with nbclust 
fviz_nbclust(data1, kmeans, method="wss")


#Silhouette

fviz_nbclust(data1, kmeans, method="silhouette")

#Visualization of clusters

# color per groups
mfcol=c(1,1)
kc <- kmeans( data1, 4 , nstart = 25, iter.max = 100 )
clusplot( data1, kc$cluster, color = TRUE, 
          shade = FALSE, labels = 4, lines = 1,
          col.p = kc$cluster )


cl_hcpc <- HCPC( data1, nb.clust = 4)



