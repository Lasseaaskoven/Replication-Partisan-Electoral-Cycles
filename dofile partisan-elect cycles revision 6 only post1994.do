

*Data note: New Zealand general government expenditure from IMF WEO*

* Setting paneldata*
tsset countrynr year


*Creating the interaction between leftwing chief executive and election*
generate interactleftwingelection= leftwingchiefexecutive* chiefexelection

*Creating the singepartygovernment dummy*
generate singlepartygov=0
replace singlepartygov=1 if herfgovdpi==1

*Creating the minority goverment dummy*
generate minoritygov=0
replace minoritygov=1 if majdpi<0.5

*Creating the endogenous election dummy*
generate endogenouselection=0
replace endogenouselection=1 if chiefexelection==1 & predictedelection==0


*Creating GDP per inhabitants in 1000s*
generate gdpcap1000=gdppercapitalconstantpricesoecd/1000

*Creating the Franzese measure of election year*
replace dateleg=. if dateleg==-999
replace dateexec=. if dateexec==-999
generate electionmonth=.
replace electionmonth=dateleg
replace electionmonth= dateexec if countrynr==7 | countrynr==21
generate franzeseelection=0
replace franzeseelection= electionmonth/12 if chiefexelection==1
replace franzeseelection =(12-f1.electionmonth)/12 if f1.chiefexelection==1

generate franzeseelectionp=0
replace franzeseelectionp= electionmonth/12 if predictedelection==1
replace franzeseelectionp =(12-f1.electionmonth)/12 if f1.predictedelection==1

*Generating center and right dummies*
generate centerchief=0
replace centerchief=1 if execrlc==2

generate rightchief=0
replace rightchief=1 if execrlc==3

* Figure 1: Public employment in several countries*

xtline  publicemploymentpctemployment, t(year) i( country ) overlay  plot1(lcolor(black) lpattern(dash)) plot2(lcolor(gs10) lpattern(line)) plot3(lcolor(black) lpattern(solid)) plot4(lcolor(black) lpattern(shortdash))plot5(lcolor(black) lpattern(longdash dot))plot6(lcolor(gs10) lpattern(dash)) xscale( range(1995 2010)) yscale(range (10 35)), if year>1994 & countrynr==5 | year>1994 & countrynr==6 | year>1994 & countrynr==8 |year>1994 & countrynr==14 |  year>1994 & countrynr==17 |  year> 1994 & countrynr==21  ,  ytitle (Percent publically employed)  xlabel( 1995 2000 2005 2010) ylabel( 10 20 30 35) graphregion(color(white)) legend(label(1 "Denmark") label(2 "Finland") label(3 "Germany") label(4 "Italy") label (5 "Spain") label (6 "United States"))

*Testing for stationarity in the dependent variable*
xtunitroot fisher publicemploymentpctemployment, dfuller   lag(1)
xtunitroot fisher publicemploymentpctemployment, dfuller  trend lag(1)


xtfisher publicemploymentpctemployment, drift 
xtfisher publicemploymentpctemployment, lag(1)
xtfisher publicemploymentpctemployment, lag(1) trend
xtfisher publicemploymentpctemployment, lag(1) drift 
xtfisher publicemploymentpctemployment, lag(2)

*Table 1: Descriptive statistics* 
xtsum publicemploymentpctemployment leftwingchiefexecutive gov_left1 chiefexecutiverile gdpcap1000 generalgovernmentexpenditurepctg unemploymentoecd gdpgrowthrateoecd chiefexelection predictedelection endogenouselection totaltaxespctgdp minoritygov singlepartygov   if publicemploymentpctemployment!=. & year>1994


*Correlation matrix*
corr leftwingchiefexecutive chiefexelection gdpcap1000 gdpgrowthrateoecd unemploymentoecd   generalgovernmentexpenditurepctg

*Testing for serial correlation with full models* 
xtserial publicemploymentpctemployment leftwingchiefexecutive gdpcap1000 generalgovernmentexpenditurepctg unemploymentoecd gdpgrowthrateoecd chiefexelection
xtserial  publicemploymentpctemployment leftwingchiefexecutive gdpcap1000 generalgovernmentexpenditurepctg unemploymentoecd gdpgrowthrateoecd chiefexelection interactleftwingelection

*Table 2 & appendix A Partisan and electoral cycles, yeardummies in half the cases *
xtreg publicemploymentpctemployment leftwingchiefexecutive,fe cluster (countrynr), if year>1994
xtreg publicemploymentpctemployment chiefexelection,fe cluster (countrynr), if year>1994

