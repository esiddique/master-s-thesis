clear all 

global path "/Users/emaansiddique/Desktop/Emaan Siddique/Work/LSE/extended essay"
global input "$path/input"
global output "$path/output"
global temp "$path/temp"
global excel "$path/excel/work product"
global programs "$path/programs"

*** FERTILIZER ***

use "$output/fertilizer", clear
gen FF=(inlist(company,"FFBL","FFC")==1)

collapse (mean) gross_sales cogs profit market_share profit_margin, by(FF year)
replace market_share=market_share*100
replace profit_margin=profit_margin*100

preserve
keep if FF==0
ren gross_sales C_rev 
ren cogs C_cost 
ren profit C_profit 
ren market_share C_MS 
ren profit_margin C_PM 
tempfile C_mean 
save `C_mean', replace
restore

keep if FF==1
ren gross_sales T_rev 
ren cogs T_cost 
ren profit T_profit 
ren market_share T_MS 
ren profit_margin T_PM 
merge 1:1 year using `C_mean'
drop _merge
order year T_MS C_MS T_PM C_PM T_rev C_rev T_cost C_cost T_profit C_profit 

export excel "$output/graphs/ff_fertilizer.xlsx", sheet("raw") sheetreplace first(var)
export delimited "$output/ff_fertilizer.csv", replace 

*** FERTILIZER OUTPUT ***
use "$output/fertilizer_2", clear
gen FF=(FF_per>0)

collapse (mean) output, by(FF year)

preserve
keep if FF==0
ren output C_output 
tempfile C_mean 
save `C_mean', replace
restore

keep if FF==1
ren output T_output 
merge 1:1 year using `C_mean'
drop _merge
order year T_output C_output
export delimited "$output/ff_fertilizer_output.csv", replace 

*** CEMENT ***

use "$output/cement", clear
gen FF=(company=="FCCL")

collapse (mean) gross_sales cogs profit market_share profit_margin, by(FF year)
replace market_share=market_share*100
replace profit_margin=profit_margin*100

preserve
keep if FF==0
ren gross_sales C_rev 
ren cogs C_cost 
ren profit C_profit 
ren market_share C_MS 
ren profit_margin C_PM 
tempfile C_mean 
save `C_mean', replace
restore

keep if FF==1
ren gross_sales T_rev 
ren cogs T_cost 
ren profit T_profit 
ren market_share T_MS 
ren profit_margin T_PM 
merge 1:1 year using `C_mean'
drop _merge
order year T_MS C_MS T_PM C_PM T_rev C_rev T_cost C_cost T_profit C_profit 

export excel "$output/graphs/ff_cement.xlsx", sheet("raw") sheetreplace first(var)
export delimited "$output/ff_cement.csv", replace 
