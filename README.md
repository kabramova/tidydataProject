# Introduction

This is a README for processing the *Human Activity Recognition Using Smartphones 
Dataset*, *Version 1.0*.

A full description of the project that generated the data is available here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

# Obtaining the data

Data can be obtained from this link:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Unzip the data to your R working directory to a folder named ucihar.

The full dataset includes the following files:

* 'README.txt'

* 'features_info.txt': Shows information about the variables used on the feature vector.

* 'features.txt': List of all features.

* 'activity_labels.txt': Links the class labels with their activity name.

* 'train/X_train.txt': Training set.

* 'train/y_train.txt': Training activity labels.

* 'train/subject_train.txt': Training subject ids for identifying the subject who performed the activity for each window sample.

* 'test/X_test.txt': Test set.

* 'test/y_test.txt': Test activity labels.

* 'test/subject_test.txt': Test subject ids for identifying the subject who performed the activity for each window sample.

* 'Inertial Signals' folder in the 'test' and 'train' folders: The folder with raw signals recorded that are used to derive features for further processing, contained in 'X_test' and 'X_train'

# Used raw data

The files that are used for processing the data are:

* 'features.txt'

* 'activity_labels.txt'

* 'train/X_train.txt'

* 'train/y_train.txt'

* 'train/subject_train.txt'

* 'test/X_test.txt'

* 'test/y_test.txt'

* 'test/subject_test.txt'

See the Code Book (section *Deriving relevant raw data*) for an explanation of this decision.

# Producing the tidy data

The tidy data is produced using the run_analysis.R script.

```{r}
source('./run_analysis.R')
```

The script produces the file 'tidydata.txt' that is saved in the working directory.

The resulting data can be viewed by reading it into the working space and viewing it.

```{r}
tidydata <- read.table("tidydata.txt", header=TRUE)
View(tidydata)
```


# Data description

See the Code Book (*Raw data description* and *Tidy data description*) for how the tidy data was produced and variable descriptions. 
