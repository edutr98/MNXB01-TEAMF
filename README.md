# MNXB01-TEAMF

R

###########################################################
FILTERED DATA
2022.07.2+576

###########################################################
Prerequisites
###########################################################

1. Be sure to have the last available version of R (Windows, Mac, Linux or Aurora) 
2. We recommend to use RStudio but the use of R would be fine 
3. Please install the required libraries 
  3.a If you don't have installed a library, use line code install.packages("name_library")
4. Load the libraries
  4.a To load the libraries use the line code library(name_library) 
6. Once you have completed all the prerequisites, you can start executing the code

############################################################
Before executing the code (you have to know) 
############################################################
In this project the data was given in .csv.
As we wanted to visualize the code before using R to take decisions, we changed file from csv "comma separated" to xlsx "File created by Microsoft Excel"


############################################################
Executing the code in R
############################################################

We will divide this sections in three different parts: 
1. Data loading 
2. Data filtering 
3. Data processing 
4. Data output 

############################################################
1. Data loading 
############################################################
As estated in the previous section, we will use the files in .xslx format
We will use the "readxl" library wich allow us to load .xslx files directly, the code line is as shown in (A) for Umea
(B) read_xlsx("C:/Users/valua/Desktop/Computing project/Data/Data.xlsx", sheet="Umea")



If you want to load the .csv original format files, just install and/or load the library "readr", the code line with the readr library should be as follows (B)
(B) read_csv("D:\\RStudio\\Binning\\data.csv") 

############################################################
2. Data filtering
############################################################
We used the dplyr, chron and lubridate libraries 

Once you have uploaded the data, we can start filtering it. 

1.  We want to change the data type for some variables in Umea and Falsterbo 
    1a. Lufttemperatur is initially as a character, we want to change it into a numeric variable
    1b. Datum and Tid (UTC) are initially characters, we want to change it into a date/time variable 
  
2.  We want to filter the data according to our goal. 
    2a. The data was divided into two groups, days between the 0 and 269 day 2. days between the 270 and 365 day. 
    2b. In each group the data was filtered according to the hours that were common in Falsterbo and Umea. 07:00:00, 13:00:00, 20:00:00.
    


Data_Filtered_GREA_LESS:
File that contains all the data divided in two groups (0-269 days), (270-365 days) and filtered by hours 07:00:00, 13:00:00, 20:00:00

Data_Filtered_Hours:
File that contains all the data Filtered by hours 07:00:00, 13:00:00, 20:00:00

############################################################
Outputs
############################################################

FALSTERBO_GREATER_HOURS: 
File that contains the FALSTERBO data filtered by the group (0-269 days)  

FALSTERBO_LESS_HOURS: 
File that contains the FALSTERBO data filtered by the group (270-365 days)  

UMEA_GREATER_HOURS: 
File that contains the UMEA data filtered by the group (270-365 days) 

UMEA_LESS_HOURS: 
File that contains the FALSTERBO data filtered by the group (270-365 days)  


The filtered data have been furhter modified with Excell, in order to add some new columns to make two final .txt files, one for Falsterbo and one for Umeå, which include all the necessary informations, to be used in ROOTcfor all the plots. Excell was used first to add two new columns for each one of the files Falsterbo_1 and Umea_1, reporting the difference between the maximum temperature values ("Maxm") and the mean temeperatures ("Avg") in the column "DeltaTmax", and for the difference between "Minm" and "Avg" in "DeltaTmin". Furhtermore, Excell has been used to make other two new columns with the days shifted, used in section 2.4 of the report. To shift the data, we chose first to filter the data in two different files for each place, called respectively "Falsterbo_GREATER_2", "Falsterbo_LESS_2", "Umeå_GREATER_2", "Umeå_LESS_2". The "GREATER" files report the values of the warmest and coldest days only if they are measured after September, namely after the 270th day of the year, while if the day is before the 270th is reported in the LESS file. In this way, it was possible to make with Excell a new merged-column with all the coldest/warmest day of the "GREATER" file shifted by -270 days, and the coldest/warmest day of the "LESS" file shifted by +95 days. The reason of this shift is explained in the report. Then, it was possible to make the two complete files suitable for all the plots, called "Umeå_final" and "Falsterbo_final".

Now that we have the data files cleaned with the calculations we need for the plots, we can use ROOT to obtain the different plots. In the folder code of this repository you can find six different files with extension ".C", those are the files we need to plot the graphs.On the other hand, in thefinal_filtered folder you can find the file in which we have the data for both locations.









