# GettingAndCleaningData

This is the final project for the Coursera Getting and Cleaning Data course.

## UCI HAR Dataset\GettingAndCleaningDataFinal.csv
The script file run_analysis.R contains all the logic to produce the initial tidy dataset:
- Download the zip file from the source to a Data directory (which is created if it does not exist)
- Extract the zip file to the Data Directory
- Reads the **UCI HAR Dataset\features.txt** file which provides names for the 561 columns in the observations
- Reads the **UCI HAR Dataset\activity_lables.txt** file which provides the ids and names for the activity labels
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

## UCI HAR Dataset\GettingAndCleaningDataAvgMeandAndStd.csv
The dataset is then processed to calculate the averages of the measures by activity and subject.

Names of measures are prepended with avg_ to make it clear that they are averages of the original observations.

This dataset is written to **Data\GettingAndCleaningDataAvgMeanAndStd.csv**
