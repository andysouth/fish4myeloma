#' loinc codes for FISH myeloma abnormalities
#'
#' quick fix, may want to store as data instead
#'
# @param no params
#' @export
#' @examples
#' #
fishmloinc <- function()
{

  #I don't want this package to rely on omopcept at start
  #so hardcoding in to start
  #some codes may change later

  df1 <- dplyr::tibble(
    abnormality=c("cks1b","del17p","ighfgfr3","ighmaf","ighccnd1"),
    loinc_fish=c("81752-8","81746-0","72726-3","77033-9","77037-0"))

  #todo could use omopcept to get concept_names in here too
  #omop_codes(df1$loinc_fish[1])
}
