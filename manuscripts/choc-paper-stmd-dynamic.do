capture log close
log using "choc-paper-stmd-dynamic", smcl replace
//_1q
qui use "../data-clean/choc-data-clean.dta", clear
qui eststo est1: estpost tabstat happy if period==0, by(treated) ///
  statistics(mean sd) columns(statistics)
qui eststo est2: estpost tabstat happy if period==1, by(treated) ///
  statistics(mean sd) columns(statistics)
qui eststo est3: estpost tabstat happy if period==2, by(treated) ///
 statistics(mean sd) columns(statistics)
qui esttab est1 est2 est3 using "../output/choc-t1.tex", replace ///
  main(mean) aux(sd) unstack mtitles("Pre" "Intervention" "Post") ///
 nonum nostar collabels("Mean (SD)") ///
 title("Mean happiness by treatment and time")
//_2q
* regression models
qui reg happy i.treated i.period, vce(cl id)
estimates store m1
qui reg happy treated##period, vce(cl id)
estimates store m2
    
* estimate and 95%CI
local md = _b[1.treated#2.period]
local mdlb = _b[1.treated#2.period] - ///
  invttail(499,0.025)* _se[1.treated#2.period]
local mdub = _b[1.treated#2.period] + ///
  invttail(499,0.025) * _se[1.treated#2.period]
    
* Table of estimates
qui esttab m1 m2 using "../output/choc-t2.tex", ///
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
//_3
display %3.2f `md'
//_4
display %3.2f `mdlb'
//_5
display %3.2f `mdub'
//_6q
qui estimates restore m2
qui margins treated#period
qui marginsplot, xdim(period) title("Effect of chocolate on happiness") ///
  ytitle("Happiness index") plotopts(legend(title("Treatment group") ///
  ring(0) pos(10)))
qui graph export "../output/choc-f1.png", replace
//_^
log close
