{smcl}
{* *! version 1.1.9  15aug2011}{...}
{viewerdialog predict "dialog reg3_p"}{...}
{vieweralsosee "[R] reg3 postestimation" "mansection R reg3postestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] reg3" "help reg3"}{...}
{viewerjumpto "Description" "reg3 postestimation##description"}{...}
{viewerjumpto "Syntax for predict" "reg3 postestimation##syntax_predict"}{...}
{viewerjumpto "Options for predict" "reg3 postestimation##options_predict"}{...}
{viewerjumpto "Examples" "reg3 postestimation##examples"}{...}
{title:Title}

{p2colset 5 32 34 2}{...}
{p2col :{manlink R reg3 postestimation} {hline 2}}Postestimation tools for reg3{p_end}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
The following postestimation commands are available after {cmd:reg3}:

{synoptset 14 tabbed}{...}
{p2coldent :Command}Description{p_end}
{synoptline}
INCLUDE help post_contrast
{p2coldent:* {helpb estat}}AIC, BIC, VCE, and estimation sample summary{p_end}
INCLUDE help post_estimates
INCLUDE help post_hausman
INCLUDE help post_lincom
INCLUDE help post_margins
INCLUDE help post_marginsplot
INCLUDE help post_nlcom
{synopt :{helpb reg3 postestimation##predict:predict}}predictions, residuals,
influence statistics, and other diagnostic measures{p_end}
INCLUDE help post_predictnl
INCLUDE help post_pwcompare
INCLUDE help post_test
INCLUDE help post_testnl
{synoptline}
{p2colreset}{...}
{pstd}* {cmd:estat ic} is not appropriate after {cmd:reg3, 2sls}.


{marker syntax_predict}{...}
{marker predict}{...}
{title:Syntax for predict}

{p 8 19 2}
{cmd:predict} {dtype} {newvar} {ifin} 
   [{cmd:,} {opt eq:uation}{cmd:(}{it:eqno}[{cmd:,}{it:eqno}]{cmd:)} 
   {it:statistic}]

{marker statistic}{...}
{synoptset 14 tabbed}{...}
{synopthdr:statistic}
{synoptline}
{syntab:Main}
{synopt :{opt xb}}linear prediction; the default{p_end}
{synopt :{opt stdp}}standard error of the linear prediction{p_end}
{synopt :{opt r:esiduals}}residuals{p_end}
{synopt :{opt d:ifference}}difference between the linear predictions of two
equations{p_end}
{synopt :{opt stddp}}standard error of the difference in linear
predictions{p_end}
{synoptline}
{p2colreset}{...}
INCLUDE help esample


INCLUDE help menu_predict


{marker options_predict}{...}
{title:Options for predict}

{dlgtab:Main}

{phang}
{cmd:equation(}{it:eqno}[{cmd:,}{it:eqno}]{cmd:)} specifies to which
equation you are referring.

{pmore}
{opt equation()} is filled in with one {it:eqno} for the {opt xb}, 
{opt stdp}, and {opt residuals} options.  {cmd:equation(#1)} would mean the
calculation is to be made for the first equation, {cmd:equation(#2)} would
mean the second, and so on.  You could also refer to the equations
by their names.  {cmd:equation(income)} would refer to the equation named
income and {cmd:equation(hours)} to the equation named hours.

{pmore}
If you do not specify {opt equation()}, results are the same as if you
specified {cmd:equation(#1)}.

{pmore}
{opt difference} and {opt stddp} refer to between-equation concepts.
To use these options, you must specify two equations, for example, 
{cmd:equation(#1,#2)} or {cmd:equation(income,hours)}.  When two equations
must be specified, {opt equation()} is required.

{phang}
{opt xb}, the default, calculates the linear predict (fitted values) -- the
prediction of xb for the specified equation.

{phang}
{opt stdp} calculates the standard error of the prediction for the specified
equation.  It can be thought of as the standard error of the predicted
expected value or mean for the observation's covariate pattern.  The standard
error of the prediction is also referred to as the standard error of the
fitted value.

{phang}
{opt residuals} calculates the residuals.

{phang}
{opt difference} calculates the difference between the linear predictions of
two equations in the system.  With {cmd:equation(#1,#2)}, {opt difference}
computes the prediction of {cmd:equation(#1)} minus the prediction of
{cmd:equation(#2)}.

{phang}
{opt stddp} is allowed only after you have previously fit a
multiple-equation model.  The standard error of the difference in linear
predictions (x1b - x2b) between equations 1 and 2 is calculated.

{phang}
For more information on using {cmd:predict} after multiple-equation estimation
commands, see {manhelp predict R}. 


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse supDem}{p_end}
{phang2}{cmd:. global demand "(qDemand: quantity price pcompete income)"}{p_end}
{phang2}{cmd:. global supply "(qSupply: quantity price praw)"}{p_end}
{phang2}{cmd:. reg3 $demand $supply, endog(price)}{p_end}
{phang2}{cmd:. summarize pcompete, meanonly}{p_end}
{phang2}{cmd:. replace pcompete = r(mean)}{p_end}
{phang2}{cmd:. summarize income, meanonly}{p_end}
{phang2}{cmd:. replace income = r(mean)}{p_end}
{phang2}{cmd:. summarize praw, meanonly}{p_end}
{phang2}{cmd:. replace praw = r(mean)}{p_end}

{pstd}Predict demand{p_end}
{phang2}{cmd:. predict demand, equation(qDemand)}{p_end}

{pstd}Predict supply{p_end}
{phang2}{cmd:. predict supply, equation(qSupply)}{p_end}
