#### Preamble ####

# Purpose: Load packages used in the analysis. Installation of packages
# is also performed as a failsafe.
# Authors: Yang Lei, Indira Mishra, Benny Rochwerg, and Peiqing Yu
# Date: April 6, 2026

#### Load Packages ####

install.packages("here")
install.packages("tidyverse")
install.packages("naniar")
install.packages("mice")
install.packages("geepack")
install.packages("table1")
install.packages("broom")
install.packages("knitr")
install.packages("kableExtra")
install.packages("nlme")
install.packages("car")

suppressPackageStartupMessages(library(here))
suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(naniar))
suppressPackageStartupMessages(library(mice))
suppressPackageStartupMessages(library(geepack))
suppressPackageStartupMessages(library(table1))
suppressPackageStartupMessages(library(broom))
suppressPackageStartupMessages(library(knitr))
suppressPackageStartupMessages(library(kableExtra))
suppressPackageStartupMessages(library(nlme))
suppressPackageStartupMessages(library(car))