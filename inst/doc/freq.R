## ----setup, include = FALSE, results = 'asis'----------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#",
  results = 'asis',
  fig.width = 7.5,
  fig.height = 4.5
)
library(dplyr)
library(AMR)

## ---- echo = TRUE--------------------------------------------------------
# Any of these will work:
# freq(septic_patients$gender)
# freq(septic_patients[, "gender"])

# Using tidyverse:
# septic_patients$gender %>% freq()
# septic_patients[, "gender"] %>% freq()
# septic_patients %>% freq("gender")

# Probably the fastest and easiest:
septic_patients %>% freq(gender)  

## ---- echo = TRUE, results = 'hide'--------------------------------------
my_patients <- septic_patients %>% left_join_microorganisms()

## ---- echo = TRUE, results = 'markup'------------------------------------
colnames(microorganisms)

## ---- echo = TRUE, results = 'markup'------------------------------------
dim(septic_patients)
dim(my_patients)

## ---- echo = TRUE--------------------------------------------------------
my_patients %>%
  freq(genus, species, nmax = 15)

## ---- echo = TRUE--------------------------------------------------------
# # get age distribution of unique patients
septic_patients %>% 
  distinct(patient_id, .keep_all = TRUE) %>% 
  freq(age, nmax = 5, header = TRUE)

## ---- echo = TRUE--------------------------------------------------------
septic_patients %>%
  freq(hospital_id)

## ---- echo = TRUE--------------------------------------------------------
septic_patients %>%
  freq(hospital_id, sort.count = FALSE)

## ---- echo = TRUE--------------------------------------------------------
septic_patients %>%
  freq(AMX, header = TRUE)

## ---- echo = TRUE--------------------------------------------------------
septic_patients %>%
  freq(date, nmax = 5, header = TRUE)

## ---- echo = TRUE--------------------------------------------------------
my_df <- septic_patients %>% freq(age)
class(my_df)

## ---- echo = TRUE--------------------------------------------------------
dim(my_df)

## ---- echo = TRUE--------------------------------------------------------
septic_patients %>%
  freq(AMX, na.rm = FALSE)

## ---- echo = TRUE--------------------------------------------------------
septic_patients %>%
  freq(hospital_id, row.names = FALSE)

## ---- echo = TRUE, results = 'markup'------------------------------------
septic_patients %>%
  freq(hospital_id, markdown = FALSE)

