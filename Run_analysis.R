###loading dataset

##train dataset
X.train<-read.table('./UCI HAR Dataset/train/X_train.txt', sep='', header=FALSE)
##head(X.train)
dim(X.train)##[1] 7352  561

##6 activities
y.train<-read.table('./UCI HAR Dataset/train/y_train.txt', sep='', header=FALSE)
##head(y.train)
dim(y.train)##[1] 7352    1

##30 subjects (volunteers)
subject.train<-read.table('./UCI HAR Dataset/train/subject_train.txt', sep='', header=FALSE)
##head(subject.train)
dim(subject.train)##[1] 7352    1

##combine measurements, activity labels, and subjects
train <- cbind(X.train, y.train, subject.train)


###test dataset
X.test<-read.table('./UCI HAR Dataset/test/X_test.txt', sep='', header=FALSE)
##head(X.test)
dim(X.test)##[1] 2947  561

##6 activities
y.test<-read.table('./UCI HAR Dataset/test/y_test.txt', sep='', header=FALSE)
##head(y.test)
dim(y.test)##[1] 2947    1


##30 subjects (volunteers)
subject.test<-read.table('./UCI HAR Dataset/test/subject_test.txt', sep='', header=FALSE)
##head(subject.test)
dim(subject.test)##[1] 2947    1

##combine three test dataset
test <- cbind(X.test, y.test, subject.test)


##Step 1 combine train and test datasets
train.test <- rbind(train, test)


##loading features
##features
features<-read.table('./UCI HAR Dataset/features.txt', sep='', header=FALSE)
##head(features[,2])
dim(features)##[1] 561   2

##add column names to train.test dataset
colnames(train.test)<-c(as.character(features[,2]),'activity_label','subject')
##head(train.test)
dim(train.test)##[1] 10299   563


####Step 2 extract only the measurements on mean and std
mean.std.ind <- grep("mean()|std()", features[,2])

train.test.1 <- train.test[c(mean.std.ind,562,563)]
##head(train.test.1)

##activity_labels
activity_labels<-read.table('./UCI HAR Dataset/activity_labels.txt', sep='', header=FALSE)
##head(activity_labels)
dim(activity_labels)##[1] 6 2

colnames(activity_labels)<-c('activity_label','activity')


###Step 3 add activity names
data<-merge(train.test.1, activity_labels, by.x='activity_label', by.y='activity_label')
dim(data)##[1] 10299    82
##head(data)


####Step 5 create new tidy data with the average of each variable for each activity and for each subject
new.data <- data.frame(subject=rep(seq(30), each=6), activity=rep(levels(activity_labels[,2]),30))
for (i in seq(2,80)){
    t <- tapply(data[,i],list(data$activity,data$subject), mean)
new.data <- cbind(new.data, as.vector(t))
}

dim(new.data)
##head(new.data)

##Step 4 add descriptive variable names
colnames(new.data)[3:81] <- names(data)[2:80]

##export the new dataset as a txt file
write.table(new.data, file='./UCI HAR Dataset/new.data.txt', row.names=FALSE)

