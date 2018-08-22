library(dplyr)

battingDetails=batsman=runs=strikeRate=meanRuns=meanSR= NULL
setwd("projectDataFrames/batting")
load("Chennai Super Kings-BattingDetails.RData")
csk_details <- battingDetails
load("Deccan Chargers-BattingDetails.RData")
dc_details <- battingDetails
load("Delhi Daredevils-BattingDetails.RData")
dd_details <- battingDetails
load("Kings XI Punjab-BattingDetails.RData")
kxip_details <- battingDetails
load("Kochi Tuskers Kerala-BattingDetails.RData")
ktk_details <- battingDetails
load("Kolkata Knight Riders-BattingDetails.RData")
kkr_details <- battingDetails
load("Mumbai Indians-BattingDetails.RData")
mi_details <- battingDetails
load("Pune Warriors-BattingDetails.RData")
pw_details <- battingDetails
load("Rajasthan Royals-BattingDetails.RData")
rr_details <- battingDetails
load("Royal Challengers Bangalore-BattingDetails.RData")
rcb_details <- battingDetails
load("Sunrisers Hyderabad-BattingDetails.RData")
sh_details <- battingDetails
load("Gujarat Lions-BattingDetails.RData")
gl_details <- battingDetails
load("Rising Pune Supergiants-BattingDetails.RData")
rps_details <- battingDetails

setwd("..")
setwd("..")

a <- select(csk_details,batsman,ballsPlayed,fours,sixes,runs,strikeRate,date)
b <- select(dc_details,batsman,ballsPlayed,fours,sixes,runs,strikeRate,date)
c <- select(dd_details,batsman,ballsPlayed,fours,sixes,runs,strikeRate,date)
d <- select(kxip_details,batsman,ballsPlayed,fours,sixes,runs,strikeRate,date)
e <- select(ktk_details,batsman,ballsPlayed,fours,sixes,runs,strikeRate,date)
f <- select(kkr_details,batsman,ballsPlayed,fours,sixes,runs,strikeRate,date)
g <- select(mi_details,batsman,ballsPlayed,fours,sixes,runs,strikeRate,date)
h <- select(pw_details,batsman,ballsPlayed,fours,sixes,runs,strikeRate,date)
i <- select(rr_details,batsman,ballsPlayed,fours,sixes,runs,strikeRate,date)
j <- select(rcb_details,batsman,ballsPlayed,fours,sixes,runs,strikeRate,date)
k <- select(sh_details,batsman,ballsPlayed,fours,sixes,runs,strikeRate,date)
l <- select(gl_details,batsman,ballsPlayed,fours,sixes,runs,strikeRate,date)
m <- select(rps_details,batsman,ballsPlayed,fours,sixes,runs,strikeRate,date)

df <- rbind(a,b,c,d,e,f,g,h,i,j,k,l,m)
batsmen <- unique(df$batsman)

df[is.na(df)] <- 0
o <- NULL
n <- data.frame(name=character(0),matches=numeric(0),meanRuns=numeric(0),meanSR=numeric(0))
for (x in 1:length(batsmen)){
    m <- filter(df,batsman==batsmen[x])
    m <- unique(m)
    m <- mutate(m,matches=n(),totalRuns=sum(runs),meanRuns=mean(runs),meanSR=mean(strikeRate))
    m <- select(m,batsman,matches,totalRuns,meanRuns,meanSR)
    n <- m[1,]
    o <- rbind(o,n)
}

p <- filter(o,matches >= 30)

p <- arrange(p,desc(meanRuns),desc(meanSR))
batsman_normal_rank <- p
details <- paste("projectDataFrames/ranking","/","Batsman-NormalRank.RData",sep="")
save(batsman_normal_rank, file=details)
