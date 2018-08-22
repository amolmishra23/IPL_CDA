IPLTeamNames <- list("Chennai Super Kings","Deccan Chargers", "Delhi Daredevils","Kings Xi Punjab", 
                     "Kochi Tuskers Kerala","Kolkata Knight Riders","Mumbai Indians","Pune Warriors",
                     "Rajasthan Royals","Royal Challengers Bangalore","Sunrisers Hyderabad","Gujarat Lions",
                     "Rising Pune Supergiants")  

getBowlers <- function(df){
    bwlr <- df %>% distinct(bowler) 
    bwlr <- as.character(bwlr$bowler)
    bowler <- sort(bwlr)
}

getTeamIndex_bowler <- function(bowler){
    setwd("projectDataFrames/bowler")
    file_names<-list.files()
    invisible(lapply(file_names,load,.GlobalEnv))
    teams_bowlers = list(csk_bowler,dc_bowler,dd_bowler,kxp_bowler,ktk_bowler,kkr_bowler,mi_bowler,
                         pw_bowler,rr_bowler,rcb_bowler,sh_bowler,gl_bowler,rps_bowler)
    b <- NULL
    for (i in 1:length(teams_bowlers)){
        a <- which(teams_bowlers[[i]] == bowler)
        if(length(a) != 0){
            b <- c(b,i)
        }
    }
    setwd("..")
    setwd("..")
    b
}

getTeams <- function(x){
    l <- NULL
    for (i in seq_along(x)){
        
        l <- c(l, IPLTeamNames[[x[i]]]) 
        
    }
    l
}