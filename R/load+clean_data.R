##### Declare Paths #####
SCRIPTDIR = "C:/Users/Jon/Downloads/"


##### Libraries #####
library(pacman)
p_load(mailR, googlesheets4, googledrive, readxl, tidyverse)

####### Contact List ##### 
data <- read_sheet("https://docs.google.com/spreadsheets/d/1PBOVglzTcCYlCun9wAI5Q1SbOw6zneLF3MTx9pG53wQ/edit#gid=403636897", sheet = "Form Responses 1") 


data2 <- data %>%
  rename(time = Timestamp, cognitive = `Rate you mental clarity`, energy = 'Rate your overall energy', pain = 'Rate your musculoskeletal pain', supplements = `What supplements did you take today?`, food = `Did you eat these things today?`) %>%
  mutate(pain = 10 - pain) %>%
  mutate(summary = (cognitive + pain +energy)/3) %>%
  select(time, cognitive, energy, pain, summary) %>%
  pivot_longer(., cols = c('cognitive','energy','pain', 'summary')) %>%
  filter(name == "summary")


ggplot(data = data2, aes(x = time, y = value, color = name)) +
  geom_line()
