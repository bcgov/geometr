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

  crul::HttpClient$new(url = param_url,
                       headers = list(`User-Agent` = "https://github.com/bcgov/geometr"))
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

