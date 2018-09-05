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
#'
#' @export
#'
#' @examples  geomet_daily_mean("08MF005")
geomet_daily_mean <- function(station_number = NULL, as_spatial = TRUE){

  query_list <-  list(STATION_NUMBER = station_number)

  stop_if_all_args_null()
  is_there_internet()


  cli <- geomet_client(geomet_param = "hydrometric-daily-mean")

  ## Total number of records available
  number_record <- num_matched_records(query_list, cli)

  (cc <- crul::Paginator$new(client = cli, by = "query_params", limit_param = "limit",
                       offset_param = "startindex", limit = number_record, limit_chunk = 10000))

  cc$get(query = query_list)

  txt <- cc$parse("UTF-8")

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
