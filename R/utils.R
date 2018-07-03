is_there_internet <- function(){
  if(!curl::has_internet()) stop("You do not appear to have a functioning internet connection")
}


base_hydrometric <- "http://geo.weather.gc.ca/geomet-beta/features/collections/hydrometric-stations"
base_url <- "http://geo.weather.gc.ca/geomet-beta/features/collections"


