library (readxl)
library(tidyverse)
install.packages("writexl")
library(writexl)
library(lubridate)
library(chron)

#Importing 
UmeaData= read_xlsx("C:/Users/valua/Desktop/Computing project/Data/Data.xlsx", sheet="Umea")
UmeaData


FalsterboData = read_xlsx("C:/Users/valua/Desktop/Computing project/Data/Data.xlsx", sheet="Falsterbo")
FalsterboData

#Changing variable type (Lufttemperatur)

#Falsterbo
TempFal<-as.factor(FalsterboData$Lufttemperatur)
TempFal_2<- as.character(TempFal)
TempFal_3<- as.numeric(TempFal_2)
FalsterboData$Lufttemperatur=TempFal_3

#Hours 
Time_Fal<-as.factor(FalsterboData$`Tid (UTC)`)
Time_Fal_2=times(Time_Fal)
FalsterboData$`Tid (UTC)`=Time_Fal_2


#Umea
TempUm<-as.factor(UmeaData$Lufttemperatur)
TempUm_2<- as.character(TempUm)
TempUm_3<- as.numeric(TempUm_2)
UmeaData$Lufttemperatur=TempUm_3

#Hours 
Time_Um<-as.factor(UmeaData$`Tid (UTC)`)
Time_Um_2=times(Time_Um)
UmeaData$`Tid (UTC)`=Time_Um_2




#Changing variable type (DATE)
#Umea
DatumUm<-as.factor(UmeaData$Datum)
Datum_2Um<-strptime(DatumUm,format="%Y-%m-%d")
Datum_3Um<-as.Date(Datum_2Um,format="%Y-%m-%d")
UmeaData$Datum=Datum_3Um


#Falsterbo 
DatumFal<-as.factor(FalsterboData$Datum)
Datum_2Fal<-strptime(DatumFal,format="%Y-%m-%d")
Datum_3Fal<-as.Date(Datum_2Fal,format="%Y-%m-%d")
FalsterboData$Datum=Datum_3Fal


#FilteringYears
UmeaData_Fil=UmeaData %>% 
  filter( Datum >= "1962-01-01") %>% 
  filter(Datum <= "2020-12-31")

FalsterboData_Fil=FalsterboData %>% 
  filter( Datum >= "1962-01-01")%>% 
  filter( Datum <= "2020-12-31")





#Creating the tables 

# UMEA --------------------------------------------------------------------



# WARM --------------------------------------------------------------------


#0-269

#Filtering hours 
FinalUm_WARM_LESS=
  UmeaData_Fil %>%
  mutate(year = format(UmeaData_Fil$Datum, "%Y"), Warmday=yday(UmeaData_Fil$Datum), TEMP_WARM=(UmeaData_Fil$`Tid (UTC)`)) %>%
  group_by(year,Warmday) %>%
  filter ( TEMP_WARM=='07:00:00'|TEMP_WARM=='13:00:00'|TEMP_WARM=='20:00:00')


#Mean temp per day 
FinalUm_WARM_LESS=
  UmeaData_Fil %>%
  mutate(year = format(UmeaData_Fil$Datum, "%Y"), Warmday=yday(UmeaData_Fil$Datum), TEMP_WARM=(UmeaData_Fil$`Tid (UTC)`)) %>%
  group_by(year,Warmday) %>%
  summarise(Mean_Warm_Day= mean(Lufttemperatur))%>%
  filter(Warmday<=269)

#Warmest day per year 
FinalUm_WARM_2_LESS=
  FinalUm_WARM_LESS %>%
  select(Warmday,Mean_Warm_Day)%>%
  group_by(year,Warmday) %>%
  summarise(Warmest_Temp=max(Mean_Warm_Day))%>%
  filter(Warmest_Temp==max(Warmest_Temp))


FinalUm_WARM_2_GREATER


# 270-365 -----------------------------------------------------------------


#Filtering hours 
FinalUm_WARM_GREATER=
  UmeaData_Fil %>%
  mutate(year = format(UmeaData_Fil$Datum, "%Y"), Warmday=yday(UmeaData_Fil$Datum), TEMP_WARM=(UmeaData_Fil$`Tid (UTC)`)) %>%
  group_by(year,Warmday) %>%
  filter ( TEMP_WARM=='07:00:00'|TEMP_WARM=='13:00:00'|TEMP_WARM=='20:00:00')


