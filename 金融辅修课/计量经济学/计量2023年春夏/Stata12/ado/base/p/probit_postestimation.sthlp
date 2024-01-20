{smcl}
{* *! version 1.1.7  15mar2011}{...}
{viewerdialog predict "dialog probit_p"}{...}
{viewerdialog estat "dialog probit_estat"}{...}
{viewerdialog lroc "dialog lroc"}{...}
{viewerdialog lsens "dialog lsens"}{...}
{vieweralsosee "[R] probit postestimation" "mansection R probitpostestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] probit" "help probit"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] logistic postestimation" "help logistic_postestimation"}{...}
{viewerjumpto "Description" "probit postestimation##description"}{...}
{viewerjumpto "Syntax for predict" "probit postestimation##syntax_predict"}{...}
{viewerjumpto "Options for predict" "probit postestimation##options_predict"}{...}
{viewerjumpto "Examples" "probit postestimation##examples"}{...}
{title:Title}

{p2colset 5 34 36 2}{...}
{p2col :{manlink R probit postestimation} {hline 2}}Postestimation tools for
probit{p_end}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
The following postestimation commands are of special interest after
{cmd:probit}:

{synoptset 20}{...}
{p2coldent :Command}Description{p_end}
{synoptline}
{synopt :{helpb logistic postestimation##estatclas:estat classification}}report various summary statistics, including the classification table{p_end}
{synopt :{helpb logistic postestimation##estatgof:estat gof}}Pearson or Hosmer-Lemeshow goodness-of-fit test{p_end}
{synopt :{helpb logistic postestimation##lroc:lroc}}compute area under ROC curve and graph the curve{p_end}
{synopt :{helpb logistic postestimation##lsens:lsens}}graph sensitivity and specificity versus probability cutoff{p_end}
{synoptline}
{p2colreset}{...}
{p 4 6 2}
These commands are not appropriate after the {cmd:svy} prefix.
{p_end}

{pstd}
The following standard postestimation commands are also available:

{synoptset 14 notes}{...}
{p2coldent :Command}Description{p_end}
{synoptline}
INCLUDE help post_contrast
INCLUDE help post_estat
INCLUDE help post_svy_estat
INCLUDE help post_estimates
INCLUDE help post_hausman
INCLUDE help post_lincom
INCLUDE help post_linktest
INCLUDE help post_lrtest_star
INCLUDE help post_margins
INCLUDE help post_marginsplot
INCLUDE help post_nlcom
{synopt :{helpb probit postestimation##predict:predict}}predictions, residuals, influence statistics, and other diagnostic measures{p_end}
INCLUDE help post_predictnl
INCLUDE help post_pwcompare
INCLUDE help post_suest
INCLUDE help post_test
INCLUDE help post_testnl
{synoptline}
{p2colreset}{...}
INCLUDE help post_lrtest_star_msg


{marker syntax_predict}{...}
{marker predict}{...}
{title:Syntax for predict}

{p 8 16 2}
{cmd:predict} {dtype} {newvar} {ifin} 
[{cmd:,} {it:statistic} {opt nooff:set} {opt rule:s} {opt asif}]

{synoptset 11 tabbed}{...}
{synopthdr :statistic}
{synoptline}
{syntab :Main}
{synopt :{opt p:r}}probability of a positive outcome; the default{p_end}
{synopt :{cmd:xb}}linear prediction{p_end}
{synopt :{cmd:stdp}}standard error of the linear prediction{p_end}
{p2coldent :* {opt de:viance}}deviance residual{p_end}
{synopt :{opt sc:ore}}first derivative of the log likelihood with respect to xb{p_end}
{synoptline}
{p2colreset}{...}
INCLUDE help unstarred


INCLUDE help menu_predict


{marker options_predict}{...}
{title:Options for predict}

{dlgtab:Main}

{phang}
{opt pr}, the default, calculates the probability of a positive outcome.

{phang}
{opt xb} calculates the linear prediction.

{phang}
{opt stdp} calculates the standard error of the linear prediction.

{phang}
{opt deviance} calculates the deviance residual.  

{phang}
{opt score} calculates the equation-level score, the derivative of the log
likelihood with respect to the linear prediction.

{phang}
{opt nooffset} is relevant only if you specified {opth offset(varname)} for
{opt probit}.  It modifies the calculations made by {opt predict} so that
they ignore the offset variable; the linear prediction is treated as xb
rather than xb + offset.

{phang}
{opt rules} requests that Stata use any rules that were used to
identify the model when making the prediction.  By default, Stata calculates
missing for excluded observations.

{phang}
{opt asif} requests that Stata ignore the rules and the exclusion criteria
and calculate predictions for all observations possible using the estimated
parameter from the model.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. sysuse auto}{p_end}
{phang2}{cmd:. probit foreign weight mpg}{p_end}

{pstd}Obtain predicted probabilities{p_end}
{phang2}{cmd:. predict p}

{pstd}Calculate and display summary statistics{p_end}
{phang2}{cmd:. summarize foreign p}{p_end}

{pstd}Use rules when making predictions{p_end}
{phang2}{cmd:. predict p2, rules}

{pstd}Calculate and display summary statistics{p_end}
{phang2}{cmd:. summarize foreign p p2}{p_end}

{pstd}Ignore rules and exclusion criteria{p_end}
{phang2}{cmd:. predict p3, asif}

{pstd}Calculate and display summary statistics{p_end}
{phang2}{cmd:. summarize foreign p p2 p3}{p_end}
