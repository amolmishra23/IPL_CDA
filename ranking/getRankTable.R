getRankTable <- function(rankingFunc="Batting average ranking"){
    if (rankingFunc == "Batting average ranking"){
        load("./projectDataFrames/ranking/Batsman-NormalRank.RData")
        a <- mutate(batsman_normal_rank,rank=1:nrow(batsman_normal_rank))
    }
    else if (rankingFunc == "Batting MVPI ranking"){
        load("./projectDataFrames/ranking/Batsman-MVPI.RData")
        a <- mutate(batsman_MVPI,rank=1:nrow(batsman_MVPI))
    }
    else if (rankingFunc == "Batting DPI ranking"){
        load("./projectDataFrames/ranking/Batsman-DPIRank.RData")
        a <- mutate(dpiRanks,rank=1:nrow(dpiRanks))
    }
    else if (rankingFunc == "Bowling average ranking"){
        load("./projectDataFrames/ranking/Bowler-NormalRank.RData")
        a <- mutate(bowler_normal_rank,rank=1:nrow(bowler_normal_rank))
    }
    else if (rankingFunc == "Bowling MVPI ranking"){
        load("./projectDataFrames/ranking/Bowler-MVPI.RData")
        a <- mutate(bowler_MVPI,rank=1:nrow(bowler_MVPI))
    }
    else if (rankingFunc == "Bowling DPI ranking"){
        load("./projectDataFrames/ranking/Bowler-DPIRank.RData")
        a <- mutate(dpiRanks,rank=1:nrow(dpiRanks))
    }
}