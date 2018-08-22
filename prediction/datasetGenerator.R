source("prediction/helper.R")
datasetGenerator <- function(theyear=""){
    df <- data.frame(Bat1=numeric(),Bowl1=numeric(),Bat2=numeric(),
                     Bowl2=numeric(),Bat3=numeric(),Bowl3=numeric(),
                     Bat4=numeric(),Bowl4=numeric(),Bat5=numeric(),
                     Bowl5=numeric(),Bat6=numeric(),Bowl6=numeric(),
                     Bat7=numeric(),Bowl7=numeric(),Bat8=numeric(),
                     Bowl8=numeric(),Bat9=numeric(),Bowl9=numeric(),
                     Bat10=numeric(),Bowl10=numeric(),Bat11=numeric(),
                     Bowl11=numeric(),Winner=numeric())
    
    setwd("projectDataFrames/data")
    file_names <- list.files()
    a <- str_detect(file_names,"2016")
    b <- file_names[a]
    setwd("..")
    setwd("..")
    b <- file_names
    for(i in 1:length(b)){
        print (b[i])
        c <- getMatch(b[i])
        if (is.null(c)){
            next
        }
        df[nrow(df)+1,] <- c
    }
    
    dataset <- df
    
    d1 <- paste("projectDataFrames/prediction","/","dataset.RData",sep="")
    save(dataset, file=d1)
}
