## ----setup, include = FALSE, results = 'markup'-------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#"
)
library(AMR)

## ---- message = FALSE---------------------------------------------------------
library(dplyr)   # to support pipes: %>%
library(cleaner) # to create frequency tables

## ---- results = 'hide'--------------------------------------------------------
example_isolates %>% 
  mdro() %>% 
  freq() # show frequency table of the result

## ---- echo = FALSE, results = 'asis', message = FALSE, warning = FALSE--------
example_isolates %>% 
  mdro(info = FALSE) %>% 
  freq() # show frequency table of the result

## -----------------------------------------------------------------------------
# a helper function to get a random vector with values S, I and R
# with the probabilities 50% - 10% - 40%
sample_rsi <- function() {
  sample(c("S", "I", "R"),
         size = 5000,
         prob = c(0.5, 0.1, 0.4),
         replace = TRUE)
}

my_TB_data <- data.frame(rifampicin = sample_rsi(),
                         isoniazid = sample_rsi(),
                         gatifloxacin = sample_rsi(),
                         ethambutol = sample_rsi(),
                         pyrazinamide = sample_rsi(),
                         moxifloxacin = sample_rsi(),
                         kanamycin = sample_rsi())

## ---- eval = FALSE------------------------------------------------------------
#  my_TB_data <- data.frame(RIF = sample_rsi(),
#                           INH = sample_rsi(),
#                           GAT = sample_rsi(),
#                           ETH = sample_rsi(),
#                           PZA = sample_rsi(),
#                           MFX = sample_rsi(),
#                           KAN = sample_rsi())

## -----------------------------------------------------------------------------
head(my_TB_data)

## -----------------------------------------------------------------------------
my_TB_data$mdr <- mdr_tb(my_TB_data)

## ---- results = 'asis'--------------------------------------------------------
freq(my_TB_data$mdr)

