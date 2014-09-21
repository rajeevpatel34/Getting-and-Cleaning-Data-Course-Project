#########################################################################
## Step 1: Merges the training and the test sets to create one data set.
#########################################################################

# Remove assigned variables in workspace
rm(list=ls());

# Download zip and unzip into working directory
temp <- tempfile();
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", temp);
unzip(temp);

# Get path to use later
startPath <- getwd()

# Move into new folder as working directory
setwd("./UCI HAR Dataset/");

# Read all the input data into data.tables
features <- read.table("./features.txt", header=F);
subjectTrain <- read.table("./train/subject_train.txt", header=F);
xTrain <- read.table("./train/x_train.txt", header=F);
yTrain <- read.table("./train/y_train.txt", header=F);
subjectTest <- read.table("./test/subject_test.txt", header=F);
xTest <- read.table("./test/x_test.txt", header=F);
yTest <- read.table("./test/y_test.txt", header=F);

# Bind training and test data into single data frame object
trainingData <- cbind(yTrain, subjectTrain, xTrain);
testData <- cbind(yTest, subjectTest, xTest);
headers <- c("activityId", "subjectId", as.character(features[,2]));
fullDataSet <- rbind(trainingData, testData);
colnames(fullDataSet) = headers

#########################################################################
## Step 2: Extracts only the measurements on the mean and 
##         standard deviation for each measurement. 
#########################################################################

# Create a vector of columns to keep
ids <- grepl("Id", headers);
means <- grepl("-mean[(][)]", headers);
stds <- grepl("-std[(][)]", headers);
keepCols <- ids | means | stds

# Use vector of columns to filter data table into just data for analysis
fullFilteredData = fullDataSet[keepCols];

#########################################################################
## Step 3: Uses descriptive activity names to name the activities in the data set
#########################################################################

# Get and apply the activity Labels to the filtered data set
activityLabels <- read.table("./activity_labels.txt", header=F);
colnames(activityLabels) = c("activityId", "activityName");
fullFilteredLabeledData = merge(fullFilteredData, activityLabels, by.x="activityId", by.y="activityId", all.x=T);

#########################################################################
## Step 4: Appropriately labels the data set with descriptive variable names. 
#########################################################################

colnames(fullFilteredLabeledData) <- c("Activity Id","Subject Id","Body Acceleration Mean X","Body Acceleration Mean Y","Body Acceleration Mean Z",
                                       "Body Acceleration Std Dev X","Body Acceleration Std Dev Y","Body Acceleration Std Dev Z","Gravity Acceleration Mean X","Gravity Acceleration Mean Y",
                                       "Gravity Acceleration Mean Z","Gravity Acceleration Std Dev X","Gravity Acceleration Std Dev Y","Gravity Acceleration Std Dev Z","Body Acceleration Jerk Mean X",
                                       "Body Acceleration Jerk Mean Y","Body Acceleration Jerk Mean Z","Body Acceleration Jerk Std Dev X","Body Acceleration Jerk Std Dev Y","Body Acceleration Jerk Std Dev Z",
                                       "Body Gyro Mean X","Body Gyro Mean Y","Body Gyro Mean Z","Body Gyro Std Dev X","Body Gyro Std Dev Y",
                                       "Body Gyro Std Dev Z","Body Gyro Jerk Mean X","Body Gyro Jerk Mean Y","Body Gyro Jerk Mean Z","Body Gyro Jerk Std Dev X",
                                       "Body Gyro Jerk Std Dev Y","Body Gyro Jerk Std Dev Z","Body Acceleration Magnitude Mean","Body Acceleration Magnitude Std Dev","Gravity Acceleration Magnitude Mean",
                                       "Gravity Acceleration Magnitude Std Dev","Body Acceleration Jerk Magnitude Mean","Body Acceleration Jerk Magnitude Std Dev","Body Gyro Magnitude Mean","Body Gyro Magnitude Std Dev",
                                       "Body Gyro Jerk Magnitude Mean","Body Gyro Jerk Magnitude Std Dev","FFT Body Acceleration Mean X","FFT Body Acceleration Mean Y","FFT Body Acceleration Mean Z",
                                       "FFT Body Acceleration Std Dev X","FFT Body Acceleration Std Dev Y","FFT Body Acceleration Std Dev Z","FFT Body Acceleration Jerk Mean X","FFT Body Acceleration Jerk Mean Y",
                                       "FFT Body Acceleration Jerk Mean Z","FFT Body Acceleration Jerk Std Dev X","FFT Body Acceleration Jerk Std Dev Y","FFT Body Acceleration Jerk Std Dev Z","FFT Body Gyro Mean X",
                                       "FFT Body Gyro Mean Y","FFT Body Gyro Mean Z","FFT Body Gyro Std Dev X","FFT Body Gyro Std Dev Y","FFT Body Gyro Std Dev Z",
                                       "FFT Body Acceleration Magnitude Mean","FFT Body Acceleration Magnitude Std Dev","FFT Body Body Acceleration Jerk Magnitude Mean","FFT Body Body Acceleration Jerk Magnitude Std Dev","FFT Body Body Gyro Magnitude Mean",
                                       "FFT Body Body Gyro Magnitude Std Dev","FFT Body Body Gyro Jerk Magnitude Mean","FFT Body Body Gyro Jerk Magnitude Std Dev","Activity Name");

#########################################################################
## Step 5: From the data set in step 4, creates a second, independent 
##         tidy data set with the average of each variable for each activity
##         and each subject.
#########################################################################

# Aggregate data by activity and subject
final <- aggregate(fullFilteredLabeledData[,colnames(fullFilteredLabeledData) != c("Activity Id","Subject Id", "Activity Name")],
                   by=list(activityId=fullFilteredLabeledData$"Activity Id",
                           subjectId = fullFilteredLabeledData$"Subject Id",
                           activityName = fullFilteredLabeledData$"Activity Name"), mean);

# Move back to the folder where initially started from
setwd(startPath)

# Output file
write.table(final, "./finalTidyDataSet.txt", row.name=FALSE, sep="\t");


