# Copyright 2018 Province of British Columbia
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and limitations under the License.



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

geomet_stations <- function(station_number = NULL, as_spatial = TRUE){

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
#' @param start_date Accepts either YYYY-MM-DD. If this argument is left missing, the function will return all data prior to \code{end_date}. If both are NULL all
#' available data is returned.
#' @param end_date Accepts either YYYY-MM-DD. If this argument is left missing, the function will return all data after \code{start_date}. If both are NULL all
#' available data is returned.
#' @param page_limit Default to 500. You likely will not need to change this value. This represents the maximum number of records that can be requested
#'                   for each pagination request.
#' @param verbose Defaults to FALSE. Do you want the URLs used to make the GET call to be printed?
#'
#' @export
#'
#' @examples
#' geomet_daily_mean("10PC003")
#'
#' geomet_daily_mean("10PC003", start_date = "1983-07-04")
geomet_daily_mean <- function(station_number = NULL, as_spatial = TRUE, start_date = NULL, end_date = NULL, page_limit = 500, verbose = FALSE){

  ## Argument Checks
  stop_if_all_args_null()
  is_there_internet()
  check_date_format(start_date, end_date)
  date_range <- handle_dates(start_date = start_date, end_date = end_date)

  ## Refine query list
  query_list <-  list(STATION_NUMBER = multi_stations(station_number),
                      time = date_range)
  ## Drop any NULLS from the list
  query_list <- Filter(Negate(is.null), query_list)


  cli <- geomet_client(geomet_param = "hydrometric-daily-mean")

  ## Total number of records available
  number_record <- num_matched_records(query_list, cli)

  cc <- crul::Paginator$new(client = cli, by = "query_params", limit_param = "limit",
                       offset_param = "startindex", limit = number_record, limit_chunk = page_limit)

  cc$get(query = query_list)

  if(compareVersion(as.character(packageVersion("crul")), "0.6.0.9310") <= 0 && verbose) cat("Paginated URLs:\n", paste0(cc$url_fetch(),"\n"))

  txt <- cc$parse("UTF-8")

  parse_response(txt, as_spatial)
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
