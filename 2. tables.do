clear all 

global path "/Users/emaansiddique/Desktop/Emaan Siddique/Work/LSE/extended essay"
global input "$path/input"
global output "$path/output"
global temp "$path/temp"

*** CEMENT *** 

use "$output/cement", clear
keep year company gross_sales cogs profit market_share profit_margin NBP_per FF_per

*** Merge in "founded" sheet
preserve
tempfile founded
import excel using "$path/excel/work product/cement.xlsx", sheet("company_info") first clear
save `founded', replace
drop if company=="JVDC"
restore 

merge m:1 company using `founded', keepusing(year_founded)
drop _merge 
order year_founded year company 

gen type=""
replace type="NBP" if (NBP_per>0)
replace type="FF" if (FF_per>0)
replace type="other" if (NBP_per==0 & FF_per==0)
drop if type=="other"

foreach var in market_share profit_margin FF_per NBP_per {
	replace `var'=`var'*100
}

bys type: eststo: estpost sum year_founded gross_sales cogs profit market_share profit_margin FF_per NBP_per, listwise
esttab using "$output/tables/cement.tex", ///
b(0) main(mean) not replace ///
refcat(gross_sales "Firm Performance (PKR million)" market_share "Industry Performance (\%)" FF_per "Shareholding (\%)", nolabel) ///
coeflabels(year_founded "Year Founded" gross_sales "\hspace{0.1cm} Revenue" cogs "\hspace{0.1cm} Cost" profit "\hspace{0.1cm} Profit" market_share "\hspace{0.1cm} Market Share" profit_margin "\hspace{0.1cm} Profit Margin" FF_per "\hspace{0.1cm} Military" NBP_per "\hspace{0.1cm} Public") ///
label mtitle("Military" "Government" "Civilian") title(Cement Industry 2003-2007) ///
nogaps nonumbers nonotes nostar compress 

*** FERTILIZER ***
clear all
use "$output/fertilizer", clear
keep year company gross_sales cogs profit market_share profit_margin NBP_per FF_per

*** Merge in "founded" sheet
preserve
tempfile founded
import excel using "$path/excel/work product/fertilizer.xlsx", sheet("company_info") first clear
drop if company==""
save `founded', replace
restore 

merge m:1 company using `founded', keepusing(year_founded)
drop _merge 
order year_founded year company 

gen type=""
replace type="NBP" if (NBP_per>0)
replace type="FF" if (FF_per>0)
replace type="other" if (NBP_per==0 & FF_per==0)

foreach var in market_share profit_margin FF_per NBP_per {
	replace `var'=`var'*100
}

bys type: eststo: estpost sum year_founded gross_sales cogs profit market_share profit_margin FF_per NBP_per, listwise
esttab using "$output/tables/fertilizer.tex", ///
b(0) main(mean) not replace ///
refcat(gross_sales "Firm Performance (PKR million)" market_share "Industry Performance (\%)" FF_per "Shareholding (\%)", nolabel) ///
coeflabels(year_founded "Year Founded" gross_sales "\hspace{0.1cm} Revenue" cogs "\hspace{0.1cm} Cost" profit "\hspace{0.1cm} Profit" market_share "\hspace{0.1cm} Market Share" profit_margin "\hspace{0.1cm} Profit Margin" FF_per "\hspace{0.1cm} Military" NBP_per "\hspace{0.1cm} Public") ///
label mtitle("Military" "Government" "Civilian") title(Fertilizer Industry 2003-2007) ///
nogaps nonumbers nonotes nostar compress 
