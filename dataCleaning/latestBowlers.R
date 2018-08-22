library(dplyr)
setwd("projectDataFrames/bowling")
load("Chennai Super Kings-BowlingDetails.RData")
csk_details <- bowlingDetails
bowlingDetails <- filter(bowlingDetails,year(ymd(date))==2017) %>% arrange(date)
details<-paste(save_dir,"Chennai Super Kings-BowlingDetailsT.RData",sep="")
save(bowlingDetails,file=details)
csk_details_t <- bowlingDetails

load("Deccan Chargers-BowlingDetails.RData")
dc_details <- bowlingDetails
bowlingDetails <- filter(bowlingDetails,year(ymd(date))==2017) %>% arrange(date)
details<-paste(save_dir,"Deccan Chargers-BowlingDetailsT.RData",sep="")
save(bowlingDetails,file=details)
dc_details_t <- bowlingDetails

load("Delhi Daredevils-BowlingDetails.RData")
dd_details <- bowlingDetails
bowlingDetails <- filter(bowlingDetails,year(ymd(date))==2017) %>% arrange(date)
details<-paste(save_dir,"Delhi Daredevils-BowlingDetailsT.RData",sep="")
save(bowlingDetails,file=details)
dd_details_t <- bowlingDetails

load("Kings XI Punjab-BowlingDetails.RData")
kxip_details <- bowlingDetails
bowlingDetails <- filter(bowlingDetails,year(ymd(date))==2017) %>% arrange(date)
details<-paste(save_dir,"Kings XI Punjab-BowlingDetailsT.RData",sep="")
save(bowlingDetails,file=details)
kxip_details_t <- bowlingDetails

load("Kochi Tuskers Kerala-BowlingDetails.RData")
ktk_details <- bowlingDetails
bowlingDetails <- filter(bowlingDetails,year(ymd(date))==2017) %>% arrange(date)
details<-paste(save_dir,"Kochi Tuskers Kerala-BowlingDetailsT.RData",sep="")
save(bowlingDetails,file=details)
ktk_details_t <- bowlingDetails

load("Kolkata Knight Riders-BowlingDetails.RData")
kkr_details <- bowlingDetails
bowlingDetails <- filter(bowlingDetails,year(ymd(date))==2017) %>% arrange(date)
details<-paste(save_dir,"Kolkata Knight Riders-BowlingDetailsT.RData",sep="")
save(bowlingDetails,file=details)
kkr_details_t <- bowlingDetails

load("Mumbai Indians-BowlingDetails.RData")
mi_details <- bowlingDetails
bowlingDetails <- filter(bowlingDetails,year(ymd(date))==2017) %>% arrange(date)
details<-paste(save_dir,"Mumbai Indians-BowlingDetailsT.RData",sep="")
save(bowlingDetails,file=details)
mi_details_t <- bowlingDetails

load("Pune Warriors-BowlingDetails.RData")
pw_details <- bowlingDetails
bowlingDetails <- filter(bowlingDetails,year(ymd(date))==2017) %>% arrange(date)
details<-paste(save_dir,"Pune Warriors-BowlingDetailsT.RData",sep="")
save(bowlingDetails,file=details)
pw_details_t <- bowlingDetails

load("Rajasthan Royals-BowlingDetails.RData")
rr_details <- bowlingDetails
bowlingDetails <- filter(bowlingDetails,year(ymd(date))==2017) %>% arrange(date)
details<-paste(save_dir,"Rajasthan Royals-BowlingDetailsT.RData",sep="")
save(bowlingDetails,file=details)
rr_details_t <- bowlingDetails

load("Royal Challengers Bangalore-BowlingDetails.RData")
rcb_details <- bowlingDetails
bowlingDetails <- filter(bowlingDetails,year(ymd(date))==2017) %>% arrange(date)
details<-paste(save_dir,"Royal Challengers Bangalore-BowlingDetailsT.RData",sep="")
save(bowlingDetails,file=details)
rcb_details_t <- bowlingDetails

load("Sunrisers Hyderabad-BowlingDetails.RData")
sh_details <- bowlingDetails
bowlingDetails <- filter(bowlingDetails,year(ymd(date))==2017) %>% arrange(date)
details<-paste(save_dir,"Sunrisers Hyderabad-BowlingDetailsT.RData",sep="")
save(bowlingDetails,file=details)
sh_details_t <- bowlingDetails

load("Gujarat Lions-BowlingDetails.RData")
gl_details <- bowlingDetails
bowlingDetails <- filter(bowlingDetails,year(ymd(date))==2017) %>% arrange(date)
details<-paste(save_dir,"Gujarat Lions-BowlingDetailsT.RData",sep="")
save(bowlingDetails,file=details)
gl_details_t <- bowlingDetails

load("Rising Pune Supergiant-BowlingDetails.RData")
rps_details <- bowlingDetails
bowlingDetails <- filter(bowlingDetails,year(ymd(date))==2017) %>% arrange(date)
details<-paste(save_dir,"Rising Pune Supergiant-BowlingDetailsT.RData",sep="")
save(bowlingDetails,file=details)
rps_details_t <- bowlingDetails
