## ----setup, include = FALSE, results = 'markup'-------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#",
  fig.width = 7.5,
  fig.height = 4.5,
  dpi = 100
)

## ---- message = FALSE---------------------------------------------------------
library(AMR)
library(dplyr)
glimpse(example_isolates)

## ---- warning = FALSE---------------------------------------------------------
resistance_data <- example_isolates %>% 
  group_by(order = mo_order(mo),       # group on anything, like order
           genus = mo_genus(mo)) %>%   #  and genus as we do here
  summarise_if(is.rsi, resistance) %>% # then get resistance of all drugs
  select(order, genus, AMC, CXM, CTX, 
         CAZ, GEN, TOB, TMP, SXT)      # and select only relevant columns

head(resistance_data)

## ----pca----------------------------------------------------------------------
pca_result <- pca(resistance_data)

## -----------------------------------------------------------------------------
summary(pca_result)

## ---- echo = FALSE------------------------------------------------------------
proportion_of_variance <- summary(pca_result)$importance[2, ]

## -----------------------------------------------------------------------------
biplot(pca_result)

## -----------------------------------------------------------------------------
ggplot_pca(pca_result)

## -----------------------------------------------------------------------------

ggplot_pca(pca_result, ellipse = TRUE) +
  ggplot2::labs(title = "An AMR/PCA biplot!")

