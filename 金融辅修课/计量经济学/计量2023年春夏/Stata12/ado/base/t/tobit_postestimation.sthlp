{smcl}
{* *! version 1.1.10  11feb2011}{...}
{viewerdialog predict "dialog tobit_p"}{...}
{vieweralsosee "[R] tobit postestimation" "mansection R tobitpostestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] tobit" "help tobit"}{...}
{viewerjumpto "Description" "tobit postestimation##description"}{...}
{viewerjumpto "Syntax for predict" "tobit postestimation##syntax_predict"}{...}
{viewerjumpto "Options for predict" "tobit postestimation##options_predict"}{...}
{viewerjumpto "Examples" "tobit postestimation##examples"}{...}
{title:Title}

{p2colset 5 33 35 2}{...}
{p2col:{manlink R tobit postestimation} {hline 2}}Postestimation tools for tobit{p_end}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
The following postestimation commands are available after {opt tobit}:

{synoptset 13 notes}{...}
{p2coldent:Command}Description{p_end}
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
{p2col :{helpb tobit postestimation##predict:predict}}predictions, residuals, influence statistics, and other diagnostic measures{p_end}
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

{p 8 17 2}
{cmd:predict}
{dtype}
{newvar}
{ifin}
[{cmd:,}
{it:statistic}
{opt nooff:set}]

{p 8 16 2}
{cmd:predict}
{dtype}
{c -(}{it:stub*}{c |}{it:{help newvar:newvar_reg}}
      {it:{help newvar:newvar_sigma}}{c )-}
{ifin}
{cmd:,}
{opt sc:ores}

{synoptset 14 tabbed}{...}
{synopthdr:statistic}
{synoptline}
{syntab:Main}
{synopt:{opt xb}}linear prediction; the default{p_end}
{synopt:{opt stdp}}standard error of the linear prediction{p_end}
{synopt:{opt stdf}}standard error of the forecast{p_end}
{synopt:{opt p:r(a,b)}}Pr(a < y < b){p_end}
{synopt:{opt e(a,b)}}{it:E}(y|a < y < b){p_end}
{synopt:{opt ys:tar(a,b)}}{it:E}(y*),y* = max{c -(}a, min(y,b){c )-} {p_end}
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
conditional on y|x being in the interval {opt (a,b)}, meaning that y|x is
truncated.  {it:a} and {it:b} are specified as they are for {opt pr()}.

{phang}
{opt ystar(a,b)} calculates {it:E}(y*),
where {bind:y* = {it:a}} if {bind:xb + u {ul:<} {it:a}}, {bind:y* = {it:b}} if
{bind:xb + u {ul:>} {it:b}}, and {bind:y* = xb+u} otherwise, meaning that
y* is censored.  {it:a} and {it:b} are specified as they are for
{opt pr()}.

{phang}
{opt nooffset} is relevant only if you specified {opth offset(varname)}.
It modifies the calculations made
by {cmd:predict} so that they ignore the offset variable; the linear
prediction is treated as xb rather than xb + offset.

{phang}
{opt scores} calculates equation-level score variables.

{pmore}
The first new variable will contain the derivative of the log likelihood with
respect to the regression equation.

{pmore}
The second new variable will contain the derivative of the log likelihood with
respect to the scale equation ({hi:sigma}).


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. sysuse auto}{p_end}
{phang2}{cmd:. generate wgt = weight/100}{p_end}
{phang2}{cmd:. tobit mpg wgt, ll(17) ul(24)}{p_end}

{pstd}Average marginal effects for all covariates{p_end}
{phang2}{cmd:. margins, dydx(*)}{p_end}

{pstd}Marginal effect on the truncated expected value, conditional on weights
of 2000 and 2500 pounds{p_end}
{phang2}{cmd:. margins, dydx(wgt) predict(e(17,24)) at(wgt=(20 25))}{p_end}
