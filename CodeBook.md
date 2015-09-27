---
title: "Human Activity Recognition Using Smartphones Data Set"
author: "Gurinder"
date: "September 22, 2015"
output: html_document
---
##Problem Description

The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. The final submission will be: 1) a tidy data set as described below, 2) a link to a Github repository with the script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that was performed to clean up the data called CodeBook.md. Also include a README.md in the repo with the scripts. 
One of the most exciting areas in all of data science right now is wearable computing. Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users.

The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones )

Citation: Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. A Public Domain Dataset for Human Activity Recognition Using Smartphones. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013.

The data for the project is obtained from: (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

##Raw data

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 


The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.


•	features.txt: This file has the complete list of variables of each feature vector (descriptive names of activities)

•	X_trainingt.txt: This file has the training data for vector information (1-531) 


•	subject_training.txt: This file has the training data for vector information (1-531) 

•	y_training.txt: This file has the training data for vector information (1-531) 


•	X_test.txt: This file has the test data for vector information (1-531) 

•	subject_test.txt: This file has the test data for participant number (1-30) 


•	y_test.txt: This file has the test data for activity number (1-6) 



###Activity-Labels:

####1 WALKING

####2 WALKING_UPSTAIRS

####3 WALKING_DOWNSTAIRS

####4 SITTING

####5 STANDING

####6 LAYING




##Transformations


•	From the raw data, the data and labels were loaded into R. 

•	More appropriate labels given to the identifier column names such as "activity" and "participant". 


•	The renaming of the vector measurement column names was done using the features text file. 

•	These were further cleaned up to remove superfluous brackets. 


•	Then next step was to extract the measurements on the mean and standard deviation for each measurement. A data frame that displayed only mean and standard deviation data was created.

•	The merging of the training and testing data was done into a single data frame and thereafter it was filtered for column names "std" and "mean". Further these filtered columns were joined with the identifier columns to produce a new data frame.


•	Next the descriptive activity names were used  to name the activities in the data set and for this purpose activity_labels text file was used. The activity names were further refined by converting the characters to lower case and replacing the underscores with spaces.

•	Then an independent tidy data frame was created using the aggretate function with the average of each variable for each activity and each subject. 


•	Thereafter an independent tidy data set was created with the average of each variable for each activity and each subject. After this process of aggregation, new columns were created making some of the old ones redundant. Therefore, the old columns were removed and the new ones were renamed.



##Executing the Project 


Step 1 - Download the "run_analysis.R" file and Open the R script run_analysis.R using a R text editor.

Step 2 - Set up the current working directory to directory where the R script file is located.

Step 3 - Run the R script file.

Step 4 - The output tidy data file is in "tidydataset.txt"



##Outputs of the Project 


•	An output file of tidy dataset named "tidydataset.txt"

•	A codebook file codebook.md (Markdown)


•	A description file "README.md" (Markdown)

•	A R script file "run_analysis.R" to run the r script code for necessary transformations to obtain tidy data.



