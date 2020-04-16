#gather data in R-readable format
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")  
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")

#1. Merges the training and the test sets to create one data set.
# x is data for test and train experiments, so combine them
x_data <- rbind(x_train,x_test)
activity_data <- rbind(y_train, y_test) #holds activity corresponding to x data row
subject_data <- rbind(subject_train, subject_test) #holds subject corresponding to x data row

#2. Extracts only the measurements on the mean and standard deviation for each measurement.
# use grep to find index values relating to mean and std dev
meanstd <- grep("mean()|std()", features[, 2]) 
# use index values to create subset of x data that is only for mean and std dev.
x_data <- x_data[,meanstd]

#3. Uses descriptive activity names to name the activities in the data set
# Iteratively apply label from activity label table to numeric activity value
names(activity_data) <- 'activity'
for(i in 1:nrow(activity_labels)){
  activity_data$activity <- gsub(activity_labels$V1[i], activity_labels$V2[i], activity_data$activity)
}

#4. Appropriately labels the data set with descriptive variable names.
# 'features' table contains labels corresponding to data, so...
# tidy data labels by taking out extraneous parts of labels
x_labels <- gsub("[()]", "",features[, 2])
x_labels <- gsub("^t", "",x_labels)
x_labels <- gsub("-", "_",x_labels)
names(x_data) <- x_labels[meanstd] #use indexes from before to put label with data
names(subject_data) <- 'subject' 
total_analysis <- cbind(subject_data, activity_data, x_data)

#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
# "Melt and cast" data to reshape as mean
library(reshape2)
melted_data <- melt(total_analysis,id=c("subject","activity"))
tidy_data <- dcast(melted_data, subject + activity ~ variable, mean)
names(tidy_data)[-c(1:2)] <- paste("Average" , names(tidy_data)[-c(1:2)] )
write.table(tidy_data, "tidy_data.txt", row.names = FALSE)
#to see data:
#tidy_data2 <- read.table("tidy_data.txt")
#View(tidy_data2)