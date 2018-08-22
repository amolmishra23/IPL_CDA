library(caret)
load("./projectDataFrames/prediction/dataset1.RData")
intrain <- createDataPartition(y = dataset$Winner, p= 0.7, list = FALSE)
dataset$Winner <- factor(dataset$Winner)
training <- dataset[intrain,]
testing <- dataset[-intrain,]

trctrl <- trainControl(method = "repeatedcv", number = 10, repeats = 3)
set.seed(3233)

svm_Linear <- train(Winner ~., data = dataset, method = "svmLinear",
                    trControl=trctrl,
                    preProcess = c("center", "scale"),
                    tuneLength = 10)


test_pred <- predict(svm_Linear, newdata = testing)
test_pred

confusionMatrix(test_pred, testing$Winner )

save(svm_Linear, file = "projectDataFrames/prediction/my_model1.rda")


