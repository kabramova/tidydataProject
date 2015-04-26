# Introduction

This is a Code Book for understanding the raw and tidied versions of the *Human Activity Recognition Using Smartphones Dataset*, *Version 1.0*.

A full description of the project that generated the data is available here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


# Raw data description

The information contained here is reproduced from the dataset website cited above.

## Study design

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

A video of the experiment including an example of the 6 recorded activities with one of the participants can be seen in the following link: https://www.youtube.com/watch?v=XOEN9W05_4A


## Deriving relevant raw data

For each record in the dataset it is provided: 

* An identifier of the subject who carried out the experiment.

* Its activity label. 

* Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 

* Triaxial Angular velocity from the gyroscope. 

* A 561-feature vector with time and frequency domain variables. 

    * Features are normalized and bounded within [-1,1].

    * Each feature vector is a row on the text file.

As the 561 features for the time and frequency domain variables are derived from the raw recordings contained in the Intertial Signals folder (triaxial acceleration and triaxial angular velocity), for further analysis we use only the subject identifier, activity labels and the features. 


## Variables description

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

* tBodyAcc-XYZ, tGravityAcc-XYZ, tBodyAccJerk-XYZ, tBodyGyro-XYZ, tBodyGyroJerk-XYZ, tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag, fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccMag, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag


The set of variables that were estimated from these signals are: 

* mean(): Mean value

* std(): Standard deviation

* mad(): Median absolute deviation 

* max(): Largest value in array

* min(): Smallest value in array

* sma(): Signal magnitude area

* energy(): Energy measure. Sum of the squares divided by the number of values. 

* iqr(): Interquartile range 

* entropy(): Signal entropy

* arCoeff(): Autorregresion coefficients with Burg order equal to 4

* correlation(): correlation coefficient between two signals

* maxInds(): index of the frequency component with largest magnitude

* meanFreq(): Weighted average of the frequency components to obtain a mean frequency

* skewness(): skewness of the frequency domain signal 

* kurtosis(): kurtosis of the frequency domain signal 

* bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.

* angle(): Angle between to vectors.


Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

* gravityMean, tBodyAccMean, tBodyAccJerkMean, tBodyGyroMean, tBodyGyroJerkMean

The complete list of variables of each feature vector is available in 'features.txt'.


# Tidy data description

## Deriving tidy data

The following steps have been taken to derive tidy from raw data:

1. Combining the relevant test data into a testset (combined by columns)
    * subject ids from 'subject_test.txt'
    * activity ids from 'y_test.txt'
    * feature measurements from 'X_test.txt'

2. Combining the relevant training data into a trainingset (combined by columns)
    * subject ids from 'subject_train.txt'
    * activity ids from 'y_train.txt'
    * feature measurements from 'X_train.txt'

3. Merging training and datasets

4. Extracting only the measurements on the mean and standard deviation for each measurement by retaining only the features that contain "mean" or "std" in their name

5. Labeling the dataset with descriptive variable names (described in sub-section _Variable description_ below)

6. Averaging all the retained measurements by subject and activity to produce aggregate measurement means.

7. Renaming activity ids with labels contained in 'activity_labels.txt'


## Variables description

The data contains 180 rows and 81 columns. It is saved in a wide data format. Each column is a variable. 

Below the variables are explained in groups denoted by different values in square brakets. For example, [t/f]BodyAcc[mean/std][X/Y/Z] unfolds into 2*2*3 = 12 variables in the tidy dataset such as tBodyAccmeanX, tBodyAccmeanY, tBodyAccstdX, fBodyAccstdX etc. 

The variable names should be understood as follows:

* in [t/f] prefix 't' stands for time measurement and 'f' stands for frequency measurement obtained with a Fast Fourier Transform (FFT)
* in [mean/std] suffix 'mean' stands for mean, 'std' for standard deviation 
* in [X/Y/Z] suffix 'X', 'Y' and 'Z' stand for the three measured movement axes
* 'Acc' in the variable name means that the raw signal was recorded from the accelerometer and 'Gyro' means that it has been recorded from the gyroscope
* 'BodyAcc' means the body signal acceleration measurement and 'GravityAcc' means the gravity acceleration signal, derived as described above in _Deriving used raw data_ under _Raw data description_
* 'meanFreq': weighted average of the frequency components to obtain a mean frequency
* 'Jerk': jerk signals obtained from the body linear acceleration and angular velocity derived in time
* 'Mag': the magnitude of 
    * body and gravity acceleration
    * body acceleration jerk
    * body gyroscope signal
    * body gyroscope jerk

The values for all the variables that are not specified below are numeric and bound to the [-1, 1] interval.

The following variables are included:

* subjectid: an identifier of the subject who carried out the experiment
    * the values are factors with 30 levels: 1 to 30

* activityid: the activity label for what activity was performed
    * the values are factors with 6 levels "LAYING", "SITTING", "STANDING", "WALKING", "WALKING_DOWNSTAIRS", "WALKING_UPSTAIRS" 

* [t/f]BodyAcc[mean/std][X/Y/Z]

* fBodyAccmeanFreqXYZ

* tGravityAcc[mean/std][X/Y/Z]

* [t/f]BodyAccJerk[mean/std][X/Y/Z]

* fBodyAccJerkmeanFreqXYZ

* [t/f]BodyGyro[mean/std][X/Y/Z]

* fBodyGyromeanFreqXYZ

* tBodyGyroJerk[mean/std][X/Y/Z]

* [t/f]BodyAccMag[mean/std]

* fBodyAccMagmeanFreq

* tGravityAccMag[mean/std]

* tBodyAccJerkMag[mean/std]

* tBodyGyroMag[mean/std]

* tBodyGyroJerkMag[mean/std]

* fBodyBodyAccJerkMag[mean/std]

* fBodyBodyAccJerkMagmeanFreq

* fBodyBodyGyroMag[mean/std]

* fBodyBodyGyroMagmeanFreq

* fBodyBodyGyroJerkMag[mean/std]

* fBodyBodyGyroJerkMagmeanFreq