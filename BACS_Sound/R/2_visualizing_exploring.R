# Visualizing and Exploring the Cleaned Distance Data ----

# Author: Ben Stalheim
# Date: July 16, 2025

############### Required Packages:----

library('tidyverse')
library('geosphere')
library(corrplot)
rm(list=ls())

setwd("F:/Fieldwork/Distance_Sampling")# This could be D: or F: or other depending on computer

############### Loading the cleaned data ----

bacs <- read.csv('bacs_master.csv') #Load the csv file


# Histogram and visualizing some data ---- 
ggplot(data = bacs) +
  geom_histogram(aes(x = distance))

ggplot(data = bacs) +
  geom_histogram(aes(x = Bearing_Difference))

ggplot(data = bacs) +
  geom_histogram(aes(x = Height))

############### Table Representing counts of distance bins ---- 

distance_range <- bacs$distance_range <- cut(
  bacs$distance,
  breaks = c(-Inf, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, Inf),
  labels = c("0–10", "11–20", "21-30", "31-40", "41-50",
             "51-60", "61-70", "71-80", "81-90", "91-100", "101-110","111-120",
             "121-130", "131-140", ">140"),
  right = TRUE
)


distance_table <- table(bacs$distance_range) # Create a frequency table
print(distance_table)

############### Plotting the distance and sound data ---- 

#   Songs   #__________________________________________

songs <- bacs %>%
  filter(Song_Type %in% c("Normal", "Complex"))

# dB # 

ggplot(data = songs, aes(x = distance, y = dB_95, color = Bearing_Difference)) +
  geom_point() + 
  scale_color_gradient(low = "blue", high = "red")+
  labs(x = "Distance", y = "dB 95", color = "Angle of Song")



# DBFS #

ggplot(data = songs, aes(x = distance, y = dbfs_95, color = Bearing_Difference)) +
  geom_point() + 
  scale_color_gradient(low = "blue", high = "red")+
  labs(x = "Distance", y = "dB 95", color = "Angle of Song")


# Sones # 

ggplot(data = songs, aes(x = distance, y = Max_Loud, color = Bearing_Difference)) +
  geom_point() + 
  scale_color_gradient(low = "blue", high = "red") +
  labs(x = "Distance", y = "Max Sones", color = "Angle of Song")


##### Okefenokee #####

okefenokee <- songs %>% 
  filter(Treatment == "okefenokee")

ggplot(data = okefenokee, aes(x = distance, y = Max_dB, color = Bearing_Difference)) +
  geom_point() + 
  scale_color_gradient(low = "blue", high = "red")+
  labs(x = "Distance", y = "Max dB", color = "Angle of Song")

mean(okefenokee$Max_dB, na.rm = TRUE)

##### Sansavilla #####

sansavilla <- songs %>% 
  filter(Treatment == "sansavilla")

ggplot(data = sansavilla, aes(x = distance, y = Max_dB, color = Bearing_Difference)) +
  geom_point() + 
  scale_color_gradient(low = "blue", high = "red")+
  labs(x = "Distance", y = "Max dB", color = "Angle of Song")

mean(sansavilla$Max_dB, na.rm = TRUE)

##### Mine #####

mine <- songs %>% 
  filter(Treatment == "mine")

ggplot(data = mine, aes(x = distance, y = Max_dB, color = Bearing_Difference)) +
  geom_point() + 
  scale_color_gradient(low = "blue", high = "red")+
  labs(x = "Distance", y = "Max dB", color = "Angle of Song")

mean(mine$Max_dB, na.rm = TRUE)

#   Calls   #__________________________________________

calls <- bacs %>%
  filter(Song_Type %in% c("Male Call", "Female Call"))

ggplot(data = calls, aes(x = distance, y = Max_dB, color = Bearing_Difference)) +
  geom_point() + 
  scale_color_gradient(low = "blue", high = "red")


#  Whisper Songs  #____________________________________

whispers <- bacs %>%
  filter(Song_Type == "Whisper")

ggplot(data = whispers, aes(x = distance, y = Max_dB, color = Bearing_Difference)) +
  geom_point() + 
  scale_color_gradient(low = "blue", high = "red")



############### Analyzing Vocalizations ---- 

##### Song Duration #####
songs_length <- songs %>%
  filter(Start_Bound != 0, End_Bound != 3) %>%
  mutate(Duration = End_Bound - Start_Bound) %>% 
  filter(Duration >= 1)

mean(songs_length$Duration, na.rm = TRUE)

ggplot(data = songs_length,
       aes(x = Duration)) +
  geom_histogram()


##### Song Bandwidth #####

songs_long <- songs %>%
  pivot_longer(cols = c(Lower_Freq, Upper_Freq),
               names_to = "Type", values_to = "Frequency")

ggplot(songs_long, aes(x = Frequency, fill = Type)) +
  geom_histogram(alpha = 0.5) +
  labs(title = "Count of Lower and Upper Frequencies",
       x = "Frequency (Hz)",
       y = "Count") +
  scale_fill_manual(values = c("Lower_Freq" = "blue", "Upper_Freq" = "red")) +
  theme_minimal()




############### Messing Around ----

ggplot(data = songs_length, aes(x = Duration, y = BN_Score)) +
  geom_point() +
  geom_smooth(method = "lm", se = TRUE, color = "blue") +
  theme_minimal()

ggplot(data = songs_length, aes(x = distance, y = BN_Score)) +
  geom_point() +
  geom_smooth(method = "lm", se = TRUE, color = "blue") +
  theme_minimal()


ggplot(data = songs, aes(x = Robel_Average, fill = Treatment)) +
  geom_histogram(position = 'dodge', bins = 15)

ggplot(data = songs, aes(x = Trees_4m, fill = Treatment)) +
  geom_histogram(position = 'dodge', bins = 15)

ggplot(data = songs, aes(x = Sound_Difference_Average, fill = Treatment)) +
  geom_histogram(position = 'dodge', bins = 15)

ggplot(data = songs, aes(x = Height, fill = Treatment)) +
  geom_histogram(position = 'dodge', bins = 15)

ggplot(data = songs, aes(x = Max_dB, fill = Treatment)) +
  geom_histogram(position = 'dodge', bins = 15)

ggplot(data = songs, aes(x = Trees_4m, fill = Treatment)) +
  geom_histogram(position = 'dodge', bins = 15)


ggplot(data = songs_length, aes(x = vocal_duration, y = BN_Score)) +
  geom_point()
