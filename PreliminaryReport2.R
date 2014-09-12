---
title: "Preliminary Report Task 2"
author: "Erich Orozco"
date: "Friday, September 12, 2014"
output: word_document
---

This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <http://rmarkdown.rstudio.com>.

When you click the **Knit** button a document will be generated that includes both content as well as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:

```{r}
# Import the production data from Amazon S3

require(httr)
production<- read.csv(text=rawToChar( 
        GET(
                "https://s3.amazonaws.com/ACEO/production.csv"
        )[["content"]] ) )

production$cost<-as.numeric(production$cost)
```

Here are the column names of the production data

```{r, echo=TRUE}
names(production)
```
Here is the average MACHINETIME and standard deviation for each production type

```{r, echo=TRUE}
require(plyr)
ddply(production,~PRODUCTCODE,summarise,mean=mean(MACHINETIME),sd=sd(MACHINETIME))

```
Here is the average ASSEMBLYTIME and standard deviation for each production type

```{r, echo=TRUE}
require(plyr)
ddply(production,~PRODUCTCODE,summarise,mean=mean(ASSEMBLYTIME),sd=sd(ASSEMBLYTIME))

```


Here is the average COST and standard deviation for each production type

```{r, echo=TRUE}
require(plyr)
ddply(production,~PRODUCTCODE,summarise,mean=mean(COST),sd=sd(COST))

```


