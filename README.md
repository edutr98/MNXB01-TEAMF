
############################################################
############################################################

Program used: R, version 2022.07.2+576
Objective: Clean and filter the raw data

############################################################
############################################################

Prerequisites

############################################################
############################################################


1. Be sure you have the last available version of Rstudio (Windows, Mac or Linux)
2. Work in a defined path in which you will store the raw data, outputs and scripts 
3. We used and recommend to use RStudio but R should work fine as well 
4. Please install the required libraries (readxl, tidyverse, writexl, lubridate, chron)
  4.a If you don't know how to install a library, use the line code install.packages("library")
5. Load the libraries 
  5.a To load the libraries use the line code library(library)
6. Once you have completed all the prerequisites, you can start executing the code


############################################################
############################################################

Before starting (you have to know) 

############################################################
############################################################


In this project the data was given in .csv
We changed the format files from csv "comma separated" to xlsx "File created by Microsoft Excel" for practical reasons

We used the .xlsx files in this project 


############################################################
############################################################

Executing the code in R

############################################################
############################################################

We will divide this section in three different parts: 

1. How to execute code in R
2. Data loading 
3. Data filtering 
4. Data processing 
5. Data filtered output 

############################################################
############################################################

1. How to execute code in R

############################################################
############################################################

Executing code in R is simple but there are some things to take into account 

1. Before executing the code be sure to have installed and loaded the libraries (specified in the beginning of the code) 
2. The code could be executed all at once but we recommend to do it line by line 
3. The code MUST be executed in order, if no, you could experience some errors (first line, then second line and so on) 



############################################################
############################################################

2. Data loading 

############################################################
############################################################
We used the readxl library which allowed us to load .xslx files directly, the code line is as shown in (A) for Umea, the process is the same for FALSTERBO
(A) read_xlsx("C:/Users/valua/Desktop/Computing project/Data/Data.xlsx", sheet="Umea")

As estated in a previous section, we used the files in .xslx format


If you want to load the .csv original format files, just install and/or load the library "readr", the code line with the readr library should be as follows (B)
(B) read_csv("D:\\RStudio\\Binning\\data.csv") 


############################################################
############################################################

3. Data filtering

############################################################
############################################################


We used the dplyr, chron and lubridate libraries 

Once you have uploaded the data, we can start filtering it. 

1.  We want to change the data type for some variables in Umea and Falsterbo 
    1a. Lufttemperatur is initially a character, we want to change it into a numeric variable
    1b. Datum and Tid (UTC) are initially characters, we want to change it into a date/time variables
  
2.  We want to filter the data according to our goal. 
    2a. The data was divided into two groups, 1. days between the 0 and 269 day 2. days between the 270 and 365 day for Umea and Falsterbo
    2b. We selected the dates from 1962-01-01 up to 2020-12-31 for Umea and Falsterbo 
    2c. In each group the data was filtered according to the hours that were common in Falsterbo and Umea. 07:00:00, 13:00:00, 20:00:00.
    
    
############################################################
############################################################

4. Data processing

############################################################
############################################################

We used dplyr and tidyverse libraries for the processing 

For the data processing we used basic mathematical operations to fulfill our goals 

1. Average
  1a. The average temperature per day helped us to use all the hours previously specified so the variance would be reduced slightly 
  1b. The average temperature per year was obtained with the average of the average temperatures per day. Variable "AVG_Year"

2. Maximum
  2a. We used the maximum to find the maximum temperature per year, the max function was applied to the average temperature per day. Variable "Warmest_Temp". 
  2b. We specified the number of the day with the maximum temperature in each year. Variable "Warmday". 
  
3. Minimum
  3a. We used the minimum to find the minimum temperature per year, the min function was applied to the average temperature per day. Variable "Coldest_Temp". 
  3b. We specified the number of the day with the maximum temperature in each year. Variable "Coldday". 
  

############################################################
############################################################

5. Data filtered output 

############################################################
############################################################

1. Output names: The output files contain important information in their name
   1a. FALSTERBO/UMEA: The city/town from which the data was taken 
   1b. LESS: The data of the days between 0-269 (first group) 
   1c. GREATER: The data of the days between 270-365 (second group) 
   1d. HOURS: The data is filtered according to the specified hours "07:00:00, 13:00:00, 20:00:00".
   
2. Variables: 
   2a. "year", year from which we obtained the data 
   2b. "Warmday", Number of the day in which the maximum temperature was registered
   2c. "Warmest_Temp", Maximum temperature of the year °C
   2d. "Coldday", Number of the day in which the minimum temperature was registered
   2e. "Coldest_Temp", Minimum temperature of the year °C
   2f. "AVG_Year", Average temperature of the year 
   
There are six variables but seven columns, the first column is just the observation number
The NA values are present when the max or min temperature were not registered in the group (0-269) or (270-365)


A little example of the data's name 

FALSTERBO_GREATER_HOURS: 
Data obtained in FALSTERBO, the group is (270-365) and is filtered by hours 


To obtain the .txt file filtered for using it into root, we used the library "writexl" and the function write.table. 




############################################################
############################################################

EXCEL

############################################################
############################################################

The filtered data have been furhter modified with Excel, in order to add some new columns to make two final .txt files, one for Falsterbo and one for Umeå, which include all the necessary informations, to be used in ROOTcfor all the plots. Excell was used first to add two new columns for each one of the files Falsterbo_1 and Umea_1, reporting the difference between the maximum temperature values ("Maxm") and the mean temeperatures ("Avg") in the column "DeltaTmax", and for the difference between "Minm" and "Avg" in "DeltaTmin". Furhtermore, Excell has been used to make other two new columns with the days shifted, used in section 2.4 of the report. To shift the data, we chose first to filter the data in two different files for each place, called respectively "Falsterbo_GREATER_2", "Falsterbo_LESS_2", "Umeå_GREATER_2", "Umeå_LESS_2". The "GREATER" files report the values of the warmest and coldest days only if they are measured after September, namely after the 270th day of the year, while if the day is before the 270th is reported in the LESS file. In this way, it was possible to make with Excell a new merged-column with all the coldest/warmest day of the "GREATER" file shifted by -270 days, and the coldest/warmest day of the "LESS" file shifted by +95 days. The reason of this shift is explained in the report. Then, it was possible to make the two complete files suitable for all the plots, called "Umeå_final" and "Falsterbo_final".

Now that we have the data files cleaned with the calculations we need for the plots, we can use ROOT to obtain the different plots. In the folder code of this repository you can find six different files with extension ".C", those are the files we need to plot the graphs.On the other hand, in thefinal_filtered folder you can find the file in which we have the data for both locations.









