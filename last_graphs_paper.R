library(gcookbook) # For the data set
ggplot(cabbage_exp, aes(x=Date, y=Weight, fill=Cultivar)) +
    geom_bar(stat="identity")


algos <- c("SVM","SMO","IBK","RF","JRIP","J48","FDA","MDA","C 5.0","NB");
acc <- c(72.41,70.68,63.79,68.96,75.86,62.06,72.41,70.68,62.06,70.68);
graph_data <- data.frame(algos,acc)

algos <- c("DMP", "CDAI")
data <- c(8,9)
graph_data <- data.frame(algos,data)
col <- c("#6495ED","#FF6EB4")
ggplot(graph_data, aes(x=(algos), y=data)) + geom_bar(stat="identity",fill=col) +
    coord_cartesian(ylim = c(6,10)) +
    xlab("Approaches") + ylab("IPL season Dataset used")

graph_data$algos <- factor(graph_data$algos,levels(graph_data$algos)[c(2,1)])
graph_data$algos

algos <- c("DMP", "CDAI")
data <- c(12,0)
graph_data <- data.frame(algos,data)
col <- c("#6495ED","#FF6EB4")
ggplot(graph_data, aes(x=(algos), y=data)) + geom_bar(stat="identity",fill=col) +
    coord_cartesian(ylim = c(1,13)) +
    xlab("Approaches") + ylab("Years of T20 dataset used")


algos <- c("DMP(existing)","CDAI(Proposed)")
data <- c(69.64,81.03)
graph_data <- data.frame(algos,data)
col <- c("#6495ED","#FF6EB4")
ggplot(graph_data, aes(x=reorder(algos,data), y=data)) + geom_bar(stat="identity",fill=col) +
    coord_cartesian(ylim = c(65,85)) +
    xlab("Approaches") + ylab("Accuracy using SVM")

