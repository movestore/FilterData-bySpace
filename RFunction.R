library('move')
library('foreach')

rFunction <- function(lon1=NULL,lon2=NULL,lat1=NULL,lat2=NULL,data)
{
  Sys.setenv(tz="UTC") 

  if (is.null(lon1))
  {
    logger.info(paste0("No left boundary (lon1) provided, extent of data used."))
    lon1 <- matrix(extent(data))[c(1),1]
  }
  if (is.null(lon2))
  {
    logger.info(paste0("No right boundary (lon2) provided, extent of data used."))
    lon2 <- matrix(extent(data))[c(2),1]
  }
  
  if (is.null(lat1))
  {
    logger.info(paste0("No lower boundary (lat1) provided, extent of data used."))
    lat1 <- matrix(extent(data))[c(3),1]
  }
  if (is.null(lat2))
  {
    logger.info(paste0("No upper boundary (lat2) provided, extent of data used."))
    lat2 <- matrix(extent(data))[c(4),1]
  }
  
  if (lon1>lon2)
  {
    logger.info("Warning! Your lon1 is larger than lon2. We switch them and filter the data accordingly.")
    lon20 <- lon2
    lon2 <- lon1
    lon1 <- lon20
  }
  if (lat1>lat2)
  {
    logger.info("Warning! Your lat1 is larger than lat2. We switch them and filter the data accordingly.")
    lat20 <- lat2
    lat2 <- lat1
    lat1 <- lat20
  }

  if (lon1<(-180))
  {
    logger.info("Your left boundary (lon1) is out of the earth's defined range. No filtering in this direction.")
    lon1 <- matrix(extent(data))[c(1),1]
  }
  if (lon2>180)
  {
    logger.info("Your right boundary (lon2) is out of the earth's defined range. No filtering in this direction.")
    lon2 <- matrix(extent(data))[c(2),1]
  }
  
  if (lat1<(-90))
  {
    logger.info("Your lower boundary (lat1) is out of the earth's defined range. No filtering in this direction.")
    lat1 <- matrix(extent(data))[c(3),1]
  }
  if (lat2>90)
  {
    logger.info("Your upper boundary (lat2) is out of the earth's defined range. No filtering in this direction.")
    lat2 <- matrix(extent(data))[c(4),1]
  }
  
  logger.info(paste0("You have selected the longitude range: [",round(lon1,2),",",round(lon2,2),"] and the latitude range [",round(lat1,2),",",round(lat2,2),"]."))
    
  data.split <- move::split(data)
  filt <- foreach(datai = data.split) %do% {
    logger.info(namesIndiv(datai))
    coo <- coordinates(datai)
    datai[coo[,1] >= lon1 & coo[,1] <= lon2 & coo[,2]>= lat1 & coo[,2]<= lat2,]
  }
  names(filt) <- names(data.split)
    
  filt_nozero <- filt[unlist(lapply(filt, length) > 0)]
  if (length(filt_nozero)==0) 
    {
    logger.info("Your output file contains no positions. Return NULL.")
    result <- NULL
    } else result <- moveStack(filt_nozero) #this gives timestamp error if empty list
  result
}
