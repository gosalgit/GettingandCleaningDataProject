#Loads the packages needed
library(plyr)

#Setting the path for the current working directory
path <- getwd()
path

# Get the data from the source

#First of all  check if a data folder exists, if not then it will create one
if (!file.exists("data")) {dir.create("data")}

#Source file URL & destination file for Samsung Phone data
sourceFileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
destinationFile <- "./data/phonedata.zip"
#Downloading the source file to destination
download.file(sourceFileUrl, destinationFile)


# Unzipping the zipped file
executable <- file.path("C:", "Program Files", "7-Zip", "7z.exe")
parameters <- "x"
unzippedData <- paste(paste0("\"", executable, "\""), parameters, paste0("\"", file.path(path, destinationFile), "\""))
#Report about unzipped data
system(unzippedData)

#The files will be put in a folder named UCI HAR Dataset. This will list these files here
pathunzipped <- file.path(path, "UCI HAR Dataset")
list.files(pathunzipped, recursive = TRUE)

#Read the data files

# Read in the data for testing, training sets and labels
testingData <- read.table("./UCI HAR Dataset/test/X_test.txt")
testingLabel <- read.table("./UCI HAR Dataset/test/Y_test.txt")
testingDataSubject <- read.table("./UCI HAR Dataset/test/subject_test.txt")

trainingData <- read.table("./UCI HAR Dataset/train/X_train.txt")
trainingLabel <- read.table("./UCI HAR Dataset/train/Y_train.txt")
trainingDataSubject <- read.table("./UCI HAR Dataset/train/subject_train.txt")

#3-Uses descriptive activity names to name the activities in the data set
activityLabel <- read.table("./UCI HAR Dataset/activity_labels.txt")
features <- read.table("./UCI HAR Dataset/features.txt")

# Will clean the data labels by punging underscores and extra brackets 
features <- gsub("\\()", "", features$V2)
activityLabel <- activityLabel$V2
activityLabel <- tolower(activityLabel)
activityLabel <- sub("_", " ", activityLabel)

# Columns names are relabelled
names(testingData) <- features; names(trainingData) <- features
names(testingLabel) <- "activity"; names(trainingLabel) <- "activity"
names(testingDataSubject) <- "participant"; names(trainingDataSubject) <- "participant"

#1-Merges the training and the test sets to create one data set.
#Merges the training and the test sets and will create a DataFrame & bind the training data 
#to the bottom of the test data
dataFrame <- rbind(testingData, trainingData)

#3-Extracts only the measurements on the mean and standard deviation for each measurement
mSD <- grep("mean|std", names(dataFrame))


#Creates a new separate data frame for holding identifiers only
dataFrameTesting <- data.frame(testingLabel, testingDataSubject)
dataFrameTraining <- data.frame(trainingLabel, trainingDataSubject)
dataFrameIdentifiers <- rbind(dataFrameTesting, dataFrameTraining)

#For every mSD: adds the data frame mSD column to a new data frame
for (each in mSD){
  dataFrameIdentifiers <- cbind(dataFrameIdentifiers, dataFrame[each])
}


#3-Uses descriptive activity names to name the activities in the data set
#4-Appropriately labels the data set with descriptive variable names
# activity numbers are replaced with their respective labels
dataFrameIdentifiers$activity <- mapvalues(dataFrameIdentifiers$activity, 
                                           from = levels(factor(dataFrameIdentifiers$activity)), 
                                           to = activityLabel)


#5-From the data set in step 4, creates a second, independent tidy data set with the 
#average of each variable for each activity and each subject.				

# Creates a new tidy data frame with the average of each variable for each activity and subject
tidyDataFrame <- aggregate(dataFrameIdentifiers, list(dataFrameIdentifiers$participant, dataFrameIdentifiers$activity), mean)

#Cleans up the columns and column names after aggregating
tidyDataFrame$participant <- NULL; tidyDataFrame$activity <- NULL
names(tidyDataFrame)[1] <- "participant"; names(tidyDataFrame)[2] <- "activity"

# Data set as a txt file created with write.table() using row.name=FALSE
write.table(file = "tidydataset.txt", x = tidyDataFrame, row.names = FALSE)
