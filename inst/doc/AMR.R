## ----setup, include = FALSE, results = 'markup'-------------------------------
knitr::opts_chunk$set(
  warning = FALSE,
  collapse = TRUE,
  comment = "#",
  fig.width = 7.5,
  fig.height = 5
)

## ----example table, echo = FALSE, results = 'asis'----------------------------
knitr::kable(data.frame(date = Sys.Date(),
                        patient_id = c("abcd", "abcd", "efgh"),
                        mo = "Escherichia coli", 
                        AMX = c("S", "S", "R"),
                        CIP = c("S", "R", "S"),
                        stringsAsFactors = FALSE), 
             align = "c")

## ----lib packages, message = FALSE, warning = FALSE, results = 'asis'---------
library(dplyr)
library(ggplot2)
library(AMR)
library(cleaner)

# (if not yet installed, install with:)
# install.packages(c("dplyr", "ggplot2", "AMR", "cleaner"))

## ----create patients----------------------------------------------------------
patients <- unlist(lapply(LETTERS, paste0, 1:10))

## ----create gender------------------------------------------------------------
patients_table <- data.frame(patient_id = patients,
                             gender = c(rep("M", 135),
                                        rep("F", 125)))

## ----create dates-------------------------------------------------------------
dates <- seq(as.Date("2010-01-01"), as.Date("2018-01-01"), by = "day")

## ----mo-----------------------------------------------------------------------
bacteria <- c("Escherichia coli", "Staphylococcus aureus",
              "Streptococcus pneumoniae", "Klebsiella pneumoniae")

## ----merge data---------------------------------------------------------------
sample_size <- 20000
data <- data.frame(date = sample(dates, size = sample_size, replace = TRUE),
                   patient_id = sample(patients, size = sample_size, replace = TRUE),
                   hospital = sample(c("Hospital A",
                                       "Hospital B",
                                       "Hospital C",
                                       "Hospital D"),
                                     size = sample_size, replace = TRUE,
                                     prob = c(0.30, 0.35, 0.15, 0.20)),
                   bacteria = sample(bacteria, size = sample_size, replace = TRUE,
                                     prob = c(0.50, 0.25, 0.15, 0.10)),
                   AMX = random_rsi(sample_size, prob_RSI = c(0.35, 0.60, 0.05)),
                   AMC = random_rsi(sample_size, prob_RSI = c(0.15, 0.75, 0.10)),
                   CIP = random_rsi(sample_size, prob_RSI = c(0.20, 0.80, 0.00)),
                   GEN = random_rsi(sample_size, prob_RSI = c(0.08, 0.92, 0.00)))

## ----merge data 2, message = FALSE, warning = FALSE---------------------------
data <- data %>% left_join(patients_table)

## ----preview data set 1, eval = FALSE-----------------------------------------
#  head(data)

## ----preview data set 2, echo = FALSE, results = 'asis'-----------------------
knitr::kable(head(data), align = "c")

## ----freq gender 1, results="asis"--------------------------------------------
data %>% freq(gender)

## ----transform mo 1-----------------------------------------------------------
data <- data %>%
  mutate(bacteria = as.mo(bacteria))

## ----transform abx------------------------------------------------------------
is.rsi.eligible(data)
colnames(data)[is.rsi.eligible(data)]

data <- data %>%
  mutate(across(where(is.rsi.eligible), as.rsi))

## ----eucast, warning = FALSE, message = FALSE---------------------------------
data <- eucast_rules(data, col_mo = "bacteria", rules = "all")

## ----new taxo-----------------------------------------------------------------
data <- data %>% 
  mutate(gramstain = mo_gramstain(bacteria),
         genus = mo_genus(bacteria),
         species = mo_species(bacteria))

## ----1st isolate--------------------------------------------------------------
data <- data %>% 
  mutate(first = first_isolate(info = TRUE))

## ----1st isolate filter-------------------------------------------------------
data_1st <- data %>% 
  filter(first == TRUE)

