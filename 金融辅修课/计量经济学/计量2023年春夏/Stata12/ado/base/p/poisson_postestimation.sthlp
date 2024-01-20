{smcl}
{* *! version 1.1.17  28apr2011}{...}
{viewerdialog predict "dialog poisso_p"}{...}
{viewerdialog estat "dialog poisson_estat"}{...}
{vieweralsosee "[R] poisson postestimation" "mansection R poissonpostestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] poisson" "help poisson"}{...}
{viewerjumpto "Description" "poisson postestimation##description"}{...}
{viewerjumpto "Special-interest postestimation commands" "poisson postestimation##special"}{...}
{viewerjumpto "Syntax for predict" "poisson postestimation##syntax_predict"}{...}
{viewerjumpto "Options for predict" "poisson postestimation##options_predict"}{...}
{viewerjumpto "Syntax for estat gof" "poisson postestimation##syntax_estat_gof"}{...}
{viewerjumpto "Examples" "poisson postestimation##examples"}{...}
{title:Title}

{p2colset 5 35 37 2}{...}
{p2col :{manlink R poisson postestimation} {hline 2}}Postestimation tools for
poisson{p_end}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
The following postestimation command is of special interest after
{cmd:poisson}:

{synoptset 13}{...}
{p2coldent :Command}Description{p_end}
{synoptline}
{synopt :{helpb poisson postestimation##estatgof:estat gof}}goodness-of-fit
test{p_end}
{synoptline}
{p2colreset}{...}
{p 4 6 2}
{cmd:estat gof} is not appropriate after the {cmd:svy} prefix.
{p_end}

{pstd}
The following standard postestimation commands are also available:

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
{synopt :{helpb poisson postestimation##predict:predict}}predictions,
residuals, influence statistics, and other diagnostic measures{p_end}
INCLUDE help post_predictnl
INCLUDE help post_pwcompare
INCLUDE help post_suest
INCLUDE help post_test
INCLUDE help post_testnl
{synoptline}
{p2colreset}{...}
INCLUDE help post_lrtest_star_msg


{marker special}{...}
{title:Special-interest postestimation command}

{pstd}
{cmd:estat gof} performs a goodness-of-fit test of the model.  Both the
deviance statistic and the Pearson statistic are reported.  If the tests are
significant, the Poisson regression model is inappropriate.  Then you could try
a negative binomial model; see {helpb nbreg:[R] nbreg}.


{marker syntax_predict}{...}
{marker predict}{...}
{title:Syntax for predict}

{p 8 16 2}
{cmd:predict} {dtype} {newvar} {ifin}
[{cmd:,} {it:statistic} {opt nooff:set}]

{synoptset 11 tabbed}{...}
{synopthdr :statistic}
{synoptline}
{syntab :Main}
{synopt :{opt n}}number of events; the default{p_end}
{synopt :{opt ir}}incidence rate{p_end}
{synopt :{opt pr(n)}}probability Pr(y = n){p_end}
{synopt :{opt pr(a,b)}}probability Pr(a {ul:<} y {ul:<} b){p_end}
{synopt :{opt xb}}linear prediction{p_end}
{synopt :{opt stdp}}standard error of the linear prediction{p_end}
{synopt :{opt sc:ore}}first derivative of the log likelihood with respect to
xb{p_end}
{synoptline}
{p2colreset}{...}
INCLUDE help esample


INCLUDE help menu_predict


{marker options_predict}{...}
{title:Options for predict}

{dlgtab:Main}

{phang}
{opt n}, the default, calculates the predicted number of events, which is
exp(xb) if neither {opt offset()} nor {opt exposure()} was
specified when the model was fit;{break}
exp(xb + offset) if {opt offset()} was specified; or{break}
exp(xb)*exposure if {opt exposure()} was specified.

{phang}
{opt ir} calculates the incidence rate exp(xb), which is the predicted number
of events when exposure is 1.  Specifying {opt ir} is equivalent to specifying
{opt n} when neither {opt offset()} nor {opt exposure()} was specified when the
model was fit.

{phang}
{opt pr(n)} calculates the probability Pr(y = n), where n is a
nonnegative integer that may be specified as a number or a variable.

INCLUDE help pr_uncond_opt

{phang}
{opt xb} calculates the linear prediction, which is xb if neither
{cmd:offset()} nor {cmd:exposure()} was specified;
xb + offset if {cmd:offset()} was specified; or
xb + ln(exposure) if {cmd:exposure()} was specified;
see {helpb poisson_postestimation##nooffset:nooffset} below.

{phang}
{opt stdp} calculates the standard error of the linear prediction.

{phang}
{opt score} calculates the equation-level score, the derivative of the log
likelihood with respect to the linear prediction.

{marker nooffset}{...}
{phang}
{opt nooffset} is relevant only if you specified {opt offset()} or
{opt exposure()} when you fit the model.  It modifies the
calculations made by {cmd:predict} so that they ignore the offset or exposure
variable; the linear prediction is treated as xb rather than
{bind:xb + offset} or xb + ln(exposure). Specifying {cmd:predict} ...{cmd:,}
{cmd:nooffset} is equivalent to specifying {cmd:predict} ...{cmd:,}
{opt ir}.


{marker syntax_estat_gof}{...}
{marker estatgof}{...}
{title:Syntax for estat gof}

{p 8 14 2}
{cmd:estat gof}


INCLUDE help menu_estat


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse dollhill3}{p_end}
{phang2}{cmd:. poisson deaths i.smokes i.agecat, exp(pyears)}{p_end}

{pstd}Predict incidence rate{p_end}
{phang2}{cmd:. predict deathrate, ir}

{pstd}Estimate incidence rates and standard errors{p_end}
{phang2}{cmd:. margins agecat#smokes, predict(ir)}

{pstd}Plot estimates and confidence intervals{p_end}
{phang2}{cmd:. marginsplot}

{pstd}Goodness-of-fit tests{p_end}
{phang2}{cmd:. estat gof}{p_end}
