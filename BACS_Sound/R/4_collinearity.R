# Checking for Collinearity in the Data ----

# Author: Ben Stalheim
# Date: July 18, 2025

############### Required Packages:----

library(tidyverse)
library(corrplot)


setwd("F:/Fieldwork/Distance_Sampling")# This could be D: or F: or other depending on computer

############### Loading in the CSV file (and clearing workspace just in case) ----

rm(list = ls())

bacs <- read.csv('bacs_master.csv')


############### Checking Collinearity and Plotting ----


# Bird Variables #_____________________________________

(bird_data <- cor(bacs %>% 
           select(distance, Height, Bearing_Difference, BN_Score,
                  Max_dB), 
         use = "pairwise.complete.obs"))

corrplot(bird_data, method = 'number')

corrplot(bird_data, method = 'color', order = 'alphabet')

corrplot(bird_data, method = 'square', order = 'FPC', type = 'lower', diag = FALSE)


# Weather Variables #___________________________________

(weather <- cor(bacs %>% 
                 select(Temp, Humidity, Wind, Julian_Day),
               use = "pairwise.complete.obs"))

corrplot(weather, method = 'number')

corrplot(weather, method = 'color', order = 'alphabet')

corrplot(weather, method = 'square', order = 'FPC', type = 'lower', diag = FALSE)


# Veg Variables #_______________________________________

(veg <-cor(bacs %>% 
            select(Robel_Average, Trees_4m, DBH_Average, Height_of_tallest,
                   Tree_Area, Tree_Volume, Tree_Height_Average,
                   Sound_Difference_Average)
                   ,  use = "pairwise.complete.obs" ))

corrplot(veg, method = 'number')

corrplot(veg, method = 'color', order = 'alphabet')

corrplot(veg, method = 'square', order = 'FPC', type = 'lower', diag = FALSE)




