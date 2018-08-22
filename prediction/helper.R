library(dplyr)
library(stringr)
getMatch <- function(name="Delhi Daredevils-Gujarat Lions-2016-04-27.RData"){
    load(paste('projectDataFrames/data','/',name,sep=''))
    overs <- na.omit(overs)
    team1 <- as.vector(overs[1,22])
    team2 <- as.vector(overs[1,23])
    winner <- as.vector(overs[1,24])
    
    w <- NULL
    if(team1==winner){
        w <- 1    
    } else if(team2==winner){
        w <- 0
    }
    if (is.null(w)){
        return (w)
        break
    }
    
    df1 <- filter(overs,team==team1)
    df2 <- filter(overs,team!=team1)
    
    a <- as.vector(unique(df1$batsman))
    b <- as.vector(unique(df2$bowler))
    y <- as.vector(unique(df2$wicketFielder))
    x <- str_detect(y,"nobody")
    y <- y[!x]
    
    c <- as.vector(unique(df2$batsman))
    d <- as.vector(unique(df1$bowler))
    z <- as.vector(unique(df1$wicketFielder))
    x <- str_detect(z,"nobody")
    z <- z[!x]
    
    e <- unique(c(a,b,y))
    f <- unique(c(c,d,z))
    l1 <- length(e)
    l2 <- length(f)
    
    if(length(e)<11){
        e <- c(e,rep(NA,abs(11-l1)))
    } else if(length(e)>11){
        e <- e[1:11]
    }
    
    if(length(f)<11){
        f <- c(f,rep(NA,abs(11-l2)))
    } else if(length(f)>11){
        f <- f[1:11]
    }
    
    g <- unlist(sapply(e,batsmanDPIRank),use.names = FALSE)
    h <- unlist(sapply(f,batsmanDPIRank),use.names = FALSE)
    
    i <- unlist(sapply(e,bowlerDPIRank),use.names = FALSE)
    j <- unlist(sapply(f,bowlerDPIRank),use.names = FALSE)
    
    names(g) <- NULL
    names(h) <- NULL
    names(i) <- NULL
    names(j) <- NULL
    
    df <- data.frame(T1=e, T2=f, T1_batsman=g, T2_batsman=h,
                     T1_bowler=i, T2_bowler=j, Winner=w, stringsAsFactors=F)
    
    df <- mutate(df,batsman=(T1_batsman-T2_batsman))
    df <- mutate(df,bowler=(T1_bowler-T2_bowler))
    a <- df$batsman
    b <- df$bowler
    c <- df$Winner[1]
    d <- NULL
    for (i in 1:11){
        d <- c(d,a[i],b[i])
    }
    d <- c(d,c)
    d
}

is.integer0 <- function(x)
{
    is.integer(x) && length(x) == 0L
}

batsmanDPIRank <- function(name="Batsman"){
    load("./projectDataFrames/ranking/batsmanRanks.RData")
    rank <- filter(batsmanRanks,batsman==name) %>% select(DPI_Ranks)
    rank <- c(rank)
    
    if(is.integer0(rank$DPI_Ranks)){
        rank <- 457
    }
    rank[[1]][1]
}

bowlerDPIRank <- function(name="Bowler"){
    load("./projectDataFrames/ranking/bowlerRanks.RData")
    rank <- filter(bowlerRanks,bowler==name) %>% select(DPI_Ranks)
    rank <- c(rank)
    if(is.integer0(rank$DPI_Ranks)){
        rank <- 330
    }
    rank[[1]][1]
}