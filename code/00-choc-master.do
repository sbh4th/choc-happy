capture log close master
log using "code/choc-master.txt", name(master) replace text

//  program:    choc-master.do
//  task:		run all analyses, generate paper
//  project:    graduate student chocolate intervention study
//  author:     sam harper \ 27feb2020

/* 
Assumes the following file structure: 

 - Do-files are located in a folder named "code".
 - Source data are in the "data-source" folder.
 - Derived datasets are in the "data-clean" folder.
  

Required user-written programs: -tabout, -estout, -markstat
Can be downloaded by typing "ssc install tabout, replace"  and
"ssc install tabout, replace", etc. into the Stata command line

Note that markstat includes a number of dependencies that may
be specific to your operating system. See 
http://data.princeton.edu/stata/markdown

*/

do "code/01-choc-data-clean.do"      // create analytic dataset
do "code/02-choc-data-analysis.do"   // tables and figures

* change to manuscript directory
cd "manuscripts"

* generate the manuscript
markstat using "choc-paper-stmd.stmd", pdf bib

* dynamic version
* markstat using "choc-paper-stmd-dynamic.stmd", pdf bib

* back to project directory
cd ..


log close master
exit