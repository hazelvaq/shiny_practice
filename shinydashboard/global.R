# LOAD LIBRARIES ----
library(shiny)
library(shinydashboard)
library(tidyverse)
library(leaflet)
library(shinycssloaders)

# read in our data
# don't use here inside of apps can cause issues
lake_data <- read_csv("data/lake_data_processed.csv")
