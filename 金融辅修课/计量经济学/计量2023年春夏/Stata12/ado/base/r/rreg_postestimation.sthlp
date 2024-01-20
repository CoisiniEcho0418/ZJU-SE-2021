{smcl}
{* *! version 1.1.6  11feb2011}{...}
{viewerdialog predict "dialog rreg_p"}{...}
{vieweralsosee "[R] rreg postestimation" "mansection R rregpostestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] rreg" "help rreg"}{...}
{viewerjumpto "Description" "rreg postestimation##description"}{...}
{viewerjumpto "Syntax for predict" "rreg postestimation##syntax_predict"}{...}
{viewerjumpto "Options for predict" "rreg postestimation##options_predict"}{...}
{viewerjumpto "Examples" "rreg postestimation##examples"}{...}
{title:Title}

{p2colset 5 32 34 2}{...}
{p2col :{manlink R rreg postestimation} {hline 2}}Postestimation tools for rreg{p_end}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
The following postestimation commands are available after {cmd:rreg}:

{synoptset 13}{...}
{p2coldent :Command}Description{p_end}
{synoptline}
INCLUDE help post_contrast
{p2col :{helpb estat}}VCE and estimation sample summary{p_end}
INCLUDE help post_estimates
INCLUDE help post_lincom
INCLUDE help post_margins
INCLUDE help post_marginsplot
INCLUDE help post_nlcom
{synopt :{helpb rreg postestimation##predict:predict}}predictions, residuals,
influence statistics, and other diagnostic measures{p_end}
INCLUDE help post_predictnl
INCLUDE help post_pwcompare
INCLUDE help post_test
INCLUDE help post_testnl
{synoptline}
{p2colreset}{...}


{marker syntax_predict}{...}
{marker predict}{...}
{title:Syntax for predict}

{p 8 17 8}
{cmd:predict} {dtype} {newvar} {ifin} 
[{cmd:,} {it:statistic}]

{synoptset 13 tabbed}{...}
{synopthdr:statistic}
{synoptline}
{syntab:Main}
{synopt :{opt xb}}linear prediction; the default{p_end}
{synopt :{opt stdp}}standard error of the linear prediction{p_end}
{synopt :{opt r:esiduals}}residuals{p_end}
{synopt :{opt hat}}diagonal elements of the hat matrix{p_end}
{synoptline}
{p2colreset}{...}
INCLUDE help esample


INCLUDE help menu_predict


{marker options_predict}{...}
{title:Options for predict}

{dlgtab:Main}

{phang}
{opt xb}, the default, calculates the linear prediction.

{phang}
{opt stdp} calculates the standard error of the linear prediction.

{phang}
{opt residuals} calculates the residuals.

{phang}
{opt hat} calculates the diagonal elements of the hat matrix.  You
must have run the {opt rreg} command with the {opt genwt()} option.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. sysuse auto}{p_end}
{phang2}{cmd:. rreg mpg foreign foreign#c.weight}{p_end}

{pstd}Test that coefficient on weight for domestic cars equals coefficient
on weight for foreign cars{p_end}
{phang2}{cmd:. test 0.foreign#c.weight = 1.foreign#c.weight}

{pstd}Obtain predicted values{p_end}
{phang2}{cmd:. predict predmpg}

{pstd}Obtain residuals{p_end}
{phang2}{cmd:. predict r, resid}{p_end}
