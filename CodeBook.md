# Code Book

## Variable definitions
temp, a temporary file used for downloading the data zip file.  
startPath, original path of working directory which is used later to locate the output folder.  
features, data table used for the features.txt file.  
subjectTrain, data table used for the subject_train.txt file.  
xTrain, data table used for the x_train.txt file  
yTrain, data table used for the y_train.txt file  
subjectTest, data table used for the subject_test.txt  
xTest, data table used for the x_test.txt file  
yTest, data table used for the y_test.txt file  
trainingData, the data frame combination of the yTrain, subjectTrain and xTrain files by column  
testData, the data frame combination of the yTest, subjectTest and xTest by column  
headers, a char vector which can be applied to each of the combined data sets  
fullDataSet, combines the training and test data sets by row  
ids, boolean vector used to identify the id columns  
means, boolean vector used to identify the mean columns  
stds, boolean vector used to identify the standard deviation columns  
keepCols, the logically combined (using OR) of the three boolean vectors: ids, means and stds  
fullFilteredData, the full data set after unused columns have been filtered out  
activityLabels, data table which contains the activity labels for each activity id  
fullFilteredLabeledData, the full data set after the activities have been labelled  
final, data frame containing only the mean values of all columns grouped by activity and subject  

## List of main transformations performed by step  
### Step 1:  
After the data is downloaded it will be unzipped  
Binding training and test data into single data frame object  
The column names are added to the data set  

### Step 2:  
Create a vector of columns to keep  
Use vector of columns to keep to filter data table into just data for analysis  

### Step 3:  
Get the activity labels and merge them into the data set on the activity id column  

### Step 4:  
Relabel the data set with more readable names  

### Step 5:  
Aggregate the data set using the (new) column names: Activity Id, Subject Id and Activity Name, calculate the mean for all other columns  
Output the data file in tab separated text file format  


