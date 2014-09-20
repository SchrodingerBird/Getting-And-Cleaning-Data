Project of Getting and Cleaning Data Course in Coursera
=========================

This Readme file is a instuction for the source file run_analysis.R 

1. get and unzip the data source from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

2. before runing the run_analysis.R in the RStudio, you may set your working directory to ./UCI HAR Dataset

3. after runing the run_analysis.R,  you will get a file "tiny_Set.txt" which is the second, independent tidy data set with the average of each variable for each activity and each subject.

4. you may run data <- read.talbe("./tiny_Set.txt") in RStudio and you will get a 180 obs * 68 vars data set. (the repo containing the file tiny_Set.txt)
