# Filter/Annotate by Bounding Box
MoveApps

Github repository: *github.com/movestore/FilterData-bySpace*

## Description
The location data are either filtered to lie within a user-given longitude/latitude square or annotated with 'in_bbox'.

## Documentation
Given user-provided latitude and longitude boundaries (bounding box), the input tracking data set is either filtered to all locations inside of those boundaries or all data are retained with an additional column 'in_bbox', indicating which locations lie within (in) or outside of (out) the bounding box. Tracks are contained.

### Input data
move2 location object

### Output data
move2 location object

### Artefacts
none

### Settings 
**Annotate data or filter (`filter`):** checkbox if the data shall be filtered or if the complete input data shall be returned with the additional column 'in_bbox'. Default: TRUE.

**left boundary (min longitude) (`lon1`):** minimum selected longitude (left boundary) to which the data shall be fitered. Unit: decimal degrees. Example: 5.2.

**right boundary (max longitude) (`lon2`):** maximum selected longitude (right boundary) to which the data shall be fitered. Unit: decimal degrees. Example: 11.5.

**lower boundary (min latitude) (`lat1`):** minimum selected latitude (lower boundary) to which the data shall be fitered. Unit: decimal degrees. Example: 51.8.

**upper boundary (max latitude) (`lat2`):** maximum selected latitude (upper boundary) to which the data shall be fitered. Unit: decimal degrees. Example: 55.0.

### Most common errors
Please make an issue [here](https://github.com/movestore/FilterData-bySpace/issues) if you encounter repeated errors.

### Null or error handling:
**Setting `lon1`:** if no left boundary is provided, the data extent into this direction is selected.

**setting `lon2`:** if no left boundary is provided, the data extent into this direction is selected.

**Setting `lat1`:** if no left boundary is provided, the data extent into this direction is selected.

**Setting `lat2`:** if no left boundary is provided, the data extent into this direction is selected.

:warning: If the longitude and latitude values are out of the earth's range (latitude -90 to +90, longitude -180 to +180) a warning is given and the data extent into the respecitve direction selected.

:warning: If the lower/left boundary is larger than the upper/right boundary, the values are switched and the data analysed accordingly. A warning is given.

**Data:** If there are no locations in the requested area, NULL is returned as output data set. The NULL return value likely gives and error.
