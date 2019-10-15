## ----setup, include = FALSE, results = 'markup'--------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#",
  fig.width = 7.5,
  fig.height = 4.75
)

## ----lib packages, message = FALSE---------------------------------------
library(dplyr)
library(ggplot2)
library(AMR)

# (if not yet installed, install with:)
# install.packages(c("tidyverse", "AMR"))

## ---- eval = FALSE-------------------------------------------------------
#  # resistance prediction of piperacillin/tazobactam (TZP):
#  resistance_predict(tbl = example_isolates, col_date = "date", col_ab = "TZP", model = "binomial")
#  
#  # or:
#  example_isolates %>%
#    resistance_predict(col_ab = "TZP",
#                       model  "binomial")
#  
#  # to bind it to object 'predict_TZP' for example:
#  predict_TZP <- example_isolates %>%
#    resistance_predict(col_ab = "TZP",
#                       model = "binomial")

## ---- echo = FALSE-------------------------------------------------------
predict_TZP <- example_isolates %>% 
  resistance_predict(col_ab = "TZP", model = "binomial")

## ------------------------------------------------------------------------
predict_TZP

## ---- fig.height = 5.5---------------------------------------------------
plot(predict_TZP)

## ------------------------------------------------------------------------
ggplot_rsi_predict(predict_TZP)

# choose for error bars instead of a ribbon
ggplot_rsi_predict(predict_TZP, ribbon = FALSE)

## ------------------------------------------------------------------------
example_isolates %>%
  filter(mo_gramstain(mo, language = NULL) == "Gram-positive") %>%
  resistance_predict(col_ab = "VAN", year_min = 2010, info = FALSE, model = "binomial") %>% 
  ggplot_rsi_predict()

## ------------------------------------------------------------------------
example_isolates %>%
  filter(mo_gramstain(mo, language = NULL) == "Gram-positive") %>%
  resistance_predict(col_ab = "VAN", year_min = 2010, info = FALSE, model = "linear") %>% 
  ggplot_rsi_predict()

## ------------------------------------------------------------------------
model <- attributes(predict_TZP)$model

summary(model)$family

summary(model)$coefficients

