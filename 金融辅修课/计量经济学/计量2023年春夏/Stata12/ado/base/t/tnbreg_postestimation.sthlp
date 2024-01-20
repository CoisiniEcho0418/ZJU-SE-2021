{smcl}
{* *! version 1.1.19  03may2011}{...}
{viewerdialog predict "dialog tnbreg_p"}{...}
{vieweralsosee "[R] tnbreg postestimation" "mansection R tnbregpostestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] tnbreg" "help tnbreg"}{...}
{viewerjumpto "Description" "tnbreg postestimation##description"}{...}
{viewerjumpto "Syntax for predict" "tnbreg postestimation##syntax_predict"}{...}
{viewerjumpto "Options for predict" "tnbreg postestimation##options_predict"}{...}
{viewerjumpto "Examples" "tnbreg postestimation##examples"}{...}
{title:Title}

{p2colset 5 34 36 2}{...}
{p2col :{manlink R tnbreg postestimation} {hline 2}}Postestimation tools
for tnbreg{p_end}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
The following postestimation commands are available after {cmd:tnbreg}:

{synoptset 13 notes}{...}
{p2col :Command}Description{p_end}
{synoptline}
INCLUDE help post_contrast
INCLUDE help post_estat
INCLUDE help post_svy_estat
INCLUDE help post_estimates
INCLUDE help post_lincom
INCLUDE help post_lrtest_star
INCLUDE help post_margins
INCLUDE help post_marginsplot
INCLUDE help post_nlcom
{p2col :{helpb tnbreg postestimation##predict:predict}}predictions,
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
 {ifin}{cmd:,} {opt sc:ores}

{synoptset 11 tabbed}{...}
{synopthdr:statistic}
{synoptline}
{syntab:Main}
{synopt:{opt n}}number of events; the default{p_end}
{synopt:{opt ir}}incidence rate{p_end}
{synopt :{opt cm}}conditional mean, E(y | y > ll){p_end}
{synopt :{opt pr(n)}}probability Pr(y = n){p_end}
{synopt :{opt pr(a,b)}}probability Pr(a {ul:<} y {ul:<} b){p_end}
{synopt :{opt cpr(n)}}conditional probability Pr(y = n | y > ll){p_end}
{synopt :{opt cpr(a,b)}}conditional probability Pr(a {ul:<} y {ul:<} b | y > ll){p_end}
{synopt:{opt xb}}linear prediction{p_end}
{synopt:{opt stdp}}standard error of the linear prediction{p_end}
{synoptline}
{p2colreset}{...}
INCLUDE help esample


INCLUDE help menu_predict


{marker options_predict}{...}
{title:Options for predict}

{dlgtab:Main}

{phang}
{opt n}, the default, calculates the predicted number of events, which
is exp(xb) if neither {opt offset()} nor {opt exposure()} was specified
when the model was fit; {bind:exp(xb + offset)} if {opt offset()} was
specified; or {bind:exp(xb)*exposure} if {opt exposure()} was specified.

{phang}
{opt ir} calculates the incidence rate exp(xb), which is the predicted
number of events when exposure is 1.  This is equivalent to specifying both
the {opt n} and the {opt nooffset} options.

{phang}
{opt cm} calculates the conditional mean, E(y|y > ll),
where ll is the truncation point found in {cmd:e(llopt)}.

{phang}
{opt pr(n)} calculates the probability Pr(y = n),
where n is a nonnegative integer that may be specified as a number
or a variable.

INCLUDE help pr_uncond_opt

{phang}
{opt cpr(n)} calculates the conditional probability Pr(y = n|y > ll),
where ll is the truncation point found in {cmd:e(llopt)}.  n is an
integer greater than the truncation point that may be
specified as a number or a variable.

INCLUDE help cpr_lb_ub_option

{phang}
{opt xb} calculates the linear prediction, which is xb if neither
{opt offset()} nor {opt exposure()} was specified when the model was fit;
{bind:xb + offset} if {opt offset()} was specified; or
{bind:xb + ln(exposure)} if {opt exposure()} was specified; see
{opt nooffset} below.

{phang}
{opt stdp} calculates the standard error of the linear prediction.

{phang}
{opt nooffset} is relevant only if you specified {opt offset()} or
{opt exposure()} when you fit the model.  It modifies the calculations made
by {cmd:predict} so that they ignore the offset or exposure variable; the
linear prediction is treated as xb rather than as {bind:xb + offset}
or {bind:xb + ln(exposure)}.  Specifying {cmd:predict} ...{cmd:, nooffset} is
equivalent to specifying {cmd:predict} ...{cmd:, ir}.

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

{pstd}Fit truncated negative binomial regression model{p_end}
{phang2}{cmd:. tnbreg deaths i.cohort, exposure(exposure) ll(9)}{p_end}

{pstd}Predict incidence rate of death{p_end}
{phang2}{cmd:. predict incidence, ir}{p_end}

{pstd}Predict the number of events{p_end}
{phang2}{cmd:. predict nevents, n}{p_end}

{pstd}Predict the number of events, conditional on the number being positive
{p_end}
{phang2}{cmd:. predict condmean, cm}{p_end}

{pstd}Predict probability of 20 or fewer deaths conditional on the number of
deaths being greater than 9{p_end}
{phang2}{cmd:. predict p1, cpr(10,20)}{p_end}

{pstd}Predict probability of 15 or more deaths conditional on the number
of deaths being greater than 9{p_end}
{phang2}{cmd:. predict p2, cpr(15,.)}{p_end}
