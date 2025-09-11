# Project Survey Form

**Name:** Ben Stalheim  
**Date:** September 8th, 2025  

---

## Project Description
The objective of this project is to estimate the abundance of Bachman's Sparrows using passive acoustic monitoring. Individuals were recorded at known distances, and now a model is being built to predict the distance to recorded birds of unknown distance. Distance sampling methods will be used to quantify abundance.

---

## 1. General Info
- **Proposed Title:** Using Passive Acoustic Monitoring to Measure Abundance in Bachman’s Sparrows  
- **Likely Coauthors:** Elizabeth Hunter  
- **Proposed Journal (1st choice):** *TBD*  
- **Proposed Journal (backup):** *TBD*  

---

## 2. Overarching Question
How does mining reclamation influence abundance of bird species?

---

## 3. Why This is Important
1. Reclaimed mine land is mimicking disturbed habitats  
2. ARUs have not been used to model abundance  
3. Bachman’s Sparrows are a species of concern  
4. Land is a scarce resource: are mine lands a source, sink, or new open habitats?  

---

## 4. Objectives
- Create a model to estimate distance based on recorded sound levels of Bachman’s Sparrows  
- Use the model to predict distance to birds recorded using ARUs at multiple locations and apply distance sampling methods to measure abundance  
- Model changes in abundance at the mine reclamation sites and study control areas  

---

## 5. Study Context
- **Location:** Southeastern Georgia — Mission Mine, Okefenokee National Wildlife Refuge, and Sansavilla Wildlife Management Area  
- **Focal Species:** Bachman’s Sparrow  
- **Approaches:** Passive acoustic monitoring, vegetation surveys, point counts, banding, etc.  

---

## 6–12. Analysis Plan
- Each row of data in my dataset is a **recording**


## Repository Structure

### `data/`
This directory stores the raw and processed data files.  

The dataset included here is a joined CSV file where each row pertains to a unique recording. Pertinent columns are:  
- Distance to the bird  
- Maximum RMS (amplitude of the recorded sound)  
- BirdNET confidence score  

### `R/`
This directory stores all of the scripts to analyze the data.  

Scripts are modular, with each script handling a different task, such as:  
- Extracting loudness  
- Cleaning the data  
- Visualization  
- Modeling  

### `maps/`
This directory stores all of the maps and figures associated with this project.
