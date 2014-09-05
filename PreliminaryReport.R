# Import the production data from Amazon S3

require(httr)
production<- read.csv(text=rawToChar( 
        GET(
                "https://s3.amazonaws.com/ACEO/production.csv"
        )[["content"]] ) )

names(production)
# convert from factor to character
as.character(production$COST)

require(stringr)
#drop dollar sign

cost<-stri_sub(production$COST,2)
#convert cost to numeric
production$COST<-as.numeric(cost)
#convert Machinetime, assemblytime and FINISHTIME to numeric
production$MACHINETIME<- as.numeric(production$MACHINETIME)
production$ASSEMBLYTIME<- as.numeric(production$ASSEMBLYTIME)
production$FINISHTIME<- as.numeric(production$FINISHTIME)
# run Multiple Linear Regression 
lm.fit =lm(COST???PRODUCTCODE + MACHINETIME + ASSEMBLYTIME + FINISHTIME ,data=production )
#results
summary(lm.fit)
coef(lm.fit)
confint (lm.fit)
install.packages("lpSolve")
install.packages("lpSolveAPI")
require(lpSolve)
library(lpSolveAPI)
?lpSolve
