
<!-- README.md is generated from README.Rmd. Please edit that file -->
<!-- use devtools::build_readme() -->

# fish4myeloma

<!-- badges: start -->
<!-- badges: end -->

**Early development 2024, breaking changes likely** **Preliminary
abnormality detection not yet finalised**

**fish4myeloma** extracts Myeloma abnormalities from cytogenetic
[FISH](https://en.wikipedia.org/wiki/Fluorescence_in_situ_hybridization)
(Fluorescence in situ hybridization) data represented in strings
according to the
[ISCN](https://en.wikipedia.org/wiki/International_System_for_Human_Cytogenomic_Nomenclature)
standardised nomenclature.

## Installation

You can install the development version of fish4myeloma from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("andysouth/fish4myeloma")
```

## Example

### detect abnormalities in simple test data

``` r
library(fish4myeloma)

## make some simple test data
fish_raw <- dplyr::tibble(test_id = c(1:5),
                          fishstring=c("17p13(TP53x3) CKS1Bx3",
                                       "17p13(TP53x2) CKS1Bx2",
                                       "17p13(TP53x1) CKS1Bx1 FGFR3 con IGH",
                                       "IGH con MAF",
                                       "CCND1 con IGH"
                          ))

fish_processed <- fish_raw |>
   fish4del17p("fishstring") |>
   fish4cks1b("fishstring") |>
   fish4ighfgfr3("fishstring") |>
   fish4ighmaf("fishstring") |>
   fish4ighccnd1("fishstring")

knitr::kable(fish_processed)
```

| test_id | fishstring                          | del17p_normality | cks1b_repeat | cks1b_normality | ighfgfr3_normality | ighmaf_normality | ighccnd1_normality |
|--------:|:------------------------------------|:-----------------|:-------------|:----------------|:-------------------|:-----------------|:-------------------|
|       1 | 17p13(TP53x3) CKS1Bx3               | NA               | 3            | abnormal        | NA                 | NA               | NA                 |
|       2 | 17p13(TP53x2) CKS1Bx2               | normal           | 2            | normal          | NA                 | NA               | NA                 |
|       3 | 17p13(TP53x1) CKS1Bx1 FGFR3 con IGH | abnormal         | 1            | abnormal        | abnormal           | NA               | NA                 |
|       4 | IGH con MAF                         | NA               | NA           | NA              | NA                 | abnormal         | NA                 |
|       5 | CCND1 con IGH                       | NA               | NA           | NA              | NA                 | NA               | abnormal           |

### map abnormalities to OMOP ids, one per abnormality

(omop ids not added yet, can have in a lookup table from name)

``` r

fish_omop <- fish_processed |> fish2omop() 

knitr::kable(fish_omop)
```

| test_id | fishstring                          | name               | value    |
|--------:|:------------------------------------|:-------------------|:---------|
|       1 | 17p13(TP53x3) CKS1Bx3               | cks1b_normality    | abnormal |
|       3 | 17p13(TP53x1) CKS1Bx1 FGFR3 con IGH | del17p_normality   | abnormal |
|       3 | 17p13(TP53x1) CKS1Bx1 FGFR3 con IGH | cks1b_normality    | abnormal |
|       3 | 17p13(TP53x1) CKS1Bx1 FGFR3 con IGH | ighfgfr3_normality | abnormal |
|       4 | IGH con MAF                         | ighmaf_normality   | abnormal |
|       5 | CCND1 con IGH                       | ighccnd1_normality | abnormal |
