#library(randomForest)

#rf <- randomForest(Survived ~ Sex + Pclass + Age + SibSp + Fare + Embarked, 
#                   ntree = 10000, data = df.train)

rf <- randomForest(Survived ~ Sex + Pclass + Age + SibSp + Parch + Fare + Embarked, 
                   ntree = 10000, data = df.train)

PrTst <- predict(rf, df.test)

rf_result <- data.frame(df.test$PassengerId, PrTst)
colnames(rf_result) = c("PassengerId","Survived")
write.csv(rf_result, file = "solutions/RF_result.csv", row.names = FALSE)
