{smcl}
{* *! version 1.1.6  11feb2011}{...}
{viewerdialog "predict (re)" "dialog xtprobit_re_p"}{...}
{viewerdialog "predict (pa)" "dialog xtprobit_pa_p"}{...}
{vieweralsosee "[XT] xtprobit postestimation" "mansection XT xtprobitpostestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[XT] xtprobit" "help xtprobit"}{...}
{viewerjumpto "Description" "xtprobit postestimation##description"}{...}
{viewerjumpto "Syntax for predict" "xtprobit postestimation##syntax_predict"}{...}
{viewerjumpto "Options for predict" "xtprobit postestimation##options_predict"}{...}
{viewerjumpto "Examples" "xtprobit postestimation##examples"}{...}
{title:Title}

{p2colset 5 37 39 2}{...}
{p2col :{manlink XT xtprobit postestimation} {hline 2}}Postestimation tools for xtprobit{p_end}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
The following postestimation commands are available after {cmd:xtprobit}:

{synoptset 13 notes}{...}
{p2coldent :Command}Description{p_end}
{synoptline}
INCLUDE help post_contrast
{p2coldent :(1) {helpb estat}}AIC, BIC, VCE, and estimation sample summary{p_end}
INCLUDE help post_estimates
INCLUDE help post_lincom
INCLUDE help post_lrtest
INCLUDE help post_margins
INCLUDE help post_marginsplot
INCLUDE help post_nlcom
{synopt :{helpb xtprobit postestimation##predict:predict}}predictions, residuals, influence statistics, and other diagnostic measures{p_end}
INCLUDE help post_predictnl
INCLUDE help post_pwcompare
INCLUDE help post_test
INCLUDE help post_testnl
{synoptline}
{p2colreset}{...}
{p 4 6 2}(1) {cmd:estat ic} is not appropriate after {cmd:xtprobit, pa}.{p_end}


{marker syntax_predict}{...}
{marker predict}{...}
{title:Syntax for predict}

{phang}
Random-effects model

{p 8 16 2}
{cmd:predict} {dtype} {newvar} {ifin} [{cmd:,} 
{it:{help xtprobit_postestimation##randomeffects:RE_statistic}} 
{opt nooff:set} ]


{phang}
Population-averaged model

{p 8 16 2}
{cmd:predict} {dtype} {newvar} {ifin} [{cmd:,} 
{it:{help xtprobit_postestimation##popaverage:PA_statistic}} 
{opt nooff:set} ]


{marker randomeffects}{...}
{synoptset 13 tabbed}{...}
{synopthdr :RE_statistic}
{synoptline}
{syntab:Main}
{synopt :{opt xb}}linear prediction; the default{p_end}
{synopt :{opt pu0}}probability of a positive outcome{p_end}
{synopt :{opt stdp}}standard error of the linear prediction{p_end}
{synoptline}
{p2colreset}{...}

{marker popaverage}{...}
{synoptset 13 tabbed}{...}
{synopthdr :PA_statistic}
{synoptline}
{syntab:Main}
{synopt :{opt mu}}probability of {depvar}; considers the {opt offset()}; the default{p_end}
{synopt :{opt rate}}probability of {depvar}{p_end}
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
{opt xb} calculates the linear prediction.  This is the default for the
random-effects model.

{phang}
{opt pu0} calculates the probability of a positive outcome, assuming that the
random effect for that observation's panel is zero.  This probability
may not be similar to the proportion of observed outcomes in the group.

{phang}
{opt stdp} calculates the standard error of the linear prediction.

{phang}
{opt mu} and {opt rate} both calculate the predicted probability of {depvar}.
{opt mu} takes into account the {opt offset()}, and {opt rate} ignores those
adjustments.  {opt mu} and {opt rate} are equivalent if you did not specify
{opt offset()}.  {opt mu} is the default for the population-averaged model.

{phang}
{opt score} calculates the equation-level score.

{phang}
{opt nooffset} is relevant only if you specified {opth offset(varname)} for
{cmd:xtprobit}.  It modifies the calculations made by {cmd:predict} so that
they ignore the offset variable; the linear prediction is treated as xb rather
than xb + offset.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse union}{p_end}

{pstd}Fit random-effects model{p_end}
{phang2}{cmd:. xtprobit union age grade south}{p_end}

{pstd}Calculate predicted probability of a positive outcome{p_end}
{phang2}{cmd:. predict prob, pu0}{p_end}

{pstd}Fit population-averaged model{p_end}
{phang2}{cmd:. xtprobit union age grade i.not_smsa south##c.year, pa}{p_end}

{pstd}Compute the average marginal effects from the fitted model on the
probability of being in a union{p_end}
{phang2}{cmd:. margins, dydx(*)}{p_end}
