library (readxl)
library(tidyverse)
install.packages("writexl")
library(writexl)
library(lubridate)

#Importing 
UmeaData = read_xlsx("C:/Users/valua/Desktop/Computing project/Data.xlsx", sheet="Umea")
UmeaData


FalsterboData = read_xlsx("C:/Users/valua/Desktop/Computing project/Data.xlsx", sheet="Falsterbo")
FalsterboData

#Changing variable type (Lufttemperatur)

#Falsterbo
TempFal<-as.factor(FalsterboData$Lufttemperatur)
TempFal_2<- as.character(TempFal)
TempFal_3<- as.numeric(TempFal_2)
FalsterboData$Lufttemperatur=TempFal_3

#Umea
TempUm<-as.factor(UmeaData$Lufttemperatur)
TempUm_2<- as.character(TempUm)
TempUm_3<- as.numeric(TempUm_2)
UmeaData$Lufttemperatur=TempUm_3





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










#Grouping by year and day 

#Umea

FinalUm_WARM=
  UmeaData_Fil %>%
  mutate(year = format(UmeaData_Fil$Datum, "%Y"), Warmday=yday(UmeaData_Fil$Datum)) %>%
  group_by(year,Warmday) %>%
  summarise(Maxm= max(Lufttemperatur))%>%
  filter (Maxm==max(Maxm))

  
FinalUm_COLD=
  UmeaData_Fil %>%
  mutate(year = format(UmeaData_Fil$Datum, "%Y"), Coldday=yday(UmeaData_Fil$Datum)) %>%
  group_by(year,Coldday) %>%
  summarise(Minm= min(Lufttemperatur))%>%
  filter (Minm==min(Minm))
  
  UnionUMEA=FinalUm_WARM %>% full_join(FinalUm_COLD,by="year")
  
  
  
#Average temp per year 
  
AVGUm=
    UmeaData_Fil %>%
    mutate(year = format(UmeaData_Fil$Datum, "%Y")) %>%
    group_by(year) %>%
    summarise(Avg= mean(Lufttemperatur))

UMEA=UnionUMEA %>% full_join(AVGUm, by="year")


UMEA_FINAL=UMEA %>% distinct(year, .keep_all = TRUE)



#Falsterbo 

#Warmest Day 
FinalFALS_WARM=
  FalsterboData_Fil %>%
  mutate(year = format(FalsterboData_Fil$Datum, "%Y"), Warmday=yday(FalsterboData_Fil$Datum)) %>%
  group_by(year,Warmday) %>%
  summarise(Maxm= max(Lufttemperatur))%>%
  filter (Maxm==max(Maxm))

#Coldest Day 
FinalFALS_COLD=
  FalsterboData_Fil %>%
  mutate(year = format(FalsterboData_Fil$Datum, "%Y"), Coldday=yday(FalsterboData_Fil$Datum)) %>%
  group_by(year,Coldday) %>%
  summarise(Minm= min(Lufttemperatur))%>%
  filter (Minm==min(Minm))

UnionFALS=FinalFALS_WARM %>% full_join(FinalFALS_COLD,by="year")

#Average temp per year 

AVGFals=
  FalsterboData_Fil %>%
  mutate(year = format(FalsterboData_Fil$Datum, "%Y")) %>%
  group_by(year) %>%
  summarise(Avg= mean(Lufttemperatur))

FALSTERBO=UnionFALS %>% full_join(AVGFals, by="year")


FALSTERBO_FINAL=FALSTERBO %>% distinct(year, .keep_all = TRUE)






write.table(FALSTERBO_FINAL,"C:/Users/valua/Desktop/Computing project/Falsterbo")

write.table(UMEA_FINAL,"C:/Users/valua/Desktop/Computing project/Umea")

          
