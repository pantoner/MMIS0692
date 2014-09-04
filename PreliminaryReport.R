## https://s3.amazonaws.com/ACEO/production.txt

require(httr)
production2<- read.csv(text=rawToChar( 
        GET(
                "https://s3.amazonaws.com/ACEO/production.txt"
        )[["content"]] ) )