xtreg publicemploymentpctemployment leftwingchiefexecutive i.year,fe cluster (countrynr), if year>1994
xtreg publicemploymentpctemployment chiefexelection i.year,fe cluster (countrynr), if year>1994

xtreg publicemploymentpctemployment leftwingchiefexecutive gdpcap1000 gdpgrowthrateoecd, fe cluster (countrynr), if year>1994
xtreg publicemploymentpctemployment  chiefexelection gdpcap1000 gdpgrowthrateoecd, fe cluster (countrynr), if year>1994

xtreg publicemploymentpctemployment leftwingchiefexecutive gdpcap1000 gdpgrowthrateoecd i.year, fe cluster (countrynr), if year>1994
xtreg publicemploymentpctemployment chiefexelection gdpcap1000 gdpgrowthrateoecd i.year, fe cluster (countrynr), if year>1994

xtreg publicemploymentpctemployment leftwingchiefexecutive gdpcap1000 unemploymentoecd  gdpgrowthrateoecd, fe cluster (countrynr), if year>1994
xtreg publicemploymentpctemployment chiefexelection gdpcap1000 unemploymentoecd  gdpgrowthrateoecd, fe cluster (countrynr), if year>1994

xtreg publicemploymentpctemployment leftwingchiefexecutive gdpcap1000 unemploymentoecd gdpgrowthrateoecd i.year, fe cluster (countrynr), if year>1994
xtreg publicemploymentpctemployment chiefexelection gdpcap1000 unemploymentoecd gdpgrowthrateoecd i.year, fe cluster (countrynr), if year>1994

xtreg publicemploymentpctemployment leftwingchiefexecutive gdpcap1000 generalgovernmentexpenditurepctg unemploymentoecd gdpgrowthrateoecd, fe cluster (countrynr), if year>1994
xtreg publicemploymentpctemployment chiefexelection gdpcap1000 generalgovernmentexpenditurepctg unemploymentoecd gdpgrowthrateoecd, fe cluster (countrynr), if year>1994

xtreg publicemploymentpctemployment leftwingchiefexecutive gdpcap1000 generalgovernmentexpenditurepctg unemploymentoecd gdpgrowthrateoecd  i.year, fe cluster (countrynr), if year>1994
xtreg publicemploymentpctemployment chiefexelection gdpcap1000 generalgovernmentexpenditurepctg unemploymentoecd gdpgrowthrateoecd  i.year, fe cluster (countrynr), if year>1994

xtreg publicemploymentpctemployment leftwingchiefexecutive gdpcap1000 generalgovernmentexpenditurepctg unemploymentoecd  gdpgrowthrateoecd chiefexelection, fe cluster (countrynr), if year>1994
xtreg publicemploymentpctemployment leftwingchiefexecutive gdpcap1000 generalgovernmentexpenditurepctg unemploymentoecd gdpgrowthrateoecd chiefexelection   i.year, fe cluster (countrynr), if year>1994


*Appendix B: Check for different measure of ideology rile from Manifesto*
xtreg publicemploymentpctemployment chiefexecutiverile,fe cluster (countrynr), if year>1994

xtreg publicemploymentpctemployment chiefexecutiverile i.year,fe cluster (countrynr), if year>1994

xtreg publicemploymentpctemployment chiefexecutiverile gdpcap1000 gdpgrowthrateoecd, fe cluster (countrynr), if year>1994

xtreg publicemploymentpctemployment chiefexecutiverile gdpcap1000 gdpgrowthrateoecd i.year, fe cluster (countrynr), if year>1994

xtreg publicemploymentpctemployment chiefexecutiverile gdpcap1000 unemploymentoecd  gdpgrowthrateoecd, fe cluster (countrynr), if year>1994

xtreg publicemploymentpctemployment  chiefexecutiverile gdpcap1000 unemploymentoecd gdpgrowthrateoecd i.year, fe cluster (countrynr), if year>1994
 
xtreg publicemploymentpctemployment chiefexecutiverile gdpcap1000 generalgovernmentexpenditurepctg unemploymentoecd gdpgrowthrateoecd, fe cluster (countrynr), if year>1994

xtreg publicemploymentpctemployment chiefexecutiverile gdpcap1000 generalgovernmentexpenditurepctg unemploymentoecd gdpgrowthrateoecd  i.year, fe cluster (countrynr), if year>1994

xtreg publicemploymentpctemployment chiefexecutiverile gdpcap1000 generalgovernmentexpenditurepctg unemploymentoecd  gdpgrowthrateoecd chiefexelection, fe cluster (countrynr), if year>1994

xtreg publicemploymentpctemployment chiefexecutiverile gdpcap1000 generalgovernmentexpenditurepctg unemploymentoecd  gdpgrowthrateoecd chiefexelection i.year, fe cluster (countrynr), if year>1994

