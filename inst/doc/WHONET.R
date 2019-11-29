## ----setup, include = FALSE, results = 'markup'-------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#",
  fig.width = 7.5,
  fig.height = 4.5
)

## ---- eval = FALSE------------------------------------------------------------
#  library(readxl)
#  data <- read_excel(path = "path/to/your/file.xlsx")

## ---- message = FALSE---------------------------------------------------------
library(dplyr)   # part of tidyverse
library(ggplot2) # part of tidyverse
library(AMR)     # this package

## -----------------------------------------------------------------------------
# transform variables
data <- WHONET %>%
  # get microbial ID based on given organism
  mutate(mo = as.mo(Organism)) %>% 
  # transform everything from "AMP_ND10" to "CIP_EE" to the new `rsi` class
  mutate_at(vars(AMP_ND10:CIP_EE), as.rsi)

## ---- results = 'asis'--------------------------------------------------------
# our newly created `mo` variable, put in the mo_name() function
data %>% freq(mo_name(mo), nmax = 10)

## ---- results = 'asis'--------------------------------------------------------
# our transformed antibiotic columns
# amoxicillin/clavulanic acid (J01CR02) as an example
data %>% freq(AMC_ND2)

## ---- eval = FALSE------------------------------------------------------------
#  data %>%
#    group_by(Country) %>%
#    select(Country, AMP_ND2, AMC_ED20, CAZ_ED10, CIP_ED5) %>%
#    ggplot_rsi(translate_ab = 'ab', facet = "Country", datalabels = FALSE)

## ---- echo = FALSE------------------------------------------------------------
# on very old and some new releases of R, this may lead to an error
tryCatch(data %>%
           group_by(Country) %>%
           select(Country, AMP_ND2, AMC_ED20, CAZ_ED10, CIP_ED5) %>%
           ggplot_rsi(translate_ab = 'ab', facet = "Country", datalabels = FALSE) %>%
           print(),
         error = function(e) base::invisible())

