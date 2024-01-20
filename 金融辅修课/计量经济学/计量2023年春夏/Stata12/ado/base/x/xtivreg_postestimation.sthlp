{smcl}
{* *! version 1.1.8  05may2011}{...}
{viewerdialog "predict (re/be/fe)" "dialog xtivp_1"}{...}
{viewerdialog "predict (fd)" "dialog xtivp_2"}{...}
{vieweralsosee "[XT] xtivreg postestimation" "mansection XT xtivregpostestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[XT] xtivreg" "help xtivreg"}{...}
{viewerjumpto "Description" "xtivreg postestimation##description"}{...}
{viewerjumpto "Syntax for predict" "xtivreg postestimation##syntax_predict"}{...}
{viewerjumpto "Options for predict" "xtivreg postestimation##options_predict"}{...}
{viewerjumpto "Examples" "xtivreg postestimation##examples"}{...}
{title:Title}

{p2colset 5 36 38 2}{...}
{p2col :{manlink XT xtivreg postestimation} {hline 2}}Postestimation tools for xtivreg{p_end}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
The following postestimation commands are available after {cmd:xtivreg}:

{synoptset 13}{...}
{p2coldent :Command}Description{p_end}
{synoptline}
INCLUDE help post_contrast
{p2col :{helpb estat}}VCE and estimation sample summary{p_end}
INCLUDE help post_estimates
INCLUDE help post_hausman
INCLUDE help post_lincom
INCLUDE help post_margins
INCLUDE help post_marginsplot
INCLUDE help post_nlcom
{synopt :{helpb xtivreg postestimation##predict:predict}}predictions, residuals, influence statistics, and other diagnostic measures{p_end}
INCLUDE help post_predictnl
INCLUDE help post_pwcompare
INCLUDE help post_test
INCLUDE help post_testnl
{synoptline}
{p2colreset}{...}


{marker syntax_predict}{...}
{marker predict}{...}
{title:Syntax for predict}

{phang}
For all but the first-differenced estimator

{p 8 16 2}{cmd:predict} {dtype} {newvar} {ifin} [{cmd:,}
{it:{help xtivreg postestimation##stat:statistic}}]


{phang}
First-differenced estimator

{p 8 16 2}{cmd:predict} {dtype} {newvar} {ifin} [{cmd:,} 
{it:{help xtivreg postestimation##fdstat:FD_statistic}}]

{marker stat}{...}
{synoptset 13 tabbed}{...}
{synopthdr :statistic}
{synoptline}
{syntab:Main}
{synopt :{opt xb}}Z_(it)d, fitted values; the default{p_end}
{synopt :{opt ue}}u_i + v_it, the combined residual{p_end}
{p2coldent :* {opt xbu}}Z_(it)d + v_i, prediction including effect{p_end}
{p2coldent :* {opt u}}u_i, the fixed- or random-error component{p_end}
{p2coldent :* {opt e}}v_it, the overall error component{p_end}
{synoptline}
{p2colreset}{...}
INCLUDE help unstarred

{marker fdstat}{...}
{synoptset 13 tabbed}{...}
{synopthdr :FD_statistic}
{synoptline}
{syntab:Main}
{synopt :{opt xb}}xb, fitted values for the first-differenced model; the default{p_end}
{synopt :{opt e}}the first-differenced overall error component{p_end}
{synoptline}
{p2colreset}{...}
INCLUDE help esample


INCLUDE help menu_predict


{marker options_predict}{...}
{title:Options for predict}

{dlgtab:Main}

{phang}
{opt xb}, the default, calculates the linear prediction, that is, Z_(it)d.
the default.

{phang}
{opt ue} calculates the prediction of u_i + v_it.  This is not available after
the first-differenced model.

{phang}
{opt xbu} calculates the prediction of Z_(it)d + v_i, the prediction including
the fixed or random component.  This is not available after the
first-differenced model.

{phang}
{opt u} calculates the prediction of u_i, the estimated fixed or random
effect.  This is not available after the first-differenced model.

{phang}
{opt e} calculates the prediction of v_it.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse nlswork}{p_end}

{pstd}Fit an instrumental variable fixed-effects model{p_end}
{phang2}{cmd:. xtivreg ln_wage age (ttl_exp = tenure grade), fe}{p_end}

{pstd}Save the estimation results for subsequent use{p_end}
{phang2}{cmd:. estimates store iv}{p_end}

{pstd}Fit an OLS fixed-effects model{p_end}
{phang2}{cmd:. xtreg ln_wage age ttl_exp, fe}{p_end}

{pstd}Perform Hausman test comparing the consistent but possibly inefficient
IV regression to the perhaps efficient but possibly inconsistent OLS regression
{p_end}
{phang2}{cmd:. hausman iv .}{p_end}