## ----1st isolate filter 2-----------------------------------------------------
data_1st <- data %>% 
  filter_first_isolate()

## ----preview data set 3, eval = FALSE-----------------------------------------
#  head(data_1st)

## ----preview data set 4, echo = FALSE, results = 'asis'-----------------------
knitr::kable(head(data_1st), align = "c")

## ----freq 1, eval = FALSE-----------------------------------------------------
#  freq(paste(data_1st$genus, data_1st$species))

## ----freq 2a, eval = FALSE----------------------------------------------------
#  data_1st %>% freq(genus, species)

## ----freq 2b, results = 'asis', echo = FALSE----------------------------------
data_1st %>% 
  freq(genus, species, header = TRUE)

## ----bug_drg 2a, eval = FALSE-------------------------------------------------
#  data_1st %>%
#    filter(any(aminoglycosides() == "R"))

## ----bug_drg 2b, echo = FALSE, results = 'asis'-------------------------------
knitr::kable(data_1st %>% 
               filter(any(aminoglycosides() == "R")) %>% 
               head(),
             align = "c")

## ----bug_drg 1a, eval = FALSE-------------------------------------------------
#  data_1st %>%
#    bug_drug_combinations() %>%
#    head() # show first 6 rows

## ----bug_drg 1b, echo = FALSE, results = 'asis'-------------------------------
knitr::kable(data_1st %>% 
               bug_drug_combinations() %>% 
               head(),
             align = "c")

## ----bug_drg 3a, eval = FALSE-------------------------------------------------
#  data_1st %>%
#    select(bacteria, aminoglycosides()) %>%
#    bug_drug_combinations()

## ----bug_drg 3b, echo = FALSE, results = 'asis'-------------------------------
knitr::kable(data_1st %>% 
               select(bacteria, aminoglycosides()) %>% 
               bug_drug_combinations(),
             align = "c")

## -----------------------------------------------------------------------------
data_1st %>% resistance(AMX)

## ---- eval = FALSE------------------------------------------------------------
#  data_1st %>%
#    group_by(hospital) %>%
#    summarise(amoxicillin = resistance(AMX))

## ---- echo = FALSE------------------------------------------------------------
data_1st %>% 
  group_by(hospital) %>% 
  summarise(amoxicillin = resistance(AMX)) %>% 
  knitr::kable(align = "c", big.mark = ",")

## ---- eval = FALSE------------------------------------------------------------
#  data_1st %>%
#    group_by(hospital) %>%
#    summarise(amoxicillin = resistance(AMX),
#              available = n_rsi(AMX))

## ---- echo = FALSE------------------------------------------------------------
data_1st %>% 
  group_by(hospital) %>% 
  summarise(amoxicillin = resistance(AMX),
            available = n_rsi(AMX)) %>% 
  knitr::kable(align = "c", big.mark = ",")

## ---- eval = FALSE------------------------------------------------------------
#  data_1st %>%
#    group_by(genus) %>%
#    summarise(amoxiclav = susceptibility(AMC),
#              gentamicin = susceptibility(GEN),
#              amoxiclav_genta = susceptibility(AMC, GEN))

## ---- echo = FALSE------------------------------------------------------------
data_1st %>% 
  group_by(genus) %>% 
  summarise(amoxiclav = susceptibility(AMC),
            gentamicin = susceptibility(GEN),
            amoxiclav_genta = susceptibility(AMC, GEN)) %>% 
  knitr::kable(align = "c", big.mark = ",")

## ----plot 1-------------------------------------------------------------------
data_1st %>% 
  group_by(genus) %>% 
  summarise("1. Amoxi/clav" = susceptibility(AMC),
            "2. Gentamicin" = susceptibility(GEN),
            "3. Amoxi/clav + genta" = susceptibility(AMC, GEN)) %>% 
  # pivot_longer() from the tidyr package "lengthens" data:
  tidyr::pivot_longer(-genus, names_to = "antibiotic") %>% 
  ggplot(aes(x = genus,
             y = value,
             fill = antibiotic)) +
  geom_col(position = "dodge2")

