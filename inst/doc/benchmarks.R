## ----setup, include = FALSE, results = 'markup'--------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.width = 7.5,
  fig.height = 4.5
)

## ---- message = FALSE, echo = FALSE--------------------------------------
library(dplyr)

## ---- message = FALSE----------------------------------------------------
library(microbenchmark)
library(AMR)

## ------------------------------------------------------------------------
S.aureus <- microbenchmark(as.mo("sau"),
                           as.mo("stau"),
                           as.mo("staaur"),
                           as.mo("STAAUR"),
                           as.mo("S. aureus"),
                           as.mo("S.  aureus"),
                           as.mo("Staphylococcus aureus"),
                           times = 10)
print(S.aureus, unit = "ms", signif = 2)

## ------------------------------------------------------------------------
T.islandicus <- microbenchmark(as.mo("theisl"),
                               as.mo("THEISL"),
                               as.mo("T. islandicus"),
                               as.mo("T.  islandicus"),
                               as.mo("Thermus islandicus"),
                               times = 10)
print(T.islandicus, unit = "ms", signif = 2)

## ------------------------------------------------------------------------
par(mar = c(5, 16, 4, 2)) # set more space for left margin text (16)

boxplot(microbenchmark(as.mo("Thermus islandicus"),
                       as.mo("Prevotella brevis"),
                       as.mo("Escherichia coli"),
                       as.mo("T. islandicus"),
                       as.mo("P. brevis"),
                       as.mo("E. coli"),
                       times = 10),
        horizontal = TRUE, las = 1, unit = "s", log = FALSE,
        xlab = "", ylab = "Time in seconds", ylim = c(0, 0.5),
        main = "Benchmarks per prevalence")

## ---- echo = FALSE-------------------------------------------------------
clean_mo_history()
par(mar = c(5, 16, 4, 2))
boxplot(microbenchmark(
  'as.mo("Thermus islandicus")' = as.mo("Thermus islandicus", force_mo_history = TRUE),
  'as.mo("Prevotella brevis")' = as.mo("Prevotella brevis", force_mo_history = TRUE),
  'as.mo("Escherichia coli")' = as.mo("Escherichia coli", force_mo_history = TRUE),
  'as.mo("T. islandicus")' = as.mo("T. islandicus", force_mo_history = TRUE),
  'as.mo("P. brevis")' = as.mo("P. brevis", force_mo_history = TRUE),
  'as.mo("E. coli")' = as.mo("E. coli", force_mo_history = TRUE),
  times = 10),
        horizontal = TRUE, las = 1, unit = "s", log = FALSE,
        xlab = "", ylab = "Time in seconds", ylim = c(0, 0.5),
        main = "Benchmarks per prevalence")

## ---- message = FALSE----------------------------------------------------
library(dplyr)
# take all MO codes from the septic_patients data set
x <- septic_patients$mo %>%
  # keep only the unique ones
  unique() %>%
  # pick 50 of them at random
  sample(50) %>%
  # paste that 10,000 times
  rep(10000) %>%
  # scramble it
  sample()
  
# got indeed 50 times 10,000 = half a million?
length(x)

# and how many unique values do we have?
n_distinct(x)

# now let's see:
run_it <- microbenchmark(mo_fullname(x),
                         times = 10)
print(run_it, unit = "ms", signif = 3)

## ------------------------------------------------------------------------
run_it <- microbenchmark(A = mo_fullname("B_STPHY_AUR"),
                         B = mo_fullname("S. aureus"),
                         C = mo_fullname("Staphylococcus aureus"),
                         times = 10)
print(run_it, unit = "ms", signif = 3)

## ------------------------------------------------------------------------
run_it <- microbenchmark(A = mo_species("aureus"),
                         B = mo_genus("Staphylococcus"),
                         C = mo_fullname("Staphylococcus aureus"),
                         D = mo_family("Staphylococcaceae"),
                         E = mo_order("Bacillales"),
                         F = mo_class("Bacilli"),
                         G = mo_phylum("Firmicutes"),
                         H = mo_kingdom("Bacteria"),
                         times = 10)
print(run_it, unit = "ms", signif = 3)

## ------------------------------------------------------------------------
mo_fullname("CoNS", language = "en") # or just mo_fullname("CoNS") on an English system

mo_fullname("CoNS", language = "es") # or just mo_fullname("CoNS") on a Spanish system

mo_fullname("CoNS", language = "nl") # or just mo_fullname("CoNS") on a Dutch system

run_it <- microbenchmark(en = mo_fullname("CoNS", language = "en"),
                         de = mo_fullname("CoNS", language = "de"),
                         nl = mo_fullname("CoNS", language = "nl"),
                         es = mo_fullname("CoNS", language = "es"),
                         it = mo_fullname("CoNS", language = "it"),
                         fr = mo_fullname("CoNS", language = "fr"),
                         pt = mo_fullname("CoNS", language = "pt"),
                         times = 10)
print(run_it, unit = "ms", signif = 4)

