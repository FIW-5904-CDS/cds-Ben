# FWC5994: Conservation Data Science- Fall 2025
# Intro to R - Part 1

######## Topics #######
# 1. Getting help
# 2. Working directories
# 3. Using R as a calculator
# 4. Creating data and variables
# 5. Functions
# 6. Downloading new packages
# 7. Loading files into R

# ----- 1. Getting help --------
# If you know a function name, you can use
#   the question mark ? to open a help file

?mean #opens help file 
?t.test

# Help files tell possible arguments
#   and give examples at the end

help.start()  # opens the links to online manuals and miscellaneous materials

# Or, open help tab (at right) and type name in
# Or, google it! (There are great R forums)
# Or ask AI (VT offers Microsoft CoPilot)

## YOUR TURN ##
#find the help file for the function that finds the maximum of the values within a given vector or matrix



# ----- 2. Working Directories ---------
# Determine your working directory

getwd()

# Set your working directory using setwd()
#   or by using "Set as working director" in the "More"
#   option in the "Files" tab on the right

setwd('/Users/Haldre/Desktop') #Why doesn't this work on your laptop?

# Working Directories & RStudio Projects
#when you are using projects, the working directory will automatically be set to the same folder as the Project. 
#If you want to access something within the project, you need to add the path to that file. 


## YOUR TURN ##
#Figure out where your working directory is currently located

#set the working directory to your desktop (hint: can use the Session - Set working directory GUI to do this, and then see what the code is)

#set the working directory back to the project directory



# ----- 3. Using R as a calculator ------
1+2
cos(pi)

# Arithmetic
#  +  add
#  -  subtract
#  *  multiply
#  /  divide
#  ^  exponent

# Relational
#  >   greater, less than
#  >=  greater than or equal to
#  !=  not equal to

# Logical
#  !  not
#  &  and
#  |  or


## YOUR TURN ##
# Do some math! 
#1) There is a group of 10 people who are ordering pizza. If each person gets 2 slices and each pizza has 4 slices, how many pizzas should they order?

#2) Ask R whether 3.1415932 is greater than pi

#3) What is your age cubed? 



# ----- 4. Creating data and variables ------


# Make a vector with concatenate, c()

c(5, 7, 3, 14)

# Give your vector a name and save it

dogAges <- c(5, 7, 3, 14)

# Type the name to see it

dogAges

# Perform functions on vectors

mean(dogAges)

dogAges2 <- dogAges*2
dogAges2

# Combine vectors

dogAges <- cbind(dogAges, dogAges2)
dogAges


## YOUR TURN ##
#create a vector of the heights (in inches) of everyone in the class


# ----- 5. Functions ------

# Functions take this form: function(argument,argument,argument,...)

# Here, curve is the function name.
# 2*x is the function I want to graph 
# "from" and "to" are arguments to specify x axis length

?curve #see what the help file says

curve(2*x, from=0,to=8)


## YOUR TURN ##

#use the mean function to take the average of the heights at your table

#what are the default arguments for the mean function? Include them in your code. 

#Use the "trim" argument to remove 0.25 from each end of your height vector before calculating the mean. What did this do?  


# ----- 6. Downloading new packages ------

# If the function you want is in a different package, use install.packages() (or use Packages tab in RStudio)

install.packages("praise")

# To load this so R can use it, use library() (or check box in Packages tab on RStudio)

library(praise)

# now use the function
praise()


## YOUR TURN ##
#install the tidyverse package (or really, suite of packages)

#load tidyverse


# ----- 7. Preparing and loading data files into R ------

# Can use .csv or .txt files or excel files

# Read file using read.csv, naming it something. Note that this file must be in your working directory

spider <- read.csv("data/raw/spider.csv")

# You can also use use file.choose()
spider <- read.csv(file.choose())

#can also use the tidyverse approach to load CSV files
library(readr) 
spidertv <- read_csv("data/raw/spider.csv") #readr approach to loading csv's

#what are the differences? 
str(spider)
str(spidertv)

# Reading in excel files is easy too, with readxl package. 
library(readxl)

#Use 'sheet = (fill in number)" to get the second or third sheet or whatever sheet number you want

spiderprey <- read_excel("data/raw/Prey_Capture_Final_Do_Not_Touch.xlsx", sheet = 2)

## Your Turn ##

# 1) Read in the first sheet of the Prey_Capture_Final excel file. Name it something appropriate for the content. 

# 2) Use the Import Dataset tool to bring in the dataset and change the classes of columns to something else (e.g. date, character etc.). Then look at the code that ran in the console below. 


