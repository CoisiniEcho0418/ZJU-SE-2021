{smcl}
{* *! version 1.1.15  05may2011}{...}
{viewerdialog "predict (re/fe)" "dialog xtpoisson_refe_p"}{...}
{viewerdialog "predict (pa)" "dialog xtpoisson_pa_p"}{...}
{vieweralsosee "[XT] xtpoisson postestimation" "mansection XT xtpoissonpostestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[XT] xtpoisson" "help xtpoisson"}{...}
{viewerjumpto "Description" "xtpoisson postestimation##description"}{...}
{viewerjumpto "Syntax for predict" "xtpoisson postestimation##syntax_predict"}{...}
{viewerjumpto "Options for predict" "xtpoisson postestimation##options_predict"}{...}
{viewerjumpto "Examples" "xtpoisson postestimation##examples"}{...}
{title:Title}

{p2colset 5 38 40 2}{...}
{p2col :{manlink XT xtpoisson postestimation} {hline 2}}Postestimation tools
for xtpoisson{p_end}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
The following postestimation commands are available after {cmd:xtpoisson}:

{synoptset 13 notes}{...}
{p2coldent :Command}Description{p_end}
{synoptline}
INCLUDE help post_contrast
{p2coldent :(1) {helpb estat}}AIC, BIC, VCE, or estimation sample
summary{p_end}
INCLUDE help post_estimates
INCLUDE help post_hausman
INCLUDE help post_lincom
INCLUDE help post_lrtest
INCLUDE help post_margins
INCLUDE help post_marginsplot
INCLUDE help post_nlcom
{synopt :{helpb xtpoisson postestimation##predict:predict}}predictions,
residuals, influence statistics, and other diagnostic measures{p_end}
INCLUDE help post_predictnl
INCLUDE help post_pwcompare
INCLUDE help post_test
INCLUDE help post_testnl
{synoptline}
{p2colreset}{...}
{p 4 6 2}
(1) {cmd:estat ic} is not appropriate after {cmd:xtpoisson, pa}.
{p_end}


{marker syntax_predict}{...}
{marker predict}{...}
{title:Syntax for predict}

{phang}
Random-effects (RE) and fixed-effects (FE) models

{p 8 16 2}
{cmd:predict} {dtype} {newvar} {ifin} [{cmd:,}
{it:{help xtpoisson_postestimation##randomandfixed:RE/FE_statistic}}
{opt nooff:set} ]

{phang}
Population-averaged (PA) model

{p 8 16 2}
{cmd:predict} {dtype} {newvar} {ifin} [{cmd:,}
{it:{help xtpoisson_postestimation##popaverage:PA_statistic}}
{opt nooff:set} ]

{marker randomandfixed}{...}
{synoptset 15 tabbed}{...}
{synopthdr :RE/FE_statistic}
{synoptline}
{syntab:Main}
{synopt :{opt xb}}linear prediction; the default{p_end}
{synopt :{opt stdp}}standard error of the linear prediction{p_end}
{synopt :{opt nu0}}predicted number of events; assumes fixed or
random effect is zero{p_end}
{synopt :{opt iru0}}predicted incidence rate; assumes fixed or
random effect is zero{p_end}
{synopt :{opt pr0(n)}}probability Pr(y = n) assuming the random effect is zero;
only allowed after {cmd: xtpoisson, re}{p_end}
{synopt :{opt pr0(a,b)}}probability Pr(a {ul:<} y {ul:<} b) assuming the
random effect is zero; only allowed after {cmd:xtpoisson, re}{p_end}
{synoptline}
{p2colreset}{...}

{marker popaverage}{...}
{synoptset 15 tabbed}{...}
{synopthdr :PA_statistic}
{synoptline}
{syntab:Main}
{synopt :{opt mu}}predicted number of events; considers
the {opt offset()}; the default{p_end}
{synopt :{opt rate}}predicted number of events{p_end}
{synopt :{opt xb}}linear prediction{p_end}
{synopt :{opt pr(n)}}probability Pr(y = n){p_end}
{synopt :{opt pr(a,b)}}probability Pr(a {ul:<} y {ul:<} b){p_end}
{synopt :{opt stdp}}standard error of the linear prediction{p_end}
{synopt :{opt sc:ore}}first derivative of the log likelihood with respect
to xb{p_end}
{synoptline}
{p2colreset}{...}

INCLUDE help esample


INCLUDE help menu_predict


{marker options_predict}{...}
{title:Options for predict}

{dlgtab:Main}

{phang}
{opt xb} calculates the linear prediction.  This is the default for the
random-effects and fixed-effects models.

{phang}
{opt mu} and {opt rate} both calculate the predicted number of events.
{opt mu} takes into account the {opt offset()}, and {opt rate} ignores those
adjustments.  {opt mu} and {opt rate} are equivalent if you did not specify
{opt offset()}.  {opt mu} is the default for the population-averaged model.

{phang}
{opt stdp} calculates the standard error of the linear prediction.

{phang}
{opt nu0} calculates the predicted number of events, assuming a zero
random or fixed effect.

{phang}
{opt iru0} calculates the predicted incidence rate, assuming a zero
random or fixed effect.

{phang}
{opt pr0(n)} calculates the probability Pr(y = n) assuming the random
effect is zero, where n is a nonnegative integer that may be specified
as a number or a variable (only allowed after {cmd:xtpoisson, re}).

{phang}
{opt pr0(a,b)} calculates the probability
Pr(a {ul:<} y {ul:<} b) assuming the random effect is zero, where
a and b are nonnegative integers that may be specified as numbers or variables
(only allowed after {cmd:xtpoisson, re});

{pmore}
b missing {bind:(b {ul:>} .)} means plus infinity;{break}
{cmd:pr0(20,.)}
calculates {bind:Pr( y {ul:>} 20)}; {break}
{cmd:pr0(20,}b{cmd:)} calculates {bind:Pr( y {ul:>} 20)} in
observations for which {bind:b {ul:>} .}{break}
and calculates {bind:Pr(20 {ul:<} y {ul:<} b)} elsewhere.

{pmore}
{cmd:pr0(.,}{it:b}{cmd:)} produces a syntax error.  A missing value in an
observation on the variable {it:a} causes a missing value in that
observation for {opt pr0(a,b)}.

{phang}
{opt pr(n)} calculates the probability Pr(y = n), where n is a
nonnegative integer that may be specified as a number or a variable
(only allowed after {cmd:xtpoisson, pa}).

{phang}
{opt pr(a,b)} calculates the probability Pr(a {ul:<} y {ul:<} b) (only
allowed after {cmd:xtpoisson, pa}).  The syntax for this option is analogous
to that used with {opt pr0(a,b)}.

{phang}
{opt score} calculates the equation-level score.

{phang}
{opt nooffset} is relevant only if you specified {opth offset(varname)} for
{cmd:xtpoisson}.  It modifies the calculations made by {cmd:predict} so that
they ignore the offset variable; the linear prediction is treated as xb rather
than xb + offset.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse ships}{p_end}
{phang2}{cmd:. xtset ship}{p_end}

{pstd}Fit random-effects model{p_end}
{phang2}{cmd:. xtpoisson accident op_75_79 co_65_69 co_70_74 co_75_79,}
             {cmd:exp(service)}{p_end}

{pstd}Compute predicted number of accidents, assuming random effect
is zero{p_end}
{phang2}{cmd:. predict cnt, nu0}

{pstd}Compute probability of no accidents, assuming random effect
is zero{p_end}
{phang2}{cmd:. predict p, pr0(0) }

{pstd}Compute probability of 5 or more accidents, assuming random effect
is zero{p_end}
{phang2}{cmd:. predict p2, pr0(5,.) }

{pstd}Fit population-averaged model with robust standard errors{p_end}
{phang2}{cmd:. xtpoisson accident op_75_79 co_65_69 co_70_74 co_75_79,}
             {cmd:exp(service) pa vce(robust)}{p_end}

{pstd}Compute predicted number of accidents taking into account months of
service{p_end}
{phang2}{cmd:. predict mean, mu}

{pstd}Fit random-effects model{p_end}
{phang2}{cmd:. xtpoisson accident op_75_79 co_65_69 co_70_74 co_75_79,}
               {cmd:exp(service)}{p_end}

{pstd}Save the random-effects results{p_end}
{phang2}{cmd:. estimates store re}

{pstd}Fit fixed-effects model{p_end}
{phang2}{cmd:. xtpoisson accident op_75_79 co_65_69 co_70_74 co_75_79,}
             {cmd:exp(service) fe}

{pstd}Save the fixed-effects results{p_end}
{phang2}{cmd:. estimates store fe}

{pstd}Perform Hausman test comparing fixed-effects estimates with
random-effects estimates{p_end}
{phang2}{cmd:. hausman fe re}

{pstd}Replay random-effects model estimation results{p_end}
{phang2}{cmd:. estimates replay re}

{pstd}Compute marginal effects of predicted number of events for
random-effects model{p_end}
{phang2}{cmd:. estimates restore re}{p_end}
{phang2}{cmd:. margins, predict(nu0)}{p_end}
