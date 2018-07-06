is_there_internet <- function(){
  if(!curl::has_internet()) stop("You do not appear to have a functioning internet connection")
}


base_url <- function() {
  "http://geo.weather.gc.ca/geomet-beta/features/collections"
}

tibble_parse <- function(parsed_txt) {

  parsed <- jsonlite::fromJSON(parsed_txt)

  lat_long_strings <- parsed[["features"]][["geometry"]][["coordinates"]][[1]]

  no_spatial_parsed <- cbind(parsed[["features"]][["properties"]],
                             LATITUDE = lat_long_strings[2],
                             LONGITUDE = lat_long_strings[1]
  )

  dplyr::as_tibble(no_spatial_parsed)
}

spatial_parse <- function(parsed_txt, ...) {

  sf::read_sf(parsed_txt, stringsAsFactors = FALSE, quiet = TRUE, ...)

}

geomet_client <- function(geomet_param = NULL) {
  param_url <- sprintf("%s/%s/items", base_url(), geomet_param)

  crul::HttpClient$new(param_url)
}

