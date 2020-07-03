library('move')
library('foreach')

rFunction <- function(lon1=NULL,lon2=NULL,lat1=NULL,lat2=NULL,data)
{
  Sys.setenv(tz="GMT") 

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
  
  logger.info(paste0("You have selected the longitude range: [",lon1,",",lon2,"] and the latutude range [",lat1,",",lat2,"]."))
    
  data.split <- move::split(data)
  filt <- foreach(datai = data.split) %do% {
    logger.info(namesIndiv(datai))
    coo <- coordinates(datai)
    datai[coo[,1] >= lon1 & coo[,1] <= lon2 & coo[,2]>= lat1 & coo[,2]<= lat2,]
  }
  names(filt) <- names(data.split)
    
  filt_nozero <- filt[unlist(lapply(filt, length) > 1)] 
  result <- moveStack(filt_nozero)
}
