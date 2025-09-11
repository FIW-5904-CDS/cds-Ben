############### Extracting loudness in Sones, RMS, and dBFS for .wav audio files

# Author: Ben Stalheim
# Date: Sep 1st, 2025

############## Required Packages ---- 

library(soundgen)
library(tuneR)
library(seewave)
library(purrr)
library(tidyverse)

############## Set the Working Directory ---- 
setwd("D:/4_Segments") #could be F:, E:, D:, etc... 

rm(list = ls()) # clear workspace (just in case).

############### Creating a function to iterate over a large folder of wave files.

#Note: The parameters are being set as 3000Hz to 8000Hz over the length of the segment.

# Function to process a single wav file
process_wav <- function(filepath, start = 0, end = 3, f_from = 3000, f_to = 8000) {
  if (!file.exists(filepath)) {
    message("Skipping missing file: ", filepath)
    return(NULL)
  }
  
  wave <- readWave(filepath)
  
  # Bandpass filter 3000–8000 Hz
  wave <- bwfilter(
    wave, f = wave@samp.rate,
    from = f_from, to = f_to,
    bandpass = TRUE, output = "Wave"
  )
  
  # RMS over 0–3 seconds
  rms_vals <- getRMS(wave, from = start, to = end, plot = FALSE)
  
  # Extract point number from filename (e.g., "p202.wav" → 202)
  
  fname <- basename(filepath)
  
  point_num <- as.integer(str_extract(fname, "\\d+"))
  
  
  tibble(
    max_rms  = max(rms_vals$detailed),
    mean_rms = mean(rms_vals$detailed),
    rms_95   = quantile(rms_vals$detailed, 0.95),
    dbfs_95  = 20 * log10(rms_95),
    dbfs     = 20 * log10(max_rms),
    point = point_num
  )
}

wav_files <- list.files("D:/4_Segments", pattern = "\\.wav$", full.names = TRUE)

bacs <- map_dfr(wav_files, process_wav)

bacs <- bacs %>% 
  arrange(point)

setwd("F:/Fieldwork/Distance_Sampling")

write.csv(bacs, "bacs_loudness.csv")
