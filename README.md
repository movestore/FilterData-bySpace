# Filter by Bounding Box
MoveApps

Github repository: *github.com/movestore/FilterData-bySpace*

## Description
The Movement data are filtered to lie within a user-given longitude/latitude square.

## Documentation
Given user-provided latitude and longitude boundaries, the input Movement data set is filtered to all locations inside of those boundaries.

### Input data
moveStack in Movebank format

### Output data
moveStack in Movebank format

### Artefacts
none

### Settings 
**left boundary (min longitude) (`lon1`):** minimum selected longitude (left boundary) to which the data shall be fitered. Unit: decimal degrees. Example: 5.2.

**right boundary (max longitude) (`lon2`):** maximum selected longitude (right boundary) to which the data shall be fitered. Unit: decimal degrees. Example: 11.5.

**lower boundary (min latitude) (`lat1`):** minimum selected latitude (lower boundary) to which the data shall be fitered. Unit: decimal degrees. Example: 51.8.

**upper boundary (max latitude) (`lat2`):** maximum selected latitude (upper boundary) to which the data shall be fitered. Unit: decimal degrees. Example: 55.0.

### Null or error handling:
**Setting `lon1`:** if no left boundary is provided, the data extent into this direction is selected.

**setting `lon2`:** if no left boundary is provided, the data extent into this direction is selected.

**Setting `lat1`:** if no left boundary is provided, the data extent into this direction is selected.

**Setting `lat2`:** if no left boundary is provided, the data extent into this direction is selected.

:warning: If the longitude and latitude values are out of the earth's range (latitude -90 to +90, longitude -180 to +180) a warning is given and the data extent into the respecitve direction selected.

:warning: If the lower/left boundary is larger than the upper/right boundary, the values are switched and the data analysed accordingly. A warning is given.

**Data:** If there are no locations in the requested area, NULL is returned as output data set. The NULL return value likely gives and error.
