clear all 

global path "/Users/emaansiddique/Desktop/Emaan Siddique/Work/LSE/extended essay"
global input "$path/input"
global output "$path/output"
global temp "$path/temp"
global excel "$path/excel/work product"
global programs "$path/programs"

import excel using "$excel/fertilizer.xlsx", sheet("fertilizer") first clear
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

encode company, gen(company_n)
xtset company_n year 
order year company company_n

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
import excel using "$path/excel/work product/fertilizer.xlsx", sheet("company_info") first clear
drop if company==""
tempfile age
save `age', replace

use `main', clear 
merge m:1 company using `age', keepusing(year_founded)
drop _merge 

gen age=year-year_founded

*** Keep vars needed for analysis ***
keep year company market_share profit_margin gross_sales cogs profit ln_rev ln_cost ln_profit post NBP_shares FF_shares total_shares NBP_per FF_per NBP_per_did FF_per_did age 

drop if inlist(company,"FATIMA")

sort company year
save "$output/fertilizer", replace
