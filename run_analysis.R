
# run_analysis.R

# COURSERA/JHU Data Science. Course 3, Week 4: Getting And Cleaning Data
# 11 February 2018

# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# NOTE: data sets have already been downloaded and unzipped manually.

library(data.table)  # for fread 
library(dplyr)       # for select
library(reshape2)    # for melt and dcast

# General Quantities

ActivityLabel   <- fread("./UCI HAR Dataset/activity_labels.txt",col.names = c("Code","Name"))           #   6 x 2
Features        <- fread("./UCI HAR Dataset/features.txt",col.names = c("Number","Name"))                # 561 x 2
DesiredFeatures <- Features[ grep("mean\\(\\)|std\\(\\)",Features$Name), ]                               #  66 x 2: want MEAN and STD items only

# Training Data Set

X_Data         <- fread("./UCI HAR Dataset/train/X_train.txt")                                           # 7352 x 561
ActivityCode   <- fread("./UCI HAR Dataset/train/y_train.txt")                                           # 7352 x 1
Subject        <- fread("./UCI HAR Dataset/train/subject_train.txt")                                     # 7352 x 1

ActivityType <- as.data.frame( ActivityCode )                                                            # 7352 x 1
N <- dim( ActivityCode )[1]                                                                              # scalar = 7352

for( k in 1:N ) { ActivityType[k,] <- ActivityLabel[ as.integer(ActivityCode[k]) ]$Name }                # Set activity type in words, not just a code

z <- DesiredFeatures$Number                                                                              # 1 x 66: columns (i.e., features) to be retained
dfTrain <- setNames( data.frame( Subject     ,  ActivityCode  ,  ActivityType  , select( X_Data, z ) ), 
                              c("Subject.Num", "Activity.Code", "Activity.Type", DesiredFeatures$Name )) # 7352 x 69: keep only desired features

# Testing Data Set

X_Data         <- fread("./UCI HAR Dataset/test/X_test.txt")                                             # 2947 x 561
ActivityCode   <- fread("./UCI HAR Dataset/test/y_test.txt")                                             # 2947 x 561                  
Subject        <- fread("./UCI HAR Dataset/test/subject_test.txt")                                       # 2947 x 1

ActivityType <- as.data.frame( ActivityCode )                                                            # 2947 x 1
N <- dim( ActivityCode )[1]                                                                              # scalar = 2947

for( k in 1:N ) { ActivityType[k,] <- ActivityLabel[ as.integer(ActivityCode[k]) ]$Name }

dfTest <- setNames( data.frame( Subject     ,  ActivityCode  ,  ActivityType  , select( X_Data, z ) ), 
                             c("Subject.Num", "Activity.Code", "Activity.Type", DesiredFeatures$Name ))  # 2947 x 69: keep only desired features

# Merge the Training and Testing data sets

dfMerged <- rbind( dfTrain, dfTest )                                                                     # 10,299 x 69

# Form the final tidy data set: averages of the Desired Features per Subject and Activity Type

dfMeltedMerged <- melt( dfMerged, id.vars = c("Subject.Num","Activity.Code","Activity.Type"))            # 679,734 x 5
dfCombo_Means  <- dcast( dfMeltedMerged, Subject.Num + Activity.Type ~ variable, mean )                  # 180 x 68

# Note if done separately: 30 * 6 = 180, dimension checks.

# Subject_Means  <- dcast( dfMeltedMerged, Subject.Num  ~ variable, mean )  # 30 x 67
# Activity_Means <- dcast( dfMeltedMerged, Activity.Type~ variable, mean )  #  6 x 67

write.table( dfCombo_Means, file = "TidyDataSet.csv", row.name = FALSE )
