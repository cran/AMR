## ----setup, include = FALSE, results = 'markup'-------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#"
)
library(AMR)

## -----------------------------------------------------------------------------
custom <- custom_mdro_guideline(CIP == "R" & age > 60 ~ "Elderly Type A",
                                ERY == "R" & age > 60 ~ "Elderly Type B")

## -----------------------------------------------------------------------------
custom

## -----------------------------------------------------------------------------
x <- mdro(example_isolates, guideline = custom)
table(x)

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
# random_rsi() is a helper function to generate
# a random vector with values S, I and R
my_TB_data <- data.frame(rifampicin = random_rsi(5000),
                         isoniazid = random_rsi(5000),
                         gatifloxacin = random_rsi(5000),
                         ethambutol = random_rsi(5000),
                         pyrazinamide = random_rsi(5000),
                         moxifloxacin = random_rsi(5000),
                         kanamycin = random_rsi(5000))

## ---- eval = FALSE------------------------------------------------------------
#  my_TB_data <- data.frame(RIF = random_rsi(5000),
#                           INH = random_rsi(5000),
#                           GAT = random_rsi(5000),
#                           ETH = random_rsi(5000),
#                           PZA = random_rsi(5000),
#                           MFX = random_rsi(5000),
#                           KAN = random_rsi(5000))

## -----------------------------------------------------------------------------
head(my_TB_data)

## -----------------------------------------------------------------------------
my_TB_data$mdr <- mdr_tb(my_TB_data)

## ---- results = 'asis'--------------------------------------------------------
freq(my_TB_data$mdr)

