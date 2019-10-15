## ----setup, include = FALSE, results = 'markup'--------------------------
knitr::opts_chunk$set(
  warning = FALSE,
  collapse = TRUE,
  comment = "#",
  fig.width = 7.5,
  fig.height = 5
)

## ----example table, echo = FALSE, results = 'asis'-----------------------
knitr::kable(dplyr::tibble(date = Sys.Date(),
                           patient_id = c("abcd", "abcd", "efgh"),
                           mo = "Escherichia coli", 
                           AMX = c("S", "S", "R"),
                           CIP = c("S", "R", "S")), 
             align = "c")

## ----lib packages, message = FALSE---------------------------------------
library(dplyr)
library(ggplot2)
library(AMR)

# (if not yet installed, install with:)
# install.packages(c("tidyverse", "AMR"))

## ----create patients-----------------------------------------------------
patients <- unlist(lapply(LETTERS, paste0, 1:10))

## ----create gender-------------------------------------------------------
patients_table <- data.frame(patient_id = patients,
                             gender = c(rep("M", 135),
                                        rep("F", 125)))

## ----create dates--------------------------------------------------------
dates <- seq(as.Date("2010-01-01"), as.Date("2018-01-01"), by = "day")

## ----mo------------------------------------------------------------------
bacteria <- c("Escherichia coli", "Staphylococcus aureus",
              "Streptococcus pneumoniae", "Klebsiella pneumoniae")

## ----create other--------------------------------------------------------
hospitals <- c("Hospital A", "Hospital B", "Hospital C", "Hospital D")
ab_interpretations <- c("S", "I", "R")

## ----merge data----------------------------------------------------------
sample_size <- 20000
data <- data.frame(date = sample(dates, size = sample_size, replace = TRUE),
                   patient_id = sample(patients, size = sample_size, replace = TRUE),
                   hospital = sample(hospitals, size = sample_size, replace = TRUE,
                                     prob = c(0.30, 0.35, 0.15, 0.20)),
                   bacteria = sample(bacteria, size = sample_size, replace = TRUE,
                                     prob = c(0.50, 0.25, 0.15, 0.10)),
                   AMX = sample(ab_interpretations, size = sample_size, replace = TRUE,
                                 prob = c(0.60, 0.05, 0.35)),
                   AMC = sample(ab_interpretations, size = sample_size, replace = TRUE,
                                 prob = c(0.75, 0.10, 0.15)),
                   CIP = sample(ab_interpretations, size = sample_size, replace = TRUE,
                                 prob = c(0.80, 0.00, 0.20)),
                   GEN = sample(ab_interpretations, size = sample_size, replace = TRUE,
                                 prob = c(0.92, 0.00, 0.08)))

## ----merge data 2, message = FALSE, warning = FALSE----------------------
data <- data %>% left_join(patients_table)

## ----preview data set 1, eval = FALSE------------------------------------
#  head(data)

## ----preview data set 2, echo = FALSE, results = 'asis'------------------
knitr::kable(head(data), align = "c")

## ----lib clean, message = FALSE------------------------------------------
library(clean)

## ----freq gender 1, eval = FALSE-----------------------------------------
#  data %>% freq(gender) # this would be the same: freq(data$gender)

## ----freq gender 2, echo = FALSE, results = 'markup'---------------------
data %>% freq(gender, markdown = FALSE, header = TRUE)

## ----transform mo 1------------------------------------------------------
data <- data %>%
  mutate(bacteria = as.mo(bacteria))

## ----transform abx-------------------------------------------------------
data <- data %>%
  mutate_at(vars(AMX:GEN), as.rsi)

## ----eucast, warning = FALSE, message = FALSE----------------------------
data <- eucast_rules(data, col_mo = "bacteria")

## ----new taxo------------------------------------------------------------
data <- data %>% 
  mutate(gramstain = mo_gramstain(bacteria),
         genus = mo_genus(bacteria),
         species = mo_species(bacteria))

## ----1st isolate---------------------------------------------------------
data <- data %>% 
  mutate(first = first_isolate(.))

## ----1st isolate filter--------------------------------------------------
data_1st <- data %>% 
  filter(first == TRUE)

## ----1st isolate filter 2, eval = FALSE----------------------------------
#  data_1st <- data %>%
#    filter_first_isolate()

## ---- echo = FALSE, message = FALSE, warning = FALSE, results = 'asis'----
weighted_df <- data %>%
  filter(bacteria == as.mo("E. coli")) %>% 
  # only most prevalent patient
  filter(patient_id == top_freq(freq(., patient_id), 1)[1]) %>% 
  arrange(date) %>%
  select(date, patient_id, bacteria, AMX:GEN, first) %>% 
  # maximum of 10 rows
  .[1:min(10, nrow(.)),] %>% 
  mutate(isolate = row_number()) %>% 
  select(isolate, everything())

## ---- echo = FALSE, message = FALSE, warning = FALSE, results = 'asis'----
weighted_df %>% 
  knitr::kable(align = "c")

## ----1st weighted, warning = FALSE---------------------------------------
data <- data %>% 
  mutate(keyab = key_antibiotics(.)) %>% 
  mutate(first_weighted = first_isolate(.))

