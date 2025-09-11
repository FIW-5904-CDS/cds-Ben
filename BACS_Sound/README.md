\# Project Summary



\*\*Name:\*\* Ben Stalheim  

\*\*Date:\*\* September 8th, 2025  



\## Project Overview



The objective of this project is to estimate the abundance of Bachman's Sparrows using passive acoustic monitoring. Individuals were recorded at known distances, and a model is being developed to predict the distance to birds recorded at unknown distances. Distance sampling methods will be used to quantify abundance.



---



\## 1. General Info



\- \*\*Proposed Title:\*\* \*Using Passive Acoustic Monitoring to Measure Abundance in Bachman’s Sparrows\*  

\- \*\*Likely Coauthor:\*\* Elizabeth Hunter  

\- \*\*Proposed Journal (1st choice):\*\* \*TBD – suggestions welcome\*  

\- \*\*Proposed Journal (backup):\*\* \*Also TBD\*



---



\## 2. Overarching Question



\*\*How does mining reclamation influence the abundance of bird species?\*\*



---



\## 3. Why This Matters



1\. Reclaimed mine land may mimic disturbed habitats.  

2\. ARUs have not been widely used to model abundance.  

3\. Bachman’s Sparrows are a species of conservation concern.  

4\. Land is a scarce resource—are mine lands ecological sinks or viable open habitats?



---



\## 4. Project Objectives



\- Develop a model to estimate distance based on recorded sound levels of Bachman’s Sparrows.  

\- Use the model to predict distances to birds recorded via ARUs across multiple locations and apply distance sampling methods to estimate abundance.  

\- Model changes in abundance at mine reclamation sites versus control areas.



---



\## 5. Study Design



\- \*\*Location:\*\* Southeastern Georgia  

&nbsp; - Mission Mine  

&nbsp; - Okefenokee National Wildlife Refuge  

&nbsp; - Sansavilla Wildlife Management Area  

\- \*\*Focal Species/System:\*\* Bachman’s Sparrow  

\- \*\*Approaches:\*\*  

&nbsp; - Passive acoustic monitoring  

&nbsp; - Vegetation surveys  

&nbsp; - Point counts  

&nbsp; - Banding  



---



\## 6.

\*\*Unit of Analysis:\*\* Each row in the dataset represents a unique recording.  



\## 7.

\*\*For my analysis, I want to test:\*\* If sound levels can be modeled to predict distances.



\## 8.

&nbsp;\*\*Response Variable (Y-axis):\*\* Sound level (RMS, dBFS, or dB)  



\## 9.

&nbsp;\*\*Predictor Variables (X-axis / Graph aesthetics):\*\*  

&nbsp; - Distance  

&nbsp; - Height  

&nbsp; - Directionality  

&nbsp; - Ambient sound pressure level  

\## 10.

\*\*Replication:\*\* Across multiple study areas and monitoring points.



\## 11.

\*\*Planned Analysis:\*\* Regression modeling  



\## 12.

\*\*Expected Output:\*\* Final figures visualizing predicted distances and abundance estimates



---



\## Directory Structure



\### `data/`  

Stores raw and processed data files.  

\- Dataset is a joined CSV file  

\- Each row = one recording  

\- Key columns:  

&nbsp; - Distance to bird  

&nbsp; - Maximum RMS amplitude  

&nbsp; - BirdNET confidence score  



\### `R/`  

Contains all analysis scripts.  

\- Modular scripts for:  

&nbsp; - Loudness extraction  

&nbsp; - Data cleaning  

&nbsp; - Visualization  

&nbsp; - Modeling  



\### `maps/`  

Stores all maps and figures associated with the project.



---