#Mean temp per day 
FinalUm_WARM_GREATER=
  UmeaData_Fil %>%
  mutate(year = format(UmeaData_Fil$Datum, "%Y"), Warmday=yday(UmeaData_Fil$Datum), TEMP_WARM=(UmeaData_Fil$`Tid (UTC)`)) %>%
  group_by(year,Warmday) %>%
  summarise(Mean_Warm_Day= mean(Lufttemperatur))%>%
  filter(Warmday>269)

#Warmest day per year 
FinalUm_WARM_2_GREATER=
  FinalUm_WARM_GREATER %>%
  select(Warmday,Mean_Warm_Day)%>%
  group_by(year,Warmday) %>%
  summarise(Warmest_Temp=max(Mean_Warm_Day))%>%
  filter(Warmest_Temp==max(Warmest_Temp))




##############################################################################
##############################################################################
##############################################################################
# 0-269 -------------------------------------------------------------------

# UMEA

# COLD --------------------------------------------------------------------

#Filtering hours 
FinalUm_COLD_LESS=
  UmeaData_Fil %>%
  mutate(year = format(UmeaData_Fil$Datum, "%Y"), Coldday=yday(UmeaData_Fil$Datum), TEMP_COLD=(UmeaData_Fil$`Tid (UTC)`)) %>%
  filter ( TEMP_COLD=='07:00:00'|TEMP_COLD=='13:00:00'|TEMP_COLD=='20:00:00')



#Mean temp per day 
FinalUm_COLD_LESS=
  UmeaData_Fil %>%
  mutate(year = format(UmeaData_Fil$Datum, "%Y"), Coldday=yday(UmeaData_Fil$Datum), TEMP_COLD=(UmeaData_Fil$`Tid (UTC)`)) %>%
  group_by(year, Coldday) %>%
  summarise(Mean_Cold_Day= mean(Lufttemperatur)) 



#COLDEST day per year 
FinalUm_COLD_2_LESS=
  FinalUm_COLD_LESS %>%
  group_by(year,Coldday) %>%
  summarise(Coldest_Temp=min(Mean_Cold_Day))%>%
  filter(Coldest_Temp==min(Coldest_Temp), Coldday<270)




# WARM --------------------------------------------------------------------


#Filtering hours 
FinalUm_WARM_LESS=
  UmeaData_Fil %>%
  mutate(year = format(UmeaData_Fil$Datum, "%Y"), Warmday=yday(UmeaData_Fil$Datum), TEMP_COLD=(UmeaData_Fil$`Tid (UTC)`)) %>%
  filter ( TEMP_COLD=='07:00:00'|TEMP_COLD=='13:00:00'|TEMP_COLD=='20:00:00')



#Mean temp per day 
FinalUm_WARM_LESS=
  UmeaData_Fil %>%
  mutate(year = format(UmeaData_Fil$Datum, "%Y"), Warmday=yday(UmeaData_Fil$Datum), TEMP_COLD=(UmeaData_Fil$`Tid (UTC)`)) %>%
  group_by(year, Warmday) %>%
  summarise(Mean_Warm_Day= mean(Lufttemperatur)) 



#WARMEST day per year 
FinalUm_WARM_2_LESS=
  FinalUm_WARM_LESS %>%
  group_by(year,Warmday) %>%
  summarise(Warm_Temp=max(Mean_Warm_Day))%>%
  filter(Warm_Temp==max(Warm_Temp), Warmday<270)


UnionUM_LESS=FinalUm_WARM_2_LESS %>% full_join(FinalUm_COLD_2_LESS,by="year")








# 270-365 -----------------------------------------------------------------

#COLD

#Filtering hours 
FinalUm_COLD_GREATER=
  UmeaData_Fil %>%
  mutate(year = format(UmeaData_Fil$Datum, "%Y"), Coldday=yday(UmeaData_Fil$Datum), TEMP_COLD=(UmeaData_Fil$`Tid (UTC)`)) %>%
  filter ( TEMP_COLD=='07:00:00'|TEMP_COLD=='13:00:00'|TEMP_COLD=='20:00:00')



#Mean temp per day 
FinalUm_COLD_GREATER=
  UmeaData_Fil %>%
  mutate(year = format(UmeaData_Fil$Datum, "%Y"), Coldday=yday(UmeaData_Fil$Datum), TEMP_COLD=(UmeaData_Fil$`Tid (UTC)`)) %>%
  group_by(year, Coldday) %>%
  summarise(Mean_Cold_Day= mean(Lufttemperatur)) 



