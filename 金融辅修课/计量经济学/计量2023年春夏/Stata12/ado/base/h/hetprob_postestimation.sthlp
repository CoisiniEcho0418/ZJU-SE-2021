{smcl}
{* *! version 1.1.9  18mar2011}{...}
{viewerdialog predict "dialog hetpr_p"}{...}
{vieweralsosee "[R] hetprob postestimation" "mansection R hetprobpostestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] hetprob" "help hetprob"}{...}
{viewerjumpto "Description" "hetprob postestimation##description"}{...}
{viewerjumpto "Syntax for predict" "hetprob postestimation##syntax_predict"}{...}
{viewerjumpto "Options for predict" "hetprob postestimation##options_predict"}{...}
{viewerjumpto "Examples" "hetprob postestimation##examples"}{...}
{title:Title}

{p2colset 5 35 37 2}{...}
{p2col :{manlink R hetprob postestimation} {hline 2}}Postestimation tools for hetprob{p_end}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
The following postestimation commands are available after {cmd:hetprob}:

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
{synopt :{helpb hetprob postestimation##predict:predict}}predictions, residuals, influence statistics, and other diagnostic measures{p_end}
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

{p 8 16 2}
{cmd:predict} {dtype} {newvar} {ifin} [{cmd:,} {it:statistic} 
{opt nooff:set}]

{p 8 16 2}
{cmd:predict} {dtype} {c -(}{it:stub*}{c |}{it:{help newvar:newvar_reg}}
{it:{help newvar:newvar_lnsigma2}}{c )-} {ifin} {cmd:,} {opt sc:ores}

{synoptset 11 tabbed}{...}
{synopthdr :statistic}
{synoptline}
{syntab :Main}
{synopt :{opt p:r}}probability of a positive outcome; the default{p_end}
{synopt :{opt xb}}linear prediction{p_end}
{synopt :{opt s:igma}}standard deviation of the error term{p_end}
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
{opt sigma} calculates the standard deviation of the error term.

{phang}
{opt nooffset} is relevant only if you specified {opth offset(varname)} for
{cmd:hetprob}.  It modifies the calculations made by {cmd:predict} so that
they ignore the offset variable; the linear prediction is treated as xb rather
than as xb + offset.

{phang}
{opt scores} calculates equation-level score variables.

{pmore}
The first new variable will contain the derivative of the log likelihood with
respect to the regression equation.

{pmore}
The second new variable will contain the derivative of the log likelihood with
respect to the scale equation ({hi:lnsigma2}).


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse hetprobxmpl}{p_end}

{pstd}Fit heteroskedastic probit model{p_end}
{phang2}{cmd:. hetprob y x, het(xhet) vce(robust)}{p_end}

{pstd}Calculate fitted probabilities{p_end}
{phang2}{cmd:. predict phat}{p_end}

{pstd}Calculate predicted standard deviation, a function of {cmd:xhet}{p_end}
{phang2}{cmd:. predict sigmahat, sigma}{p_end}
