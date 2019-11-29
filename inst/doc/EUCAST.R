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