xtreg publicemploymentpctemployment  gdpcap1000 generalgovernmentexpenditurepctg unemploymentoecd  gdpgrowthrateoecd c.chiefexecutiverile##c.chiefexelection i.year, fe cluster (countrynr), if year>1994

xtreg publicemploymentpctemployment  gdpcap1000 generalgovernmentexpenditurepctg unemploymentoecd  gdpgrowthrateoecd c.chiefexecutiverile##c.predictedelection i.year, fe cluster (countrynr), if year>1994


*Check for different measure of ideology welfare from Manifesto*
xtreg publicemploymentpctemployment chiefexecutivewelfare,fe cluster (countrynr), if year>1994

xtreg publicemploymentpctemployment chiefexecutivewelfare i.year,fe cluster (countrynr), if year>1994

xtreg publicemploymentpctemployment chiefexecutivewelfare gdpcap1000 gdpgrowthrateoecd, fe cluster (countrynr), if year>1994

xtreg publicemploymentpctemployment chiefexecutivewelfare gdpcap1000 gdpgrowthrateoecd i.year, fe cluster (countrynr), if year>1994

xtreg publicemploymentpctemployment chiefexecutivewelfare gdpcap1000 unemploymentoecd  gdpgrowthrateoecd, fe cluster (countrynr), if year>1994

xtreg publicemploymentpctemployment  chiefexecutivewelfare gdpcap1000 unemploymentoecd gdpgrowthrateoecd i.year, fe cluster (countrynr), if year>1994

xtreg publicemploymentpctemployment chiefexecutivewelfare gdpcap1000 generalgovernmentexpenditurepctg unemploymentoecd gdpgrowthrateoecd, fe cluster (countrynr), if year>1994

xtreg publicemploymentpctemployment chiefexecutivewelfare gdpcap1000 generalgovernmentexpenditurepctg unemploymentoecd gdpgrowthrateoecd  i.year, fe cluster (countrynr), if year>1994

xtreg publicemploymentpctemployment  chiefexecutivewelfare gdpcap1000 generalgovernmentexpenditurepctg unemploymentoecd  gdpgrowthrateoecd chiefexelection, fe cluster (countrynr), if year>1994

xtreg publicemploymentpctemployment  chiefexecutivewelfare gdpcap1000 generalgovernmentexpenditurepctg unemploymentoecd  gdpgrowthrateoecd chiefexelection i.year , fe cluster (countrynr), if year>1994

xtreg publicemploymentpctemployment   gdpcap1000 generalgovernmentexpenditurepctg unemploymentoecd  gdpgrowthrateoecd c.chiefexecutivewelfare##c.chiefexelection i.year , fe cluster (countrynr), if year>1994

xtreg publicemploymentpctemployment   gdpcap1000 generalgovernmentexpenditurepctg unemploymentoecd  gdpgrowthrateoecd c.chiefexecutivewelfare##c.predictedelection i.year , fe cluster (countrynr), if year>1994




*Appendix C: Checks for  share of leftwing cabinet*
xtreg publicemploymentpctemployment gov_left1 ,fe cluster (countrynr), if year>1994

xtreg publicemploymentpctemployment gov_left1 i.year,fe cluster (countrynr), if year>1994

xtreg publicemploymentpctemployment gov_left1 gdpcap1000 gdpgrowthrateoecd, fe cluster (countrynr), if year>1994

xtreg publicemploymentpctemployment gov_left1 gdpcap1000 gdpgrowthrateoecd i.year, fe cluster (countrynr), if year>1994

xtreg publicemploymentpctemployment gov_left1 gdpcap1000 unemploymentoecd  gdpgrowthrateoecd, fe cluster (countrynr), if year>1994

xtreg publicemploymentpctemployment  gov_left1 gdpcap1000 unemploymentoecd gdpgrowthrateoecd i.year, fe cluster (countrynr), if year>1994

xtreg publicemploymentpctemployment gov_left1 gdpcap1000 generalgovernmentexpenditurepctg unemploymentoecd gdpgrowthrateoecd, fe cluster (countrynr), if year>1994

xtreg publicemploymentpctemployment gov_left1 gdpcap1000 generalgovernmentexpenditurepctg unemploymentoecd gdpgrowthrateoecd  i.year, fe cluster (countrynr), if year>1994

xtreg publicemploymentpctemployment  gov_left1 gdpcap1000 generalgovernmentexpenditurepctg unemploymentoecd  gdpgrowthrateoecd chiefexelection, fe cluster (countrynr), if year>1994

