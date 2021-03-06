% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_bbox.R
\name{get_bbox}
\alias{get_bbox}
\alias{get_bbox.sf}
\alias{get_bbox.RasterLayer}
\alias{get_coord_bbox}
\alias{get_bbox.default}
\title{Get bounding box for spatial vector data.}
\usage{
get_bbox(data = NULL, lat = NULL, lng = NULL, na.rm = NULL)

\method{get_bbox}{sf}(data, lat, lng, na.rm)

\method{get_bbox}{RasterLayer}(data, lat, lng, na.rm)

get_coord_bbox(data = NULL, lat, lng, na.rm = NULL)

\method{get_bbox}{default}(data = NULL, lat, lng, na.rm = NULL)
}
\arguments{
\item{data}{An object of class \code{sf} (see \link[sf:sf]{sf::st_sf}), an object of class
\code{RasterLayer} (see \link[raster:raster]{raster::raster}), a data frame containing latitude and
longitude values, or \code{NULL}.}

\item{lat}{If \code{data} is a data frame, the name of
the column containing latitude values. If \code{data} is \code{NULL}, a
vector of latitude values.}

\item{lng}{If \code{data} is a data frame, the name of
the column containing longitude values. If \code{data} is \code{NULL}, a
vector of longitude values.}

\item{na.rm}{Logical: Silently remove NA values? If \code{NULL}, the default,
will warn if there are NAs. If \code{FALSE}, will raise an error on NA.}
}
\value{
A \code{\link{terrainr_bounding_box}} object.
}
\description{
This function returns a \code{\link{terrainr_bounding_box}} object
representing the bottom left and upper right corners of the smallest
rectangle containing your data. If you only have one data point for either
latitude or longitude, this function will buffer it in both directions by
1e-10 in order to return a rectangle with a real "bottom left" and
"upper right".
}
\examples{
df <- data.frame(
  lat = c(44.05771, 44.18475),
  lng = c(-73.99212, -73.81515)
)
get_bbox(df, "lat", "lng")
get_bbox(lat = df$lat, lng = df$lng)
}
\seealso{
Other utilities: 
\code{\link{addbuff}},
\code{\link{calc_haversine_distance}()},
\code{\link{convert_distance}()},
\code{\link{deg_to_rad}()},
\code{\link{get_bbox_centroid}()},
\code{\link{point_from_distance}()},
\code{\link{rad_to_deg}()}
}
\concept{utilities}