## ----plot 2, eval = FALSE-----------------------------------------------------
#  ggplot(data = a_data_set,
#         mapping = aes(x = year,
#                       y = value)) +
#    geom_col() +
#    labs(title = "A title",
#         subtitle = "A subtitle",
#         x = "My X axis",
#         y = "My Y axis")
#  
#  # or as short as:
#  ggplot(a_data_set) +
#    geom_bar(aes(year))

## ----plot 3-------------------------------------------------------------------
ggplot(data_1st) +
  geom_rsi(translate_ab = FALSE)

## ----plot 4-------------------------------------------------------------------
# group the data on `genus`
ggplot(data_1st %>% group_by(genus)) + 
  # create bars with genus on x axis
  # it looks for variables with class `rsi`,
  # of which we have 4 (earlier created with `as.rsi`)
  geom_rsi(x = "genus") + 
  # split plots on antibiotic
  facet_rsi(facet = "antibiotic") +
  # set colours to the R/SI interpretations (colour-blind friendly)
  scale_rsi_colours() +
  # show percentages on y axis
  scale_y_percent(breaks = 0:4 * 25) +
  # turn 90 degrees, to make it bars instead of columns
  coord_flip() +
  # add labels
  labs(title = "Resistance per genus and antibiotic", 
       subtitle = "(this is fake data)") +
  # and print genus in italic to follow our convention
  # (is now y axis because we turned the plot)
  theme(axis.text.y = element_text(face = "italic"))

## ----plot 5-------------------------------------------------------------------
data_1st %>% 
  group_by(genus) %>%
  ggplot_rsi(x = "genus",
             facet = "antibiotic",
             breaks = 0:4 * 25,
             datalabels = FALSE) +
  coord_flip()

## ---- results='markup'--------------------------------------------------------
mic_values <- random_mic(size = 100)
mic_values

## ----mic_plots----------------------------------------------------------------
# base R:
plot(mic_values)
# ggplot2:
ggplot(mic_values)

## ---- results = 'markup', message = FALSE, warning = FALSE--------------------
mic_values <- random_mic(size = 100, mo = "E. coli", ab = "cipro")

## ----mic_plots_mo_ab, message = FALSE, warning = FALSE------------------------
# base R:
plot(mic_values, mo = "E. coli", ab = "cipro")
# ggplot2:
ggplot(mic_values, mo = "E. coli", ab = "cipro")

## ---- results = 'markup'------------------------------------------------------
disk_values <- random_disk(size = 100, mo = "E. coli", ab = "cipro")
disk_values

## ----disk_plots, message = FALSE, warning = FALSE-----------------------------
# base R:
plot(disk_values, mo = "E. coli", ab = "cipro")

## ----disk_plots_mo_ab, message = FALSE, warning = FALSE-----------------------
ggplot(disk_values,
       mo = "E. coli",
       ab = "cipro",
       guideline = "CLSI")

## ---- results = 'markup'------------------------------------------------------
# use package 'tidyr' to pivot data:
library(tidyr)

check_FOS <- example_isolates %>%
  filter(hospital_id %in% c("A", "D")) %>% # filter on only hospitals A and D
  select(hospital_id, FOS) %>%             # select the hospitals and fosfomycin
  group_by(hospital_id) %>%                # group on the hospitals
  count_df(combine_SI = TRUE) %>%          # count all isolates per group (hospital_id)
  pivot_wider(names_from = hospital_id,    # transform output so A and D are columns
              values_from = value) %>%     
  select(A, D) %>%                         # and only select these columns
  as.matrix()                              # transform to a good old matrix for fisher.test()

check_FOS

## -----------------------------------------------------------------------------
# do Fisher's Exact Test
fisher.test(check_FOS)                            

