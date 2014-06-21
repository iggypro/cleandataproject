Course Project in "Getting and Cleaning Data"
=============================================

Repo Content:
-------------
1. run\_analysis.R - script for raw data processing that returns a tidy dataset as per project requirements
2. CodeBook.md - list of variables in the tidy dataset
3. tidy\_dataset.csv - output of run\_analysis.R script ready for further analysis

Data Cleaning Process:
----------------------
1. Read "activity labels" and "features" from respective files
2. Read "test" dataset (x,y and subject components)
3. Read "train" dataset (x,y and subject components)
4. Add column names to x, y and subject components of "test" and "train" datasets
5. Merge x, y and subject components by columns into one data frame
6. Extract only mean() and std() variables from "test" and "train" datasets
7. Merge "test" and "train" datasets by rows into one "tidy" dataset
8. Aggregate "tidy" dataset by Activity+Subject using Mean function
9. Add meaningful column names to a "tidy" dataset
10. Write "tidy" dataset as a CSV file in the working directory
