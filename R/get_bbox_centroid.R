#' Get the great-circle centroid for a given bounding box.
#'
#' @param bbox The bounding box to find a centroid for. If not already
#' a \code{\link{terrainr_bounding_box}} object, will be converted.
#'
#' @keywords internal
#'
#' @family utilities
#'
#' @return A \code{\link{terrainr_coordinate_pair}}.
#'
#' @examples
#' get_bbox_centroid(
#'   list(
#'     c(lat = 44.04905, lng = -74.01188),
#'     c(lat = 44.17609, lng = -73.83493)
#'   )
#' )
#' @export
get_bbox_centroid <- function(bbox) {
  if (!methods::is(bbox, "terrainr_bounding_box")) {
    bbox <- terrainr::terrainr_bounding_box(bbox[[1]], bbox[[2]])
  }

  lat <- c(bbox@bl@lat, bbox@tr@lat)
  lng <- c(bbox@bl@lng, bbox@tr@lng)

  lat <- terrainr::deg_to_rad(lat)
  lng <- terrainr::deg_to_rad(lng)

  x <- sum(cos(lat) * cos(lng)) / length(lat)
  y <- sum(cos(lat) * sin(lng)) / length(lat)
  z <- sum(sin(lat)) / length(lat)
  lng <- atan2(y, x)
  lat <- atan2(z, sqrt(x * x + y * y))

  lat <- terrainr::rad_to_deg(lat)
  lng <- terrainr::rad_to_deg(lng)

  return(terrainr::terrainr_coordinate_pair(c(lat = lat, lng = lng)))
}
