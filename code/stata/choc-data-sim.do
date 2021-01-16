capture log close
log using "code/stata/logs/choc-data-sim.txt", name(sim) replace text

//  program:  choc-data-sim.do
//  task:     simulate chocolate data
// 	input:    
//	output:   choc-data-raw.csv
//  project:  graduate student chocolate intervention study
//  author:   sam harper \ 2021-01-16

//  #0
//  program setup

version 16
set linesize 80
clear all
macro drop _all

// #1
// create individuals

clear
set seed 3781
set obs 500
generate id = _n


* generate random effect for individuals
* following a normal distribution N(0,2)
generate u_i = rnormal(0,2)

* set up treatment
gen rnum = runiform() // assign random number
sort rnum // sort by random number
gen treated = (_n <= _N/2) // 50% treated


// #2
// create longitudinal structure

* expand to 3 time periods per individual
expand 3

* create index for time periods 
bysort id: generate period = _n - 1

qui tab period, gen(p)

* generate random effects for each period
generate e_ij = rnormal(0,20)

* generate outcome
gen y = 10 + (p2 * 5) + (treated * p2 * 2) ///
  + (p3 * 10) + (treated * p3 * 5) ///
  + (u_i + e_ij)
  

// #3
// write to comma separated file
  
* write to csv file
export delimited id treated period y using ///
  "data-source/choc-data-raw.csv", replace 


log close sim
exit

