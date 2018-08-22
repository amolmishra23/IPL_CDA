getAllMatchesAllOpposition <- function(team,dir=".",save=FALSE){
    overs=NULL
    # Gather team data  against all ooposition
    d1 <- paste("*",team,"*",sep="")
    path=paste(dir,"/",d1,sep="")
    fl <- Sys.glob(path)
    if(length(fl) !=0){
        
        
        matches <- NULL
        for(i in 1:length(fl)){
            load(fl[i])
            matches <- rbind(matches,overs)
        }
        b <- paste(team,".RData",sep="")
        if(save){
            save(matches,file=b)
        }
        matches
    }
}
