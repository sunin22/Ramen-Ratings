#Title: Ramen Rating
#1. Data Import and cleaning
#Author: Sunin choi
#Date:11/05/2020
#Data Source: Kaggle, Ramen Ratings


# 1.Data Import

ramen_rate <- read.csv("ramen-ratings.csv")
#read.csv and csv2 are different!

library(tidyverse)
library(ggplot2)
library(funModeling)
library(corrplot)
library(dplyr)
library(ggplot2)
library(readr)

# 2. Basic understanding dataset 
class(ramen_rate) # data.frame
dim(ramen_rate) #2580 rows & 7 columns
head(ramen_rate) # Top.Ten has NA
tail(ramen_rate) # Texts in varaiety can be messy
str(ramen_rate) 
glimpse(ramen_rate)
summary(ramen_rate)

# A brief summary
# Data type: Review is int, rest are factor
# 38 countries, 43 levels of stars, 39 levels of topten(needs to check)
# Variety needs some text analysis


# 2.1 Details in 'Top.Ten' & 'Variety' columns

attributes(ramen_rate$Top.Ten)
# From 2012 to 2016, 37 products were ranked as top 10 ramens 
# Except for the top 10, the rest are empty

attributes(ramen_rate$Variety)
# Variety includes product names, taste of ramens, methods of cooking etc.
# Interesting topics to explore more such as which flavors, ingredients are famous

attributes(ramen_rate$Stars)
# the starts are reviews starting from 0 to 5, and unrated existed


# 3. NA and redundant data check

# 3.1 Check NA
# NA in general
ramen_rate[is.na(ramen_rate)] #[0]
sum(is.na(ramen_rate))   # character(0)
table(is.na(ramen_rate)) # False 18060
sum(complete.cases(ramen_rate)) # 2580
sum(!complete.cases(ramen_rate)) # 0 

# NA in Each columns 
as.data.frame(table(ramen_rate$Stars))
# 3 unrated stars

as.data.frame(table(ramen_rate$Top.Ten))
# 2543 empty rows in top.ten

as.data.frame(table(ramen_rate$Brand))
# number of products per each brand or company

as.data.frame(table(ramen_rate$Style))
# 2 empty rows in style


# 3.2 Distinct data

length(unique(ramen_rate)) # number of unique items
n_distinct(ramen_rate)  # number of times each unique value repeated


# 3.3 Cleaning NA data

# Stars
ramen_rate <- ramen_rate %>% filter(Stars != "Unrated")
# deleted unrated star

# Top.Ten
ramen_rate[ramen_rate == ""] <- "No rank"
"No Rank"<- ramen_rate$Top.Ten[ramen_rate$Top.Ten == ""]

# Style
"Unwritten"<- ramen_rate$Top.Ten[ramen_rate$Top.Ten == ""]


# 4.Data type check
ramen_rate$Variety <- ramen_rate$Variety %>% as.character()
ramen_rate$Top.Ten <- ramen_rate$Top.Ten %>% as.character()
ramen_rate$Stars <- as.numeric(as.character(ramen_rate$Stars))
str(ramen_rate)

# 5. Save the cleaned dataset and export
write.csv(ramen_rate, "ramen_rate.csv", row.names = T)


