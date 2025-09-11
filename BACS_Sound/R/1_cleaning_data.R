# Organizing, Cleaning, and Adding Distances to the Raw Data from Epicollect ----

# Author: Ben Stalheim
# Date: July 16, 2025


############### Required Packages:----

library('tidyverse')
library('geosphere')
library('hms')
library('writexl')

setwd("F:/Fieldwork/Distance_Sampling") #could be F:, E:, D:, etc... 

rm(list=ls())

############### Cleaning and Organizing ---- 

bacs <- read.csv('bacs_raw_data.csv') #read in the csv file (I edited this one to have correct order of points)

bacs <- bacs[, 6:39] # remove unnecessary columns

colnames(bacs) <- gsub("^X[0-9]+_?", "", colnames(bacs)) #Clean up the Column Names


bacs$Date <- as.Date(bacs$Date, format = "%m/%d/%Y") # Make sure the date column is actually a date


############### Renaming all of the weird column names from epicollect ----
bacs <- bacs %>%
  rename(
    lat_ARU = lat_9_ARU_Location,
    long_ARU = long_9_ARU_Location,
    Accuracy_ARU = accuracy_9_ARU_Location,
    UTM_N_ARU = UTM_Northing_9_ARU_Location,
    UTM_E_ARU = UTM_Easting_9_ARU_Location,
    lat_BACS = lat_10_BACS_Location, 
    long_BACS = long_10_BACS_Location,
    Accuracy_BACS = accuracy_10_BACS_Location,
    UTM_N_BACS = UTM_Northing_10_BACS_Location,
    UTM_E_BACS = UTM_Easting_10_BACS_Location,
    Point = Point_
  )  %>%
  mutate( # this updates the time columns from characters to actual time values.
    ARU_Start = as_hms(ARU_Start),
    BACS_Start = as_hms(BACS_Start),
    BACS_End = as_hms(BACS_End),
    vocal_start = BACS_Start - ARU_Start, # Add 3 new columns to make finding calls in Birdnet easier.
    vocal_end = BACS_End - ARU_Start,
    vocal_duration = BACS_End - BACS_Start
  )


################ Adding distances to the data ----

# calculate distance using the UTMs 
bacs$distance <- sqrt(
  (bacs$UTM_E_BACS - bacs$UTM_E_ARU)^2 + 
    (bacs$UTM_N_BACS - bacs$UTM_N_ARU)^2
)

bacs <- bacs %>% # reordering the columns so that the important info is at the start
  select(vocal_start, vocal_end, vocal_duration, distance, everything())


# bacs$distance_meters <- mapply(function(lat1, lon1, lat2, lon2) {
 # distHaversine(c(lon1, lat1), c(lon2, lat2))
#},
# bacs$lat_ARU, bacs$long_ARU,
# bacs$lat_BACS, bacs$long_BACS) #  #not using this distance calc anymore
# This is calculating the distance from lat/long

############### Writing a cleaned csv file ----

write.csv(bacs, "bacs_cleaned.csv", row.names = FALSE) #write csv for R

############### Making a master csv file ---- 
rm(list=ls())

bacs_cleaned <- read.csv('bacs_cleaned.csv') # load cleaned csv

bn_scores <- read.csv('bacs_bn_scores.csv') #load in bn score and *most* sound data
bn_scores <- bn_scores[,c(7:19,22:23)] %>% 
  mutate(filename = str_remove_all(filename, '^"|"$'))# remove duplicative columns

rms_95 <- read.csv('rms_95.csv')# load in new rms csv
rms_95 <- rms_95[,c(1, 4:5)]

bn_scores <- left_join(bn_scores, rms_95, by = 'filename')

# Add in dB based on the calibration factor (from extracting loudness script)
bn_scores <- bn_scores %>%
  mutate(Max_dB = 84 + 20 * log10(Max_RMS / 0.3143959),
         dB_95 = 84 + 20 * log10(rms_95 / 0.3143959))


bacs_master <- full_join(bacs_cleaned, bn_scores) %>% 
 mutate(RL = 84 + (20 * log10(rms_95 / 0.3143959)) - (0.07 * distance),
        SL = RL + (20 * log10(distance)) + (0.07 * distance))

# Relating Bird ID's to Veg Territories 

bird_territory <- tibble::tibble(
  Bird_ID = c("B001", "B002", "B003", "B004", "B005", "B006", "B007", "B008",
              "B009", "B010", "B011", "B012", "B013", "B014", "B015", "B016",
              "B017", "B018", "B019", "B020", "B021", "B022", "B023", "B024",
              "B025", "B026", "B027", "B028", "B029", "B030", "B031", "B032",
              "B033", "B034", "B035", "B036", "B037", "B038", "B039", "B040",
              "B041", "B042", "B043", "B044", "B045", "B046", "B047", "B048",
              "B049", "B050", "B051"),
  Veg_Territory = c("Slime", "Slime", "Svens", "Salsa", "Spike", "Salsa",
                    "Svens", "Svens", "Svens", "Salsa", "Mario", "Monty",
                    "Moose", "Mario", "Mario", "Melon", "Moose", "Oscar",
                    "Oscar", "Oscar", "Ollie", "Okoro", "Oxxen", "Oreos",
                    "Oreos", "Okoro", "Okoro", "Oodle", "Oodle", "Oodle",
                    "Oscar", "Oxxen", "Oxxen", "Okoro", "Oxxen", "Oxxen",
                    "Oxxen", "Oxxen", "Oxxen", "Oxxen", "Oreos", "Oxxen",
                    "Oxxen", "Oxxen", "Oxxen", "Oxxen", "Okoro", "Oxxen",
                    "Oreos","Oscar", "Oxxen"))

bacs_master <- left_join(bacs_master, bird_territory, by = "Bird_ID") %>% 
  select(-Accuracy_ARU, -UTM_Zone_9_ARU_Location, -Accuracy_BACS, 
         -UTM_Zone_10_BACS_Location, -Accuracy)

############### Read in and join the veg data ---- 

veg_data <- read.csv('veg_additional.csv')
veg_data <- veg_data[,c(1,8:35)]

bacs_master <- full_join(bacs_master, veg_data, by = "Veg_Territory")


############### Write the Master CSV file
write.csv(bacs_master, 'bacs_master.csv', row.names = FALSE) # write csv for next script
