cd "../code"

capture log close
log using 02-choc-data-clean.txt, replace text

//  program:  02-choc-data-analysis.do
//  task:     analysis of chocolate data
// 	input:    choc-data-clean.dta
//	output:   choc-t1, choc-t2, choc-f1
//  project:  graduate student chocolate intervention study
//  author:   sam harper \ 26jun2018

//  #0
//  program setup

version 14
set linesize 80
clear all
macro drop _all

* local tag for notes
local tag "02-choc-data-analysis.do sh 26jun2018"

// #1
// read in and verify clean data

use "../data-clean/choc-data-clean.dta", replace
datasignature confirm


// #2
// descriptive table

* Table 1
table period treated, c(mean happy sd happy) format(%4.2f)

* write to file
eststo est1: estpost tabstat happy if period==0, by(treated) ///
  statistics(mean sd) columns(statistics)
  
eststo est2: estpost tabstat happy if period==1, by(treated) ///
  statistics(mean sd) columns(statistics)
  
eststo est3: estpost tabstat happy if period==2, by(treated) ///
  statistics(mean sd) columns(statistics)
  
* Table for Word
esttab est1 est2 est3 using "../manuscripts/choc-t1.rtf", replace ///
  main(mean) aux(sd) unstack mtitles("Pre" "Intervention" "Post") ///
  nonum nostar collabels("Mean (SD)")
  
* LaTeX table
esttab est1 est2 est3 using "../manuscripts/choc-t1.tex", replace ///
  main(mean) aux(sd) unstack mtitles("Pre" "Intervention" "Post") ///
  nonum nostar collabels("Mean (SD)") ///
  title("Mean happiness by treatment and time")


// #3
// regression estimates

* Table 2
reg happy i.treated i.period
estimates store m1

* Table 3
* include product term
reg happy treated##period
estimates store m2

* Table of estimates
esttab m1 m2, b(%3.2f) ci(%3.2f) nostar ///
  keep(1.treated 1.period 2.period 1.treated#1.period ///
  1.treated#2.period _cons) ///
  coeflabel(1.treated "Treated (Yes vs. No)" 1.period ///
  "Time 1 vs. Time 0)" 2.period "Time 2 vs. Time 0" ///
  1.treated#1.period "Treated X Time 1" 1.treated#2.period ///
  "Treated X Time 2" _cons "Intercept") ///
  mtitles("Adjusted" "Interaction") ///
  title("Effect of chocolate on happiness index")

* write estimates to a table
esttab m1 m2 using "../manuscripts/choc-t2.rtf", ///
  replace b(%3.2f) ci(%3.2f) nostar ///
  keep(1.treated 1.period 2.period 1.treated#1.period ///
  1.treated#2.period _cons) ///
  coeflabel(1.treated "Treated (Yes vs. No)" 1.period ///
  "Time 1 vs. Time 0)" 2.period "Time 2 vs. Time 0" ///
  1.treated#1.period "Treated X Time 1" 1.treated#2.period ///
  "Treated X Time 2" _cons "Intercept") ///
  mtitles("Adjusted" "Interaction") ///
  title("Effect of chocolate on happiness index")
  
esttab m1 m2 using "../manuscripts/choc-t2.tex", ///
  replace b(%3.2f) ci(%3.2f) nostar ///
  keep(1.treated 1.period 2.period 1.treated#1.period ///
  1.treated#2.period _cons) ///
  coeflabel(1.treated "Yes vs. No" 1.period ///
  "Time 1 vs. Time 0" 2.period "Time 2 vs. Time 0" ///
  1.treated#1.period "Treated X Time 1" 1.treated#2.period ///
  "Treated X Time 2" _cons "Intercept") ///
  refcat(1.treated "\textbf{Treatment}" 1.period "\textbf{Time period}" ///
  1.treated#1.period "\textbf{Product terms}", nolabel) ///
  mtitles("Adjusted model" "Interaction model") ///
  title("Effect of chocolate on happiness")



// #3
// Figure for that product term model

estimates restore m2

* Figure 1
margins treated#period
marginsplot, xdim(period) title("Effect of chocolate on happiness") ///
  ytitle("Happiness index") plotopts(legend(title("Treatment group") ///
  ring(0) pos(10)))

graph export "../manuscripts/choc-f1.png", replace

log close
exit	






