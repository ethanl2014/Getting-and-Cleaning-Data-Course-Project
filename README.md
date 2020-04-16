# Getting-and-Cleaning-Data-Course-Project

Repository contains script "run_analysis.R" that takes data from accelerometers (see Code Book) and outputs summary file (tidy_data.txt)

Code Book is explanation file on input and output files

tidy_data is output file from script, summary data of accelerometer

Script...

Takes each input file, as described in code book, and reads into R

Combines x data(measured values), y data(activities) and subject data into 3 separate tables

Uses the features files to find the indexes for mean and std dev, and gets subset of x data for mean and std dev

Labels 3 tables with correct titles based on input from files

Combines all 3 tables into single table containing data on subject, data, and testing and training values (mean and std dev)

Takes the average of each mean collected for each actvity, tidies table, and outputs as text file
