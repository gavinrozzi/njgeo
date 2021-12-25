#' Geocode an address and retrieve all candidates using the NJOGIS ArcGIS REST API
#'
#' @param address First line of address. Don't use the other address arguments if geocoding a single line address
#' @param address2 Second line of address
#' @param address3 Third line of address
#' @param city Name of city or municipality
#' @param zip 5-digit ZIP code of city
#' @param crs Four digit coordinate reference system code. Defaults to 4326, 3424 and 4269 are also supported
#' @param max_results Max number of address candidates to return
#' @importFrom jsonlite fromJSON
#' @importFrom sf st_as_sf
#' @importFrom httr GET
#' @importFrom httr content
#'
#' @return
#' @export
#'
#' @examples
#' geocode_address_candidates(address = "33 Livingston Ave", city = "New Brunswick")
geocode_address_candidates <- function(address = NULL,
                                       address2 = NULL,
                                       address3 = NULL,
                                       city = NULL,
                                       zip = NULL,
                                       max_results = NULL,
                                       crs = 4326) {
  baseurl <- "https://geo.nj.gov/"


  response <- httr::GET(baseurl,
    path = "arcgis/rest/services/Tasks/NJ_Geocode/GeocodeServer/findAddressCandidates",
    query = list(
      f = "pjson",
      outSR = crs,
      Address = address,
      Address2 = address2,
      Address3 = address3,
      City = city,
      Postal = zip,
      maxLocations = max_results
    )
  )
  candidates <- jsonlite::fromJSON(httr::content(response, "text"), simplifyVector = TRUE, flatten = TRUE)

  candidates <- sf::st_as_sf(candidates[["candidates"]], coords = c("location.x", "location.y"), remove = FALSE, crs = crs)

  return(candidates)
}
