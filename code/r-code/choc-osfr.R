#  program:  choc-osfr.R
#  task:     push from project to OSF repository
#  input:    project files (various files)
#  output:   none
#  project:  chocolate and happiness
#  author:   sam harper \ 2021-01-16

# load packages
library(here)
library(osfr)
library(tidyverse)

## Create a temporary directory to hold the repository
path <- file.path(tempfile(pattern="osfr-"), "osfr")
dir.create(path, recursive=TRUE)

temp <- tempfile()

# download a .zip file of the repository
# from the "Clone or download - Download ZIP" button
# on the GitHub repository of interest
download.file(url = "https://github.com/sbh4th/choc-happy/archive/master.zip", 
              destfile = "temp/master.zip")

# unzip the .zip file
unzip(zipfile = temp, "master.zip")

## Clone the git2r repository
repo <- clone("https://github.com/sbh4th/choc-happy", path)
summary(repo)

proj <- osf_retrieve_node("3fcxd")
proj
osf_ls_nodes(proj)

df <- osf_retrieve_node("ev38k")
df
osf_ls_nodes(df)