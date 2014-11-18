library(Hmisc)
library(randomForest)
library(gbm)
#library(e1071) included later because of function impute with the same name 
                # as input in Hmisc
library(ggplot2)

### Reading the data
train.column.types <- c('integer',   # PassengerId
                        'factor',    # Survived 
                        'factor',    # Pclass
                        'character', # Name
                        'factor',    # Sex
                        'numeric',   # Age
                        'integer',   # SibSp
                        'integer',   # Parch
                        'character', # Ticket
                        'numeric',   # Fare
                        'character', # Cabin
                        'factor'     # Embarked
)
test.column.types <- train.column.types[-2]     # # no Survived column in test.csv

train.raw <- read.table("data/raw/train.csv", colClasses=train.column.types, header = T, sep = ",")
df.train <- train.raw

test.raw <- read.table("data/raw/test.csv", colClasses=test.column.types, header = T, sep = ",")
df.test <- test.raw   


### Add title
getTitle <- function(data) {
    title.dot.start <- regexpr("\\,[A-Z ]{1,20}\\.", data$Name, TRUE)
    title.comma.end <- title.dot.start  + attr(title.dot.start, "match.length")-1
    data$Title <- substr(data$Name, title.dot.start+2, title.comma.end-1)
    return (data$Title)
}   
df.train$Title <- getTitle(df.train)
unique(df.train$Title)


### Fill Age by median for grouping by var.levels
imputeMedian <- function(impute.var, filter.var, var.levels) {
    for (v in var.levels) {
        impute.var[ which( filter.var == v)] <- impute(impute.var[ 
            which( filter.var == v)])
    }
    return (impute.var)
}
### Fill Age by median for grouping by title
df.train$Age <- imputeMedian(df.train$Age, df.train$Title, unique(df.train$Title))

### Fill Embarked with the most common "S"
df.train$Embarked[which(is.na(df.train$Embarked))] <- 'S'
df.train$Embarked[df.train$Embarked == ""] <- 'S'
levels(df.train$Embarked) <- c("S","C","Q","S") 


df.train$Age[is.na(df.train$Age)] <- median(df.train$Age, na.rm = TRUE)
df.train$Fare[df.train$Fare] <- median(df.train$Fare, na.rm = TRUE)
df.train$Title <- as.factor(df.train$Title)


### Test data
df.test$Title <- getTitle(df.test)
df.test$Age <- imputeMedian(df.test$Age, df.test$Title, unique(df.test$Title))
df.test$Embarked[which(is.na(df.test$Embarked))] <- 'S'
df.test$Embarked[df.test$Embarked == ""] <- 'S'

df.test$Age[is.na(df.test$Age)] <- median(df.test$Age, na.rm = TRUE)
df.test$Fare[is.na(df.test$Fare)] <- median(df.test$Fare, na.rm = TRUE)
df.test$Title <- as.factor(df.test$Title)


write.csv(train.raw, file = "data/processed/processed_train_data.csv")
write.csv(test.raw, file = "data/processed/processed_test_data.csv")

### GLM
source("glm_predict.R")

### Random Forest
source("random_forest.R")

### SVM
library(e1071)
source("svm.R")

### Naive
source("naive.R")

### Naive
source("visualize_data.R")