## ---- echo = FALSE, message = FALSE, warning = FALSE, results = 'asis'----
weighted_df2 <- data %>%
  filter(bacteria == as.mo("E. coli")) %>% 
  # only most prevalent patient
  filter(patient_id == top_freq(freq(., patient_id), 1)[1]) %>% 
  arrange(date) %>%
  select(date, patient_id, bacteria, AMX:GEN, first, first_weighted) %>% 
  # maximum of 10 rows
  .[1:min(10, nrow(.)),] %>% 
  mutate(isolate = row_number()) %>% 
  select(isolate, everything())

weighted_df2 %>% 
  knitr::kable(align = "c")

## ----1st isolate filter 3, results = 'hide', message = FALSE, warning = FALSE----
data_1st <- data %>% 
  filter_first_weighted_isolate()

## ------------------------------------------------------------------------
data_1st <- data_1st %>% 
  select(-c(first, keyab))

## ----preview data set 3, eval = FALSE------------------------------------
#  head(data_1st)

## ----preview data set 4, echo = FALSE, results = 'asis'------------------
knitr::kable(head(data_1st), align = "c")

## ----freq 1, eval = FALSE------------------------------------------------
#  freq(paste(data_1st$genus, data_1st$species))

## ----freq 2a, eval = FALSE-----------------------------------------------
#  data_1st %>% freq(genus, species)

## ----freq 2b, results = 'asis', echo = FALSE-----------------------------
data_1st %>% 
  freq(genus, species, header = TRUE)

## ------------------------------------------------------------------------
data_1st %>% portion_R(AMX)

## ---- eval = FALSE-------------------------------------------------------
#  data_1st %>%
#    group_by(hospital) %>%
#    summarise(amoxicillin = portion_R(AMX))

## ---- echo = FALSE-------------------------------------------------------
data_1st %>% 
  group_by(hospital) %>% 
  summarise(amoxicillin = portion_R(AMX)) %>% 
  knitr::kable(align = "c", big.mark = ",")

## ---- eval = FALSE-------------------------------------------------------
#  data_1st %>%
#    group_by(hospital) %>%
#    summarise(amoxicillin = portion_R(AMX),
#              available = n_rsi(AMX))

## ---- echo = FALSE-------------------------------------------------------
data_1st %>% 
  group_by(hospital) %>% 
  summarise(amoxicillin = portion_R(AMX),
            available = n_rsi(AMX)) %>% 
  knitr::kable(align = "c", big.mark = ",")

## ---- eval = FALSE-------------------------------------------------------
#  data_1st %>%
#    group_by(genus) %>%
#    summarise(amoxiclav = portion_SI(AMC),
#              gentamicin = portion_SI(GEN),
#              amoxiclav_genta = portion_SI(AMC, GEN))

## ---- echo = FALSE-------------------------------------------------------
data_1st %>% 
  group_by(genus) %>% 
  summarise(amoxiclav = portion_SI(AMC),
            gentamicin = portion_SI(GEN),
            amoxiclav_genta = portion_SI(AMC, GEN)) %>% 
  knitr::kable(align = "c", big.mark = ",")

## ----plot 1--------------------------------------------------------------
data_1st %>% 
  group_by(genus) %>% 
  summarise("1. Amoxi/clav" = portion_SI(AMC),
            "2. Gentamicin" = portion_SI(GEN),
            "3. Amoxi/clav + genta" = portion_SI(AMC, GEN)) %>% 
  tidyr::gather("antibiotic", "S", -genus) %>%
  ggplot(aes(x = genus,
             y = S,
             fill = antibiotic)) +
  geom_col(position = "dodge2")

## ----plot 2, eval = FALSE------------------------------------------------
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

## ----plot 3--------------------------------------------------------------
ggplot(data_1st) +
  geom_rsi(translate_ab = FALSE)

## ----plot 4--------------------------------------------------------------
# group the data on `genus`
ggplot(data_1st %>% group_by(genus)) + 
  # create bars with genus on x axis
  # it looks for variables with class `rsi`,
  # of which we have 4 (earlier created with `as.rsi`)
  geom_rsi(x = "genus") + 
  # split plots on antibiotic
  facet_rsi(facet = "antibiotic") +
  # make R red, I yellow and S green
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

## ----plot 5--------------------------------------------------------------
data_1st %>% 
  group_by(genus) %>%
  ggplot_rsi(x = "genus",
             facet = "antibiotic",
             breaks = 0:4 * 25,
             datalabels = FALSE) +
  coord_flip()

## ---- results = 'markup'-------------------------------------------------
check_FOS <- example_isolates %>%
  filter(hospital_id %in% c("A", "D")) %>% # filter on only hospitals A and D
  select(hospital_id, FOS) %>%             # select the hospitals and fosfomycin
  group_by(hospital_id) %>%                # group on the hospitals
  count_df(combine_SI = TRUE) %>%          # count all isolates per group (hospital_id)
  tidyr::spread(hospital_id, value) %>%    # transform output so A and D are columns
  select(A, D) %>%                         # and select these only
  as.matrix()                              # transform to good old matrix for fisher.test()

check_FOS

## ------------------------------------------------------------------------
# do Fisher's Exact Test
fisher.test(check_FOS)                            

