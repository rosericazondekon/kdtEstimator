#-------------------------------------------------------------------------
#  Roseric Azondekon,
#  April 21st, 2018
#  Last update: March 15, 2019
#  Milwaukee, WI, USA
#-------------------------------------------------------------------------

packages <- c("shiny","shinydashboard","htmlwidgets","MASS","drc","ggplot2","readxl","openxlsx") # CRAN packages


# Install and load missing packages
new.packages <- packages[!(packages %in% installed.packages()[,"Package"])]
if(length(new.packages)){
  install.packages(new.packages, repos = repositories)
}

lapply(packages, require, character.only = TRUE)