xtreg publicemploymentpctemployment  gov_left1 gdpcap1000 generalgovernmentexpenditurepctg unemploymentoecd  gdpgrowthrateoecd chiefexelection i.year, fe cluster (countrynr), if year>1994

xtreg publicemploymentpctemployment   gdpcap1000 generalgovernmentexpenditurepctg unemploymentoecd  gdpgrowthrateoecd c.gov_left1##c.chiefexelection i.year, fe cluster (countrynr), if year>1994

xtreg publicemploymentpctemployment   gdpcap1000 generalgovernmentexpenditurepctg unemploymentoecd  gdpgrowthrateoecd c.gov_left1##c.predictedelection i.year, fe cluster (countrynr), if year>1994



*Foot note lag structures*
xtreg publicemploymentpctemployment l.leftwingchiefexecutive gdpcap1000 generalgovernmentexpenditurepctg unemploymentoecd gdpgrowthrateoecd chiefexelection   i.year, fe cluster (countrynr), if year>1994
xtreg publicemploymentpctemployment l2.leftwingchiefexecutive gdpcap1000 generalgovernmentexpenditurepctg unemploymentoecd gdpgrowthrateoecd chiefexelection   i.year, fe cluster (countrynr), if year>1994
xtreg publicemploymentpctemployment l3.leftwingchiefexecutive gdpcap1000 generalgovernmentexpenditurepctg unemploymentoecd gdpgrowthrateoecd chiefexelection   i.year, fe cluster (countrynr), if year>1994

xtreg publicemploymentpctemployment leftwingchiefexecutive l.gdpcap1000 l.generalgovernmentexpenditurepctg l.unemploymentoecd  l.gdpgrowthrateoecd chiefexelection i.year, fe cluster (countrynr), if year>1994
xtreg publicemploymentpctemployment leftwingchiefexecutive l.gdpcap1000 l.generalgovernmentexpenditurepctg l.unemploymentoecd l.gdpgrowthrateoecd  chiefexelection interactleftwingelection i.year, fe cluster (countrynr), if year>1994
xtreg publicemploymentpctemployment leftwingchiefexecutive l.gdpcap1000 l.generalgovernmentexpenditurepctg l.unemploymentoecd l.gdpgrowthrateoecd predictedelection c.leftwingchiefexecutive##c.endogenouselection c.leftwingchiefexecutive##c.predictedelection i.year, fe cluster (countrynr), if year>1994




*Table 2: Partisanship/Election interaction* 
xtreg publicemploymentpctemployment leftwingchiefexecutive gdpcap1000 generalgovernmentexpenditurepctg unemploymentoecd gdpgrowthrateoecd  chiefexelection interactleftwingelection, fe cluster (countrynr), if year>1994
xtreg publicemploymentpctemployment leftwingchiefexecutive gdpcap1000 generalgovernmentexpenditurepctg unemploymentoecd gdpgrowthrateoecd chiefexelection interactleftwingelection  i.year, fe cluster (countrynr), if year>1994


xtreg publicemploymentpctemployment c.leftwingchiefexecutive##c.chiefexelection gdpcap1000 generalgovernmentexpenditurepctg unemploymentoecd gdpgrowthrateoecd i.year, fe cluster (countrynr), if year>1994
margins, dydx(leftwingchiefexecutive) over(chiefexelection)
marginsplot, level(90) ytitle(Effect of left-wing government on public employment) xtitle(Election occurence)scheme(s2mono) xlabel(0 "No election" 1 "Election")  graphregion(color(white))legend (off)

generate predictedinteraction= leftwingchiefexecutive*predictedelection
generate endogenousinteraction= leftwingchiefexecutive*endogenouselection

xtreg publicemploymentpctemployment leftwingchiefexecutive gdpcap1000 generalgovernmentexpenditurepctg unemploymentoecd gdpgrowthrateoecd chiefexelection c.leftwingchiefexecutive##c.chiefexelection i.year, fe cluster (countrynr), if year>1994
xtreg publicemploymentpctemployment leftwingchiefexecutive gdpcap1000 generalgovernmentexpenditurepctg unemploymentoecd gdpgrowthrateoecd predictedelection c.leftwingchiefexecutive##c.predictedelection i.year, fe cluster (countrynr), if year>1994
margins, dydx(leftwingchiefexecutive) over(predictedelection )
marginsplot, level(90)ylabel(1 0.5 0 -0.5 -1) ytitle(Effect of left-wing government on public employment) xtitle(Occurence of a predicted election) xlabel(0 "No election" 1 "Election")scheme(s2mono) yline(0, lstyle(grid) lcolor(gs8) lpattern(dash)) graphregion(color(white))legend (off)

