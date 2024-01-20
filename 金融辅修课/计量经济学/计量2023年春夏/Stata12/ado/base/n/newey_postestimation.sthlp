{smcl}
{* *! version 1.1.8  11feb2011}{...}
{viewerdialog predict "dialog newey_p"}{...}
{vieweralsosee "[TS] newey postestimation" "mansection TS neweypostestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[TS] newey" "help newey"}{...}
{viewerjumpto "Description" "newey postestimation##description"}{...}
{viewerjumpto "Syntax for predict" "newey postestimation##syntax_predict"}{...}
{viewerjumpto "Options for predict" "newey postestimation##options_predict"}{...}
{viewerjumpto "Example" "newey postestimation##example"}{...}
{title:Title}

{p2colset 5 34 36 2}{...}
{p2col:{manlink TS newey postestimation} {hline 2}}Postestimation tools for
newey{p_end}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
The following postestimation commands are available after {opt newey}:

{synoptset 13}{...}
{synopt:Command}Description{p_end}
{synoptline}
INCLUDE help post_contrast
{p2col :{helpb estat}}VCE and estimation sample summary{p_end}
INCLUDE help post_estimates
INCLUDE help post_lincom
INCLUDE help post_linktest
INCLUDE help post_margins
INCLUDE help post_marginsplot
INCLUDE help post_nlcom
{p2col :{helpb newey postestimation##predict:predict}}predictions, residuals, influence statistics, and other diagnostic measures{p_end}
INCLUDE help post_predictnl
INCLUDE help post_pwcompare
INCLUDE help post_test
INCLUDE help post_testnl
{synoptline}


{marker syntax_predict}{...}
{marker predict}{...}
{title:Syntax for predict}

{p 8 16 2}
{cmd:predict}
{dtype}
{newvar}
{ifin}
[{cmd:,} {it:statistic}]

{synoptset 13 tabbed}{...}
{synopthdr:statistic}
{synoptline}
{syntab :Main}
{synopt:{opt xb}}linear prediction; the default{p_end}
{synopt:{opt stdp}}standard error of the linear prediction{p_end}
{synopt:{opt r:esiduals}}residuals{p_end}
{synoptline}
{p2colreset}{...}
INCLUDE help esample


INCLUDE help menu_predict


{marker options_predict}{...}
{title:Options for predict}

{dlgtab:Main}

{phang}{opt xb}, the default, calculates the linear prediction.

{phang}{opt stdp} calculates the standard error of the linear prediction.

{phang}{opt residuals} calculates the residuals.


{marker example}{...}
{title:Example}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse idle2}{p_end}
{phang2}{cmd:. tsset time}{p_end}
{phang2}{cmd:. newey usr idle, lag(3)}{p_end}

{pstd}Linear prediction{p_end}
{phang2}{cmd:. predict usrhat}{p_end}
