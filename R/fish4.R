#' extract cks1b abnormalities from cytogenetic FISH data
#'
#' @param df data frame with a column containing FISH strings
#' @param column name of column containing FISH strings, default="region_gene"
#' @export
#' @examples
#' df1 <- dplyr::tibble(fishstring=c("CKS1Bx3","CKS1Bx2","CKS1Bx1"))
#' df2 <- df1 |> fish4cks1b(column="fishstring")
fish4cks1b <- function(df, column="region_gene")
{
  locs <- df[[column]] |>  str_locate("CKS1Bx")

  df2 <- df |>
    #mutate(cks1b_repeat = .data[[substr(locs[,2]+1,locs[,2]+1)]])
    mutate(cks1b_repeat = str_sub(.data[[column]], locs[,2]+1, locs[,2]+1)) |>
    mutate(cks1b_normality = ifelse(cks1b_repeat==2,"normal",
                                    ifelse(is.na(cks1b_repeat),NA,
                                           "abnormal")))
}

#' extract del17p abnormalities from cytogenetic FISH data
#'
#' @param df data frame with a column containing FISH strings
#' @param column name of column containing FISH strings, default="region_gene"
#' @export
#' @examples
#' df1 <- dplyr::tibble(fishstring=c("17p13(TP53x1)","17p13(TP53x2)","17p13(TP53x3)"))
#' df2 <- df1 |> fish4del17p(column="fishstring")
fish4del17p <- function(df, column="region_gene")
{
  df2 <- df |>

  #fixed() for str_detect to detect literal string rather than regex
  mutate(del17p_normality =
           ifelse(str_detect(.data[[column]],fixed("17p13(TP53x1)")),"abnormal",
                  ifelse(str_detect(.data[[column]],fixed("17p13(TP53x2)")),"normal", NA)))

  #Conor said that for del17p
  #normal : "17p13(TP53x2)"
  #abnormal : "17p13(TP53x1)"
  #all others not relevant

  #old version looking for exact fragments BUT raw string needs to be broken up first
  # mutate(del17p_normality =
  #          ifelse(.data[[column]] == "17p13(TP53x1)","abnormal",
  #                 ifelse(.data[[column]] == "17p13(TP53x2)","normal", NA)))
}


#' extract ighfgfr3 abnormalities from cytogenetic FISH data
#'
#' @param df data frame with a column containing FISH strings
#' @param column name of column containing FISH strings, default="region_gene"
#' @export
#' @examples
#' df1 <- dplyr::tibble(fishstring=c("FGFR3 con IGH","anything else!"))
#' df2 <- df1 |> fish4ighfgfr3(column="fishstring")
fish4ighfgfr3 <- function(df, column="region_gene")
{
  df2 <- df |>
    mutate(ighfgfr3_normality = ifelse(str_detect(df[[column]],"FGFR3 con IGH"),"abnormal",NA))
}


#' extract ighmaf abnormalities from cytogenetic FISH data
#'
#' @param df data frame with a column containing FISH strings
#' @param column name of column containing FISH strings, default="region_gene"
#' @export
#' @examples
#' df1 <- dplyr::tibble(fishstring=c("IGH con MAF","anything else!"))
#' df2 <- df1 |> fish4ighmaf(column="fishstring")
fish4ighmaf <- function(df, column="region_gene")
{
  df2 <- df |>
    mutate(ighmaf_normality = ifelse(str_detect(df[[column]],"IGH con MAF"),"abnormal",NA))
}

#' extract ighccnd1 abnormalities from cytogenetic FISH data
#'
#' @param df data frame with a column containing FISH strings
#' @param column name of column containing FISH strings, default="region_gene"
#' @export
#' @examples
#' df1 <- dplyr::tibble(fishstring=c("CCND1 con IGH","IGH con CCND1","anything else"))
#' df2 <- df1 |> fish4ighccnd1(column="fishstring")
fish4ighccnd1 <- function(df, column="region_gene")
{
  #BEWARE "CCND1 con IGH" not other way
  df2 <- df |>
    mutate(ighccnd1_normality = ifelse(str_detect(df[[column]],"CCND1 con IGH"),"abnormal",NA))
}

#OLD TESTING CODE
#TODO - delete this soon

# library(dplyr)
# library(stringr)
#
# datafolder <- "S:/NIHR_HIC_Myeloma/working-omop-data/"
# filepath <- here::here(datafolder,"uclh-fish-data","MM Sample Results Anon.csv")
#
# fish <- data.frame(raw=readr::read_lines(filepath, skip = 1))
#
# fish2 <- fish |>
#   fish4del17p("raw") |>
#   fish4cks1b("raw") |>
#   fish4ighfgfr3("raw") |>
#   fish4ighmaf("raw") |>
#   fish4ighccnd1("raw")
#
# fish2 |> count(del17p_normality)
# # 1 abnormal           110
# # 2 normal             636
#
# fish2 |> count(cks1b_normality)
# # 1 abnormal          343
# # 2 normal            416
#
# fish2 |> count(ighfgfr3_normality)
# #1 abnormal           77
#
# fish2 |> count(ighmaf_normality)
# #1 abnormal            21
#
# fish2 |> count(ighccnd1_normality)
# #1 abnormal              16
