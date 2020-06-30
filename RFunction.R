library('move')
library('foreach')

rFunction <- function(lon=NULL,lat=NULL,data)
{
  Sys.setenv(tz="GMT") 

  if (is.null(lon))
  {
    logger.info(paste0("No longitude range provided, extent of data used."))
    lon <- matrix(extent(data))[c(1,2),1]
  }
  
  if (is.null(lat))
  {
    logger.info(paste0("No latitude range provided, extent of data used."))
    lat <- matrix(extent(data))[c(3,4),1]
  }
  
  if (length(lon)!=length(lat)) 
  {
    logger.info("lon and lat have different length, please correct. Return full data set.")
    result <- data
  } else
  {
    logger.info(paste0("You have selected the longitude range: [",lon, "] and the latutude range [",lat,"]."))
    
    data.split <- split(data)
    filt <- foreach(datai = data.split) %do% {
      logger.info(namesIndiv(datai))
      coo <- coordinates(datai)
      datai[coo[,1] >= lon[1] & coo[,1] <= lon[2] & coo[,2]>= lat[1] & coo[,2]<= lat[2],]
    }
    names(filt) <- names(data.split)
    
    filt_nozero <- filt[unlist(lapply(filt, length) > 1)] 
    result <- moveStack(filt_nozero)
  }
  result
}
