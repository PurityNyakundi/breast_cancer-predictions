#load the dataset
#load the needed libraries
library(ggplot2)
library(dplyr)
library(tidyverse)
library(class)

cancer_data<- read.csv("data.csv",stringsAsFactors = FALSE)

View(cancer_data)

#some variables or features should be removed

cancer_data<-cancer_data[-1]


str(cancer_data)

#drop the last variable
dim(cancer_data)

cancer_data<-cancer_data[-32]

str(cancer_data)

#change the diagnosis to factor

cancer_data$diagnosis<-as.factor(cancer_data$diagnosis)

str(cancer_data)

table(cancer_data$diagnosis)

dim(cancer_data)

#next normalize the numeric data

normalize <- function(x) {
  return ((x - min(x)) / (max(x) - min(x)))
}


cancer_data_nom<-as.data.frame(lapply(cancer_data[2:31],normalize))


summary(cancer_data_nom)

#well already normalized

#separate the two to have the training and the testing dataset

cancer_data_train<-cancer_data_nom[1:460,]
cancer_data_test<-cancer_data_nom[461:569,]

#also separate the diagnosis labels

cancer_train_label<-cancer_data[1:460,1]
cancer_test_label<-cancer_data[461:569,1]

#train the model

kmodel<-knn(cancer_data_train,cancer_data_test,cl = 
              cancer_train_label,k = 3)
kmodel

#create a confusion matrix

table(cancer_test_label,kmodel)

#from the confusion matrix it seems we predicted 78 correct for benin and 5 wrong 

#now we can check the accuracy of our model

mean(cancer_test_label==kmodel)
#woow 94% accuracy
#lets try using random forest classifier
#form new dataset
cancer_data_train<-cancer_data[1:460,]
cancer_data_test<-cancer_data[461:569,]

#create a ranger model
library(ranger)
rmodel<-ranger(diagnosis~.,data = cancer_data_train,num.trees = 500, respect.unordered.factors="order")
#Do predictions for it
pred<-predict(rmodel,cancer_data_test)
pred
#check ones accuracy
mean(cancer_data_test$diagnosis==pred$predictions)

summary(rmodel)
#create a confusion matrix to check the given predictions
table(cancer_data_test$diagnosis,pred$predictions)

#as you can see ranger model is far more accurate than the knn 

#Thankyou

