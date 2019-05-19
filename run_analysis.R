library(dplyr)

##Initialize environment variables
sourceDataUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dataDirectory <- ".\\Data"

##Initialize dataset variables
zipFileName <- ".\\Data\\UCI HAR Dataset.zip"
featureNamesFile <- ".\\Data\\UCI HAR Dataset\\features.txt"
activityNamesFile <- ".\\Data\\UCI HAR Dataset\\activity_labels.txt"
trainObsFile <- ".\\Data\\UCI HAR Dataset\\train\\x_train.txt"
trainActivityFile <- ".\\Data\\UCI HAR Dataset\\train\\y_train.txt"
trainSubjectFile <- ".\\Data\\UCI HAR Dataset\\train\\subject_train.txt"
testObsFile <- ".\\Data\\UCI HAR Dataset\\test\\x_test.txt"
testActivityFile <- ".\\Data\\UCI HAR Dataset\\test\\y_test.txt"
testSubjectFile <- ".\\Data\\UCI HAR Dataset\\test\\subject_test.txt"


##Create a data directory if it doesn't exist
if (!dir.exists(dataDirectory)) dir.create(dataDirectory)

##Download the zip file from the source if it does not exist
if (!file.exists(zipFileName))
{
  download.file(sourceDataUrl,zipFileName)
}

##Extract the data from the zip file
unzip(fileName,exdir = dataDirectory)

##------Common names---------------
##Read the feature (names)
featureNames <- read.table(featureNamesFile,col.names = c("colId","name"))

##Read the activity (names)
activityNames <- read.table(activityNamesFile, col.names = c("activityId","activityName"))

##------Train Data-----------------
##--4: Read the train data using feature names for descriptive variable names
trainData <- read.table(trainObsFile, col.names = featureNames[,"name"])

##Read the train activity labels
trainLabels <- read.table(trainActivityFile,col.names = "activityId")

##Bind the train activity labels to the train data
trainData <- cbind(trainLabels,trainData)

##Read the train subjects
trainSubjects <- read.table(trainSubjectFile,col.names = "subjectId")

##Bind the train subjects into the data
trainData <- cbind(trainSubjects,trainData)

##------Test Data-----------------
##--4: Read the test data using feature names for descriptive variable names
testData <- read.table(testObsFile, col.names = featureNames[,"name"])

##Read the test activity labels
testLabels <- read.table(testActivityFile,col.names = "activityId")

##Bind the test activity labels to the test data
testData <- cbind(testLabels,testData)

##Read the test subjects
testSubjects <- read.table(testSubjectFile,col.names = "subjectId")

##Bind the test subjects into the data
testData <- cbind(testSubjects,testData)

##------1: Combine Data to one set------------
##Bind the test and train data
allData <- rbind(trainData,testData)

##------2: Only Mean and Std measurements-----
##Get only mean and std measurment colunm names
meanStdNames <- filter(featureNames,grepl("mean[(]",name) | grepl("std",name))

##Select only subjectid, activityId, and the mean/std columns
meanStdData <- select(allData,c("subjectId","activityId",meanStdNames[,1]))

##------3: Add descriptive activity names-----
##Add the activity name into the data
finalData <- merge(activityNames,meanStdData,by = "activityId")
View(finalData)

##------5: Average all of the columns by Activity and Subject
avgData <- aggregate(select(finalData,-(c("activityId","activityName","subjectId"))),list(finalData$activityId,finalData$activityName,finalData$subjectId),mean)
names(avgData) <- paste("avg_",names(avgData),sep="")
names(avgData)[1:3] <- c("activityId","activityName","subjectId")
avgData <- arrange(avgData,activityId,subjectId)
View(avgData)
