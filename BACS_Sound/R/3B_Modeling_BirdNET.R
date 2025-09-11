# Modeling the BirdNET Data ----

# Author: Ben Stalheim
# Date: July 16, 2025

############### Required Packages:----

library(tidyverse)
library(lme4)


############### Unrequired, but helpful packages for plotting after models: ---- 
library(ggeffects)
library(car)
library(MuMIn)


setwd("F:/Fieldwork/Distance_Sampling")# This could be D: or F: or other depending on computer



############### Loading the CSV and filtering to desired vocalizations ----

rm(list=ls())

bacs <- read.csv('bacs_master.csv')

songs <- bacs %>%
  filter(Song_Type %in% c("Normal", "Complex")) %>% 
  filter(Start_Bound != 0, End_Bound != 3) %>%
  mutate(Duration = End_Bound - Start_Bound) %>% 
  filter(Duration >= 1)



############### Building the Model ---- 
null_model.1 <- lmer(BN_Score ~ 1 + (1 | Bird_ID), data = songs, REML = FALSE)
summary(null_model.1)
r.squaredGLMM(null_model.1)


duration_model.2 <- lmer(BN_Score ~ Duration + (1 | Bird_ID), data = songs, REML = FALSE)
summary(duration_model.2)
r.squaredGLMM(duration_model.2)


distance_model.3 <- lmer(BN_Score ~ distance + (1 | Bird_ID), data = songs, REML = FALSE)
summary(distance_model.3)
r.squaredGLMM(distance_model.3)


distance_duration_model.4 <- lmer(BN_Score ~ distance + Duration + (1 | Bird_ID), data = songs, REML = FALSE)
summary(distance_duration_model.4)
r.squaredGLMM(distance_duration_model.4)
