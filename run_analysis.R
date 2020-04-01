library(reshape2)
library(dplyr)

setwd("~/Cursos/Ciencia de Datos John Hopkins/Curso 3/Tarea")

#load features and activity labels
features<-read.table("./UCI HAR Dataset/features.txt")
activity_labels<-read.table("./UCI HAR Dataset/activity_labels.txt")

#load train data set
train<-read.table("./UCI HAR Dataset/train/X_train.txt")     #features
colnames(train)<-features$V2                                 #colnames features
y_train<-read.table("./UCI HAR Dataset/train/y_train.txt")
train$activity<-y_train$V1
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt") #subjects
train$subject <- factor(subject_train$V1)

#load test data set
test<-read.table("./UCI HAR Dataset/test/X_test.txt")     #features
colnames(test)<-features$V2                                 #colnames features
y_test<-read.table("./UCI HAR Dataset/test/y_test.txt")
test$activity<-y_test$V1
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt") #subjects
test$subject <- factor(subject_test$V1)

#1 Merges the training and the test sets to create one data set.

df<-rbind(test,train)

#2 Extracts only the measurements on the mean and standard deviation for each measurement.

ColNames <- colnames(df)

ExtractCol<-grep("std\\(\\)|mean\\(\\)|activity|subject", ColNames, value=TRUE)

dfExtract<-df[,ExtractCol]

#3-4 Uses descriptive activity names to name the activities in the data set

dfExtract2<-merge(dfExtract,activity_labels,by.x = "activity",by.y = "V1")

colnames(dfExtract2)[69]<-"activityname"


#5 From the data set in step 4, creates a second, independent tidy data set with the 
#average of each variable for each activity and each subject.

ExtractCol2  <- grep("std\\(\\)|mean\\(\\)", ColNames, value=TRUE)
dfMelt <- melt(dfExtract2, id = c('activityname', 'subject'), measure.vars = ExtractCol2)
dfData <- dcast(dfMelt, activityname + subject ~ variable, mean) 

#creating a tidy dataset   
write.table(dfData, file = "tidydataset.txt", row.names = FALSE)

