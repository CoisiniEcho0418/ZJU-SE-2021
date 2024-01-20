{smcl}
{* *! version 1.1.9  15mar2011}{...}
{viewerdialog predict "dialog ivprobit_p"}{...}
{viewerdialog estat "dialog ivprobit_estat"}{...}
{viewerdialog lroc "dialog lroc"}{...}
{viewerdialog lsens "dialog lsens"}{...}
{vieweralsosee "[R] ivprobit postestimation" "mansection R ivprobitpostestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] ivprobit" "help ivprobit"}{...}
{viewerjumpto "Description" "ivprobit postestimation##description"}{...}
{viewerjumpto "Syntax for predict" "ivprobit postestimation##syntax_predict"}{...}
{viewerjumpto "Options for predict" "ivprobit postestimation##options_predict"}{...}
{viewerjumpto "Examples" "ivprobit postestimation##examples"}{...}
{title:Title}

{p2colset 5 36 38 2}{...}
{p2col :{manlink R ivprobit postestimation} {hline 2}}Postestimation tools for ivprobit{p_end}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
The following postestimation commands are of special interest after
{cmd:ivprobit}:

{synoptset 20}{...}
{p2coldent :Command}Description{p_end}
{synoptline}
{synopt :{helpb logistic postestimation##estatclas:estat classification}}report various summary statistics, including the classification table{p_end}
{synopt :{helpb logistic postestimation##lroc:lroc}}compute area under ROC curve and graph the curve{p_end}
{synopt :{helpb logistic postestimation##lsens:lsens}}graph sensitivity and specificity versus probability cutoff{p_end}
{synoptline}
{p2colreset}{...}
{p 4 6 2}
These commands are not appropriate after the two-step estimator or the {cmd:svy}
prefix.{p_end}

{pstd}
The following standard postestimation commands are also available:

{synoptset 13 notes}{...}
{p2coldent :Command}Description{p_end}
{synoptline}
INCLUDE help post_contrast
{p2coldent :(1) {helpb estat}}AIC, BIC, VCE, and estimation sample summary{p_end}
INCLUDE help post_svy_estat
INCLUDE help post_estimates
INCLUDE help post_hausman
INCLUDE help post_lincom
INCLUDE help post_lrtest_twostep
INCLUDE help post_margins
INCLUDE help post_marginsplot
INCLUDE help post_nlcom
{synopt :{helpb ivprobit postestimation##predict:predict}}predictions, residuals, influence statistics, and other diagnostic measures{p_end}
INCLUDE help post_predictnl
INCLUDE help post_pwcompare
{p2coldent :(1) {helpb suest}}seemingly unrelated estimation{p_end}
INCLUDE help post_test
INCLUDE help post_testnl
{synoptline}
{p2colreset}{...}
{p 4 6 2}
(1) {cmd:estat ic} and {cmd:suest} are not appropriate after
     {cmd:ivprobit, twostep}.
{p_end}
INCLUDE help post_lrtest_twostep_msg


{marker syntax_predict}{...}
{marker predict}{...}
{title:Syntax for predict}

{phang}
After ML or twostep

{p 8 16 2}
{cmd:predict} {dtype} {newvar} {ifin} [{cmd:,} {it:statistic} 
     {opt rule:s} {opt asif}]


{phang}
After ML

{p 8 16 2}
{cmd:predict} {dtype}
{c -(}{it:stub*}{c |}{it:{help newvarlist}}{c )-}
{ifin} {cmd:,} {opt sc:ores}


{synoptset 13 tabbed}{...}
{synopthdr :statistic}
{synoptline}
{syntab :Main}
{synopt :{opt xb}}linear prediction; the default{p_end}
{synopt :{opt stdp}}standard error of the linear prediction{p_end}
{synopt :{opt p:r}}probability of a positive outcome; not available with
two-step estimator{p_end}
{synoptline}
{p2colreset}{...}
INCLUDE help esample


INCLUDE help menu_predict


{marker options_predict}{...}
{title:Options for predict}

{dlgtab:Main}

{phang}{opt xb}, the default, calculates the linear prediction.

{phang}{opt stdp} calculates the standard error of the linear prediction. 

{phang}{opt pr} calculates the probability of a positive outcome. {opt pr} is
not available with the two-step estimator.

{phang}{opt rules} requests that Stata use any rules that were used to
identify the model when making the prediction.  By default, Stata calculates
missing for excluded observations. {opt rules} is not available with the
two-step estimator.

{phang}{opt asif} requests that Stata ignore the rules and the exclusion
criteria and calculate predictions for all observations possible using the
estimated parameters from the model.  {opt asif} is not available with the
two-step estimator.

{phang}{opt scores}, not available with {opt twostep}, calculates
equation-level score variables.

{pmore}
For models with one endogenous regressor, four new variables are 
created.

{pmore2}
The first new variable will contain the first derivative of the log 
likelihood with respect to the probit equation.

{pmore2}
The second new variable will contain the first derivative of the log 
likelihood with respect to the reduced-form equation for the endogenous 
regressor.

{pmore2}
The third new variable will contain the first derivative of the log 
likelihood with respect to atanh(rho).

{pmore2}
The fourth new variable will contain the first derivative of the log 
likelihood with respect to ln(sigma).

{pmore}
For models with j endogenous regressors, 
j + {c -(}(j + 1)(j + 2){c )-}/2
new variables are created.

{pmore2}
The first new variable will contain the first derivative of the log 
likelihood with respect to the probit equation.

{pmore2}
The second through (j + 1)th new variables will contain the first 
derivatives of the log likelihood with respect to the reduced-form 
equations for the endogenous variables in the order they were specified 
when {cmd:ivprobit} was called.

{pmore2}
The remaining score variables will contain the partial derivatives of the
log likelihood with respect to s[2,1], s[3,1], ..., s[j+1,1], s[2,2], 
..., s[j+1,2], ..., s[j+1,j+1], where s[m,n] denotes the (m,n) element 
of the Cholesky decomposition of the error covariance matrix.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse laborsup}{p_end}
{phang2}{cmd:. ivprobit fem_work fem_educ kids (other_inc = male_educ)}{p_end}

{pstd}Compute average marginal effect of {cmd:fem_educ} on probability
that a woman works{p_end}
{phang2}{cmd:. margins, dydx(fem_educ) predict(pr)}{p_end}

{pstd}Same as above, but specify no children{p_end}
{phang2}{cmd:. margins, dydx(fem_educ) predict(pr) at(kids=0)}{p_end}
