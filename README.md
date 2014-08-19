 README.md
==================================================================
 Average of Mean and Standard Deviation  for Human Activity Recognition Using Smartphones Dataset
 Version 1.0
==================================================================
 Getting and Cleaning Data Class Project assignment

==================================================================
 Source Data reference: readme.txt file from "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
 
==================================================================
 For each record it is provided:
======================================
  
 - ActivityName that performers perfermed.
 - Subject idenifying the person who perform the activity
 - Mean of Triaxial acceleration and Triaxial Angular velocity estimations per ActivityName and Subject.
 - Standard deviation of Triaxial acceleration and Triaxial Angular velocity estimations per ActivityName and Subject.

 The dataset includes the following files:
=========================================
  
 - 'README.md'
 - 'run_analysis.R': Generates the Average of Mean and Standard Deviation  for Human Activity Recognition Using Smartphones dataset.
 - 'AverageMeasuresHumanActivityRecognition.txt': Contains the average of mean and standard deviation of measured variables 
                                                  per performed activities and per performer for Human Activity Recognition Using Smartphones. 

 - 'CodeBook.md': Shows information about the variables of 'AverageMeasuresHumanActivityRecognition.txt' data that the run_analysis.R genarated.

 How to read this dataset into R
=========================================
 read.table("filename.txt", head=TRUE) is recommended

 Version
=========================================
  1.0