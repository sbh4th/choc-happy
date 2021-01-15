#  program:  choc-osfr.R
#  task:     write from github to OSF repository
#  input:    git repo (various files)
#  output:   none
#  project:  chocolate and happiness
#  author:   sam harper \ 2021-01-15

# load packages
library(git2r)
library(osfr)
library(tidyverse)

## Create a temporary directory to hold the repository
path <- file.path(tempfile(pattern="git2r-"), "git2r")
dir.create(path, recursive=TRUE)

## Clone the git2r repository
repo <- clone("https://github.com/sbh4th/choc-happy", path)
summary(repo)

proj <- osf_retrieve_node("3fcxd")
proj
osf_ls_nodes(proj)

df <- osf_retrieve_node("ev38k")
df
osf_ls_files(df)