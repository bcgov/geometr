#' Query Water survey of Canada stations
#'
#' Query geospatial webservice for hydrometric data
#'
#' @param STATION_NUMBER 7 digit unique station ID
#' @param as_spatial Convert to sf object
#'
#' @export

geo_stations <- function(STATION_NUMBER = NULL, as_spatial = FALSE){

  is_there_internet()

  cli <- crul::HttpClient$new(url = paste0(base_url,"/hydrometric-stations/items"))
  # do a GET request
  res <- cli$get(query = list(STATION_NUMBER = STATION_NUMBER))

  res$raise_for_status()
  # parse response to plain text (JSON in this case) - most likely you'll

  txt <- res$parse("UTF-8")

  if(as_spatial) return(sf::read_sf(txt))

  if(!as_spatial){
    # parse to json
    parsed <- jsonlite::fromJSON(txt)

    lat_long_strings <- parsed[["features"]][["geometry"]][["coordinates"]][[1]]

    cbind(parsed[["features"]][["properties"]],
          LATITUDE = lat_long_strings[2],
          LONGITUDE = lat_long_strings[1])
  }
}


geo_daily_flows <- function(STATION_NUMBER = NULL, as_spatial = FALSE){

  is_there_internet()

  (cli <- crul::HttpClient$new(url = paste0(base_url,"/hydrometric-daily-mean/items")))

  # cli_pag <- crul::Paginator$new(cli,
  #                                by = "query_params",
  #                                limit_param = "limit",
  #                                offset_param = "startindex",
  #                                limit = 10,
  #                                limit_chunk = 10)


  res <- cli$get(query = list(STATION_NUMBER = STATION_NUMBER))

  res$raise_for_status()
  # parse response to plain text (JSON in this case) - most likely you'll

  txt <- res$parse("UTF-8")

  if(as_spatial) return(sf::read_sf(txt))

  if(!as_spatial){
    # parse to json
    parsed <- jsonlite::fromJSON(txt)

    lat_long_strings <- parsed[["features"]][["geometry"]][["coordinates"]][[1]]

    cbind(parsed[["features"]][["properties"]],
          LATITUDE = lat_long_strings[2],
          LONGITUDE = lat_long_strings[1])
  }
}

