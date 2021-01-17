#  program:  choc-osfr.R
#  task:     push from project to OSF repository
#  input:    project files (various files)
#  output:   none
#  project:  chocolate and happiness
#  author:   sam harper \ 2021-01-17

# 0
# load packages
library(here)
library(osfr)
library(tidyverse)

# 1
# navigate to OSF project
proj <- osf_retrieve_node("3fcxd")
osf_ls_nodes(proj) # list components

# 2 
# write all code files to OSF
codefiles <- osf_ls_nodes(proj, pattern = "code")
setwd(here("code"))
osf_upload(codefiles, ".")
here()


# 3
# write data to OSF
osf_ls_nodes(proj, pattern = "data") %>%
  osf_upload(here("data-source"), ".") # data-source directory

osf_ls_nodes(proj, pattern = "data") %>%
  osf_upload(here("data-clean"), ".") # data-clean directory

# 4
# write outputs to OSF
out <- osf_ls_nodes(proj, pattern = "output")
setwd(here("output"))
osf_upload(out, ".")
here()


# 5
# write manuscripts to OSF
papers <- osf_ls_nodes(proj, pattern = "manuscripts")
setwd(here("manuscripts"))
osf_upload(papers, ".", conflicts = "overwrite")
here()

