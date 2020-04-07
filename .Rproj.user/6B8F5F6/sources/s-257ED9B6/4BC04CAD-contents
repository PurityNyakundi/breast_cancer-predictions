data2<-read.csv("data.csv",stringsAsFactors = FALSE)

view(data2)

data2$diagnosis<-as.character(data2$diagnosis)

str(data2)

#data2$diagnosis <-factor(data2$diagnosis, levels = c("B", "M"),
                         #labels = c("Benign", "Malignant"))
str(data2)
data2$diagnosis[data2$diagnosis=='B']<-1
data2$diagnosis[data2$diagnosis=='M']<-0
str(data2)
as.factor(data2$diagnosis)
table(data2$diagnosis)
