IPLTeamNames <- list("Chennai Super Kings","Deccan Chargers", "Delhi Daredevils","Kings Xi Punjab", 
                     "Kochi Tuskers Kerala","Kolkata Knight Riders","Mumbai Indians","Pune Warriors",
                     "Rajasthan Royals","Royal Challengers Bangalore","Sunrisers Hyderabad","Gujarat Lions",
                     "Rising Pune Supergiants")  

getBatsmen <- function(df){
    bmen <- df %>% distinct(batsman) 
    bmen <- as.character(bmen$batsman)
    batsmen <- sort(bmen)
}


getTeamIndex <- function(batsman){
    setwd("projectDataFrames/batsman")
    file_names<-list.files()
    lapply(file_names,load,.GlobalEnv)
    teams_batsmen = list(csk_batsmen,dc_batsmen,dd_batsmen,kxp_batsmen,ktk_batsmen,kkr_batsmen,mi_batsmen,
                         pw_batsmen,rr_batsmen,rcb_batsmen,sh_batsmen,gl_batsmen,rps_batsmen)
    b <- NULL
    for (i in 1:length(teams_batsmen)){
        a <- which(teams_batsmen[[i]] == batsman)
        
        if(length(a) != 0)
            b <- c(b,i)
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