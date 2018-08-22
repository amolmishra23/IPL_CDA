load("./projectDataFrames/teamwise_rank/Delhi Daredevils.RData")
load("./projectDataFrames/teamwise_rank/Kings XI Punjab.RData")
load("./projectDataFrames/teamwise_rank/Kolkata Knight Riders.RData")
load("./projectDataFrames/teamwise_rank/Mumbai Indians.RData")
load("./projectDataFrames/teamwise_rank/Royal Challengers Bangalore.RData")
load("./projectDataFrames/teamwise_rank/Sunrisers Hyderabad.RData")
load("./projectDataFrames/teamwise_rank/Gujarat Lions.RData")
load("./projectDataFrames/teamwise_rank/Rising Pune Supergiant.RData")


dat1 <- arrange(dat,bat_rank)
dat2 <- arrange(dat,bowl_rank)
dat3 <- as.character(dat1[1:6,]$player)
dat4 <- as.character(dat2[1:5,]$player)
dat5 <- c(dat3,dat4)
dat5
str(dat5)


team <- data.frame(player=dat5)
details <- paste("projectDataFrames/teamwise_playing11","/","Rising Pune Supergiant.RData",sep="")
save(team, file=details)

