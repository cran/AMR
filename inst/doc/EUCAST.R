## ----setup, include = FALSE, results = 'markup'-------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#",
  fig.width = 7.5,
  fig.height = 4.5
)
library(AMR)

## ---- warning = FALSE, message = FALSE----------------------------------------
oops <- data.frame(mo = c("Klebsiella", 
                          "Escherichia"),
                   ampicillin = "S")
oops

eucast_rules(oops, info = FALSE)

## ---- warning = FALSE, message = FALSE----------------------------------------
data <- data.frame(mo = c("Staphylococcus aureus",
                          "Enterococcus faecalis",
                          "Escherichia coli",
                          "Klebsiella pneumoniae",
                          "Pseudomonas aeruginosa"),
                   VAN = "-",       # Vancomycin
                   AMX = "-",       # Amoxicillin
                   COL = "-",       # Colistin
                   CAZ = "-",       # Ceftazidime
                   CXM = "-",       # Cefuroxime
                   PEN = "S",       # Penicillin G
                   FOX = "S",       # Cefoxitin
                   stringsAsFactors = FALSE)

## ---- eval = FALSE------------------------------------------------------------
#  data

## ---- echo = FALSE------------------------------------------------------------
knitr::kable(data, align = "lccccccc")

## ---- eval = FALSE------------------------------------------------------------
#  eucast_rules(data)

## ---- echo = FALSE, message = FALSE-------------------------------------------
knitr::kable(eucast_rules(data), align = "lccccccc")

