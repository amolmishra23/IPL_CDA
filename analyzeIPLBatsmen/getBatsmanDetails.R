getBatsmanDetails <- function(team, name,dir="projectDataFrames/batsman"){
    batsman=battingDetails=NULL
    fl <- paste(dir,"/",team,"-BattingDetails.RData",sep="")
    print(fl)
    load(fl)
    details <- battingDetails
    batsmanDetails <- filter(details,grepl(name,batsman))
    batsmanDetails
}
