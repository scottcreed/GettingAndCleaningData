# GettingAndCleaningData

This is the final project for the Coursera "Getting and Cleaning Data" course.

The source data is provided at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

This data is described in:
- features.txt: Provides names for all of the variables in the observations
- features_info.txt: Provides a description of what the variables mean
- activity_labels.txt: Names for the activity labels for each observation

The script file **run_analysis.R** contains all the logic to read the source data and produce the two tidy datasets:
- Data\GettingAndCleaningDataFinal.csv
- Data\GettingAndCleaningDataAvgMeanAndStd.csv

## GettingAndCleaningDataFinal.csv
This file is the tidy dataset containing all observations for mean and std measures.  It is produced as follows:
- Download the zip file from the source to a Data directory (which is created if it does not exist)
- Extract the zip file to the Data Directory
- Reads the **UCI HAR Dataset\features.txt** file which provides names for the 561 columns in the observations
- Reads the **UCI HAR Dataset\activity_labels.txt** file which provides the ids and names for the activity labels
- For the Train dataset:
  - Reads the observation data from **UCI HAR Dataset\train\x_train.txt** and uses feature names for the column names
  - Reads and combines the activity id data from **UCI HAR Dataset\train\y_train.txt**
  - Reads and combines the subject id data from **UCI HAR Dataset\train\subject_train.txt**
- For the Test dataset:
  - Reads the observation data from UCI HAR **Dataset\test\x_test.txt** and users feature names for the column names
  - Reads and combines the activity id data from **UCI HAR Dataset\test\y_test.txt**
  - Reads and combines the subject id data from **UCI HAR Dataset\test\subject_test.txt**
- Combines the Train and Test datasets
- Selects only the measures that are mean or std measures
- Merges in the readable activity names corresponding to the activity ids in the dataset

The final tidy dataset is written to **Data\GettingAndCleaningDataFinal.csv**

## GettingAndCleaningDataAvgMeandAndStd.csv
This dataset contains averages of all of the measures from the dataset above.  The averages are
calculated for each activity/subject combination. 

Names of measures are prepended with avg_ to make it clear that they are averages of the original observations.

This dataset is then written to **Data\GettingAndCleaningDataAvgMeanAndStd.csv**
