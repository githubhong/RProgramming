## Script Name: run_analysis.R
## Last Update: MM-DD-YYYY
## Author: myname
## Description: This script takes the source data and generate one R data set
## which contains the average of mean and standard deviation  of measured variables 
## per performed activities and per performer for Human Activity Recognition Using Smartphones.
## Source Data: Human Activity Recognition Using Smartphones Dataset
## Script Output: AverageMeasuresHumanActivityRecognition.txt

## Step 1: Manually do the following's before running this script:
##         Create a folder ~/UCI_HAR_Dataset. 
##         Download the zip file from "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
##         Extract the file into ~/UCI_HAR_Dataset folder
        
## Step 2: Read in files into R and assign meaningful column names to the R data sets

## This data set contains 6 meansured activities, including: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING
## It applies to both test and training data sets.
    activity_labels_rawdata<-read.table("~/UCI_HAR_Dataset/activity_labels.txt", sep = " ", head=FALSE, quote="")
    colnames(activity_labels_rawdata)[1] <- "ActivityCode"
    colnames(activity_labels_rawdata)[2] <- "ActivityName"

## This data set contains 561 measured feature names, which are the source of merged data set column names.
## It applies to both test and training data sets.
    features_rawdata<-read.table("~/UCI_HAR_Dataset/features.txt", sep = " ", head=FALSE, quote="")
    colnames(features_rawdata)[1] <- "FeatureCode"
    colnames(features_rawdata)[2] <- "FeatureName"

## These data sets contains subject, in another words, the identification of the people who performance the activities.
## One set contains performers for test data. The other is for performers for training data. 
    subject_test_rawdata<-read.table("~/UCI_HAR_Dataset/test/subject_test.txt", sep = " ", head=FALSE, quote="")
    colnames(subject_test_rawdata)[1] <- "Subject"
    subject_train_rawdata<-read.table("~/UCI_HAR_Dataset/train/subject_train.txt", sep = " ", head=FALSE, quote="")
    colnames(subject_train_rawdata)[1] <- "Subject"

## These data sets contain estimated measures for every features performed by the subject.
## One set contains test data, the other is traning data.
## Column names are assigned based on featurename column from features_rawdata data set.
    X_test_rawdata<-read.table("~/UCI_HAR_Dataset/test/X_test.txt")
    colnames(X_test_rawdata)<- features_rawdata$FeatureName
    X_train_rawdata<-read.table("~/UCI_HAR_Dataset/train/X_train.txt")
    colnames(X_train_rawdata)<- features_rawdata$FeatureName

## These data sets contain the activity labels for data within X_test.txt.    
## The activity code is identified as 1 for WALKING, 2 for WALKING_UPSTAIRS, etc.
## One set contains test data, the other is traning data.
    y_test_rawdata<-read.table("~/UCI_HAR_Dataset/test/y_test.txt", sep = " ", head=FALSE, quote="")
    colnames(y_test_rawdata)[1] <- "ActivityCode"
    y_train_rawdata<-read.table("~/UCI_HAR_Dataset/train/y_train.txt", sep = " ", head=FALSE, quote="")
    colnames(y_train_rawdata)[1] <- "ActivityCode"

## Step 3 combine test and training data into one data set
    
## row concatenate test feature rows and training feature rows into one data set
    FeaturesMeasures<- rbind(X_test_rawdata,X_train_rawdata )
## row concatenate test subject and training subject into one data set
    SubjectCombined<- rbind(subject_test_rawdata,subject_train_rawdata)

## row concatenate test activity code label and training activitiy code label into one data set
    ActivityCode<- rbind(y_test_rawdata,y_train_rawdata)

## column concatenate all above data sets together for future analysis.
    TestTrainCombined<-cbind( SubjectCombined,ActivityCode, FeaturesMeasures)  ## TestTrainCombined is the original R data set


## Step 4 Extracts only the measurements on the mean and standard deviation for each measurement. 
# Keep all of the Mean and STD features only

    meanFeatureNames<- features_rawdata$FeatureName[grep("mean()", features_rawdata$FeatureName,fixed = TRUE)]
      ##Total of 33 features including mean() only, not meanFreq() or angle(tBodyAccMean,gravity). 
    
    stdFeatureNames<-  features_rawdata$FeatureName[ grep("std()", features_rawdata$FeatureName,fixed = TRUE)]
      ## total of 33 records including std()
  
    meanstd_FeatureNames<- c(as.character(meanFeatureNames),as.character(stdFeatureNames))  ## total of 66 features for mean() and std().
    MeanSTD_FeatureMeasures <- FeaturesMeasures[,meanstd_FeatureNames] 

    ## Remove '-' and '()'from the feature name to make it more meaningful 
    featureNameCleaned<-gsub("[-()]","",names(MeanSTD_FeatureMeasures)) 
    colnames(MeanSTD_FeatureMeasures)<- featureNameCleaned

    ## put all required data together in order to do summary analysis
    MeanSTD_TestTrainMerged<-cbind(SubjectCombined,ActivityCode,MeanSTD_FeatureMeasures) 
      ## MeanSTD_TestTrainMerged contains only mean and std features. It is the subset of original R data set. 

## step 5: create tidy data set of the means of the variables for each combination of variable, subject, and activity.

    meanbySubjectActivityCode<-aggregate(MeanSTD_TestTrainMerged, by=list(MeanSTD_TestTrainMerged$Subject, MeanSTD_TestTrainMerged$ActivityCode ), 
                                         FUN=mean, na.rm=TRUE)[3:70]   ## get ride of grouping column

## Step 6 Uses descriptive activity names to name the activities in the data set
    
## substitute ActivityCode by Activity Name to improve readability
   AverageMeasuresByActivityBySubject<-merge(activity_labels_rawdata,meanbySubjectActivityCode,  
                                            by="ActivityCode", sort =FALSE)[,2:69] ## remove ActivityCode column


## step 7: write out the tidy data into the directory. File contains header. It can be read into R by read.table function
  write.table(AverageMeasuresByActivityBySubject, file="~/UCI_HAR_Dataset/AverageMeasuresHumanActivityRecognition.txt", 
              sep = " ", row.names = FALSE)

## summary(AverageMeasuresByActivityBySubject) to get the column name and data range for Cookbook.

## Read generated file for testing purpose
## TestTarget<-read.table("~/UCI_HAR_Dataset/AverageMeasuresHumanActivityRecognition.txt", head=TRUE)
