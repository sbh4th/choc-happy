capture log close master
log using "code/stata/logs/choc-master-dyn.txt", name(master) replace text

//  program:    choc-master-dynamic.do
//  task:		run all analyses, generate dynamic paper
//  project:    graduate student chocolate intervention study
//  author:     sam harper \ 2021-01-15

/*
Assumes the following file structure:

 - Markstat Stata Markdown file is in the 'manuscripts' folder

Note that markstat includes a number of dependencies that may
be specific to your operating system. See
http://data.princeton.edu/stata/markdown

*/

* change to manuscript directory
cd "manuscripts"

* dynamic version of manuscript
markstat using "choc-paper-stmd-dynamic.stmd", pdf bib

* back to project directory
cd ..

log close master
exit
