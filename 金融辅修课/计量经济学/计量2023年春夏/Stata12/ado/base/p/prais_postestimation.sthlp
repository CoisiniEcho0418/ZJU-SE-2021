{smcl}
{* *! version 1.1.7  01jun2011}{...}
{viewerdialog predict "dialog prais_p"}{...}
{vieweralsosee "[TS] prais postestimation" "mansection TS praispostestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[TS] prais" "help prais"}{...}
{viewerjumpto "Description" "prais postestimation##description"}{...}
{viewerjumpto "Syntax for predict" "prais postestimation##syntax_predict"}{...}
{viewerjumpto "Options for predict" "prais postestimation##options_predict"}{...}
{viewerjumpto "Example" "prais postestimation##example"}{...}
{title:Title}

{p2colset 5 34 36 2}{...}
{p2col:{manlink TS prais postestimation} {hline 2}}Postestimation tools for prais{p_end}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
The following standard postestimation commands are available after {opt prais}:

{synoptset 13}{...}
{synopt:Command}Description{p_end}
{synoptline}
INCLUDE help post_contrast
INCLUDE help post_estat
INCLUDE help post_estimates
INCLUDE help post_lincom
INCLUDE help post_linktest
INCLUDE help post_margins
INCLUDE help post_marginsplot
INCLUDE help post_nlcom
{p2col :{helpb prais postestimation##predict:predict}}predictions, residuals, influence statistics, and other diagnostic measures{p_end}
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
{syntab:Main}
{synopt:{cmd:xb}}linear prediction; the default{p_end}
{synopt:{cmd:stdp}}standard error of the linear prediction{p_end}
{synopt:{cmdab:r:esiduals}}residuals{p_end}
{synoptline}
{p2colreset}{...}
INCLUDE help esample


INCLUDE help menu_predict


{marker options_predict}{...}
{title:Options for predict}

{dlgtab:Main}

{phang}
{opt xb}, the default, calculates the fitted values -- the prediction of 
   xb for the specified equation.  This is the linear
   predictor from the fitted regression model; it does not apply the estimate
   of rho to prior residuals.

{phang}
{opt stdp} calculates the standard error of the prediction for the specified
   equation, that is, the standard error of the predicted expected
   value or mean for the observation's covariate pattern.  The standard error
   of the prediction is also referred to as the standard error of the fitted
   value.

{pmore}
   As computed for {opt prais}, this is strictly the standard error from the
   variance in the estimates of the parameters of the linear model and assumes
   that rho is estimated without error.

{phang}
{opt residuals} calculates the residuals from the linear prediction.


{marker example}{...}
{title:Example}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse idle}{p_end}
{phang2}{cmd:. tsset t}{p_end}
{phang2}{cmd:. prais usr idle}{p_end}

{pstd}Linear prediction{p_end}
{phang2}{cmd:. predict usrhat}{p_end}
