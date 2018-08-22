# We get output in following format
# bowler delivery wicketNo       date
# 1 R Ashwin        6        1 2010-03-14
# 2 R Ashwin        7        2 2010-03-14
# 3 R Ashwin       20        1 2010-04-22
# 4 R Ashwin        3        1 2010-04-15
# 5 R Ashwin       13        1 2011-05-12
# 6 R Ashwin       19        2 2011-05-12

getDeliveryWickets <- function(team,dir=".",name,save=FALSE){
    overs=NULL
    a <- paste(dir,"/","*",team,"*",sep="")
    
    fl <- Sys.glob(a)
    deliveryWKts <- NULL
    for(i in 1:length(fl)){
        load(fl[i])
        match <- overs
        details <- bowlerDeliveryWickets(match,team,name)
        if(!is.null(dim(details))){
            deliveryWKts <- rbind(deliveryWKts,details)
        }else {
            next
        }
    }
    deliveryWKts
}