#COLDEST day per year 
FinalUm_COLD_2_GREATER=
  FinalUm_COLD_LESS %>%
  group_by(year,Coldday) %>%
  summarise(Coldest_Temp=min(Mean_Cold_Day))%>%
  filter(Coldest_Temp==min(Coldest_Temp), Coldday>270)




#WARM-----------------------------------------------------------------------------

#Filtering hours 
FinalUm_WARM_GREATER=
  UmeaData_Fil %>%
  mutate(year = format(UmeaData_Fil$Datum, "%Y"), Coldday=yday(UmeaData_Fil$Datum), TEMP_COLD=(UmeaData_Fil$`Tid (UTC)`)) %>%
  filter ( TEMP_COLD=='07:00:00'|TEMP_COLD=='13:00:00'|TEMP_COLD=='20:00:00')



#Mean temp per day 
FinalUm_WARM_GREATER=
  UmeaData_Fil %>%
  mutate(year = format(UmeaData_Fil$Datum, "%Y"), Warmday=yday(UmeaData_Fil$Datum), TEMP_COLD=(UmeaData_Fil$`Tid (UTC)`)) %>%
  group_by(year, Warmday) %>%
  summarise(Mean_Warm_Day= mean(Lufttemperatur)) 



#COLDEST day per year 
FinalUm_WARM_2_GREATER=
  FinalUm_COLD_GREATER %>%
  group_by(year,Warmday) %>%
  summarise(Warmest_Temp=max(Mean_Warm_Day))%>%
  filter(Warmest_Temp==max(Warmest_Temp), Warmday>270)

#No observations

UnionUM_GREATER=FinalUm_WARM_2_GREATER %>% full_join(FinalUm_COLD_2_GREATER,by="year")






#Average temp per year 

AVG_Year_UM=
  UmeaData_Fil %>%
  mutate(year = format(UmeaData_Fil$Datum, "%Y")) %>%
  group_by(year) %>%
  summarise(AVG_Year= mean(Lufttemperatur))


  UMEA_GREATER=UnionUM_GREATER %>% full_join(AVG_Year_UM, by="year")
  UMEA_LESS=UnionUM_LESS %>% full_join (AVG_Year_UM, by="year")





# FALSTERBO ---------------------------------------------------------------




# 0-269 -------------------------------------------------------------------



# WARM --------------------------------------------------------------------


#Filtering hours 
  FinalFal_WARM_LESS=
    FalsterboData_Fil %>%
    mutate(year = format(FalsterboData_Fil$Datum, "%Y"), Warmday=yday(FalsterboData_Fil$Datum), TEMP_COLD=(FalsterboData_Fil$`Tid (UTC)`)) %>%
    filter ( TEMP_COLD=='07:00:00'|TEMP_COLD=='13:00:00'|TEMP_COLD=='20:00:00')


#Mean temp per day 
FinalFals_WARM_LESS=
  FalsterboData_Fil %>%
  mutate(year = format(FalsterboData_Fil$Datum, "%Y"), Warmday=yday(FalsterboData_Fil$Datum), TEMP_COLD=(FalsterboData_Fil$`Tid (UTC)`)) %>%
  group_by(year, Warmday) %>%
  summarise(Mean_Warm_Day= mean(Lufttemperatur)) 



#WARMEST day per year 
FinalFal_WARM_2_LESS=
  FinalFals_WARM_LESS %>%
  group_by(year,Warmday) %>%
  summarise(Warm_Temp=max(Mean_Warm_Day))%>%
  filter(Warm_Temp==max(Warm_Temp), Warmday<270)




#Cold--------------------------------------------------------------

#Filtering hours 
FinalFal_COLD_LESS=
  FalsterboData_Fil %>%
  mutate(year = format(FalsterboData_Fil$Datum, "%Y"), Coldday=yday(FalsterboData_Fil$Datum), TEMP_COLD=(FalsterboData_Fil$`Tid (UTC)`)) %>%
  filter ( TEMP_COLD=='07:00:00'|TEMP_COLD=='13:00:00'|TEMP_COLD=='20:00:00')



