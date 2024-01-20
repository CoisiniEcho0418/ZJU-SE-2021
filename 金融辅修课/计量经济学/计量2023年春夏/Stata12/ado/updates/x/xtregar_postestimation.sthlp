{smcl}
{* *! version 1.1.8  29jul2011}{...}
{viewerdialog predict "dialog xtrar_p"}{...}
{vieweralsosee "[XT] xtregar postestimation" "mansection XT xtregarpostestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[XT] xtregar" "help xtregar"}{...}
{viewerjumpto "Description" "xtregar postestimation##description"}{...}
{viewerjumpto "Syntax for predict" "xtregar postestimation##syntax_predict"}{...}
{viewerjumpto "Options for predict" "xtregar postestimation##options_predict"}{...}
{viewerjumpto "Example" "xtregar postestimation##example"}{...}
{title:Title}

{p2colset 5 36 33 2}{...}
{p2col :{manlink XT xtregar postestimation} {hline 2}}Postestimation tools for xtregar{p_end}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
The following postestimation commands are available after {cmd:xtregar}:

{synoptset 13 notes}{...}
{p2coldent :Command}Description{p_end}
{synoptline}
INCLUDE help post_contrast
{p2coldent:(1) {bf:{help estat}}}AIC, BIC, VCE, and estimation sample summary{p_end}
INCLUDE help post_estimates
INCLUDE help post_hausman
INCLUDE help post_lincom
INCLUDE help post_margins
INCLUDE help post_marginsplot
INCLUDE help post_nlcom
{synopt :{helpb xtregar postestimation##predict:predict}}predictions, residuals, influence statistics, and other diagnostic measures{p_end}
INCLUDE help post_predictnl
INCLUDE help post_pwcompare
INCLUDE help post_test
INCLUDE help post_testnl
{synoptline}
{p2colreset}{...}
{p 4 6 2}(1) {opt estat ic} is not appropriate after {opt xtregar, re}.


{marker syntax_predict}{...}
{marker predict}{...}
{title:Syntax for predict}

{p 8 16 2}
{cmd:predict} {dtype} {newvar} {ifin} [{cmd:,} {it:statistic}]


{synoptset 13 tabbed}{...}
{synopthdr :statistic}
{synoptline}
{syntab:Main}
{synopt :{opt xb}}xb, linear prediction; the default{p_end}
{synopt :{opt ue}}u_i + e_it, the combined residual{p_end}
{p2coldent :* {opt u}}u_i, the fixed- or random error component{p_end}
{p2coldent :* {opt e}}e_it, the overall error component{p_end}
{synoptline}
{p2colreset}{...}
{p 4 6 2}
Unstarred statistics are available both in and out of sample; type
{cmd:predict} {it:...} {cmd:if e(sample)} {it:...} if wanted only for the
estimation sample.  Starred statistics are calculated only for the estimation
sample even when "{cmd:if e(sample)}" is not specified.


INCLUDE help menu_predict


{marker options_predict}{...}
{title:Options for predict}

{dlgtab:Main}

{phang}
{opt xb}, the default, calculates the linear prediction, xb.

{phang}
{opt ue} calculates the prediction of u_it + e_it.

{phang}
{opt u} calculates the prediction of u_i, the estimated fixed or random effect.

{phang}
{opt e} calculates the prediction of e_it.
{p_end}


{marker example}{...}
{title:Example}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse grunfeld}{p_end}
{phang2}{cmd:. xtregar invest mvalue kstock, fe}

{pstd}Compute linear prediction{p_end}
{phang2}{cmd:. predict xb}{p_end}

{pstd}Estimate fixed effects{p_end}
{phang2}{cmd:. predict u, u}{p_end}
