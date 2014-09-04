# Import the production data from Amazon S3

require(httr)
production<- read.csv(text=rawToChar( 
        GET(
                "https://s3.amazonaws.com/ACEO/production.csv"
        )[["content"]] ) )

names(production)