xtreg publicemploymentpctemployment leftwingchiefexecutive gdpcap1000 generalgovernmentexpenditurepctg unemploymentoecd gdpgrowthrateoecd endogenouselection c.leftwingchiefexecutive##c.endogenouselection i.year, fe cluster (countrynr), if year>1994
xtreg publicemploymentpctemployment leftwingchiefexecutive gdpcap1000 generalgovernmentexpenditurepctg unemploymentoecd gdpgrowthrateoecd endogenouselection c.leftwingchiefexecutive##c.endogenouselection c.leftwingchiefexecutive##c.predictedelection i.year, fe cluster (countrynr), if year>1994
xtreg publicemploymentpctemployment leftwingchiefexecutive gdpcap1000 generalgovernmentexpenditurepctg unemploymentoecd gdpgrowthrateoecd endogenouselection  endogenousinteraction predictedelection predictedinteraction i.year, fe cluster (countrynr), if year>1994
test endogenousinteraction = predictedinteraction



*Vif tests*
reg publicemploymentpctemployment leftwingchiefexecutive gdpcap1000 generalgovernmentexpenditurepctg unemploymentoecd gdpgrowthrateoecd chiefexelection   i.year i.countrynr,  cluster (countrynr), if year>1994
vif 

reg publicemploymentpctemployment leftwingchiefexecutive gdpcap1000 generalgovernmentexpenditurepctg unemploymentoecd gdpgrowthrateoecd chiefexelection  if year>1994
vif 

*Footnote: Running without high VIF variables* 
xtreg publicemploymentpctemployment leftwingchiefexecutive  unemploymentoecd gdpgrowthrateoecd chiefexelection   i.year, fe cluster (countrynr), if year>1994
xtreg publicemploymentpctemployment leftwingchiefexecutive  unemploymentoecd gdpgrowthrateoecd chiefexelection c.leftwingchiefexecutive##c.chiefexelection i.year, fe cluster (countrynr), if year>1994
xtreg publicemploymentpctemployment leftwingchiefexecutive  unemploymentoecd gdpgrowthrateoecd predictedelection c.leftwingchiefexecutive##c.predictedelection i.year, fe cluster (countrynr), if year>1994
xtreg publicemploymentpctemployment leftwingchiefexecutive  unemploymentoecd gdpgrowthrateoecd endogenouselection c.leftwingchiefexecutive##c.endogenouselection i.year, fe cluster (countrynr), if year>1994
xtreg publicemploymentpctemployment leftwingchiefexecutive  unemploymentoecd gdpgrowthrateoecd c.leftwingchiefexecutive##c.predictedelection c.leftwingchiefexecutive##c.endogenouselection  i.year, fe cluster (countrynr), if year>1994



*Footnote: Running without control variables*
xtreg publicemploymentpctemployment leftwingchiefexecutive   chiefexelection   i.year, fe cluster (countrynr), if year>1994
xtreg publicemploymentpctemployment leftwingchiefexecutive    c.leftwingchiefexecutive##c.chiefexelection i.year, fe cluster (countrynr), if year>1994
xtreg publicemploymentpctemployment leftwingchiefexecutive    c.leftwingchiefexecutive##c.predictedelection i.year, fe cluster (countrynr), if year>1994
xtreg publicemploymentpctemployment leftwingchiefexecutive  c.leftwingchiefexecutive##c.endogenouselection i.year, fe cluster (countrynr), if year>1994
xtreg publicemploymentpctemployment leftwingchiefexecutive   c.leftwingchiefexecutive##c.predictedelection c.leftwingchiefexecutive##c.endogenouselection  i.year, fe cluster (countrynr), if year>1994




*Table 3: Robustness check:*


*Control for tax levels* 
xtreg publicemploymentpctemployment leftwingchiefexecutive gdpcap1000 generalgovernmentexpenditurepctg unemploymentoecd gdpgrowthrateoecd predictedelection c.leftwingchiefexecutive##c.predictedelection totaltaxespctgdp i.year, fe cluster (countrynr), if year>1994


*Controlling for minority gov*
xtreg publicemploymentpctemployment leftwingchiefexecutive gdpcap1000 generalgovernmentexpenditurepctg unemploymentoecd gdpgrowthrateoecd  c.leftwingchiefexecutive##c.predictedelection minoritygov i.year, fe cluster (countrynr), if year>1994

*Controlling for single party government*
xtreg publicemploymentpctemployment leftwingchiefexecutive gdpcap1000 generalgovernmentexpenditurepctg unemploymentoecd gdpgrowthrateoecd predictedelection c.leftwingchiefexecutive##c.predictedelection singlepartygov i.year, fe cluster (countrynr), if year>1994

