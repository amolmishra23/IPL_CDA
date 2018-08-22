# This function returns output in the following format
# bowler delivery wicketNo       date
# 1 R Ashwin       20        1 2010-04-22
bowlerDeliveryWickets <- function(match,theTeam,name){
    team = bowler = wicketPlayerOut =delivery = wicketNo = NULL
    d <- NULL
    a <-filter(match,team!=theTeam)
    b <- filter(a,grepl(name,bowler))
    if(dim(b)[1] != 0){
        b$delivery<- seq(1:dim(b)[1])
        c <- filter(b,wicketPlayerOut != "nobody")
        if(dim(c)[1] !=0){
            c$wicketNo <- seq(1:dim(c)[1])
            d <- select(c,bowler,delivery,wicketNo,date)
        }
        
    }
    d
}
