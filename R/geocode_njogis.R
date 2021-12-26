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
#' @importFrom httr http_error
#' @importFrom curl has_internet
#'
#' @return an sf object with geocoded address candidates for a single address
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
  # URL of state geocoding service
  baseurl <- "https://geo.nj.gov/"

  # Check if internet connection exists before attempting data download
  if (curl::has_internet() == FALSE) {
    message("No internet connection. Please connect to the internet and try again.")
    return(NULL)
  }

  # Check if data is available and download the data
  if (httr::http_error(baseurl)) {
    message("Data source broken. Please try again.")
    return(NULL)
  } else {
    message("njgeo: downloading data")
    # Construct the API call
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
  }

  candidates <- jsonlite::fromJSON(httr::content(response, "text"), simplifyVector = TRUE, flatten = TRUE)

  candidates <- sf::st_as_sf(candidates[["candidates"]], coords = c("location.x", "location.y"), remove = FALSE, crs = crs)

  return(candidates)
}


