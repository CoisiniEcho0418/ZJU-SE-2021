{smcl}
{* *! version 1.1.7  11feb2011}{...}
{viewerdialog predict "dialog xtrc_p"}{...}
{vieweralsosee "[XT] xtrc postestimation" "mansection XT xtrcpostestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[XT] xtrc" "help xtrc"}{...}
{viewerjumpto "Description" "xtrc postestimation##description"}{...}
{viewerjumpto "Syntax for predict" "xtrc postestimation##syntax_predict"}{...}
{viewerjumpto "Options for predict" "xtrc postestimation##options_predict"}{...}
{viewerjumpto "Examples" "xtrc postestimation##examples"}{...}
{title:Title}

{p2colset 5 34 36 2}{...}
{p2col :{manlink XT xtrc postestimation} {hline 2}}Postestimation tools for xtrc{p_end}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
The following postestimation commands are available after {cmd:xtrc}:

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
{synopt :{helpb xtrc postestimation##predict:predict}}predictions, residuals, influence statistics, and other diagnostic measures{p_end}
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
{cmd:predict} {dtype} {newvar} {ifin} [{cmd:,} {it:statistic}
{opt nooff:set}]

{synoptset 16 tabbed}{...}
{synopthdr :statistic}
{synoptline}
{syntab:Main}
{synopt :{opt xb}}calculate linear prediction; the default{p_end}
{synopt :{opt stdp}}calculate standard error of the linear prediction{p_end}
{synopt :{opt group(group)}}calculate linear prediction based on group {it:group}{p_end}
{synoptline}
{p2colreset}{...}
INCLUDE help esample


INCLUDE help menu_predict


{marker options_predict}{...}
{title:Options for predict}

{dlgtab:Main}

{phang}
{opt xb}, the default, calculates the linear prediction using the mean
parameter vector.

{phang}
{opt stdp} calculates the standard error of the linear prediction.

{phang}
{opt group(group)} calculates the linear prediction using the best linear
predictors for group {it:group}.

{phang}
{opt nooffset} is relevant only if you specified {opth offset(varname)} for
{cmd:xtrc}.  It modifies the calculations made by {cmd:predict} so that
they ignore the offset variable; the linear prediction is treated as xb rather
than xb + offset.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse invest2}{p_end}
{phang2}{cmd:. xtrc invest market stock}{p_end}

{pstd}Linear prediction{p_end}
{phang2}{cmd:. predict xb}

{pstd}Mean of linear prediction{p_end}
{phang2}{cmd:. margins}{p_end}
