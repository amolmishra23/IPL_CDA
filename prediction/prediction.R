library(caret)
load("./projectDataFrames/prediction/dataset_new1.RData")
load("./projectDataFrames/prediction/my_model1.rda")
new_pred <- predict(svm_Linear,dataset)
actual <- dataset$Winner

setwd("projectDataFrames/data")
file_names <- list.files()
a <- str_detect(file_names,"2017")
b <- file_names[a]
setwd("..")
setwd("..")

df <- data.frame(Match=character(),Winner=character(),Prediction=character(),stringsAsFactors=FALSE)
k <- 0

for(i in b){
    load(paste('projectDataFrames/data','/',i,sep=''))
    t1 <- as.vector(overs[1,22])
    t2 <- as.vector(overs[1,23])
    w_actual <- as.vector(overs[1,24])
    if (w_actual=="NA"){
        next
    }
    k=k+1
    if(new_pred[k]==1){
        w_predicted <- t1
    } else{
        w_predicted <- t2
    }
    df[nrow(df)+1,] <- c(i,w_actual,w_predicted)
}

predicted <- mutate(df, Result=(Winner==Prediction))
table(df$Winner)

confusionMatrix(new_pred, dataset$Winner )

details1 <- paste("projectDataFrames/prediction","/","predicted.RData",sep="")
save(predicted, file=details1)
