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