xtreg publicemploymentpctemployment leftwingchiefexecutive gdpcap1000 generalgovernmentexpenditurepctg unemploymentoecd gdpgrowthrateoecd predictedelection c.leftwingchiefexecutive##c.predictedelection##c.singlepartygov i.year, fe cluster (countrynr), if year>1994


*Excluding Switzerland*
xtreg publicemploymentpctemployment leftwingchiefexecutive gdpcap1000 generalgovernmentexpenditurepctg unemploymentoecd gdpgrowthrateoecd predictedelection c.leftwingchiefexecutive##c.predictedelection i.year, fe cluster (countrynr), if countrynr!=19 &  year>1994

*Excluding Greece*
xtreg publicemploymentpctemployment leftwingchiefexecutive gdpcap1000 generalgovernmentexpenditurepctg unemploymentoecd gdpgrowthrateoecd predictedelection c.leftwingchiefexecutive##c.predictedelection i.year, fe cluster (countrynr), if countrynr!=9 &  year>1994

*Test without countries without endogenous elections (Finland, France, Luxembourg,New Zealand Norway,Sweden Schwitzerland & US)* 
xtreg publicemploymentpctemployment leftwingchiefexecutive gdpcap1000 generalgovernmentexpenditurepctg unemploymentoecd gdpgrowthrateoecd predictedelection c.leftwingchiefexecutive##c.predictedelection i.year, fe cluster (countrynr), if countrynr!=7 & countrynr!=22 & countrynr!=22 & countrynr!=18 & countrynr!=7 & countrynr!=15 & countrynr!=19 & countrynr!=21 & year>1994


