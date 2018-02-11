# Course3-Week4
Project for "Getting and Cleaning Data" Course

Sourcing the script "run_analysis.R" will generate the output file "TidyDataSet.csv"

The script assumes that the Samsung data set has already been downloaded and unzipped under "UCI HAR Dataset" in the working directory.

The script performs the following actions:
  - Reads general variable information. These are for subsequent labeling and organizing, not measurements.
  - Determines the desired subset of measurement features: only variables representing a mean or standard deviation.
  - Reads measurements from training data set: forms data frame representing the data for only the desired subset of measurement features.
  - Reads measurements from testing  data set: forms data frame representing the data for only the desired subset of measurement features.
  - Merges the two data frames.
  - Computes the mean values of the desired features per subject and activity type, storing the result in a "tidy" data frame.
  - Writes this final tidy data set to "TidyDataSet.csv"
  
 Code Book
 ---------
 
 (Dimensions of each variable is shown)  
 
 *ActivityLabel*      6 x 2   Description of the activities that the subjects may perform  
 *Features*         561 x 2   Descriptive label of the set of measurements in the Samsung experiment  
 *DesiredFeatures*   66 x 2   The feature subset containing only MEAN and STANDARD DEVIATION variables   
 
 *X_Data*          7352 x 561 The training data  
 *ActivityCode*    7352 x 1   Numerical code for each type of activity, numbered 1 to 6  
 *Subject*         7352 x 1   Numerical code for each subject, numbered 1 to 30  
 *ActivityType*    7352 x 1   Subset of Activity Labels corresponding to only the desired features  
 *dfTrain*         7352 x 69  Training set data frame with only the desired features  
 
 *X_Data*          2947 x 561 The testing data (repeated usage of variable name)  
 *ActivityCode*    2947 x 1   Numerical code for each type of activity, numbered 1 to 6 (repeated usage of variable name)  
 *Subject*         2947 x 1   Numerical code for each subject, numbered 1 to 30 (repeated usage of variable name)  
 *ActivityType*    2947 x 1   Subset of Activity Labels corresponding to only the desired features (repeated usage of variable name)  
 *dfTest*          2947 x 69  Testing set data frame with only the desired features  
 
 *dfMerged*        10,299 x 69  Merged data set  
 *dfMeltedMerged* 679,734 x 5   Melted version of dfMerged, to facilitate averaging  
 *dfCombo_Means*      180 x 68  Final tidy data set: averages of the Desired Features per Subject and Activity Type  
