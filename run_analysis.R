###apply recast function to create a average  tidy set
library(reshape2)

setwd("C:\\Tejo\\Datascience\\CleansingData\\")
getwd()

zipfilename <- "getdata_projectfiles_UCI_HAR_Dataset.zip"

##download the zip file, if it does not exists.
if (!file.exists(zipfilename))
{
  zipURL<- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(zipURL,destfile = zipfilename, mode="wb") 
}

foldername<-"UCI HAR Dataset"

##unzip the folder..
if(!file.exists(foldername))
{
  unzip(zipfilename)
}


###merge the datasets (train and test)

#read the features 
features<-read.table("UCI HAR Dataset\\features.txt", header = FALSE)
colnames(features)<-c("Sno", "fuctionname")

###4.Appropriately labels the data set with descriptive variable names. 
features[,2]<-gsub("[()]","", features[,2])
features[,2]<-gsub("-mean","Mean", features[,2])
features[,2]<-gsub("-std","Std", features[,2])
##features[grep("*mean|*std", features[,2]),]

##load activity label data.
activitylabel<-read.table("UCI HAR Dataset\\activity_labels.txt", header = FALSE)
colnames(activitylabel)<- c("actid", "actname")
#load the Xtrain data in xtrain
xtrain<-read.table("UCI HAR Dataset\\train\\X_train.txt", header = FALSE)

##load subject_train data.
##Holds the subject ID
subject_train<-read.table("UCI HAR Dataset\\train\\subject_train.txt", header = FALSE)


##load y_train data.
## holds the activity.
y_train<-read.table("UCI HAR Dataset\\train\\y_train.txt", header = FALSE)

###merge the training column data
traindata<-cbind(subject_train,y_train, xtrain)


#load the Xtest data in xtest
xtest<-read.table("UCI HAR Dataset\\test\\X_test.txt", header = FALSE)


##load subject_test data.
##Holds the subject ID
subject_test<-read.table("UCI HAR Dataset\\test\\subject_test.txt", header = FALSE)


##load y_train data.
## holds the activity.
y_test<-read.table("UCI HAR Dataset\\test\\y_test.txt", header = FALSE)

###merge the testing column data
testdata<-cbind(subject_test,y_test, xtest)

##1. Merges the training and the test sets to create one data set
onedata<-rbind(traindata,testdata)

####3. Uses descriptive activity names to name the activities in the data set
colnames(onedata)<- c("subjectID", "Activitytype", features[,2])


####2. Extracts only the measurements on the mean and standard deviation for each measurement. 
getColIndex<-grep("*Mean|*Std", colnames(onedata))


###Update the onedata with the required columns.
onedata<-onedata[, c(1,2,getColIndex)]

####create a factor which will be used in recasting..
####1
onedata$Activitytype<- factor(onedata$Activitytype, levels=activitylabel$actid, labels = activitylabel$actname)
####2
onedata$subjectID<-factor(onedata$subjectID)

####cast the tidy dataset, so that we will get the average of all the variables.
indtidyset<-recast(onedata, subjectID+Activitytype ~ variable, id.var = 1:2 , mean)

###write the new set to a file...
##write.csv(indtidyset, "C:\\Tejo\\Datascience\\CleansingData\\tidydataset.csv")
write.table(indtidyset, "C:\\Tejo\\Datascience\\CleansingData\\tidydataset.txt", row.names = FALSE, quote = FALSE)



