#library(e1071)

s <- svm(Survived ~ Sex + Pclass + Age + SibSp + Fare + Embarked, 
         data = df.train, type='C-classification')

o <- tune.svm(Survived ~ Sex + Pclass + Age + SibSp + Fare + Embarked, 
              data = df.train, gamma = 2^(-8:-4), cost = 2^(5:10), k=10,
              kernel="radial", best.model=TRUE)

#summary(o)
#plot(o)

bm <- o$best.model
bp <- o$best.parameter

model <- svm(Survived ~ Sex + Pclass + Age + SibSp + Fare + Embarked, 
             data = df.train, cost=bp$cost, gamma=bp$gamma, 
             type="C-classification")

p.train <- predict(model, newdata = df.train)
p.test <- predict(model, newdata = df.test)

svm_result <- data.frame(df.test$PassengerId, p.test)
colnames(svm_result) = c("PassengerId","Survived")
write.csv(svm_result, file = "solutions/SVM_result.csv", row.names = FALSE)

