# Getting-and-Cleaning-Data-Course-Project
========================================

This repository contains one file: run_analysis.R

To execute the program run (from R command prompt):
source("run_analysis.R")

The program will download the data from source. If the original source is not available then the data may have to be unzipped and put into the working folder manually. The folder the program is looking for should be called: 'UCI HAR Dataset'. This folder should be in the same folder as run_analysis.R which should be the same as the working directory (can be set by using the setwd(path) command in the R prompt.

run_analysis.R, will complete the instructions as stated by the assignment in order:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
