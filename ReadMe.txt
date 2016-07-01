The purpose of this assigment is to cleanse the data using week 4 assignment topics and create a tidy dataset called as "run_analysis.R" 
and also provide average for all the measurements from the tidy dataset.

Activities performed.

1. download the zip file and extract to the working directory.
2. merge the files to make the one raw dataset. (files used: features.txt,activity_labels.txt,X_train.txt,subject_train.txt,y_train.txt,X_test.txt, subject_test.txt,y_test.txt)
3. Named the raw dataset as onedata based on the files used from #2.
4. Provide the proper descriptive names to the dataset "onedata".
5. Filter out only the required variables which includes the names with (Std and Mean).
6. Download library(reshape2), which will use for melt and cast function - called as recast.
7. Create the two factors for creating the ID's when using for the recast function.
8. Call the recast function to create the long dataset with mean for all the variables.
9. Store the new dataset which provides the average for each variable for each activity in tidydataset.csv.



