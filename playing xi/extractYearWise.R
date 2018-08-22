teams <- c("Mumbai Indians","Rising Pune Supergiants","Sunrisers Hyderabad",
           "Kolkata Knight Riders","Kings XI Punjab","Delhi Daredevils",
           "Gujarat Lions", "Royal Challengers Bangalore")

library(lubridate)
library(dplyr)
load("./projectDataFrames/ranking/batsmanRanks.RData")
load("./projectDataFrames/ranking/bowlerRanks.RData")


load("./projectDataFrames/all_matches_all_oppositions/Delhi Daredevils.RData")
load("./projectDataFrames/all_matches_all_oppositions/Kings XI Punjab.RData")
load("./projectDataFrames/all_matches_all_oppositions/Kolkata Knight Riders.RData")
load("./projectDataFrames/all_matches_all_oppositions/Mumbai Indians.RData")
load("./projectDataFrames/all_matches_all_oppositions/Royal Challengers Bangalore.RData")
load("./projectDataFrames/all_matches_all_oppositions/Sunrisers Hyderabad.RData")
load("./projectDataFrames/all_matches_all_oppositions/Gujarat Lions.RData")
load("./projectDataFrames/all_matches_all_oppositions/Rising Pune Supergiants.RData")










c <- matches[matches$date >= "2017-01-01" & matches$date <= "2017-12-31",]

batsmen <- unique(select(filter(c,team=="Rising Pune Supergiant"),batsman))
bowler <- unique(select(filter(c,team!="Rising Pune Supergiant"),bowler))
fielder <- unique(select(filter(c,team!="Rising Pune Supergiant",wicketFielder!="nobody"),bowler))
entireTeam <- as.character(unique(unlist(c(batsmen,bowler,fielder))))


dat <- data.frame(player = factor(), bat_rank = integer(), bowl_rank = integer())

for (a in entireTeam)
{
    b <- as.integer(filter(batsmanRanks,batsman==a) %>% select(DPI_Ranks))
    c <- as.integer(filter(bowlerRanks,bowler==a) %>% select(DPI_Ranks))
    dat <- rbind(dat, data.frame(player = a, bat_rank = b, bowl_rank = c))
}
dat[is.na(dat)] <- 500
details <- paste("projectDataFrames/teamwise_rank","/","Rising Pune Supergiant.RData",sep="")
save(dat, file=details)