*Foot note, removing all other countries*
xtreg publicemploymentpctemployment leftwingchiefexecutive gdpcap1000 generalgovernmentexpenditurepctg unemploymentoecd gdpgrowthrateoecd predictedelection c.leftwingchiefexecutive##c.predictedelection i.year, fe cluster (countrynr), if countrynr!=1 &  year>1994
xtreg publicemploymentpctemployment leftwingchiefexecutive gdpcap1000 generalgovernmentexpenditurepctg unemploymentoecd gdpgrowthrateoecd predictedelection c.leftwingchiefexecutive##c.predictedelection i.year, fe cluster (countrynr), if countrynr!=2 &  year>1994
xtreg publicemploymentpctemployment leftwingchiefexecutive gdpcap1000 generalgovernmentexpenditurepctg unemploymentoecd gdpgrowthrateoecd predictedelection c.leftwingchiefexecutive##c.predictedelection i.year, fe cluster (countrynr), if countrynr!=3 &  year>1994
xtreg publicemploymentpctemployment leftwingchiefexecutive gdpcap1000 generalgovernmentexpenditurepctg unemploymentoecd gdpgrowthrateoecd predictedelection c.leftwingchiefexecutive##c.predictedelection i.year, fe cluster (countrynr), if countrynr!=4 &  year>1994
xtreg publicemploymentpctemployment leftwingchiefexecutive gdpcap1000 generalgovernmentexpenditurepctg unemploymentoecd gdpgrowthrateoecd predictedelection c.leftwingchiefexecutive##c.predictedelection i.year, fe cluster (countrynr), if countrynr!=5 &  year>1994
xtreg publicemploymentpctemployment leftwingchiefexecutive gdpcap1000 generalgovernmentexpenditurepctg unemploymentoecd gdpgrowthrateoecd predictedelection c.leftwingchiefexecutive##c.predictedelection i.year, fe cluster (countrynr), if countrynr!=6 &  year>1994
xtreg publicemploymentpctemployment leftwingchiefexecutive gdpcap1000 generalgovernmentexpenditurepctg unemploymentoecd gdpgrowthrateoecd predictedelection c.leftwingchiefexecutive##c.predictedelection i.year, fe cluster (countrynr), if countrynr!=7 &  year>1994
xtreg publicemploymentpctemployment leftwingchiefexecutive gdpcap1000 generalgovernmentexpenditurepctg unemploymentoecd gdpgrowthrateoecd predictedelection c.leftwingchiefexecutive##c.predictedelection i.year, fe cluster (countrynr), if countrynr!=8 &  year>1994
xtreg publicemploymentpctemployment leftwingchiefexecutive gdpcap1000 generalgovernmentexpenditurepctg unemploymentoecd gdpgrowthrateoecd predictedelection c.leftwingchiefexecutive##c.predictedelection i.year, fe cluster (countrynr), if countrynr!=9 &  year>1994
xtreg publicemploymentpctemployment leftwingchiefexecutive gdpcap1000 generalgovernmentexpenditurepctg unemploymentoecd gdpgrowthrateoecd predictedelection c.leftwingchiefexecutive##c.predictedelection i.year, fe cluster (countrynr), if countrynr!=10 &  year>1994
xtreg publicemploymentpctemployment leftwingchiefexecutive gdpcap1000 generalgovernmentexpenditurepctg unemploymentoecd gdpgrowthrateoecd predictedelection c.leftwingchiefexecutive##c.predictedelection i.year, fe cluster (countrynr), if countrynr!=11 &  year>1994
xtreg publicemploymentpctemployment leftwingchiefexecutive gdpcap1000 generalgovernmentexpenditurepctg unemploymentoecd gdpgrowthrateoecd predictedelection c.leftwingchiefexecutive##c.predictedelection i.year, fe cluster (countrynr), if countrynr!=12 &  year>1994
xtreg publicemploymentpctemployment leftwingchiefexecutive gdpcap1000 generalgovernmentexpenditurepctg unemploymentoecd gdpgrowthrateoecd predictedelection c.leftwingchiefexecutive##c.predictedelection i.year, fe cluster (countrynr), if countrynr!=13 &  year>1994
xtreg publicemploymentpctemployment leftwingchiefexecutive gdpcap1000 generalgovernmentexpenditurepctg unemploymentoecd gdpgrowthrateoecd predictedelection c.leftwingchiefexecutive##c.predictedelection i.year, fe cluster (countrynr), if countrynr!=14 &  year>1994
xtreg publicemploymentpctemployment leftwingchiefexecutive gdpcap1000 generalgovernmentexpenditurepctg unemploymentoecd gdpgrowthrateoecd predictedelection c.leftwingchiefexecutive##c.predictedelection i.year, fe cluster (countrynr), if countrynr!=15 &  year>1994
xtreg publicemploymentpctemployment leftwingchiefexecutive gdpcap1000 generalgovernmentexpenditurepctg unemploymentoecd gdpgrowthrateoecd predictedelection c.leftwingchiefexecutive##c.predictedelection i.year, fe cluster (countrynr), if countrynr!=16 &  year>1994
xtreg publicemploymentpctemployment leftwingchiefexecutive gdpcap1000 generalgovernmentexpenditurepctg unemploymentoecd gdpgrowthrateoecd predictedelection c.leftwingchiefexecutive##c.predictedelection i.year, fe cluster (countrynr), if countrynr!=17 &  year>1994
xtreg publicemploymentpctemployment leftwingchiefexecutive gdpcap1000 generalgovernmentexpenditurepctg unemploymentoecd gdpgrowthrateoecd predictedelection c.leftwingchiefexecutive##c.predictedelection i.year, fe cluster (countrynr), if countrynr!=18 &  year>1994
xtreg publicemploymentpctemployment leftwingchiefexecutive gdpcap1000 generalgovernmentexpenditurepctg unemploymentoecd gdpgrowthrateoecd predictedelection c.leftwingchiefexecutive##c.predictedelection i.year, fe cluster (countrynr), if countrynr!=19 &  year>1994
xtreg publicemploymentpctemployment leftwingchiefexecutive gdpcap1000 generalgovernmentexpenditurepctg unemploymentoecd gdpgrowthrateoecd predictedelection c.leftwingchiefexecutive##c.predictedelection i.year, fe cluster (countrynr), if countrynr!=20 &  year>1994
xtreg publicemploymentpctemployment leftwingchiefexecutive gdpcap1000 generalgovernmentexpenditurepctg unemploymentoecd gdpgrowthrateoecd predictedelection c.leftwingchiefexecutive##c.predictedelection i.year, fe cluster (countrynr), if countrynr!=21 &  year>1994
xtreg publicemploymentpctemployment leftwingchiefexecutive gdpcap1000 generalgovernmentexpenditurepctg unemploymentoecd gdpgrowthrateoecd predictedelection c.leftwingchiefexecutive##c.predictedelection i.year, fe cluster (countrynr), if countrynr!=22 &  year>1994


*____________________________________________________________*
*Additional tests not in article*



*Alternative measuers of dependent and independent variables*

* Alternative measure of public employment*
generate logpublicemployment= log( publicemployment)
generate logemployment= log( annuallaborforce1000oecd)
xtreg logpublicemployment leftwingchiefexecutive  logemployment gdpcap1000 generalgovernmentexpenditurepctg unemploymentoecd gdpgrowthrateoecd  c.leftwingchiefexecutive##c.predictedelection  i.year, fe cluster (countrynr), if year>1994


