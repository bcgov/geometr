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



## Parsing helpers for a basic output
parse_response <- function(parsed_txt, as_spatial) {

  ## Iterate over paginated results
  parsed <- purrr::map_dfr(parsed_txt, parsing_helper)

  ## Extract the list column which contains the coords
  coords <- as.data.frame(do.call(rbind, parsed$coordinates))

  ## Get rid of the original list column
  parsed$coordinates <- NULL
  parsed$type <- NULL

  colnames(coords) <- c("LONGITUDE","LATITUDE")

  ## Add the new separate columns to data non spatial
  if(!as_spatial) parsed <- dplyr::as_tibble(cbind(parsed, coords))

  ## Parsed to spatial data
  if(as_spatial){
    parsed <- cbind(parsed, coords)
    parsed <- sf::st_as_sf(parsed,
                           coords = c("LONGITUDE", "LATITUDE"),
                           agr = "constant", crs = 4236)

    class(parsed) <- c("sf", "tbl", "tbl_df", "data.frame")
  }

  if("DATE" %in% colnames(parsed)){
    ## Parse date correctly
    parsed$DATE <- as.Date(parsed$DATE, format="%Y-%m-%d")
    ## Sort by date
    parsed <- parsed[order(parsed$DATE),]
  }

  ## All lower case
  colnames(parsed) <- tolower(colnames(parsed))

  return(parsed)

}



parsing_helper <- function(x){
  list_obj <- jsonlite::fromJSON(x)

  geometry_obj <- list_obj$features$geometry

  properties_obj <- list_obj$features$properties

  cbind(properties_obj, geometry_obj)

}

