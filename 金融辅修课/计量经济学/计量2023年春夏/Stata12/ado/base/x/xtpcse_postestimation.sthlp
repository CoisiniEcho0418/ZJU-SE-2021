{smcl}
{* *! version 1.1.6  11feb2011}{...}
{viewerdialog predict "dialog xtpcse_p"}{...}
{vieweralsosee "[XT] xtpcse postestimation" "mansection XT xtpcsepostestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[XT] xtpcse" "help xtpcse"}{...}
{viewerjumpto "Description" "xtpcse postestimation##description"}{...}
{viewerjumpto "Syntax for predict" "xtpcse postestimation##syntax_predict"}{...}
{viewerjumpto "Options for predict" "xtpcse postestimation##options_predict"}{...}
{viewerjumpto "Example" "xtpcse postestimation##example"}{...}
{title:Title}

{p2colset 5 35 37 2}{...}
{p2col :{manlink XT xtpcse postestimation} {hline 2}}Postestimation tools for xtpcse{p_end}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
The following postestimation commands are available after {cmd:xtpcse}:

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
{synopt :{helpb xtpcse postestimation##predict:predict}}predictions, residuals, influence statistics, and other diagnostic measures{p_end}
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
{cmd:predict} {dtype} {newvar} {ifin}  [{cmd:,} {opt xb} {opt stdp}]

INCLUDE help esample


INCLUDE help menu_predict


{marker options_predict}{...}
{title:Options for predict}

{dlgtab:Main}

{phang}
{opt xb}, the default, calculates the linear prediction.

{phang}
{opt stdp} calculates the standard error of the linear prediction.


{marker example}{...}
{title:Example}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse grunfeld}{p_end}
{phang2}{cmd:. xtset company year, yearly}{p_end}
{phang2}{cmd:. xtpcse invest mvalue kstock, correlation(psar1) rhotype(tscorr)}
{p_end}

{pstd}Obtain linear prediction{p_end}
{phang2}{cmd:. predict ihat, xb}{p_end}
