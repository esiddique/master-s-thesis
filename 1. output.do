clear all 

global path "/Users/emaansiddique/Desktop/Emaan Siddique/Work/LSE/extended essay"
global input "$path/input"
global output "$path/output"
global temp "$path/temp"
global excel "$path/excel/work product"
global programs "$path/programs"

use "$output/fertilizer", clear
keep year company gross_sales cogs profit NBP_shares FF_shares total_shares

replace company="FFCFFBL" if inlist(company,"FFBL","FFC")
collapse (sum) gross_sales cogs profit NBP_shares FF_shares total_shares, by(year company)
gen NBP_per=NBP_shares/total_shares
gen FF_per=FF_shares/total_shares
gen post=(year>2007)
gen NBP_per_did=(NBP_per*post)
gen FF_per_did=(FF_per*post)
drop *_shares post
sort company year

tempfile main1
save `main1', replace

*** ADD PRODUCTION ***
import excel using "$excel/industry.xlsx", sheet("fertilizer") first clear
drop if PERIOD=="" | year==""
keep year EFERT PAFL AGL FFCFFBL Total
destring year, replace

tempfile production
save `production', replace

keep year EFERT
ren EFERT output
gen company="EFERT"
tempfile main2 
save `main2', replace

foreach i in "PAFL" "AGL" "FFCFFBL" {
	use `production', clear
	keep year `i'
	ren `i' output 
	gen company="`i'"
	tempfile prod 
	save `prod', replace
	
	use `main2', clear 
	append using `prod'
	save `main2', replace
}

use `main1', clear
merge 1:1 year company using `main2'
drop _merge
sort company year

gen ln_output=ln(output)
replace ln_output=0 if ln_output==.

save `main1', replace

*** Add age variable ***
import excel using "$path/excel/work product/fertilizer.xlsx", sheet("company_info") first clear
drop if company==""
tempfile age
save `age', replace

use `main1', clear 
merge m:1 company using `age', keepusing(year_founded)
drop _merge 

gen age=year-year_founded
replace age=(1978+1993)/2 if company=="FFCFFBL"

drop if inlist(company,"FATIMA","FFC","FFBL")

save "$output/fertilizer_2", replace 
