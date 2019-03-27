## ----setup, include = FALSE, results = 'markup'--------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
# set to original language (English)
Sys.setlocale(locale = "C")
library(AMR)

## ---- warning = FALSE, message = FALSE-----------------------------------
# not all values are valid MIC values:
as.mic(0.125)
as.mic("testvalue")

# the Gram stain is avaiable for all bacteria:
mo_gramstain("E. coli")

# Klebsiella is intrinsic resistant to amoxicllin, according to EUCAST:
klebsiella_test <- data.frame(mo = "klebsiella", 
                              amox = "S",
                              stringsAsFactors = FALSE)
klebsiella_test
eucast_rules(klebsiella_test, info = FALSE)

# hundreds of trade names can be translated to an ATC or name:
atc_name("floxapen")
as.atc("floxapen")
atc_tradenames("floxapen")

## ---- eval = FALSE-------------------------------------------------------
#  SPSS_data
#  # # A tibble: 4,203 x 4
#  #     v001 sex       status    statusage
#  #    <dbl> <dbl+lbl> <dbl+lbl>     <dbl>
#  #  1 10002 1         1              76.6
#  #  2 10004 0         1              59.1
#  #  3 10005 1         1              54.5
#  #  4 10006 1         1              54.1
#  #  5 10007 1         1              57.7
#  #  6 10008 1         1              62.8
#  #  7 10010 0         1              63.7
#  #  8 10011 1         1              73.1
#  #  9 10017 1         1              56.7
#  # 10 10018 0         1              66.6
#  # # … with 4,193 more rows
#  
#  as_factor(SPSS_data)
#  # # A tibble: 4,203 x 4
#  #     v001 sex    status statusage
#  #    <dbl> <fct>  <fct>      <dbl>
#  #  1 10002 Male   alive       76.6
#  #  2 10004 Female alive       59.1
#  #  3 10005 Male   alive       54.5
#  #  4 10006 Male   alive       54.1
#  #  5 10007 Male   alive       57.7
#  #  6 10008 Male   alive       62.8
#  #  7 10010 Female alive       63.7
#  #  8 10011 Male   alive       73.1
#  #  9 10017 Male   alive       56.7
#  # 10 10018 Female alive       66.6
#  # # … with 4,193 more rows

## ---- eval = FALSE-------------------------------------------------------
#  # download and install the latest version:
#  install.packages("haven")
#  # load the package you just installed:
#  library(haven)

## ---- eval = FALSE-------------------------------------------------------
#  # read any SPSS file based on file extension (best way):
#  read_spss(file = "path/to/file")
#  
#  # read .sav or .zsav file:
#  read_sav(file = "path/to/file")
#  
#  # read .por file:
#  read_por(file = "path/to/file")

## ---- eval = FALSE-------------------------------------------------------
#  # save as .sav file:
#  write_sav(data = yourdata, path = "path/to/file")
#  
#  # save as compressed .zsav file:
#  write_sav(data = yourdata, path = "path/to/file", compress = TRUE)

## ---- eval = FALSE-------------------------------------------------------
#  # read .sas7bdat + .sas7bcat files:
#  read_sas(data_file = "path/to/file", catalog_file = NULL)
#  
#  # read SAS transport files (version 5 and version 8):
#  read_xpt(file = "path/to/file")

## ---- eval = FALSE-------------------------------------------------------
#  # save as regular SAS file:
#  write_sas(data = yourdata, path = "path/to/file")
#  
#  # the SAS transport format is an open format
#  # (required for submission of the data to the FDA)
#  write_xpt(data = yourdata, path = "path/to/file", version = 8)

## ---- eval = FALSE-------------------------------------------------------
#  # read .dta file:
#  read_stata(file = "/path/to/file")
#  
#  # works exactly the same:
#  read_dta(file = "/path/to/file")

## ---- eval = FALSE-------------------------------------------------------
#  # save as .dta file, Stata version 14:
#  # (supports Stata v8 until v15 at the time of writing)
#  write_dta(data = yourdata, path = "/path/to/file", version = 14)

