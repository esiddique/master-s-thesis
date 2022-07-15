clear all 

global path "/Users/emaansiddique/Desktop/Emaan Siddique/Work/LSE/extended essay"
global input "$path/input"
global output "$path/output"
global temp "$path/temp"
global excel "$path/excel/work product"
global programs "$path/programs"

import excel using "$excel/cement.xlsx", sheet("cement") first clear
keep year company gross_sales cogs profit total_shares NBP_shares_orig NBP_shares_comp FF_shares NIT_ICP_shares mutual_funds
keep if year>=2003 & year<=2017

gen NBP_shares=0
replace NBP_shares=NBP_shares_orig if NBP_shares_orig>0 & NBP_shares_orig!=.
replace NBP_shares=NBP_shares_comp if NBP_shares_comp>0 & NBP_shares_comp!=.
drop NBP_shares_orig NBP_shares_comp

gen NIT_shares=0
replace NIT_shares=NIT_ICP_shares if NIT_ICP_shares>0 & NIT_ICP_shares!=.
replace NIT_shares=mutual_funds if mutual_funds>0 & mutual_funds!=.
drop NIT_ICP_shares mutual_funds

*** Generate market share and profit margin vars ***
preserve
tempfile annual_gross_sales
collapse (sum) gross_sales, by(year)
ren gross_sales annual_gross_sales
save `annual_gross_sales', replace
restore 

merge m:1 year using `annual_gross_sales'
drop _merge
gen market_share=gross_sales/annual_gross_sales
drop annual_gross_sales

gen profit_margin=profit/gross_sales
replace profit_margin=0 if profit_margin==.

gen ln_rev=log(gross_sales)
gen ln_cost=log(cogs)
gen ln_profit=log(profit)
replace ln_rev=0 if ln_rev==.
replace ln_cost=0 if ln_cost==.
replace ln_profit=0 if ln_profit==.
sort year company

*** Generate regressors ***
gen NBP_per = NBP_shares / total_shares
gen FF_per = FF_shares / total_shares
gen NIT_per = NIT_shares / total_shares

*** Generate post and DID var ***
gen post=(year>2007)
gen NBP_per_did=(NBP_per*post)
gen FF_per_did=(FF_per*post)
gen NIT_per_did=(NIT_per*post)

tempfile main 
save `main', replace

*** Add age variable ***
import excel using "$path/excel/work product/cement.xlsx", sheet("company_info") first clear
drop if company==""
tempfile age
save `age', replace

use `main', clear 
merge m:1 company using `age', keepusing(year_founded monthly_agreed_output_2003 daily_agreed_output_2018)
drop _merge 
sort company year

gen age=year-year_founded
save `main', replace

*** Calculate agreed output values ***

use `main', clear 
keep company year monthly_agreed_output daily_agreed_output_2018

expand 2 if year==2017
bys company year: gen dup=_n
replace year=2018 if dup==2
drop dup

gen agreed_output=.
replace agreed_output=12*monthly_agreed_output if (year>=2003 & year<=2005)
replace agreed=365*daily_agreed_output_2018 if year==2018
replace agreed_output=agreed_output/10^6
drop monthly_agreed_output daily_agreed_output_2018

bys company: ipolate agreed_output year, gen(agreed_output2)
drop agreed_output 
ren agreed_output2 agreed_output
drop if year==2018

tempfile agreed_output
save `agreed_output', replace

use `main', clear
merge 1:1 company year using `agreed_output'
drop _merge

*** Keep vars needed for analysis ***
keep year company market_share profit_margin gross_sales cogs profit ln_rev ln_cost ln_profit post NBP_per FF_per NBP_per_did FF_per_did age agreed_output

drop if inlist(company,"JVDC")

sort company year
save "$output/cement", replace
export delimited "$output/cement", replace 
