# GettingandCleaningDataCourseProject

This is the project of the coursera Getting and cleaning data course

This readme consists of explaining how the script works

- Load the libraries that I am going to occupy, in this case reshape2 and dplyr
- Next I define the working directory
- Load features and activity labels from the txt files and create data frames features and activity_labels.
- Load x_train,y_train and subject_train txt files. With that I generate the data frame train.
- I repeat the previous step with x_test, y_test and subject_test and create the data frame test.
- Then I combine both data frames with rbind function and create the data frame df.
- I extract the measurements that only contain data of the mean and standard deviation with the grep function and 
  create a new data frame called dfExtract.
- With merge function I do a join between the dataframe dfExtract and activity_labels and I get the name of the activities and
  create the dataframe dfExtract2
- Finally I use merge and dcast function to create a tidy data set called tidydataset.txt

