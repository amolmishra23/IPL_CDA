library(caret)
library(dplyr)

load("./projectDataFrames/ranking/BowlerPredict.RData")

f <- full_bowler_data
preObj <- preProcess(f[,-7],method=c("center","scale"))
a <- predict(preObj,f[,-7])
b <- cbind(a,f[7])
modFit <- train(MVPI~PBWER+PBWA+PBWSR+ShortPerf,data=b,method="rf",prox=TRUE)
d <- predict(modFit,b)
d <- data.frame(DPI=d)
e <- cbind(b,d)
dpiRanks <- e
e <- arrange(e,desc(DPI))
e <- mutate(e,DPI_Ranks=1:nrow(e))
e <- arrange(e,desc(MVPI))
e <- mutate(e,MVPI_Ranks=1:nrow(e))

bowlerRanks <- e[,c(1,9,10)]
bowlerRanks <- arrange(bowlerRanks,DPI_Ranks)
d1 <- paste("projectDataFrames/ranking","/","bowlerRanks.RData",sep="")
save(bowlerRanks, file=d1)
d2 <- paste("projectDataFrames/ranking","/","Bowler-DPIRank.RData",sep="")
save(dpiRanks,file=d2)
