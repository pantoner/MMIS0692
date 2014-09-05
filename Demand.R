# Import the demand data from Amazon S3

demand<- read.csv(text=rawToChar( 
        GET(
                "https://s3.amazonaws.com/ACEO/demand.csv"
        )[["content"]] ) )

names(demand)
