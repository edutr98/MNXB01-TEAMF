
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


#Filtering hours 
FinalUm_WARM=
  UmeaData_Fil %>%
  mutate(year = format(UmeaData_Fil$Datum, "%Y"), Warmday=yday(UmeaData_Fil$Datum), TEMP_WARM=(UmeaData_Fil$`Tid (UTC)`)) %>%
  group_by(year,Warmday) %>%
  filter ( TEMP_WARM=='07:00:00'|TEMP_WARM=='13:00:00'|TEMP_WARM=='20:00:00')


#Mean temp per day 
FinalUm_WARM=
  UmeaData_Fil %>%
  mutate(year = format(UmeaData_Fil$Datum, "%Y"), Warmday=yday(UmeaData_Fil$Datum), TEMP_WARM=(UmeaData_Fil$`Tid (UTC)`)) %>%
  group_by(year,Warmday) %>%
  summarise(Mean_Warm_Day= mean(Lufttemperatur))

#Warmest day per year 
FinalUm_WARM_2=
  FinalUm_WARM %>%
  select(Warmday,Mean_Warm_Day)%>%
  group_by(year,Warmday) %>%
  summarise(Warmest_Temp=max(Mean_Warm_Day))%>%
  filter(Warmest_Temp==max(Warmest_Temp))


# COLD --------------------------------------------------------------------

#Filtering hours 
FinalUm_COLD=
  UmeaData_Fil %>%
  mutate(year = format(UmeaData_Fil$Datum, "%Y"), Coldday=yday(UmeaData_Fil$Datum), TEMP_COLD=(UmeaData_Fil$`Tid (UTC)`)) %>%
  group_by(year, Coldday) %>%
  filter ( TEMP_COLD=='07:00:00'|TEMP_COLD=='13:00:00'|TEMP_COLD=='20:00:00')


#Mean temp per day 
FinalUm_COLD=
  UmeaData_Fil %>%
  mutate(year = format(UmeaData_Fil$Datum, "%Y"), Coldday=yday(UmeaData_Fil$Datum), TEMP_COLD=(UmeaData_Fil$`Tid (UTC)`)) %>%
  group_by(year, Coldday) %>%
  summarise(Mean_Cold_Day= mean(Lufttemperatur))


#Warmest day per year 
FinalUm_COLD_2=
  FinalUm_COLD %>%
  select(Coldday,Mean_Cold_Day)%>%
  group_by(year,Coldday) %>%
  summarise(Coldest_Temp=min(Mean_Cold_Day))%>%
  filter(Coldest_Temp==min(Coldest_Temp))

#Union
UMEA=FinalUm_COLD_2 %>% full_join(FinalUm_WARM_2, by="year")




#Average temp per year 

AVG_Year_UM=
  UmeaData_Fil %>%
  mutate(year = format(UmeaData_Fil$Datum, "%Y")) %>%
  group_by(year) %>%
  summarise(AVG_Year= mean(Lufttemperatur))

UMEA=UMEA %>% full_join(AVG_Year_UM, by="year")


# FALSTERBO ---------------------------------------------------------------



# WARM --------------------------------------------------------------------


#Filtering hours 
FinalFals_WARM=
  FalsterboData_Fil %>%
  mutate(year = format(FalsterboData_Fil$Datum, "%Y"), Warmday=yday(FalsterboData_Fil$Datum), TEMP_WARM=(FalsterboData_Fil$`Tid (UTC)`)) %>%
  group_by(year,Warmday) %>%
  filter ( TEMP_WARM=='07:00:00'|TEMP_WARM=='13:00:00'|TEMP_WARM=='20:00:00')


#Mean temp per day 
FinalFals_WARM=
  FalsterboData_Fil %>%
  mutate(year = format(FalsterboData_Fil$Datum, "%Y"), Warmday=yday(FalsterboData_Fil$Datum), TEMP_WARM=(FalsterboData_Fil$`Tid (UTC)`)) %>%
  group_by(year,Warmday) %>%
  summarise(Mean_Warm_Day= mean(Lufttemperatur))

#Warmest day per year 
FinalFals_WARM_2=
  FinalFals_WARM %>%
  select(Warmday,Mean_Warm_Day)%>%
  group_by(year,Warmday) %>%
  summarise(Warmest_Temp=max(Mean_Warm_Day))%>%
  filter(Warmest_Temp==max(Warmest_Temp))


# COLD --------------------------------------------------------------------

#Filtering hours 
FinalFals_COLD=
  FalsterboData_Fil %>%
  mutate(year = format(FalsterboData_Fil$Datum, "%Y"), Coldday=yday(FalsterboData_Fil$Datum), TEMP_COLD=(FalsterboData_Fil$`Tid (UTC)`)) %>%
  group_by(year, Coldday) %>%
  filter ( TEMP_COLD=='07:00:00'|TEMP_COLD=='13:00:00'|TEMP_COLD=='20:00:00')


#Mean temp per day 
FinalFals_COLD=
  FalsterboData_Fil %>%
  mutate(year = format(FalsterboData_Fil$Datum, "%Y"), Coldday=yday(FalsterboData_Fil$Datum), TEMP_COLD=(FalsterboData_Fil$`Tid (UTC)`)) %>%
  group_by(year, Coldday) %>%
  summarise(Mean_Cold_Day= mean(Lufttemperatur))


#Warmest day per year 
FinalFals_COLD_2=
  FinalFals_COLD %>%
  select(Coldday,Mean_Cold_Day)%>%
  group_by(year,Coldday) %>%
  summarise(Coldest_Temp=min(Mean_Cold_Day))%>%
  filter(Coldest_Temp==min(Coldest_Temp))

#Union
FALSTERBO=FinalFals_COLD_2 %>% full_join(FinalFals_WARM_2, by="year")




#Average temp per year 

AVG_Year_FALS=
  FalsterboData_Fil %>%
  mutate(year = format(FalsterboData_Fil$Datum, "%Y")) %>%
  group_by(year) %>%
  summarise(AVG_Year= mean(Lufttemperatur))

FALSTERBO=FALSTERBO %>% full_join(AVG_Year_FALS, by="year")






write.table(FALSTERBO,"C:/Users/valua/Desktop/Computing project/Falsterbo_Hours")

write.table(UMEA,"C:/Users/valua/Desktop/Computing project/Umea_Hours")





