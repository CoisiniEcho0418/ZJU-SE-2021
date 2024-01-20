{smcl}
{* *! version 1.2.16  18mar2011}{...}
{viewerdialog predict "dialog zip_p"}{...}
{vieweralsosee "[R] zip postestimation" "mansection R zippostestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] zip" "help zip"}{...}
{viewerjumpto "Description" "zip postestimation##description"}{...}
{viewerjumpto "Syntax for predict" "zip postestimation##syntax_predict"}{...}
{viewerjumpto "Options for predict" "zip postestimation##options_predict"}{...}
{viewerjumpto "Examples" "zip postestimation##examples"}{...}
{title:Title}

{p2colset 5 31 33 2}{...}
{p2col :{manlink R zip postestimation} {hline 2}}Postestimation tools for zip
{p_end}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
The following postestimation commands are available after {cmd:zip}:

{synoptset 13 notes}{...}
{p2coldent :Command}Description{p_end}
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
{synopt :{helpb zip postestimation##predict:predict}}predictions, residuals,
influence statistics, and other diagnostic measures{p_end}
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

{p 8 18 2}
{cmd:predict} {dtype} {newvar} {ifin}
[{cmd:,} {it:statistic} {opt nooff:set}]

{p 8 18 2}
{cmd:predict} {dtype} {{it:stub}{cmd:*}|{it:{help newvar:newvar_reg}}
   {it:{help newvar:newvar_inflate}}}
   {ifin}{cmd:,} {opt sc:ores}

{marker statistic}{...}
{synoptset 11 tabbed}{...}
{synopthdr:statistic}
{synoptline}
{syntab:Main}
{synopt :{opt n}}number of events; the default{p_end}
{synopt :{opt ir}}incidence rate{p_end}
{synopt :{opt p:r}}probability of a degenerate zero{p_end}
{synopt :{opt pr(n)}}probability Pr(y = n){p_end}
{synopt :{opt pr(a,b)}}probability Pr(a {ul:<} y {ul:<} b){p_end}
{synopt :{opt xb}}linear prediction{p_end}
{synopt :{opt stdp}}standard error of the linear prediction{p_end}
{synoptline}
{p2colreset}{...}
INCLUDE help esample


INCLUDE help menu_predict


{marker options_predict}{...}
{title:Options for predict}

{dlgtab:Main}

{phang}
{opt n}, the default, calculates the predicted number of events, which is
(1-p_j)exp(x_j b) if neither {opt offset()} nor {opt exposure()} was specified
when the model was fit, where p_j is the predicted probability of a zero
outcome; (1-p_j)exp{(x_j b) + offset_j} if {opt offset()} was specified; or
{bind:(1-p_j)(exp(x_j b) * exposure_j}) if {opt exposure()} was specified.

{phang}
{opt ir} calculates the incidence rate exp(xb), which is the predicted
number of events when exposure is 1.  This is equivalent to specifying both
the {opt n} and the {opt nooffset} options.

{phang}
{opt pr} calculates the probability Pr(y = 0), where this zero was obtained from
the degenerate distribution F(zg).  If {opt offset()} was specified within the
{opt inflate()} option, then F(zg + offset^g) is calculated.

{phang}
{opt pr(n)} calculates the probability Pr(y = n), where n is a
nonnegative integer that may be specified as a number or a variable.
Note that {opt pr} is not equivalent to {cmd:pr(0)}.

INCLUDE help pr_uncond_opt

{phang}
{opt xb} calculates the linear prediction, which is xb if neither
{opt offset()} nor {opt exposure()} was specified; {bind:xb + offset} if
{opt offset()} was specified; or {bind:xb + ln(exposure)} if
{opt exposure()} was specified; see {opt nooffset} below.

{phang}
{opt stdp} calculates the standard error of the linear prediction.

{phang}
{opt nooffset} is relevant only if you specified {opt offset()} or
{opt exposure()} when you fit the model.  It modifies the calculations made
by {opt predict} so that they ignore the offset or exposure variable; the
linear prediction is treated as xb rather than as
{bind:xb + offset} or {bind:xb + ln(exposure)}.  Specifying
{bind:{cmd:predict} ...{cmd:, nooffset}} is equivalent to specifying
{bind:{cmd:predict} ...{cmd:, ir}}.

{phang}
{opt scores} calculates equation-level score variables.

{pmore}
The first new variable will contain the derivative of the log likelihood with
respect to the regression equation.

{pmore}
The second new variable will contain the derivative of the log likelihood with
respect to the inflation equation.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse fish}{p_end}
{phang2}{cmd:. zip count persons i.livebait, inflate(child camper)}{p_end}

{pstd}Number of events{p_end}
{phang2}{cmd:. predict n}

{pstd}Linear prediction{p_end}
{phang2}{cmd:. predict lp, xb}

{pstd}Predictive margins for {cmd:livebait}{p_end}
{phang2}{cmd:. margins}

{pstd}Calculate the probability of a zero outcome based on the logit or
probit link function{p_end}
{phang2}{cmd:. predict p, pr}

{pstd}Calculate the overall probability of a zero outcome{p_end}
{phang2}{cmd:. predict p, pr(0)}

{pstd}Calculate the overall probability of 5 or more outcomes{p_end}
{phang2}{cmd:. predict p, pr(5,.)}{p_end}
