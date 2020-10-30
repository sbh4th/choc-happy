# load packages
library(osfr)
library(tidyverse)

proj <- osf_retrieve_node("3fcxd")
proj
osf_ls_nodes(proj)

df <- osf_retrieve_node("ev38k")
df
osf_ls_files()