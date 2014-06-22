# library reshape is required 
require(reshape2)

# The data is read intio temporary variables

datax1_temp <- read.table("train/X_train.txt")
datax2_temp <- read.table("test/X_test.txt")
datay1_temp <- read.table("train/y_train.txt")
datay2_temp <- read.table("test/y_test.txt")
datas1_temp <- read.table("train/subject_train.txt")
datas2_temp <- read.table("test/subject_test.txt")

# rows are binded to join test and training data 
data_X <- rbind(datax1_temp, datax2_temp)
data_Y <- rbind(datay1_temp, datay2_temp)
data_S <- rbind(datas1_temp, datas2_temp)

# getting features
features_set <- read.table("features.txt")[,"V2"]
colnames(data_X) <- features_set
colnames(data_Y) <- "activity_id"
colnames(data_S) <- "subject"


#reading in the activities

activities <- read.table("activity_labels.txt")
colnames(activities) <- c("activity_id", "activity")
dataY <- merge(data_Y, activities)

#Reading the measurements

means <- grep("-mean\\(\\)", features_set, value=TRUE)
stds <- grep("-std\\(\\)", features_set, value=TRUE)
req_features <- c(means, stds)
dataX <- data_X[, req_features]




# Providing the data output

dataout_1 <- cbind(dataX, dataY["activity"])
write.csv(dataout_1, "measurements_mean_std.txt")

# merge the subject data
datasubject <- cbind(dataout_1, data_S)
datasubject_melt <- melt(datasubject, id=c("subject", "activity"))


datafinal <- dcast(dataoutsubject_melt, activities + data_S ~ variable, mean)
write.csv(datafinal, "activity_subject_means.txt")
