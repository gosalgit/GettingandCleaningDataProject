---
title: "Human Activity Recognition Using Smartphones Data Set"
author: "Gurinder"
date: "September 22, 2015"
output: html_document
---
##Problem Description


The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. The final submission will be: 1) a tidy data set as described below, 2) a link to a Github repository with the script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that was performed to clean up the data called CodeBook.md. Also include a README.md in the repo with the scripts. 

This repo explains how all of the scripts work and how they are connected.  
One of the most exciting areas in all of data science right now is wearable computing. 
Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. 

###Sources


####Data

The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones )

Citation: Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. A Public Domain Dataset for Human Activity Recognition Using Smartphones. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013.

Here are the data for the project: (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)


####Description of Data


The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

###Task

Create one R script called run_analysis.R that does the following. 

1. Merges the training and the test sets to create one data set.

2. Extracts only the measurements on the mean and standard deviation for each measurement. 

3. Uses descriptive activity names to name the activities in the data set

4. Appropriately labels the data set with descriptive variable names. 

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


###Packages


The different packages were used in this project in R environment.

*	plyr

*	knitr


##Reproduction of the project -Tidy data set for Activity Sensors


*Step 1 - Download the "run_analysis.R" file and Open the R script run_analysis.R using a R text editor.

*Step 2 - Set up the current working directory to directory where the R script file is located

*Step 3 - Run the R script file

*Step 4 - The output tidy data file is in "tidydataset.txt"

## Preliminaries


###Loading the Packages


##### Loading of packages (assumed already installed) Step of Cousera’s Getting and Cleaning Data Project

The following code will load the packages used in this particular project.

```{r}
library(caret)
library(knitr)
library(plyr)
```


###Acquiring the Data


To get the data for the project, First of all  check if a data folder exists, if not then it will create one

```{r}
if (!file.exists("data")) {dir.create("data")}
```

###Source file URL & destination file for Samsung Phone data

```{r}
sourceFileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
destinationFile <- "./data/phonedata.zip"
```

###Downloading the source file to destination

```{r}
download.file(sourceFileUrl, destinationFile)
```

### Unzipping the zipped file

```{r}
executable <- file.path("C:", "Program Files", "7-Zip", "7z.exe")
parameters <- "x"
unzippedData <- paste(paste0("\"", executable, "\""), parameters, paste0("\"", file.path(path, destinationFile), "\""))
```

###Report about unzipped data


```{r}
system(unzippedData)
```

###The files will be put in a folder named UCI HAR Dataset. This will list these files here

```{r}
pathunzipped <- file.path(path, "UCI HAR Dataset")
list.files(pathunzipped, recursive = TRUE)


 [1] "activity_labels.txt"                         
 [2] "features.txt"                                
 [3] "features_info.txt"                           
 [4] "README.txt"                                  
 [5] "test/Inertial Signals/body_acc_x_test.txt"   
 [6] "test/Inertial Signals/body_acc_y_test.txt"   
 [7] "test/Inertial Signals/body_acc_z_test.txt"   
 [8] "test/Inertial Signals/body_gyro_x_test.txt"  
 [9] "test/Inertial Signals/body_gyro_y_test.txt"  
[10] "test/Inertial Signals/body_gyro_z_test.txt"  
[11] "test/Inertial Signals/total_acc_x_test.txt"  
[12] "test/Inertial Signals/total_acc_y_test.txt"  
[13] "test/Inertial Signals/total_acc_z_test.txt"  
[14] "test/subject_test.txt"                       
[15] "test/X_test.txt"                             
[16] "test/y_test.txt"                             
[17] "train/Inertial Signals/body_acc_x_train.txt" 
[18] "train/Inertial Signals/body_acc_y_train.txt" 
[19] "train/Inertial Signals/body_acc_z_train.txt" 
[20] "train/Inertial Signals/body_gyro_x_train.txt"
[21] "train/Inertial Signals/body_gyro_y_train.txt"
[22] "train/Inertial Signals/body_gyro_z_train.txt"
[23] "train/Inertial Signals/total_acc_x_train.txt"
[24] "train/Inertial Signals/total_acc_y_train.txt"
[25] "train/Inertial Signals/total_acc_z_train.txt"
[26] "train/subject_train.txt"                     
[27] "train/X_train.txt"                           
[28] "train/y_train.txt
```

##Read the data files


### Read in the data for testing, training sets and labels


```{r}
testingData <- read.table("./UCI HAR Dataset/test/X_test.txt")
testingLabel <- read.table("./UCI HAR Dataset/test/Y_test.txt")
testingDataSubject <- read.table("./UCI HAR Dataset/test/subject_test.txt")

trainingData <- read.table("./UCI HAR Dataset/train/X_train.txt")
trainingLabel <- read.table("./UCI HAR Dataset/train/Y_train.txt")
trainingDataSubject <- read.table("./UCI HAR Dataset/train/subject_train.txt")
```

####3-Uses descriptive activity names to name the activities in the data set


```{r}
activityLabel <- read.table("./UCI HAR Dataset/activity_labels.txt")
features <- read.table("./UCI HAR Dataset/features.txt")
```


#### Will clean the data labels by punging underscores and extra brackets 


```{r}
features <- gsub("\\()", "", features$V2)
activityLabel <- activityLabel$V2
activityLabel <- tolower(activityLabel)
activityLabel <- sub("_", " ", activityLabel)
```


#### Columns names are relabelled


```{r}
names(testingData) <- features; names(trainingData) <- features
names(testingLabel) <- "activity"; names(trainingLabel) <- "activity"
names(testingDataSubject) <- "participant"; names(trainingDataSubject) <- "participant"
```

##1-Merges the training and the test sets to create one data set.

####Merges the training and the test sets and will create a DataFrame & bind the training data to the bottom of the test data


```{r}
dataFrame <- rbind(testingData, trainingData)
```

####-Extracts only the measurements on the mean and standard deviation for each measurement


```{r}
mSD <- grep("mean|std", names(dataFrame))
```

####Creates a new separate data frame for holding identifiers only


```{r}
dataFrameTesting <- data.frame(testingLabel, testingDataSubject)
dataFrameTraining <- data.frame(trainingLabel, trainingDataSubject)
dataFrameIdentifiers <- rbind(dataFrameTesting, dataFrameTraining)
```

####For every mSD: adds the data frame mSD column to a new data frame


```{r}
for (each in mSD){
  dataFrameIdentifiers <- cbind(dataFrameIdentifiers, dataFrame[each])
}
```

####3-Uses descriptive activity names to name the activities in the data set
####4-Appropriately labels the data set with descriptive variable names


##### Activity numbers are replaced with their respective labels


```{r}
dataFrameIdentifiers$activity <- mapvalues(dataFrameIdentifiers$activity, 
                                           from = levels(factor(dataFrameIdentifiers$activity)), 
                                           to = activityLabel)
```


####5-From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.				


#### Creates a new tidy data frame with the average of each variable for each activity and subject


```{r}
tidyDataFrame <- aggregate(dataFrameIdentifiers, list(dataFrameIdentifiers$participant, dataFrameIdentifiers$activity), mean)
```

####Cleans up the columns and column names after aggregating

```{r}
tidyDataFrame$participant <- NULL; tidyDataFrame$activity <- NULL
names(tidyDataFrame)[1] <- "participant"; names(tidyDataFrame)[2] <- "activity"
```

## Tidy Data Output

#### Data set as a txt file created with write.table() using row.name=FALSE


```{r}
write.table(file = "tidydataset.txt", x = tidyDataFrame, row.names = FALSE)
```


