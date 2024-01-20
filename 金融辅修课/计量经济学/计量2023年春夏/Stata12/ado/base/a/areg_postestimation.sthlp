{smcl}
{* *! version 1.1.7  17mar2011}{...}
{viewerdialog predict "dialog areg_p"}{...}
{vieweralsosee "[R] areg postestimation" "mansection R aregpostestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] areg" "help areg"}{...}
{viewerjumpto "Description" "areg_postestimation##description"}{...}
{viewerjumpto "Syntax for predict" "areg_postestimation##syntax_predict"}{...}
{viewerjumpto "Options for predict" "areg_postestimation##options_predict"}{...}
{viewerjumpto "Examples" "areg_postestimation##examples"}{...}
{title:Title}

{p2colset 5 32 34 2}{...}
{p2col :{manlink R areg postestimation} {hline 2}}Postestimation tools for areg{p_end}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
The following postestimation commands are available after {cmd:areg}:

{synoptset 11}{...}
{p2coldent :Command}Description{p_end}
{synoptline}
INCLUDE help post_contrast
INCLUDE help post_estat
INCLUDE help post_estimates
INCLUDE help post_lincom
INCLUDE help post_linktest
INCLUDE help post_lrtest
INCLUDE help post_margins
INCLUDE help post_marginsplot
INCLUDE help post_nlcom
{synopt :{helpb areg postestimation##predict:predict}}predictions, residuals, influence statistics, and other diagnostic measures{p_end}
INCLUDE help post_predictnl
INCLUDE help post_pwcompare
INCLUDE help post_test
INCLUDE help post_testnl
{synoptline}
{p2colreset}{...}


{marker syntax_predict}{...}
{marker predict}{...}
{title:Syntax for predict}

{p 8 16 2}
{cmd:predict} 
{dtype} 
{newvar} 
{ifin}
[{cmd:,} {it:statistic}]

{pstd}
where y = xb + d_absorbvar + e  and {it:statistic} is

{synoptset 13 tabbed}
{synopthdr:statistic}
{synoptline}
{syntab :Main}
{synopt :{opt xb}} xb fitted values; the default{p_end}
{synopt :{opt stdp}} standard error of the prediction{p_end}
{synopt:{opt dr:esiduals}} d_absorbvar + e = y - xb{p_end}
{p2coldent: * {opt xbd}} xb + d_absorbvar{p_end}
{p2coldent :* {opt d}} d_absorbvar{p_end}
{p2coldent :* {opt r:esiduals}} residual{p_end}
{p2coldent :* {opt sc:ore}} score; equivalent to {opt residuals}{p_end}
{synoptline}
{p2colreset}{...}
INCLUDE help unstarred


INCLUDE help menu_predict


{marker options_predict}{...}
{title:Options for predict}

{dlgtab:Main}

{phang}{opt xb}, the default, calculates the prediction of xb, the
fitted values, by using the average effect of the absorbed variable.  Also see
{opt xbd} below.

{phang}{opt stdp} calculates the standard error of xb.

{phang}{opt dresiduals} calculates y - xb, which are the
residuals plus the effect of the absorbed variable.

{phang}{opt xbd} calculates xb + d_absorbvar, which are
the fitted values including the individual effects of the absorbed variable.

{phang}{opt d} calculates d_absorbvar, the individual
coefficients for the absorbed variable.

{phang}{opt residuals} calculates the residuals, that is, 
{bind:y - (xb + d_absorbvar)}.  

{phang}{opt score} is a synonym for {opt residuals}.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. sysuse auto}{p_end}
{phang2}{cmd:. areg mpg weight gear_ratio, absorb(rep78)}{p_end}

{pstd}Calculate linear prediction{p_end}
{phang2}{cmd:. predict yhat}

{pstd}Display information criteria{p_end}
{phang2}{cmd:. estat ic}

{pstd}Link test for model specification{p_end}
{phang2}{cmd:. linktest, absorb(rep78)}{p_end}
