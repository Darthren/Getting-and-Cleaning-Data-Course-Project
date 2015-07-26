library(dplyr)
## Will download the file if is not there
if (!file.exists("getdata-projectfiles-UCI HAR Dataset.zip")){
        download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip","getdata-projectfiles-UCI HAR Dataset.zip")
        unzip("getdata-projectfiles-UCI HAR Dataset.zip")
}
setwd("UCI HAR Dataset")

## Helper function to read and combine the train and test datasets
read_combine <- function(file1, file2){
        train <- read.table(file1)
        test <- read.table(file2)
        combined <- rbind(train, test)
        return (combined)
}

## Read and combine x, y and subject files
x <- read_combine("train/X_train.txt","test/X_test.txt")
y <- read_combine("train/Y_train.txt","test/Y_test.txt")
subject <- read_combine("train/subject_train.txt","test/subject_test.txt")

## Names for columns
features <- read.table("features.txt") %>%
        tbl_df() %>%
        rename(measurement = V2)

# Combine subjects, y, and x. Assign them a name according to what they are
data <- cbind(subject, y, x)
colnames(data) <- c("subject", "activity_code", c(as.vector(features$measurement)))
#removes duplicate names
data <- data[!duplicated(names(data))]

## Read activities labels, assign them colnames, and merge them with y by "activity_code" (V1)
labels <- read.table("activity_labels.txt")
colnames(labels) <- c("activity_code", "activity")
data <- merge(data, labels, by = "activity_code")
## remove already used variables
rm(features, labels, subject, x, y)
## Reshape data to a more readable one
data <- data %>%
  select(subject, activity, ) %>%
  group_by(subject, activity) %>%

## Change variables names to more readable ones
variable_name <- names(data)
variable_name <- gsub(pattern="^t",replacement="time",x=variable_name)
variable_name <- gsub(pattern="^f",replacement="freq",x=variable_name)
variable_name <- gsub(pattern="-?std[()][)]-?",replacement="Std",x=variable_name)
variable_name <- gsub(pattern="-?mean[(][)]-?",replacement="Mean",x=variable_name)
variable_name <- gsub(pattern="-?meanFreq[()][)]-?",replacement="MeanFreq",x=variable_name) 
variable_name <- gsub(pattern="BodyBody",replacement="Body",x=variable_name)

names(data) <- variable_name


## subset data with only subjects, activity names, and the mean and standard deviation of all variables.
subset_data <- data %>%
        select(subject, activity, matches("(mean)"),matches("(std)"),-(matches("(angle)"))) %>%
        group_by(subject, activity) %>%
        summarise_each(funs(mean), -(c(subject, activity)))

View(subset_data)
write.table(subset_data, "../Step5_Tidy_data.txt", row.name=FALSE)
