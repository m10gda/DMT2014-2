GLM1 <- glm(formula = Survived ~ Sex + Pclass + Age + SibSp,
           data = df.train, family = "binomial"); # apply glm
summary(GLM1); # see GLM summary


GLM2 <- glm(formula = Survived ~ Sex + Pclass + Age + SibSp + Fare + Embarked,
           data = df.train, family = "binomial")
summary(GLM2)


PrTst <- predict(GLM1, df.test); # get prediction of survivors on TstSet
GLM1_res <- (sign(PrTst) + 1) / 2
GLM1_result <- data.frame(df.test$PassengerId, GLM1_res)
colnames(GLM1_result) = c("PassengerId","Survived")
write.csv(GLM1_result, file = "solutions/GLM1_result.csv", row.names = FALSE)



PrTst <- predict(GLM2, df.test); # get prediction of survivors on TstSet
GLM2_res <- (sign(PrTst) + 1) / 2
GLM2_result <- data.frame(df.test$PassengerId, GLM2_res)
colnames(GLM2_result) = c("PassengerId","Survived")
write.csv(GLM2_result, file = "solutions/GLM2_result.csv", row.names = FALSE)


GLM3 <- glm(formula = Survived ~ Sex + Pclass + Fare,
            data = df.train, family = "binomial")
PrTst <- predict(GLM3, df.test); # get prediction of survivors on TstSet
GLM3_res <- (sign(PrTst) + 1) / 2
GLM3_result <- data.frame(df.test$PassengerId, GLM3_res)
colnames(GLM3_result) = c("PassengerId","Survived")
write.csv(GLM3_result, file = "solutions/GLM3_result.csv", row.names = FALSE)