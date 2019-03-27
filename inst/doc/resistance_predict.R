## ----setup, include = FALSE, results = 'markup'--------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
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
#  # resistance prediction of piperacillin/tazobactam (pita):
#  resistance_predict(tbl = septic_patients, col_date = "date", col_ab = "pita")
#  
#  # or:
#  septic_patients %>%
#    resistance_predict(col_ab = "pita")
#  
#  # to bind it to object 'predict_pita' for example:
#  predict_pita <- septic_patients %>%
#    resistance_predict(col_ab = "pita")

## ---- echo = FALSE-------------------------------------------------------
predict_pita <- septic_patients %>% 
  resistance_predict(col_ab = "pita")

## ------------------------------------------------------------------------
predict_pita

## ---- fig.height = 5.5---------------------------------------------------
plot(predict_pita)

## ------------------------------------------------------------------------
ggplot_rsi_predict(predict_pita)

# choose for error bars instead of a ribbon
ggplot_rsi_predict(predict_pita, ribbon = FALSE)

## ------------------------------------------------------------------------
septic_patients %>%
  filter(mo_gramstain(mo) == "Gram positive") %>%
  resistance_predict(col_ab = "vanc", year_min = 2010, info = FALSE) %>% 
  ggplot_rsi_predict()

## ------------------------------------------------------------------------
septic_patients %>%
  filter(mo_gramstain(mo) == "Gram positive") %>%
  resistance_predict(col_ab = "vanc", year_min = 2010, info = FALSE, model = "linear") %>% 
  ggplot_rsi_predict()

## ------------------------------------------------------------------------
model <- attributes(predict_pita)$model

summary(model)$family

summary(model)$coefficients

