{smcl}
{* *! version 1.1.7  30may2011}{...}
{viewerdialog predict "dialog scob_p"}{...}
{vieweralsosee "[R] scobit postestimation" "mansection R scobitpostestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] scobit" "help scobit"}{...}
{viewerjumpto "Description" "scobit postestimation##description"}{...}
{viewerjumpto "Syntax for predict" "scobit postestimation##syntax_predict"}{...}
{viewerjumpto "Options for predict" "scobit postestimation##options_predict"}{...}
{viewerjumpto "Examples" "scobit postestimation##examples"}{...}
{title:Title}

{p2colset 5 34 36 2}{...}
{p2col:{manlink R scobit postestimation} {hline 2}}Postestimation tools for
scobit{p_end}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
The following postestimation tools are available after {opt scobit}:

{synoptset 13 notes}{...}
{p2coldent:Command}Description{p_end}
{synoptline}
INCLUDE help post_contrast
INCLUDE help post_estat
INCLUDE help post_svy_estat
INCLUDE help post_estimates
INCLUDE help post_lincom
INCLUDE help post_lrtest_star
INCLUDE help post_margins
INCLUDE help post_marginsplot
INCLUDE help post_nlcom
{p2col :{helpb scobit postestimation##predict:predict}}predictions, residuals, influence statistics, and other diagnostic measures{p_end}
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
{cmd:predict}
{dtype}
{newvar}
{ifin}
[{cmd:,}
{it:statistic}
{opt nooff:set} ]

{p 8 16 2}
{cmd:predict}
{dtype}
{c -(}{it:stub}{cmd:*}{c |}{it:{help newvar:newvar_reg}}
    {it:{help newvar:newvar_lnalpha}}{c )-}
{ifin}
{cmd:,}
{opt sc:ores}

{synoptset 11 tabbed}
{synopthdr:statistic}
{synoptline}
{syntab:Main}
{synopt:{opt p:r}}probability of a positive outcome; the default{p_end}
{synopt:{opt xb}}xb, linear prediction {p_end}
{synopt:{opt stdp}}standard error of the linear prediction{p_end}
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
{opt nooffset} is relevant only if you specified {opth offset(varname)} for
{opt scobit}.  It modifies the calculations made by {opt predict} so that they
ignore the offset variable; the linear prediction is treated as xb rather than
as {bind:xb - offset}.

{phang}
{opt scores} calculates equation-level score variables.

{pmore}
The first new variable will contain {bind:d(ln L_j)/d(x_j b)}.

{pmore}
The second new variable will contain {bind:d(ln L_j)/d(ln(alpha))}.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. sysuse auto}

{pstd}Fit skewed logistic regression{p_end}
{phang2}{cmd:. scobit foreign mpg}

{pstd}Calculate predicted probabilities{p_end}
{phang2}{cmd:. predict p}

{pstd}Graph data and fitted model; jitter the binary outcome{p_end}
{phang2}{cmd:. line p mpg, sort || scatter foreign mpg, jitter(6)}
   {cmd:ytitle(Pr(foreign)) legend(off)}{p_end}
