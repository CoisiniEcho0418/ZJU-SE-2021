{smcl}
{* *! version 1.1.10  18mar2011}{...}
{viewerdialog predict "dialog intreg_p"}{...}
{vieweralsosee "[R] intreg postestimation" "mansection R intregpostestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] intreg" "help intreg"}{...}
{viewerjumpto "Description" "intreg postestimation##description"}{...}
{viewerjumpto "Syntax for predict" "intreg postestimation##syntax_predict"}{...}
{viewerjumpto "Options for predict" "intreg postestimation##options_predict"}{...}
{viewerjumpto "Examples" "intreg postestimation##examples"}{...}
{title:Title}

{p2colset 5 34 36 2}{...}
{p2col :{manlink R intreg postestimation} {hline 2}}Postestimation tools for
intreg{p_end}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
The following postestimation commands are available after {opt intreg}:

{synoptset 13 notes}{...}
{p2coldent :Command}Description{p_end}
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
{synopt :{helpb intreg postestimation##predict:predict}}predictions, residuals, influence statistics, and other diagnostic measures{p_end}
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
{cmd:predict}
{dtype}
{newvar}
{ifin}
[{cmd:,} {it:statistic} {opt nooff:set}]

{p 8 16 2}
{cmd:predict}
{dtype}
{c -(}{it:stub*}{c |}{it:{help newvar:newvar_reg}}
     {it:{help newvar:newvar_lnsigma}}{c )-}
{ifin}
{cmd:,}
{opt sc:ores}

{synoptset 14 tabbed}{...}
{synopthdr :statistic}
{synoptline}
{syntab :Main}
{synopt :{opt xb}}linear prediction; the default{p_end}
INCLUDE help regstats
{synoptline}
{p2colreset}{...}
INCLUDE help esample
{p 4 6 2}
{opt stdf} is not allowed with {cmd:svy} estimation results.
{p_end}

INCLUDE help whereab


INCLUDE help menu_predict


{marker options_predict}{...}
{title:Options for predict}

{dlgtab:Main}

{phang}
{opt xb}, the default, calculates the linear prediction.

{phang}
{opt stdp} calculates the standard error of the prediction, which can be
thought of as the standard error of the predicted expected value or mean for
the observation's covariate pattern.  The standard error of the prediction is
also referred to as the standard error of the fitted value.

{phang}
{opt stdf} calculates the standard error of the forecast, which is the
standard error of the point prediction for 1 observation.  It is
commonly referred to as the standard error of the future or forecast value.
By construction, the standard errors produced by {opt stdf} are always larger
than those produced by {opt stdp}; see
{it:{mansection R regressMethodsandformulas:Methods and formulas}} in
{hi:[R] regress}.

INCLUDE help pr_opt

{phang}
{opt e(a,b)} calculates
{bind:{it:E}(xb + u | {it:a} < xb + u < {it:b})}, the expected value of y|x
conditional on y|x being in the interval ({it:a},{it:b}), meaning that y|x is
truncated.  {it:a} and {it:b} are specified as they are for {cmd:pr()}.

{phang}
{opt ystar(a,b)} calculates {it:E}(y*),
where {bind:y* = {it:a}} if {bind:xb + u {ul:<} {it:a}}, {bind:y* = {it:b}} if
{bind:xb + u {ul:>} {it:b}}, and {bind:y* = xb + u} otherwise, meaning that
y* is censored.  {it:a} and {it:b} are specified as they are for
{cmd:pr()}.

{phang}
{opt nooffset} is relevant only if you specified {opth offset(varname)}.  It
modifies the calculations made by {cmd:predict} so that they ignore the
offset variable; the linear prediction is treated as xb rather than xb +
offset.

{phang}
{opt scores} calculates equation-level score variables.{break}

{pmore}
The first new variable will contain the derivative of the log likelihood with
respect to the regression equation.

{pmore}
The second new variable will contain the derivative of the log likelihood with
respect to the scale equation ({hi:lnsigma}).


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse intregxmpl}{p_end}
{phang2}{cmd:. intreg wage1 wage2 age c.age#c.age nev_mar rural school tenure}
{p_end}

{pstd}Calculate expected wage conditional on it being between {cmd:wage1}
and {cmd:wage2}{p_end}
{phang2}{cmd:. predict expwage, e(wage1, wage2)}{p_end}

{pstd}Estimate probability that wage (in thousands of dollars) would be
observed in the interval (20, 30){p_end}
{phang2}{cmd:. predict prob, pr(20,30)}{p_end}
