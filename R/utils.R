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


base_url <- function() {
  "http://geo.weather.gc.ca/geomet-beta/features/collections"
}


geomet_client <- function(geomet_param = NULL) {
  param_url <- sprintf("%s/%s/items", base_url(), geomet_param)

  crul::HttpClient$new(url = param_url,
                       headers = list(`User-Agent` = "https://github.com/bcgov/geometr"))
}




## Issue a query of one to get the max number of records available
num_matched_records <- function(query_list, client){

  query_list <- c(query_list, limit = 1)

  res_max <- client$get(query = query_list)
  txt_max <- res_max$parse("UTF-8")
  jsonlite::fromJSON(txt_max)$numberMatched

}


# Argument checks ---------------------------------------------------------

check_date_format <- function(start_date = start_date, end_date = end_date) {
  if (!grepl(
    "[0-9]{4}-[0-1][0-9]-[0-3][0-9]",
    start_date
  )) {
    stop("Invalid date format. start_date need to be in either YYYY-MM-DD",
      call. = FALSE
    )
  }
  if (!grepl(
    "[0-9]{4}-[0-1][0-9]-[0-3][0-9]",
    end_date
  )) {
    stop("Invalid date format. end_date need to be in either YYYY-MM-DD",
      call. = FALSE
    )
  }

  if (!is.null(start_date) & !is.null(end_date)) {
    if (lubridate::ymd_hms(end_date) < lubridate::ymd_hms(start_date)) {
      stop("start_date is after end_date. Try swapping values.",
        call. = FALSE
      )
    }
  }
  if (is.na(as.Date(start_date, format = "%Y-%m-%d")) | is.na(as.Date(end_date, format = "%Y-%m-%d"))) {
    stop("Invalid date format. Dates need to be in YYYY-MM-DD format")
  }
}

stop_if_all_args_null <- function() {

  ## Original idea from: https://stackoverflow.com/a/14398674/5596534

  ## Set parent environment
  parent_env <- sys.parent()

  ## Get the formals from the parent environment
  parent_formals <- formals(fun = sys.function(parent_env))

  ## Eval those formals in the parent environment
  eval_formals <- mget(names(parent_formals), sys.frame(parent_env))

  ## Subset parameters to the API can't all be null
  args_to_check_if_null <- eval_formals[names(eval_formals) %in% c("bbox","time","station_number")]

  ## Determine which elements are null
  ## Makes sure we don't error if other no API call params aren't called
  null_list <- vapply(args_to_check_if_null, is.null, FUN.VALUE = logical(1))

  ## Throw error is all these are null
  if(all(null_list)) stop("At least one argument needs to be non NULL", call. = FALSE)

}


is_there_internet <- function(){
  if(!curl::has_internet()) stop("You do not appear to have a functioning internet connection")
}

