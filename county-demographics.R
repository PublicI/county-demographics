# load libraries ----------------------------------------------------------

library("dplyr")
library("tidyverse")
library("readxl")
library("janitor")


# download data -----------------------------------------------------------
# data dictionary: https://www2.census.gov/programs-surveys/popest/technical-documentation/file-layouts/2010-2018/cc-est2018-alldata.pdf

download.file(url = "https://www2.census.gov/programs-surveys/popest/datasets/2010-2018/counties/asrh/cc-est2018-alldata.csv", 
              destfile = "C:/data/census-demographics/data-raw/annual_county_resident_population_estimates_2010_2018.csv")

# load data ---------------------------------------------------------------

county_demographics10_18 <- read.csv("C:/data/census-demographics/data-raw/annual_county_resident_population_estimates_2010_2018.csv") %>%
  clean_names()

# tidy data ---------------------------------------------------------------
tidy_demographics10_18 <- county_demographics10_18 %>% 
  select(state, county, stname, ctyname, year, tot_pop, ba_male, ba_female, ia_male, ia_female,
         aa_male, aa_female, na_male, na_female, tom_male, tom_female, nhwa_male, nhwa_female,
         h_male, h_female) %>% 
  mutate(ba_tot = ba_male + ba_female) %>% # new columns for male + female
  mutate(ia_tot = ia_male + ia_female) %>% 
  mutate(aa_tot = aa_male + aa_female) %>% 
  mutate(na_tot = na_male + na_female) %>%
  mutate(tom_tot = tom_male + tom_female) %>% 
  mutate(nhwa_tot = nhwa_male + nhwa_female) %>%
  mutate(h_tot = h_male + h_female) %>%
  mutate(p_white = nhwa_tot/tot_pop) %>% # new column for % not hispanic, white only
  