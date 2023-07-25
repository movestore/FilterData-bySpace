library('move2')
library('foreach')
library('sf')

rFunction <- function(lon1=NULL,lon2=NULL,lat1=NULL,lat2=NULL,filter=TRUE,data)
{
  Sys.setenv(tz="UTC") 

  if (is.null(lon1))
  {
    logger.info(paste0("No left boundary (lon1) provided, extent of data used."))
    lon1 <- as.numeric(st_bbox(data)[1])
  }
  if (is.null(lon2))
  {
    logger.info(paste0("No right boundary (lon2) provided, extent of data used."))
    lon2 <- as.numeric(st_bbox(data)[3])
  }
  
  if (is.null(lat1))
  {
    logger.info(paste0("No lower boundary (lat1) provided, extent of data used."))
    lat1 <- as.numeric(st_bbox(data)[2])
  }
  if (is.null(lat2))
  {
    logger.info(paste0("No upper boundary (lat2) provided, extent of data used."))
    lat2 <- as.numeric(st_bbox(data)[4])
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
    lon1 <- as.numeric(st_bbox(data)[1])
  }
  if (lon2>180)
  {
    logger.info("Your right boundary (lon2) is out of the earth's defined range. No filtering in this direction.")
    lon2 <- as.numeric(st_bbox(data)[3])
  }
  
  if (lat1<(-90))
  {
    logger.info("Your lower boundary (lat1) is out of the earth's defined range. No filtering in this direction.")
    lat1 <- as.numeric(st_bbox(data)[2])
  }
  if (lat2>90)
  {
    logger.info("Your upper boundary (lat2) is out of the earth's defined range. No filtering in this direction.")
    lat2 <- as.numeric(st_bbox(data)[4])
  }
  
  logger.info(paste0("You have selected the longitude range: [",round(lon1,2),",",round(lon2,2),"] and the latitude range [",round(lat1,2),",",round(lat2,2),"]."))
   
  if (filter==TRUE) logger.info("Data will be filtered to only return those in the bounding box.") else logger.info("Input data with annotation 'in_bbox' will be returned. Locations in the bounding box are indicated as 'in', others 'out'.")
   
  data.split <- split(data,mt_track_id(data))
  filt <- foreach(datai = data.split) %do% {
    logger.info(unique(mt_track_id(datai)))
    coo <- st_coordinates(datai)
    if (filter==TRUE) 
    {
      datai[coo[,1] >= lon1 & coo[,1] <= lon2 & coo[,2]>= lat1 & coo[,2]<= lat2,] 
    } else 
    {
      ix <- which(coo[,1] >= lon1 & coo[,1] <= lon2 & coo[,2]>= lat1 & coo[,2]<= lat2)
      datai$in_bbox <- NA
      datai$in_bbox[ix] <- "in"
      datai$in_bbox[-ix] <- "out"
      datai
    }
  }
  names(filt) <- names(data.split)
    
  result <- mt_stack(filt,.track_combine="rename")
  if (dim(result)[1]==0)
  {
    logger.info("Your output file contains no positions. Return NULL.")
    result <- NULL
  }

  result
}
