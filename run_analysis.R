# This script implements a data cleaning process for the Human Activity 
# Recognition Using Smartphones Dataset, Version 1.0.
# It reads in the test and training datasets, combines them into a single 
# dataset, extracts the mean and standard deviation measurements and relabels
# variables and activity factor.
# The output is a tidy dataset with the average of each retained variable for 
# each activity and each subject.
# See the comments below, the readme file and the codebook for details on the
# dataset and the procedure.

# Load the library required for data manipulation
library(dplyr)


# Merge the training and the test sets to create one dataset
# Combine all the relevant test data
test_subjects <- read.table("./ucihar/test/subject_test.txt") # 2947 subject ids
test_y <- read.table("./ucihar/test/y_test.txt") # 2947 activity ids
test_X <- read.table("./ucihar/test/X_test.txt") # 2947 by 561 features
# The test dataset is combined in such a way that the first column contains 
# the subject id, the second - activity id, and the remaining columns contain 
# features that have been measured in the experiment.
testset <- cbind(test_subjects, test_y, test_X) # dimensions are 2947 x 563

# Combine all the relevant training data
train_subjects <- read.table("./ucihar/train/subject_train.txt") # 7352 subject ids
train_y <- read.table("./ucihar/train/y_train.txt") # 7352 activity ids
train_X <- read.table("./ucihar/train/X_train.txt") # 7352 by 561 features
# The training dataset is combined in the same way as the test dataset.
trainingset <- cbind(train_subjects, train_y, train_X) # dimensions are 7352 x 563

# Combine test data with training data into one dataset by binding by rows
# The columns are still subject id, activity id, and features data
dataset <- rbind(testset, trainingset)


# Extract only the measurements on the mean and standard deviation for each measurement
# We do this by retaining only the features that have "mean" or "std" in their name
# The 561 feature names are contained in the file "features.txt"

# Read the feature names
features <- read.table("./ucihar/features.txt", colClasses=c("NULL", "character"))
# Create a vector that will represent column names for the dataset
cols <- c("subjectid","activityid", features[,1])

# Determine indices for the feature names that measure mean or standard deviation
meanvars <- grep("mean", cols)
stdvars <- grep("std", cols)
# Combine indices for the variables to be retained
relvars <- c(1,2,meanvars,stdvars)

# Extract relevant feature names to be used as variable names in the retained data
relcols <- cols[relvars]
# Extract the relevant data from the combined dataset
reldata <- dataset[,relvars]


# Appropriately label the dataset with tidy descriptive variable names 
# Clean the feature names to remove any punctuation marks
clean_name <- function(name) {
    # This function takes a character variable as input, removes underscores,
    # brackets and commas and outputs a cleaned up character variable as output
    name1 <- gsub("-", "", name)
    name2 <- gsub("\\(", "", name1)
    name3 <- gsub("\\)", "", name2)
    name4 <- gsub(",", "", name3)
    name4
}

# Clean the relevant feature names
clean_cols <- sapply(relcols, clean_name, simplify=TRUE, USE.NAMES=FALSE)
# Label the dataset with feature names
colnames(reldata) <- clean_cols

# Create an independent tidy dataset with the average of each variable for each 
# activity and each subject
# We aggregate our extracted dataset (reldata) by subject id and activity id
# by calculating the mean for each measurement
summarized <- aggregate(. ~ subjectid + activityid, data=reldata, FUN="mean")
# We order by the subject id in the first column for readability
ordered <- arrange(summarized, subjectid)


# Use descriptive activity names to name the activities in the dataset
# The activity names are contained in the activity_labels.txt file
# Read in the names
activities <- read.table("./ucihar/activity_labels.txt", colClasses=c("NULL", "character"))
# Map activity ids to activity names
new_activities <- plyr::mapvalues(ordered$activityid, from = c(1:6), to = c(activities[,1]))
# Replace activity ids with informative labels
ordered$activityid <- new_activities

# Tidying up: convert subject id and activity id to factors
ordered$activityid <- as.factor(ordered$activityid)
ordered$subjectid <- as.factor(ordered$subjectid)

# Save the tidy dataset to a tidydata text file
write.table(ordered, file="tidydata.txt", row.names=FALSE, col.names=TRUE)

# Read the tidy data in by running read.table("tidydata.txt", header=TRUE)