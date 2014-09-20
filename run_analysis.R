# 1. Merges the training and the test sets to create one data set.

# setwd("E:/Coursera/Getting and Cleaning Data/Project/UCI HAR Dataset")

train_Set <- read.table("./train/X_train.txt") # read training set (7352 obs * 561 vars)
train_Label <- read.table("./train/y_train.txt") 
train_Subject <- read.table("./train/subject_train.txt") 

test_Set <- read.table("./test/X_test.txt") # read test set (2947 obs * 561 vars)
test_Label <- read.table("./test/Y_test.txt") 
test_Subject <- read.table("./test/subject_test.txt") 

merged_Set <- rbind(train_Set, test_Set) # merge traing and test set (10299 obs * 561 vars)
merged_Label <- rbind(train_Label, test_Label)
merged_Subject <- rbind(train_Subject, test_Subject)



# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

features <- read.table("./features.txt")
meanstd_Number <- grep("mean\\(\\)|std\\(\\)", features[, 2]) 
# merged_Set_Orig <- merged_Set # copy the original merged_Set for convenient
merged_Set <- merged_Set[, meanstd_Number] # select mean and std of data, (10299 obs * 66 vars) 

names(merged_Set) <- gsub("\\(\\)", "", features[meanstd_Number, 2]) # remove "()" 
names(merged_Set) <- gsub("-", "", names(merged_Set)) # remove "-"
names(merged_Set) <- gsub("mean", "Mean", names(merged_Set)) # "m" to "M"
names(merged_Set) <- gsub("std", "Std", names(merged_Set)) # "s" to "S"



# 3. Uses descriptive activity names to name the activities in the data set

activity_Names <- read.table("./activity_labels.txt")

activity_Names[, 2] <- tolower(gsub("_", "", activity_Names[, 2])) # "upper letters to lower letters"

substr(activity_Names[, 2], 1, 1) <- toupper(substr(activity_Names[, 2], 1, 1)) # capitalize the first letter of words
activity_Names[, 2] <- gsub("up", "Up", activity_Names[, 2])
activity_Names[, 2] <- gsub("down", "Down", activity_Names[, 2])

activity_Label <- activity_Names[merged_Label[, 1], 2]
merged_Label[, 1] <- activity_Label
names(merged_Label) <- "Activity"



# 4. Appropriately labels the data set with descriptive variable names. 

names(merged_Subject) <- "Subject"

cleaned_Set <- cbind(merged_Subject, merged_Label, merged_Set) # get the cleand data set
#write.table(cleaned_Set, "cleaned_Set.txt", row.names = F)


# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

subject_Number <- sort(unique(merged_Subject)[,1])
tiny_Set <- cleaned_Set[1:(length(subject_Number)*length(activity_Names[,2])), ] # tiny set is 180 obs * 68 vars
var_Number <- length(cleaned_Set[1, ])
j <- 1

for (i in subject_Number) { # this for loop is to calculate the mean of each variable for each activity and each subject.
  for (subject_Names in activity_Names[, 2]) {
    tiny_Set[j, 1] <- i
    tiny_Set[j, 2] <- subject_Names
    tiny_Set[j, 3:var_Number] <- colMeans(cleaned_Set[cleaned_Set$Subject == i & cleaned_Set$Activity == subject_Names, 3:var_Number])
    j <- j+1
  }
}

write.table(tiny_Set, "tiny_Set.txt", row.names = F) # write the tiny data set as tiny_Set.txt
