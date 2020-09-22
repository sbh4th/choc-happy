# load packages
library(osfr)
library(tidyverse)

proj <- osf_retrieve_node("3fcxd")
proj
osf_ls_nodes(proj)

proj %>%
  osf_ls_nodes() %>%
  filter(name == "Data") %>%
  osf_ls_nodes(pattern = "Study 19") %>%
  osf_ls_files()

df <- osf_retrieve_node("bygz3")
df
osf_ls_files(df)