#Mean temp per day 
FinalFal_COLD_LESS=
  FalsterboData_Fil %>%
  mutate(year = format(FalsterboData_Fil$Datum, "%Y"), Coldday=yday(FalsterboData_Fil$Datum), TEMP_COLD=(FalsterboData_Fil$`Tid (UTC)`)) %>%
  group_by(year, Coldday) %>%
  summarise(Mean_Cold_Day= mean(Lufttemperatur)) 



#COLDEST day per year 
FinalFal_COLD_2_LESS=
  FinalFal_COLD_LESS %>%
  group_by(year,Coldday) %>%
  summarise(Coldest_Temp=min(Mean_Cold_Day))%>%
  filter(Coldest_Temp==min(Coldest_Temp), Coldday<270)

UnionFAL_LESS=FinalFal_WARM_2_LESS %>% full_join(FinalFal_COLD_2_LESS,by="year")



# 270-365 -------------------------------------------------------------------



# WARM --------------------------------------------------------------------


#Filtering hours 
FinalFal_WARM_GREATER=
  FalsterboData_Fil %>%
  mutate(year = format(FalsterboData_Fil$Datum, "%Y"), Warmday=yday(FalsterboData_Fil$Datum), TEMP_COLD=(FalsterboData_Fil$`Tid (UTC)`)) %>%
  filter ( TEMP_COLD=='07:00:00'|TEMP_COLD=='13:00:00'|TEMP_COLD=='20:00:00')



#Mean temp per day 
FinalFal_WARM_GREATER=
  FalsterboData_Fil %>%
  mutate(year = format(FalsterboData_Fil$Datum, "%Y"), Warmday=yday(FalsterboData_Fil$Datum), TEMP_COLD=(FalsterboData_Fil$`Tid (UTC)`)) %>%
  group_by(year, Warmday) %>%
  summarise(Mean_Warm_Day= mean(Lufttemperatur)) 


#Warmest day per year 
FinalFal_WARM_2_GREATER=
  FinalFal_WARM_GREATER %>%
  group_by(year,Warmday) %>%
  summarise(Warmest_Temp=max(Mean_Warm_Day))%>%
  filter(Warmest_Temp==max(Warmest_Temp), Warmday>270)
#NO DATA 


#COLD -------------------------------------------------------------------------------------------

#Filtering hours 
FinalFal_COLD_GREATER=
  FalsterboData_Fil %>%
  mutate(year = format(FalsterboData_Fil$Datum, "%Y"), Coldday=yday(FalsterboData_Fil$Datum), TEMP_COLD=(FalsterboData_Fil$`Tid (UTC)`)) %>%
  filter ( TEMP_COLD=='07:00:00'|TEMP_COLD=='13:00:00'|TEMP_COLD=='20:00:00')



#Mean temp per day 
FinalFal_COLD_GREATER=
  FalsterboData_Fil %>%
  mutate(year = format(FalsterboData_Fil$Datum, "%Y"), Coldday=yday(FalsterboData_Fil$Datum), TEMP_COLD=(FalsterboData_Fil$`Tid (UTC)`)) %>%
  group_by(year, Coldday) %>%
  summarise(Mean_Cold_Day= mean(Lufttemperatur)) 



#COLDEST day per year 
FinalFal_COLD_2_GREATER=
  FinalFal_COLD_GREATER %>%
  group_by(year,Coldday) %>%
  summarise(Coldest_Temp=min(Mean_Cold_Day))%>%
  filter(Coldest_Temp==min(Coldest_Temp), Coldday>270)


UnionFal_GREATER=FinalFal_WARM_2_GREATER %>% full_join(FinalFal_COLD_2_GREATER,by="year")

FALSTERBO_GREATER=UnionFal_GREATER %>% full_join(AVG_Year_UM, by="year")
FALSTERBO_LESS=UnionFAL_LESS%>% full_join (AVG_Year_UM, by="year")






write.table(UMEA_LESS,"C:/Users/valua/Desktop/Computing project/UMEA_LESS_HOURS")
write.table(UMEA_GREATER,"C:/Users/valua/Desktop/Computing project/UMEA_GREATER_HOURS")
write.table(FALSTERBO_LESS,"C:/Users/valua/Desktop/Computing project/FALSTERBO_LESS_HOURS")
write.table(FALSTERBO_GREATER,"C:/Users/valua/Desktop/Computing project/FALSTERBO_GREATER_HOURS")




