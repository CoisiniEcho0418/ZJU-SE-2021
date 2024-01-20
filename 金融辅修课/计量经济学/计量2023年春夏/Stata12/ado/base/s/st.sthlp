{smcl}
{* *! version 1.1.3  03may2011}{...}
{vieweralsosee "[ST] st" "mansection ST st"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[ST] stset" "help stset"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[ST] ct" "help ct"}{...}
{vieweralsosee "[ST] snapspan" "help snapspan"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[ST] Glossary" "help st_glossary"}{...}
{title:Title}

{p2colset 5 16 18 2}{...}
{p2col :{manlink ST st} {hline 2}}Survival-time data{p_end}
{p2colreset}{...}


{title:Description}

{pstd}
The term st refers to survival-time data and the commands -- most of
which begin with the letters st -- for analyzing these data.  If you have
data on individual subjects with observations recording that this subject came
under observation at time t0 and that later, at t1, a failure or censoring was
observed, you have what we call survival-time data.

{pstd}
If you have subject-specific data, with observations recording not a span of
time, but measurements taken on the subject at that point in time, you
have what we call a snapshot dataset; see {manhelp snapspan ST}.

{pstd}
If you have data on populations, with observations recording the number of
units under test at time t (subjects alive) and the number of subjects that
failed or were lost because of censoring, you have what we call count-time
data; see {manhelp ct ST}.

{pstd}
The st commands are

{p2colset 9 30 32 2}{...}
{p2col :{helpb stset}}Declare data to be survival-time data{p_end}
{p2col :{helpb stdescribe}}Describe survival-time data{p_end}
{p2col :{helpb stsum}}Summarize survival-time data{p_end}
{p2col :{helpb stvary}}Report whether variables vary over time{p_end}
{p2col :{helpb stfill}}Fill in by carrying forward values of
	covariates{p_end}
{p2col :{helpb stgen}}Generate variables reflecting entire
	histories{p_end}
{p2col :{helpb stsplit}}Split time-span records{p_end}
{p2col :{helpb stjoin}}Join time-span records{p_end}
{p2col :{helpb stbase}}Form baseline dataset{p_end}
{p2col :{helpb sts}}Generate, graph, list, and test the survivor
	and cumulative hazard functions{p_end}
{p2col :{helpb stir}}Report incidence-rate comparison{p_end}
{p2col :{helpb stci}}Confidence intervals for means and percentiles
	of survival time{p_end}
{p2col :{helpb strate}}Tabulate failure rate{p_end}
{p2col :{helpb stptime}}Calculate person-time{p_end}
{p2col :{helpb stmh}}Calculate rate ratios with the Mantel-Haenszel
	method{p_end}
{p2col :{helpb stmc}}Calculate rate ratios with the Mantel-Cox method{p_end}
{p2col :{helpb stcox}}Fit Cox proportional hazards model{p_end}
{p2col :{helpb estat concordance}}Compute the concordance probability{p_end}
{p2col :{helpb estat phtest}}Test Cox proportional-hazards assumption{p_end}
{p2col :{helpb stphplot}}Graphically assess the Cox 
        proportional-hazards assumption{p_end}
{p2col :{helpb stcoxkm}}Graphically assess the Cox 
        proportional-hazards assumption{p_end}
{p2col :{helpb streg}}Fit parametric survival models{p_end}
{p2col :{helpb stcurve}}Plot survivor, hazard, 
        cumulative hazard, or cumulative incidence function{p_end}
{p2col :{helpb stcrreg}}Fit competing-risks regression models{p_end}
{p2col :{helpb stpower}}Sample-size, power, and effect-size determination for
survival studies{p_end}
{p2col :{helpb stpower cox}}Sample size, power, and effect size for the Cox
proportional hazards model{p_end}
{p2col :{helpb stpower exponential}}Sample size and power for the exponential test{p_end}
{p2col :{helpb stpower logrank}}Sample size, power, and effect size for the
log-rank test{p_end}
{p2col :{helpb sttocc}}Convert survival-time data to case-control
	data{p_end}
{p2col :{helpb sttoct}}Convert survival-time data to count-time
	data{p_end}
{p2col :{helpb st_is:st_*}}Survival analysis subroutines for programmers{p_end}
{p2colreset}{...}

{pstd}
The st commands are used for analyzing time-to-absorbing-event (single failure)
data and for analyzing time-to-be-repeated-event (multiple failure) data.

{pstd}
You begin an analysis by {cmd:stset}ting your data, which tells Stata the key
survival-time variables; see {manhelp stset ST}.  Once you have {cmd:stset} your
data, you can use the other st commands.  If you {opt save} your data after
{cmd:stset}ting it, you will not have to {cmd:stset} it again in the future;
Stata will remember.
{p_end}
