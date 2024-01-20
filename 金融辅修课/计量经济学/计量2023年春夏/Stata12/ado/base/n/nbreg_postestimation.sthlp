{smcl}
{* *! version 1.2.1  06apr2011}{...}
{viewerdialog "nbreg predict" "dialog nbreg_p"}{...}
{viewerdialog "gnbreg predict" "dialog gnbreg_p"}{...}
{vieweralsosee "[R] nbreg postestimation" "mansection R nbregpostestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] nbreg" "help nbreg"}{...}
{viewerjumpto "Description" "nbreg postestimation##description"}{...}
{viewerjumpto "Syntax for predict" "nbreg postestimation##syntax_predict"}{...}
{viewerjumpto "Options for predict" "nbreg postestimation##options_predict"}{...}
{viewerjumpto "Examples" "nbreg postestimation##examples"}{...}
{title:Title}

{p2colset 5 33 35 2}{...}
{p2col :{manlink R nbreg postestimation} {hline 2}}Postestimation tools for
nbreg and gnbreg{p_end}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
The following postestimation commands are available after {cmd:nbreg} and
{cmd:gnbreg}:

{synoptset 13 notes}{...}
{p2coldent :Command}Description{p_end}
{synoptline}
INCLUDE help post_contrast
INCLUDE help post_estat
INCLUDE help post_svy_estat
INCLUDE help post_estimates
INCLUDE help post_lincom
INCLUDE help post_linktest
INCLUDE help post_lrtest_star
INCLUDE help post_margins
INCLUDE help post_marginsplot
INCLUDE help post_nlcom
{synopt :{helpb nbreg postestimation##predict:predict}}predictions,
residuals, influence statistics, and other diagnostic measures{p_end}
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
{cmd:predict} {dtype} {newvar} {ifin} [{cmd:,} {it:statistic}
{opt nooff:set}]

{p 8 16 2}
{cmd:predict} {dtype} {c -(}{it:stub*}{c |}{it:{help newvar:newvar_reg}}
 {it:{help newvar:newvar_disp}}{c )-}
 {ifin} {cmd:,} {opt sc:ores}

{synoptset 11 tabbed}{...}
{synopthdr :statistic}
{synoptline}
{syntab :Main}
{synopt :{cmd:n}}number of events; the default{p_end}
{synopt :{cmd:ir}}incidence rate (equivalent to {cmd:predict} ...,
{cmd:n nooffset}){p_end}
{synopt :{opt pr(n)}}probability Pr(y = n){p_end}
{synopt :{opt pr(a,b)}}probability Pr(a {ul:<} y {ul:<} b){p_end}
{synopt :{cmd:xb}}linear prediction{p_end}
{synopt :{cmd:stdp}}standard error of the linear prediction{p_end}
{synoptline}
{p2colreset}{...}

{pstd}
In addition, relevant only after {cmd:gnbreg} are the following:

{synoptset 11 tabbed}{...}
{synopthdr :statistic}
{synoptline}
{syntab :Main}
{synopt :{opt a:lpha}}predicted values of alpha{p_end}
{synopt :{opt lna:lpha}}predicted values of ln(alpha){p_end}
{synopt :{opt stdpl:na}}standard error of predicted ln(alpha){p_end}
{synoptline}
{p2colreset}{...}

INCLUDE help esample


INCLUDE help menu_predict


{marker options_predict}{...}
{title:Options for predict}

{dlgtab:Main}

{phang}
{opt n}, the default, calculates the predicted number of events, which
is exp(xb) if neither {opth offset:(varname:varname_o)}
nor {opt exposure(varname_e)}
was specified when the model was fit; exp(xb + offset) if
{opt offset()} was specified; or exp(xb)*exposure if {opt exposure()} was
specified.

{phang}
{opt ir} calculates the incidence rate exp(xb), which is the predicted number
of events when exposure is 1.  This is equivalent to specifying both
the {opt n} and the {opt nooffset} options.

{phang}
{opt pr(n)} calculates the probability Pr(y = n), where n is a
nonnegative integer that may be specified as a number or a variable.

INCLUDE help pr_uncond_opt

{phang}
{opt xb} calculates the linear prediction.

{phang}
{opt stdp} calculates the standard error of the linear prediction.

{phang}
{opt alpha}, {opt lnalpha}, and {opt stdplna} are relevant after {cmd:gnbreg}
estimation only; they produce the predicted values of alpha, ln(alpha), and
the standard error of the predicted ln(alpha), respectively.

{phang}
{opt nooffset} is relevant only if you specified {opt offset()} or
{opt exposure()} when you fit the model.  It modifies the
calculations made by {cmd:predict} so that they ignore the
offset or exposure variable; the linear prediction is treated as xb rather
than as xb + offset or xb + ln(exposure_j).  Specifying {cmd:predict}
...{cmd:,} {opt nooffset} is equivalent to specifying {cmd:predict} ...{cmd:,}
{opt ir}.

{phang}
{opt scores} calculates equation-level score variables.

{pmore}
The first new variable will contain the derivative of the log likelihood with
respect to the regression equation.

{pmore}
The second new variable will contain the derivative of the log likelihood with
respect to the dispersion equation.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse rod93}{p_end}
{phang2}{cmd:. nbreg deaths i.cohort, exposure(exp)}{p_end}

{pstd}Test that coefficients of {cmd:2.cohort} and {cmd:3.cohort} are equal
{p_end}
{phang2}{cmd:. test 2.cohort=3.cohort}{p_end}

{pstd}Predict number of events{p_end}
{phang2}{cmd:. predict count}{p_end}

{pstd}Predict incidence rate{p_end}
{phang2}{cmd:. predict rate, ir}

{pstd}Predict probability of 5 deaths for each cohort accounting for the
exposure described in the sample{p_end}
{phang2}{cmd:. predict p, pr(5)}

{pstd}Predict probability of 5 or more deaths for each cohort accounting for
the exposure described in the sample{p_end}
{phang2}{cmd:. predict p, pr(5, .)}{p_end}
