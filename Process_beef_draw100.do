*please change to your directory
import delimited "C:\DOC\NTU Year3 Sem1\HE2022\Project\Data_Stata\Beef_data.csv" 

*convert hundredweight to pound
gen cattle_q_bpd = cattle_q_mpd/1000
gen beef_p_pd = beef_p_cwt/100

*convert string to float
gen cattle1_p_cwt_tx = real(cattle_p_cwt_tx)
*price of cattle per hundredweight
gen cattle_p_cwt = cattle_weightage_tx*cattle1_p_cwt_tx + cattle_weightage_ne*cattle_p_cwt_ne

*convert hundredweight to pound
gen cattle_p_pd = cattle_p_cwt/100

*calculate the marginal cost and marginal profit
gen mc_pd = cattle_p_pd + slaughter_processing_c_pd
gen mpi_pd = beef_p_pd - mc_pd

rename ïdate date

gen date2 = date(date, "DMY")
gen month = mofd(date2)
format month %tm
tsset month, monthly

rename month Month
rename mpi_pd Marginal_profit
rename mc_pd Marginal_cost
rename beef_p_pd Beef_price

*plot for periods after 2010
tsline Marginal_profit Marginal_cost Beef_price, tline(2020m3 2020m7, lcolor(purple)) tline((2021m1), lcolor(pink)) title("Marginal Profit, Marginal Cost,and Beef Price in $/pound") 
*plot for periods after July 2019
tsline Marginal_profit Marginal_cost Beef_price if date2>=21731, tline(2020m3 2020m7, lcolor(purple)) tline((2021m1), lcolor(pink)) title("Marginal Profit, Marginal Cost,and Beef Price in $/pound") 
