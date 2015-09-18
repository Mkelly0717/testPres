library(reshape)
library(caret); library(kernlab) ; library(ggplot2) ;
# library(rattle) ;
library(doParallel) ;
#cl <- makeCluster(detectCores()); registerDoParallel(cl)
data <- read.csv("./damage_industry_cnt.dsv", sep="|", header=TRUE, na.strings=c("NA", "#DIV/0!"))
data$U_INDUSTRY <- gsub('\\&','',data$U_INDUSTRY)
data$U_INDUSTRY <- gsub('-','',data$U_INDUSTRY)
data$U_INDUSTRY <- gsub(' +','\\.',data$U_INDUSTRY)
d2 <- cast(data, YIELD~U_INDUSTRY, value='PERCENT', mean, na.rm=TRUE, fill=0)
d2[1:5,1:6]

inTrain <- createDataPartition(y=d2$YIELD, p=0.7, list=FALSE)
training <- d2[inTrain,]
testing <- d2[-inTrain,]
dim(training)
set.seed(123);
fitControl <- trainControl(method = "repeatedcv",
                           number = 10,
                           repeats = 10
)


modFit


new_pred <- predict(modFit, testing)
confusionMatrix(new_pred, testing$classe)