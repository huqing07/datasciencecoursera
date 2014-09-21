---
title: "README.md"
output: html_document
---

This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <http://rmarkdown.rstudio.com>.

When you click the **Knit** button a document will be generated that includes both content as well as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:

```{r}
summary(cars)
```

You can also embed plots, for example:

```{r, echo=FALSE}
plot(cars)
```

Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.

==================================================================
R Script for "Getting and Cleaning Data" Course Project
Data Analysis for Human Activity Recognition Using Smartphones Dataset
Version 1.0
==================================================================
==================================================================


Brief Background of the dataset:
===============================
The experiments have been carried out with a group of 30 volunteers. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, The experimenters captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. a vector of features was obtained by calculating variables from the time and frequency domain.The obtained dataset has been randomly partitioned into two sets, where 70% was selected for generating the training data and 30% the test data. 


The objective of this course project:
======================================

- Merges the training and the test sets to create one data set.
- Extracts only the measurements on the mean and standard deviation for each measurement. 
- Uses descriptive activity names to name the activities in the data set
- Appropriately labels the data set with descriptive variable names. 
- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for        each activity and each subject.

Steps to accomplish the goal:
=========================================

- Load training and test datasets
```{r, echo=FALSE}
X.train<-read.table('./UCI HAR Dataset/train/X_train.txt', sep='', header=FALSE)
```
- Add subject ID and activity label to X.train
```{r, echo=FALSE}
train<-cbind(X.train, y.train, subject.train)
```
- Append test dataset to training dataset
```{r, echo=FALSE}
train.test<-rbind(train, test)
```

- Add column names to the dataset
```{r, echo=FALSE}
colnames(train.test)<-c(as.character(features[,2], 'activity_label', 'subject'))
```

- Extract only the measurements on mean and standard deviation for each measurement
```{r, echo=FALSE}
mean.std.ind<-grep("mean()|std()", features[,2])
train.test.1<-train.test[c(mean.std.ind, 562, 563)]
```

- Add activity names
```{r, echo=FALSE}
data<-merge(train.test.1, activity_labels, by.x="activity_label", by.y="activity_label")
```

- Create a new dataset with the average of each variable for each activity and each subject
```{r, echo=FALSE}
new.data<-write.table('./UCI HAR Dataset/new.data.txt', sep='', row.names=FALSE)
```
==================================================================