*Alternative measure of public employment2*
generate ratiolagged= publicemployment/l.annuallaborforce1000oecd*100
xtreg ratiolagged leftwingchiefexecutive  gdpcap1000 generalgovernmentexpenditurepctg unemploymentoecd gdpgrowthrateoecd  c.leftwingchiefexecutive##c.predictedelection  i.year, fe cluster (countrynr), if year>1994


*Excluding elections early in the year*
generate predicted2=predictedelection
replace predicted2=0 if electionmonth<4 
xtreg publicemploymentpctemployment leftwingchiefexecutive gdpcap1000 generalgovernmentexpenditurepctg unemploymentoecd gdpgrowthrateoecd  c.leftwingchiefexecutive##c.predicted2 i.year, fe cluster (countrynr), if year>1994


*Use of franzesemeasure of election*
xtreg publicemploymentpctemployment leftwingchiefexecutive gdpcap1000 generalgovernmentexpenditurepctg unemploymentoecd gdpgrowthrateoecd  c.leftwingchiefexecutive##c.franzeseelectionp i.year, fe cluster (countrynr), if year>1994

*Plot*
xtreg publicemploymentpctemployment leftwingchiefexecutive gdpcap1000 generalgovernmentexpenditurepctg unemploymentoecd gdpgrowthrateoecd  c.leftwingchiefexecutive##c.franzeseelectionp i.year, fe cluster (countrynr), if year>1994
margins, dydx(leftwingchiefexecutive) at (franzeseelectionp=(0 0.25 0.50 0.75 1 )) 
marginsplot, level(90) ytitle(Effect of left-wing government on public employment) xtitle(Closeness of election)scheme(s2mono)   graphregion(color(white))  legend (off)

sum franzeseelectionp predictedelection if publicemploymentpctemployment!=. & leftwingchiefexecutive!=. & gdpcap1000!=. & generalgovernmentexpenditurepctg!=. & unemploymentoecd!=. & gdpgrowthrateoecd!=.  & leftwingchiefexecutive!=. & year>1994

*Looking at center end rightwing parties*
xtreg publicemploymentpctemployment  gdpcap1000 generalgovernmentexpenditurepctg unemploymentoecd gdpgrowthrateoecd c.rightchief##c.predictedelection c.centerchief##c.predictedelection  i.year, fe cluster (countrynr), if year>1994
margins, dydx(centerchief) over (predictedelection) 
marginsplot, level(90) ytitle(Effect of left-wing government on public employment) xtitle(Closeness of election)scheme(s2mono)   graphregion(color(white))  legend (off)


*Foot note: post election year*
xtreg publicemploymentpctemployment leftwingchiefexecutive gdpcap1000 generalgovernmentexpenditurepctg unemploymentoecd gdpgrowthrateoecd predictedelection c.leftwingchiefexecutive##c.f1.predictedelection i.year, fe cluster (countrynr), if year>1994

*Foot note: first difference and growth rate*
xtreg d.publicemployment leftwingchiefexecutive gdpcap1000 generalgovernmentexpenditurepctg unemploymentoecd gdpgrowthrateoecd predictedelection c.leftwingchiefexecutive##c.predictedelection i.year, fe cluster (countrynr), if year>1994
generate publicemploymentgrowth= (publicemployment -1.publicemployment)/l.publicemployment
xtreg publicemploymentgrowth leftwingchiefexecutive gdpcap1000 generalgovernmentexpenditurepctg unemploymentoecd gdpgrowthrateoecd predictedelection c.leftwingchiefexecutive##c.predictedelection i.year, fe cluster (countrynr), if year>1994




*Two step GMM*

xtabond2 publicemploymentpctemployment leftwingchiefexecutive gdpcap1000 generalgovernmentexpenditurepctg unemploymentoecd gdpgrowthrateoecd chiefexelection i i.year, gmm(publicemploymentpctemployment) iv( leftwingchiefexecutive chiefexelection  i.year) twostep robust

xtabond2 publicemploymentpctemployment leftwingchiefexecutive gdpcap1000 generalgovernmentexpenditurepctg unemploymentoecd gdpgrowthrateoecd chiefexelection interactleftwingelection   i.year, gmm(publicemploymentpctemployment) iv( leftwingchiefexecutive chiefexelection  interactleftwingelection  i.year) twostep robust

xtabond2 publicemploymentpctemployment leftwingchiefexecutive gdpcap1000 generalgovernmentexpenditurepctg unemploymentoecd gdpgrowthrateoecd predictedelection predictedinteraction   i.year, gmm(publicemploymentpctemployment) iv( leftwingchiefexecutive predictedelection predictedinteraction i.year ) twostep robust
