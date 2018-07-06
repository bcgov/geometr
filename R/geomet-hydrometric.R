#' Query Water Survey of Canada data
#'
#' Query geomet webservice for hydrometric data
#'
#' @param station_number A seven digit Water Survey of Canada station number.
#' @param as_spatial Convert to sf object. Defaults to FALSE.
#'
#' @export
#'
#' @examples  geomet_stations("08MF005")

geomet_stations <- function(station_number = NULL, as_spatial = FALSE){

  stop_if_all_args_null()

  is_there_internet()

  cli <- geomet_client(geomet_param = "hydrometric-stations")

  res <- cli$get(query = list(STATION_NUMBER = station_number))

  txt <- res$parse("UTF-8")

  if(as_spatial) return(spatial_parse(txt))

  if(!as_spatial) tibble_parse(txt)

}

#' Query Water Survey of Canada data
#'
#' Query geomet webservice for hydrometric data
#'
#' @inheritParams geomet_stations
#'
#' @export
#'
#' @examples  geomet_daily_mean("08MF005")
geomet_daily_mean <- function(station_number = NULL, as_spatial = FALSE){

  stop_if_all_args_null()
  is_there_internet()


  cli <- geomet_client(geomet_param = "hydrometric-daily-mean")

  res <- cli$get(query = list(STATION_NUMBER = station_number))

  txt <- res$parse("UTF-8")

  if(as_spatial) return(spatial_parse(txt))

  if(!as_spatial) tibble_parse(txt)
}

#' Query Water Survey of Canada data
#'
#' Query geomet webservice for hydrometric data
#'
#' @inheritParams geomet_stations
#'
#' @export
#'
#' @examples  geomet_annual_stats("08MF005")
geomet_annual_stats <- function(station_number = NULL, as_spatial = FALSE) {

  stop_if_all_args_null()
  is_there_internet()

  cli <- geomet_client(geomet_param = "hydrometric-annual-statistics")

  res <- cli$get(query = list(STATION_NUMBER = station_number))

  txt <- res$parse("UTF-8")

  if(as_spatial) return(spatial_parse(txt))

  if(!as_spatial) tibble_parse(txt)
}

#' Query Water Survey of Canada data
#'
#' Query geomet webservice for hydrometric data
#'
#' @inheritParams geomet_stations
#'
#' @export
#'
#' @examples  geomet_annual_instant_peaks("08MF005")
geomet_annual_instant_peaks <- function(station_number = NULL, as_spatial = FALSE) {

  stop_if_all_args_null()
  is_there_internet()

  cli <- geomet_client(geomet_param = "hydrometric-annual-peaks")

  res <- cli$get(query = list(STATION_NUMBER = station_number))

  txt <- res$parse("UTF-8")

  if(as_spatial) return(spatial_parse(parsed_txt = txt))

  if(!as_spatial) tibble_parse(parsed_txt = txt)
}


#' Query Water Survey of Canada data
#'
#' Query geomet webservice for hydrometric data
#'
#' @inheritParams geomet_stations
#'
#' @export
#'
#' @examples geomet_monthly_mean("08MF005")
geomet_monthly_mean <- function(station_number = NULL, as_spatial = FALSE) {

  stop_if_all_args_null()
  is_there_internet()

  cli <- geomet_client(geomet_param = "hydrometric-monthly-mean")

  res <- cli$get(query = list(STATION_NUMBER = station_number))

  txt <- res$parse("UTF-8")

  if(as_spatial) return(spatial_parse(parsed_txt = txt))

  if(!as_spatial) tibble_parse(parsed_txt = txt)
}
