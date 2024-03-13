

#TODO start by getting this to do all
#want to get from rows to columns
#have mapping file as a csv
#start by working on columns containing _normality
#widen
#filter on abnormal
#map2omop

#' map fish myeloma abnormalities to OMOP from cytogenetic FISH data
#'
#' @param df data frame with columns containing FISH abnormalities
#' @export
#' @examples
#' #
fish2omop <- function(df)
{

  df2 <- df |>
    #TODO decide how to filter next better
    select(!cks1b_repeat) |>
    pivot_longer(cols=ends_with("normality"), names_to="abnormality") |>
    filter(value=="abnormal") |>
    mutate(abnormality=str_remove(abnormality,"_normality")) |>
    #to join on loinc code
    left_join(fishmloinc())


  #todo left join *_normality with a lookup table of omop IDs

}
