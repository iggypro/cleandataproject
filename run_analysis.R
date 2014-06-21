## Getting and Cleaning Data - Course Project
## June 8th, 2014

## Read data from dataset directory
path <- getwd()

## Read labels
activity_labels <- read.table(paste(path,"activity_labels.txt",sep="/"),header=F,sep="")
features <- read.table(paste(path,"features.txt",sep="/"),header=F,sep="")

## Read test set
subject_test <- read.table(paste(path,"test/subject_test.txt",sep="/"),header=F,sep="")
x_test <- read.csv(paste(path,"test/X_test.txt",sep="/"),header=F,sep="")
y_test <- read.csv(paste(path,"test/y_test.txt",sep="/"),header=F,sep="")

## Read training set
subject_train <- read.table(paste(path,"train/subject_train.txt",sep="/"),header=F,sep="")
x_train <- read.csv(paste(path,"train/X_train.txt",sep="/"),header=F,sep="")
y_train <- read.csv(paste(path,"train/y_train.txt",sep="/"),header=F,sep="")

## Add column names to X vectors
colnames(x_train) <- as.character(features[,2])
colnames(x_test) <- as.character(features[,2])

## Add activity labels to Y vectors
names(y_test) <- "Activity"
names(y_train) <- "Activity"
y_test$Activity <- as.factor(y_test$Activity)
y_train$Activity <- as.factor(y_train$Activity)
levels(y_test$Activity) <- as.character(activity_labels$V2)
levels(y_train$Activity) <- as.character(activity_labels$V2)

## Merge X, Y and Subject
x_test$Activity <- as.factor(y_test$Activity)
x_test$Subject <- as.factor(subject_test$V1)
x_train$Activity <- as.factor(y_train$Activity)
x_train$Subject <- as.factor(subject_train$V1)

## Add only Activity, Subject,MEAN & STD variable to Tidy Dataset
tidyTest <- data.frame(x_test$Activity,x_test$Subject)
tidyTest <- cbind(tidyTest,
              x_test[,which(grepl("mean\\(\\)",names(x_test)))],
              x_test[,which(grepl("std\\(\\)",names(x_test)))])
colnames(tidyTest)[1:2] <- c("Activity","Subject")

tidyTrain <- data.frame(x_train$Activity,x_train$Subject)
tidyTrain <- cbind(tidyTrain,
               x_train[,which(grepl("mean\\(\\)",names(x_train)))],
               x_train[,which(grepl("std\\(\\)",names(x_train)))])
colnames(tidyTrain)[1:2] <- c("Activity","Subject")

## Merge Test and Train
tidy <- data.frame(rbind(tidyTrain,tidyTest))

## Aggregate data frame by averaging all variables for each Activity/Subject pair
tidy <- aggregate(.~tidy$Activity+tidy$Subject,data=tidy,mean,na.action=na.omit)
tidy <- tidy[,-c(3,4)]

## Add meaningful variable names
colnames(tidy)[1:2] <- c("Activity","Subject")
colnames(tidy) <- gsub("\\.mean\\.\\.\\.","Mean",colnames(tidy))
colnames(tidy) <- gsub("\\.std\\.\\.\\.","Std",colnames(tidy))
colnames(tidy) <- gsub("\\.mean\\.\\.","Mean",colnames(tidy))
colnames(tidy) <- gsub("\\.std\\.\\.","Std",colnames(tidy))

## Write tidy datset to file in the working directory
write.table(tidy,"tidy_dataset_table.txt")