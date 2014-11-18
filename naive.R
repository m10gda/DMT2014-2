PrTst <- sapply(1:dim(df.test)[1], function(x){
    if(df.test[x,"Sex"] == "female" | (df.test[x,"Age"] < 14 
                                       & df.train[x,"Pclass"] != 3) ){
        1
    }else{
        0
    }
})
naive_result <- data.frame(df.test$PassengerId, PrTst)
colnames(naive_result) = c("PassengerId","Survived")
write.csv(naive_result, file = "solutions/Naive_result.csv", row.names = FALSE)
