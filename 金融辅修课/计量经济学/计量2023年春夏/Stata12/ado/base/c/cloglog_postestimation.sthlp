{smcl}
{* *! version 1.1.7  11feb2011}{...}
{viewerdialog predict "dialog clog_p"}{...}
{vieweralsosee "[R] cloglog postestimation" "mansection R cloglogpostestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] cloglog" "help cloglog"}{...}
{viewerjumpto "Description" "cloglog postestimation##description"}{...}
{viewerjumpto "Syntax for predict" "cloglog postestimation##syntax_predict"}{...}
{viewerjumpto "Options for predict" "cloglog postestimation##options_predict"}{...}
{viewerjumpto "Examples" "cloglog postestimation##examples"}{...}
{title:Title}

{p2colset 5 35 37 2}{...}
{p2col :{manlink R cloglog postestimation} {hline 2}}Postestimation tools for cloglog{p_end}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
The following postestimation commands are available after {cmd:cloglog}:

{synoptset 13 notes}{...}
{p2coldent :Command}Description{p_end}
{synoptline}
INCLUDE help post_contrast
INCLUDE help post_estat
INCLUDE help post_svy_estat
INCLUDE help post_estimates
INCLUDE help post_lincom
INCLUDE help post_linktest
INCLUDE help post_lrtest_star
INCLUDE help post_margins
INCLUDE help post_marginsplot
INCLUDE help post_nlcom
{synopt :{helpb cloglog postestimation##predict:predict}}predictions, residuals, influence statistics, and other diagnostic measures{p_end}
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

{phang2}{cmd:predict}
{dtype}
{newvar}
{ifin}
[{cmd:,} {it:statistic} {cmdab:nooff:set}]

{synoptset 11 tabbed}{...}
{synopthdr:statistic}
{synoptline}
{syntab :Main}
{synopt :{opt p:r}}probability of a positive outcome; the default{p_end}
{synopt :{opt xb}}linear prediction{p_end}
{synopt :{opt stdp}}standard error of the linear prediction{p_end}
{synopt :{opt sc:ore}}first derivative of the log likelihood with respect to xb{p_end}
{synoptline}
{p2colreset}{...}
INCLUDE help esample


INCLUDE help menu_predict


{marker options_predict}{...}
{title:Options for predict}

{dlgtab:Main}

{phang}
{opt pr}, the default, calculates the probability of a positive outcome.

{phang}
{opt xb} calculates the linear prediction.

{phang}
{opt stdp} calculates the standard error of the linear prediction.

{phang}
{opt score} calculates the equation-level score, the derivative of the log
likelihood with respect to the linear prediction.

{phang}
{opt nooffset} is relevant only if you specified {opth offset(varname)} for
{cmd:cloglog}.  It modifies the calculations made by {opt predict} so that they
ignore the offset variable; the linear prediction is treated as xb rather than
xb + offset.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. sysuse auto}{p_end}
{phang2}{cmd:. cloglog foreign weight mpg}{p_end}
{phang2}{cmd:. estimates store cloglog}{p_end}
{phang2}{cmd:. logit foreign weight mpg}{p_end}
{phang2}{cmd:. estimates store logit}{p_end}

{pstd}Perform seemingly unrelated estimation so that we can compare the
estimates from the two fitted models{p_end}
{phang2}{cmd:. suest cloglog logit}

{pstd}Display the coefficient matrix to learn how the equations are
named{p_end}
{phang2}{cmd:. matrix list e(b)}

{pstd}Test that the estimates from the two fitted models are the same{p_end}
{phang2}{cmd:. test [cloglog_foreign = logit_foreign]}{p_end}
