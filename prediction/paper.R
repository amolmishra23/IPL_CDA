library(caret)
library(neuralnet)
library(mda)
library(C50)
library(e1071)
# Loading the data
load("./projectDataFrames/prediction/dataset1.RData")

dataset_train <- dataset
dataset_train$Winner <- factor(dataset_train$Winner)
dataset_test <- dataset
dataset_test$Winner <- factor(dataset_test$Winner)


# Creating training and testing data
# intrain <- createDataPartition(y = dataset$Winner, p= 0.7, list = FALSE)
intrain <- dataset_train
dataset$Winner <- factor(dataset$Winner)
training <- dataset[intrain,]
testing <- dataset[-intrain,]
testing <- dataset
dataset_test <- testing
# 1. SVM
trctrl <- trainControl(method = "repeatedcv", number = 10, repeats = 3)
set.seed(3233)
svm_Linear <- train(Winner ~., data = dataset_train, method = "svmLinear",
                    trControl=trctrl,
                    preProcess = c("center", "scale"),
                    tuneLength = 10)
test_pred <- predict(svm_Linear, newdata = dataset_test)
test_pred
confusionMatrix(test_pred, dataset_test$Winner )

# 2. SMO - Sequential minimal optimization
s <- SMO(Winner ~., data = dataset_train)
test_pred1 <- predict(s, newdata = dataset_test)
test_pred1
confusionMatrix(test_pred1, dataset$Winner )



# 3. IBK - Instance based learning on parameter k
i <- IBk(Winner ~., data = dataset_train)
test_pred <- predict(i, newdata = dataset_test)
test_pred
confusionMatrix(test_pred, dataset_test$Winner )


# 4. randomForest
r <- randomForest(Winner ~., data = dataset_train)
test_pred <- predict(r, newdata = dataset_test)
test_pred
confusionMatrix(test_pred, dataset_test$Winner )



# 5. JRip algorithm
j <- JRip(Winner ~., data = dataset_train)
test_pred <- predict(j, newdata = dataset_test)
test_pred
confusionMatrix(test_pred, dataset_test$Winner )


# 6. J48 algorithm
j <- J48(Winner ~., data = dataset_train)
test_pred <- predict(j, newdata = dataset_test)
test_pred
confusionMatrix(test_pred, dataset_test$Winner )


# 7. fda algorithm
f <- fda(Winner ~., data = dataset_train)
test_pred <- predict(f, newdata = dataset_test)
test_pred
confusionMatrix(test_pred, dataset_test$Winner)


# 8. mda algorithm
m <- mda(Winner ~., data = dataset_train)
test_pred <- predict(m, newdata = dataset_test)
test_pred
confusionMatrix(test_pred, dataset_test$Winner)



# 9. c 5.0 algorithm
m <- C5.0(Winner ~., data = dataset_train)
set.seed(4444)
test_pred <- predict(m, newdata = dataset_test)
test_pred
confusionMatrix(test_pred, dataset_test$Winner)


# 10. knn algorithm
trctrl <- trainControl(method = "repeatedcv", number = 10, repeats = 3)
set.seed(3333)
knn_fit <- train(Winner ~., data = dataset_train, method = "knn",
                 trControl=trctrl,
                 preProcess = c("center", "scale"),
                 tuneLength = 10)
test_pred <- predict(m, newdata = dataset_test)
test_pred
confusionMatrix(test_pred, dataset_test$Winner )




test_pred1 <- predict(svm_Linear, newdata = dataset)
test_pred1

confusionMatrix(test_pred1, dataset$Winner )







# 11. naiveBayes
m <- naiveBayes(Winner ~., data = dataset_train)
set.seed(4444)
test_pred <- predict(m, newdata = dataset_test)
test_pred
confusionMatrix(test_pred, dataset_test$Winner)


library(rpart)
m <- rpart(Winner ~., data = dataset_train)
set.seed(4444)
test_pred <- predict(m, newdata = dataset_test)
k <- data.frame(test_pred)
k <- mutate(k,X2=X1-X0)
k$X3 <- ifelse((k$X2>0),1,0)
confusionMatrix(k$X3, dataset_test$Winner)


algos <- c("SVM","SMO","IBK","RF","JRIP","J48","FDA","MDA","C 5.0","NB");
acc <- c(72.41,70.68,63.79,68.96,75.86,62.06,72.41,70.68,62.06,70.68);
graph_data <- data.frame(algos,acc)


library(ggplot2)


col <- c("#6495ED","#FF6EB4","#C71585","#FF4500","#999999","#B23AEE","#00FF00","#EE1289","#EEEE00","#00008B")
ggplot(graph_data, aes(x=algos, y=acc)) + geom_bar(stat="identity",fill=col) +
    coord_cartesian(ylim = c(60,80)) +
    xlab("Algorithm") + ylab("Accuracy")

       