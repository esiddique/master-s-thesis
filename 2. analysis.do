clear all 

global path "/Users/emaansiddique/Desktop/Emaan Siddique/Work/LSE/extended essay"
global input "$path/input"
global output "$path/output"
global temp "$path/temp"
global excel "$path/excel/work product"
global programs "$path/programs"
	
	/// FERTILIZER ///
	
	use "$output/fertilizer", clear
	encode company, gen(company_n)
	order year company_n 
	keep year company_n NBP_per_did FF_per_did ln_rev ln_cost age
	tab company_n, generate(icompany)
	
	foreach var in ln_rev ln_cost {
		reg `var' NBP_per_did age icompany1 icompany2 icompany3 icompany4 i.year, cluster(company_n)
		eststo `var'1
	}
	
	foreach var in ln_rev ln_cost {
		reg `var' FF_per_did age icompany1 icompany2 icompany3 icompany4 i.year, cluster(company_n)
		eststo `var'2
	}
	
		foreach var in ln_rev ln_cost {
		reg `var' NBP_per_did FF_per_did age icompany1 icompany2 icompany3 icompany4 i.year, cluster(company_n)
		eststo `var'3
	}
	
	estout
	esttab using "$output/results/NBP_FF_fertilizer.tex", se replace ///
	title(Fertilizer — Effects of Competition Act on Revenue and Cost) ///
	refcat(icompany1 "Firms", nolabel) ///
	mtitles("Revenue" "Cost" "Revenue" "Cost" "Revenue" "Cost") ///
	coeflabels(NBP_per_did "NBP Shares x Post" FF_per_did "FF Shares x Post" age "Age" _cons "Constant" ///
	icompany1 "\hspace{0.1cm} AGL" icompany2 "\hspace{0.1cm} EFERT" icompany3 "\hspace{0.1cm} FFBL" icompany4 "\hspace{0.1cm} FFC") ///
	order(NBP_per_did FF_per_did age) ///
	drop(*.year) ///
	nonotes addnotes("Standard errors in parentheses and clustered at firm level." /// 
	"Dependent variables log transformed. Year fixed effects output suppressed." ///
	"\sym{*} \(p<0.05\), \sym{**} \(p<0.01\), \sym{***} \(p<0.001\)")
	
	/// CEMENT ///
	
	use "$output/cement", clear
	encode company, gen(company_n)
	order year company_n 
	keep year company_n NBP_per_did FF_per_did ln_rev ln_cost age
	
	foreach var in ln_rev ln_cost {
		reg `var' NBP_per_did age i.company_n i.year, cluster(company_n)
		eststo `var'1
	}
	
	foreach var in ln_rev ln_cost {
		reg `var' FF_per_did age i.company_n i.year, cluster(company_n)
		eststo `var'2
	}
	
		foreach var in ln_rev ln_cost {
		reg `var' NBP_per_did FF_per_did age i.company_n i.year, cluster(company_n)
		eststo `var'3
	}
	
	estout
	esttab using "$output/results/NBP_FF_cement.tex", se replace ///
	title(Cement — Effects of Competition Act on Revenue and Cost) ///
	refcat(icompany1 "Firms", nolabel) ///
	mtitles("Revenue" "Cost" "Revenue" "Cost" "Revenue" "Cost") ///
	coeflabels(NBP_per_did "NBP Shares x Post" FF_per_did "FF Shares x Post" ///
	age "Age" _cons "Constant") ///
	order(NBP_per_did FF_per_did age) ///
	drop(*.year *.company_n) ///
	nonotes addnotes("Standard errors in parentheses and clustered at firm level." ///
	"Dependent variables log transformed. Firm and year fixed effects output suppressed." ///
	"\sym{*} \(p<0.05\), \sym{**} \(p<0.01\), \sym{***} \(p<0.001\)")
	
	
	*** FERTILIZER OUTPUT ***
	clear all 
	global path "/Users/emaansiddique/Desktop/Emaan Siddique/Work/LSE/extended essay"
	global output "$path/output"
	use "$output/fertilizer_2", clear 
	
	encode company, gen(company_n)
	order year company_n 
	tab company_n, generate(icompany)
	
		reg ln_output NBP_per_did age icompany1 icompany2 icompany3 i.year, cluster(company_n)
		eststo m1
		
		reg ln_output FF_per_did age icompany1 icompany2 icompany3 i.year, cluster(company_n)
		eststo m2
		
		reg ln_output NBP_per_did FF_per_did age icompany1 icompany2 icompany3 i.year, cluster(company_n)
		eststo m3
		
	estout
	esttab using "$output/results/NBP_FF_output.tex", se replace ///
	title(Fertilizer — Effects of Competition Act on Sector Output) ///
	mtitles("Output" "Output" "Output") ///
	refcat(icompany1 "Firms", nolabel) ///
	coeflabels(NBP_per_did "NBP Shares x Post" FF_per_did "FF Shares x Post" age "Age" _cons "Constant" ///
	icompany1 "\hspace{0.1cm} AGL" icompany2 "\hspace{0.1cm} EFERT" icompany3 "\hspace{0.1cm} FFC/FFBL") ///
	order(NBP_per_did FF_per_did age) ///
	drop(*.year) ///
	nonotes addnotes("Standard errors in parentheses and clustered at firm level." ///
	"Dependent variables log transformed. Year fixed effects output suppressed." ///
	"\sym{*} \(p<0.05\), \sym{**} \(p<0.01\), \sym{***} \(p<0.001\)")
	