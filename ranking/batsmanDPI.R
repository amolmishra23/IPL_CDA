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

a <- select(csk_details,batsman,ballsPlayed,fours,sixes,runs,strikeRate,date,wicketKind)
b <- select(dc_details,batsman,ballsPlayed,fours,sixes,runs,strikeRate,date,wicketKind)
c <- select(dd_details,batsman,ballsPlayed,fours,sixes,runs,strikeRate,date,wicketKind)
d <- select(kxip_details,batsman,ballsPlayed,fours,sixes,runs,strikeRate,date,wicketKind)
e <- select(ktk_details,batsman,ballsPlayed,fours,sixes,runs,strikeRate,date,wicketKind)
f <- select(kkr_details,batsman,ballsPlayed,fours,sixes,runs,strikeRate,date,wicketKind)
g <- select(mi_details,batsman,ballsPlayed,fours,sixes,runs,strikeRate,date,wicketKind)
h <- select(pw_details,batsman,ballsPlayed,fours,sixes,runs,strikeRate,date,wicketKind)
i <- select(rr_details,batsman,ballsPlayed,fours,sixes,runs,strikeRate,date,wicketKind)
j <- select(rcb_details,batsman,ballsPlayed,fours,sixes,runs,strikeRate,date,wicketKind)
k <- select(sh_details,batsman,ballsPlayed,fours,sixes,runs,strikeRate,date,wicketKind)
l <- select(gl_details,batsman,ballsPlayed,fours,sixes,runs,strikeRate,date,wicketKind)
m <- select(rps_details,batsman,ballsPlayed,fours,sixes,runs,strikeRate,date,wicketKind)

df <- rbind(a,b,c,d,e,f,g,h,i,j,k,l,m)
batsmen <- unique(df$batsman)
# df <- mutate(df,hardHitter=(4*fours+6*sixes)/ballsPlayed)
# df


o <- NULL
n <- data.frame(name=character(0),matches=numeric(0),meanRuns=numeric(0),meanSR=numeric(0))
df[is.na(df)]<-0
for (x in 1:length(batsmen)){
    m <- filter(df,batsman==batsmen[x])
    m <- unique(m)
    m <- mutate(m,matches=n(),totalRuns=sum(runs),totalBalls=sum(ballsPlayed),meanRuns=mean(runs),meanSR=mean(strikeRate),fours=sum(fours),sixes=sum(sixes))
    m <- mutate(m,nonBoundaryBall=totalBalls-fours-sixes)
    p <- filter(m,wicketKind=="notOut")
    q <- mutate(p,count=n())
    m <- mutate(m,notOut=q$count[1])
    m <- select(m,batsman,matches,totalRuns,totalBalls,nonBoundaryBall,meanRuns,meanSR,fours,sixes,notOut)
    n <- m[1,]
    o <- rbind(o,n)
}
o[is.na(o)]<-0

# #HardHitter = (4*Fours + 6*Sixes) / Balls faced by player
# #Finisher = Number of times Not Out/ Total number of played Innings
# FastScorer (PBSR)
# Consistent (PBA)
# RunningBetweenWickets (RBW) = (PRS - (4*Fours+ 6*Sixes))/ Number of balls faced without boundary

o<-mutate(o,hardHitter=(4*fours+6*sixes)/totalBalls)
o<-mutate(o,finisher=notOut/matches)
o<-mutate(o,fastScorer=meanSR)
o<-mutate(o,consistent=meanRuns)
o<-mutate(o,rbw=(totalRuns-(4*fours+6*sixes))/nonBoundaryBall)

batsman_DPI <- o
details1 <- paste("projectDataFrames/ranking","/","Batsman-DPI.RData",sep="")
save(batsman_DPI, file=details1)
