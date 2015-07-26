CodeBook

The scrip run_analysis.R performs the 5 steps described in the course project's requirements:

Firstly, a helper function is defined to combine both training and test files.
This function is called for each file (x, containing the data, y containing the activity codes, and subject containing the subjects in the experiment).

Then, the features.txt files is read, and the name of its variable is changed to "measurement" for later assignment.

Data from subject, y and x is combined using cbind(), and using colnames() to assign them the names of "subject" for subject data, "activity_code" for y data, and
features$measurements.

Duplicate data names are removed.

Then, activity labels are assigned, and merged with y by "activity_code"

Variables names are then changed to more readable ones:
t is replaced with time
f is replaced with freq
std() is replaced with Std
mean() is replaced with Mean
meanFreq() is replaced with MeanFreq
BodyBody is replaced with just body

Finally, data is subsetted by selecting subject, activity, and all those variables that have the name "mean" or "std" in them.
Variables with the names "angle" in them were discarded because the angle calculation was derivative.
Data is grouped by subject and activity, and then summarised by mean.

This tidy dataset of 180 rows and 81 columns is then exported as "Step5_Tidy_data.txt"
