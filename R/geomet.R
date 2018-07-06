#' Collections available in the GeoMet webservice
#'
#' Outputs a tibble of the collections currently available via the webservice.
#'
#' @export

geomet_collection <- function() {
  cli <- crul::HttpClient$new(url = base_url())

  res <- cli$get()

  txt <- res$parse("UTF-8")

  parsed <- jsonlite::fromJSON(txt)

  parsed_tibble <- dplyr::as_tibble(parsed$collections)

  parsed_tibble$crs <- as.character(parsed_tibble$crs)

  parsed_tibble[, c("title", "name", "description", "extent", "crs", "links")]
}
