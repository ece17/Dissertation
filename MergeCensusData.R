
setwd("C:/Users/tshealy - admin/Documents/PhD/Research Materials/Data Sets/Analyze Census Tract Data_D.C./R files")

#Upload ACS08301 Transportation to Work and delete second header row
c<-read.csv("ACS08301.csv", header=TRUE)
c<- c[-c(1),]

#Select columns of interest from 08301 and create new dataframe:
##HD01_VD18 is the estimate of bicycle commuters and HD02_VD18 is the margin of error
##HD01_VD01 is the estimate of toal commuters and HD02_VD01 is the margin of error

v1<-c$HD01_VD01
v2<-c$HD01_VD18
v3<-c$HD02_VD01
v4<-c$HD02_VD18
v5<-c$GEO.id2
bikecommute<-data.frame(v1, v2, v3, v4, v5)

#Correct data to be numeric and create descriptive column names
bikecommute$v1 <- as.numeric(as.character(bikecommute$v1))
bikecommute$v2 <- as.numeric(as.character(bikecommute$v2))
bikecommute$v3 <- as.numeric(as.character(bikecommute$v3))
bikecommute$v4 <- as.numeric(as.character(bikecommute$v4))
bikecommute$v5 <- as.numeric(as.character(bikecommute$v5))
names(bikecommute)<- c("Estimate.Total.Commuters", "Estimate.Bike.Commuters", "MOE.Total.Commuters", "MOE.Bike.Commuters", "GEO.id2")


#Upload ACS02001 Race and ACS03003 Hispanic origin
race<-read.csv("ACS02001.csv", header=TRUE)
hispanic<-read.csv("ACS03003.csv", header=TRUE)

#Upload coronary heart disease data from 500 cities project
CVDprevalence<-read.csv("BRFSS.csv", header=TRUE)

#Upload CHDB 500 cities data for hypertension, obesity, diabetes, smoking habits, and access to healthy food
##If metric_number=9 then hypertension
##If metric_number=6 then diabetes
##If metric_number=17 then obesity
##If metric_number=15 then FEI
##If metric_number=22 then smoking habits
BRFSS<-read.csv("CHDBv6.csv", header=TRUE)

#Select Columns of Interest:
vars<-c("state_abbr", "city_name", "metric_number", "est", "lci", "uci", "data_yr_type", "stcotr_fips")
CitiesData<-BRFSS[vars]
colnames(CitiesData)[colnames(CitiesData)=="stcotr_fips"]<-"GEO.id2"

#Merge dataframes into master spreadsheet for Washington D.C. census tract
merge1 <- merge(race,hispanic, by="GEO.id2")
merge2<- merge(merge1,CVDprevalence, by="GEO.id2")
merge3<- merge(merge2,bikecommute, by="GEO.id2")
WashingtonDC<- merge(merge3,CitiesData, by="GEO.id2")

#download merged dataframe to Documents 
write.csv(WashingtonDC, 'WashingtonDC.csv')

#Upload ACS01001 Sex By Age
s<-read.csv("ACS01001.csv", header=TRUE)
s<- c[-c(1),]

v6<-s$HD01_VD07
v7<-s$HD01_VD08
v8<-s$HD01_VD09
v9<-s$HD01_VD10
v10<-s$HD01_VD11
v11<-s$HD01_VD12
v12<-s$HD01_VD13
v13<-s$HD01_VD14
v14<-s$HD01_VD15
v15<-s$HD01_VD16
v16<-s$HD01_VD17
v17<-s$HD01_VD18
v18<-s$HD01_VD19
v19<-s$HD01_VD20
v20<-s$HD01_VD21
v21<-s$HD01_VD22
v22<-s$HD01_VD23
v23<-s$HD01_VD24
v24<-s$HD01_VD25
v25<-s$HD01_VD31
v26<-s$HD01_VD32
v27<-s$HD01_VD33
v28<-s$HD01_VD34
v29<-s$HD01_VD35
v30<-s$HD01_VD36
v31<-s$HD01_VD37
v32<-s$HD01_VD38
v33<-s$HD01_VD39
v34<-s$HD01_VD40
v35<-s$HD01_VD41
v36<-s$HD01_VD42
v37<-s$HD01_VD43
v38<-s$HD01_VD44
v39<-s$HD01_VD45
v40<-s$HD01_VD46
v41<-s$HD01_VD47
v42<-s$HD01_VD48
v43<-s$HD01_VD49
v44<-s$HD01_VD01
v45<-s$HD01_VD02
v46<-s$HD01_VD26
sexage<-data.frame(v6,v7,v8,v9,v10,v11,v12,v13,v14,v15,v16,v17,v18,v19,v20,v21,v22,v23,v24,v25,v26,v27,v28,v29,v30,v31,v32,v33,v34,v35,v36,v37,v38,v39,v40,v41,v42,v43,v44,v45,v46)

s$v1 <- as.numeric(as.character(s$v1))


#Create age group columns: G1 is 18-24, G2 is 25-34, G3 is 35-44, G4 is 45-64, G5 is 65 or older
##HD01_VD07 to HD01_VD10 and HD01_VD31 to HD01_VD34 is 18-24
##HD01_VD11 to HD01_VD12 and HD01_VD35 to HD01_VD36 is 25-34
##HD01_VD13 to HD01_VD14 and HD01_VD37 to HD01_VD38 is 35-44
##HD01_VD15 to HD01_VD19 and HD01_VD39 to HD01_VD43 is 45-64
##HD01_VD20 to HD01_VD25 and HD01_VD44 to HD01_VD49 is >65
sexage$ageG1<-sexage$HD01_VD07+sexage$HD01_VD08+sexage$HD01_VD09+sexage$HD01_VD10+sexage$HD01_VD31+sexage$HD01_VD32+sexage$HD01_VD33+sexage$HD01_VD34
sexage$ageG2<-sexage$HD01_VD11+sexage$HD01_VD12+sexage$HD01_VD35+sexage$HD01_VD36
sexage$ageG3<-sexage$HD01_VD13+sexage$HD01_VD14+sexage$HD01_VD37+sexage$HD01_VD38
sexage$ageG4<-sexage$HD01_VD15+sexage$HD01_VD16+sexage$HD01_VD17+sexage$HD01_VD18+sexage$HD01_VD19+sexage$HD01_VD39+sexage$HD01_VD40+sexage$HD01_VD41+sexage$HD01_VD42+sexage$HD01_VD43
sexage$ageG5<-sexage$HD01_VD20+sexage$HD01_VD21+sexage$HD01_VD22+sexage$HD01_VD23+sexage$HD01_VD24+sexage$HD01_VD25+sexage$HD01_VD44+sexage$HD01_VD45+sexage$HD01_VD46+sexage$HD01_VD47+sexage$HD01_VD48+sexage$HD01_VD49

#Select Columns of Interest: 
#HD01_VD01 is the total population estimate (HD02_VD01 is margin of error)
#HD01_VD02 is the estimate of total males (HD02_VD02 is margin of error)
#HD01_VD26 is the estimate of total females (HD02_VD26 is margin of error)
vars<- c("HD01_VD01", "HD01_VD02", "HD01_VD26", "HD02_VD01", "HD02_VD02", "HD02_VD26", "GEO.id2", "ageG1", "ageG2", "ageG3", "ageG4", "ageG5")
sexANDage<- sexage[vars]

#Rename columns
names(sexANDage)<-c("Total Population", "Total Males", "Total Females", "MOE Total Pop", "MOE Total Males", "MOE Total Females", "GEO.id2", "ageG1", "ageG2", "ageG3", "ageG4", "ageG5")

