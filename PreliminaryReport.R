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
?lp
#example

# this sets up the LP Model -  (Number of constraints , decision variables)

# X_1:         	Number of units of AS1 produced through regular run.
# X_2: 		Number of units of AS2 produced through regular run.
# X_3: 		Number of units of AS3 produced through regular run.
# Y_1: 		Number of units of AS1 produced through special run.
# Y_2: 		Number of units of AS2 produced through special run.
# Y_3: 		Number of units of AS3 produced through special run. 


# Constraints are 
# Demand for AS1, Demand for AS2: Demand for AS3:
# Machining time constraint: Assembly time constraint: Finishing time constraint:        

# Decision variables are Regular A1, A2, A3 and Special A1, A2, A3

# Objective Function is to 
# Minimize total production cost = Cost under regular run + Cost under special run. 
# Cost = Specify an appropriate linear function of the decisions variables and parameters.

#test
#add estimates to solve

lprec <- make.lp(4, 3)
set.objfn(lprec, c(1, 3, 6.24))
add.constraint(lprec, c(0, 78.26, 1), "<=", 800)
add.constraint(lprec, c(0.24, 0, 11.31), "<=", 700)
add.constraint(lprec, c(12.68, 0, 0.08), "<=", 500)
add.constraint(lprec, c(12.68, 0, 0.08), ">=", 0)
set.bounds(lprec, lower = c(28.6, 18), columns = c(1, 4))
set.bounds(lprec, upper = 48.98, columns = 4)
RowNames <- c("Machine Time", "Assembly Time", "Finish Time" ,"Cost" )
ColNames <- c("AS1", "AS2", "AS3")
dimnames(lprec) <- list(RowNames, ColNames)

solve(lprec)
get.objective(lprec)

get.variables(lprec)

get.constraints(lprec)

print(lprec)

library(lpSolveAPI)
library(lpSolve)
?lpSolve
?make.lp
?set.objfn
?add.constraint
?set.bounds

#create an LP model with 10 constraints and 12 decision variables

lpmodel&lt;-make.lp(2*NROW(train)+NROW(cargo),12)

#I used this to keep count within the loops, I admit that this could be done a lot neater
column&lt;-0
row&lt;-0

#build the model column per column
for(wg in train$wagon){
        row&lt;-row+1
        for(type in seq(1,NROW(cargo$type))){
                column&lt;-column+1
                
                #this takes the arguments 'column','values' &amp; 'indices' (as in where these values should be placed in the column)
                set.column(lpmodel,column,c(1, cargo[type,'volume'],1), indices=c(row,NROW(train)+row, NROW(train)*2+type))
        }}

#set rhs weight constraints
set.constr.value(lpmodel, rhs=train$weightcapacity, constraints=seq(1,NROW(train)))

#set rhs volume constraints
set.constr.value(lpmodel, rhs=train$spacecapacity, constraints=seq(NROW(train)+1,NROW(train)*2))


#set rhs volume constraints
set.constr.value(lpmodel, rhs=cargo$available, constraints=seq(NROW(train)*2+1,NROW(train)*2+NROW(cargo)))

#set objective coefficients
set.objfn(lpmodel, rep(cargo$profit,NROW(train)))

#set objective direction
lp.control(lpmodel,sense='max')

#I in order to be able to visually check the model, I find it useful to write the model to a text file
write.lp(lpmodel,'model.lp',type='lp')


avg
