capture log close
log using "code/stata/logs/01-choc-data-clean.txt", replace text

//  program:  01-choc-data-clean.do
//  task:     cleaning chocolate data
// 	input:    choc-data-raw.csv
//	output:   choc-data-clean.dta
//  project:  graduate student chocolate intervention study
//  author:   sam harper \ 2021-01-15

//  #0
//  program setup

version 14
set linesize 80
clear all
macro drop _all

* local tag for notes
local tag "1-choc-data-clean.do sh 2020-10-29"

// #1
// read in raw data

import delimited "data-source/choc-data-raw.csv", clear


// #2
// rename some variables, create labels

label var id "Individual unique ID"

* dependent variable
rename y happy
label var happy "Happiness index"

* treatment group
label var treated "Treated group?"

* generate post-treatment indicator
gen post = (period>0 & period!=.)
label var post "Post-treatment period?"

label define noyes 0 No 1 Yes
label values treated post noyes

* time variable
label var period "Time period"

label define period 0 "Pre" 1 "Intervention" 2 "Post", modify
label values period period
numlabel period, add


// #3
// save to a Stata dataset

notes: created from raw .csv file on 2020-03-01

label data "Chocolate study dataset 2020-03-02 \ `tag'"
datasignature set, reset
saveold "data-clean/choc-data-clean.dta", replace version(12)

log close
exit	






