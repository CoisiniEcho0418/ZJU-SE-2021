{smcl}
{* *! version 1.1.7  11feb2011}{...}
{viewerdialog "predict (re)" "dialog xtlogit_re_p"}{...}
{viewerdialog "predict (fe)" "dialog xtlogit_fe_p"}{...}
{viewerdialog "predict (pa)" "dialog xtlogit_pa_p"}{...}
{vieweralsosee "[XT] xtlogit postestimation" "mansection XT xtlogitpostestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[XT] xtlogit" "help xtlogit"}{...}
{viewerjumpto "Description" "xtlogit postestimation##description"}{...}
{viewerjumpto "Syntax for predict" "xtlogit postestimation##syntax_predict"}{...}
{viewerjumpto "Options for predict" "xtlogit postestimation##options_predict"}{...}
{viewerjumpto "Examples" "xtlogit postestimation##examples"}{...}
{title:Title}

{p2colset 5 36 38 2}{...}
{p2col :{manlink XT xtlogit postestimation} {hline 2}}Postestimation tools for xtlogit{p_end}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
The following postestimation commands are available after {cmd:xtlogit}:

{synoptset 13 notes}{...}
{p2coldent :Command}Description{p_end}
{synoptline}
INCLUDE help post_contrast
{p2coldent :(1) {helpb estat}}AIC, BIC, VCE, and estimation sample summary{p_end}
INCLUDE help post_estimates
INCLUDE help post_hausman
INCLUDE help post_lincom
INCLUDE help post_lrtest
INCLUDE help post_margins2
INCLUDE help post_marginsplot
INCLUDE help post_nlcom
{synopt :{helpb xtlogit postestimation##predict:predict}}predictions, residuals, influence statistics, and other diagnostic measures{p_end}
INCLUDE help post_predictnl
INCLUDE help post_pwcompare
INCLUDE help post_test
INCLUDE help post_testnl
{synoptline}
{p2colreset}{...}
{phang}
(1) {cmd: estat ic} is not appropriate after {cmd: xtlogit, pa}.
{p_end}
{phang}
(2) The default prediction statistic for {cmd:xtlogit, fe}, {cmd:pu1},
        cannot be correctly handled by {cmd:margins}; however, {cmd:margins}
        can be used after {cmd:xtlogit, fe} with the {cmd:predict(pu0)}
        option or the {cmd:predict(xb)} option.


{marker syntax_predict}{...}
{marker predict}{...}
{title:Syntax for predict}

{phang}
Random-effects model

{p 8 16 2}
{cmd:predict} {dtype} {newvar} {ifin} [{cmd:,} 
{it:{help xtlogit_postestimation##randomeffects:RE_statistic}} {opt nooff:set}]

{phang}
Fixed-effects model

{p 8 16 2}
{cmd:predict} {dtype} {newvar} {ifin} [{cmd:,} 
{it:{help xtlogit_postestimation##fixedeffects:FE_statistic}} {opt nooff:set}]

{phang}
Population-averaged model

{p 8 16 2}
{cmd:predict} {dtype} {newvar} {ifin} [{cmd:,} 
{it:{help xtlogit_postestimation##popaverage:PA_statistic}} {opt nooff:set}]

{marker randomeffects}{...}
{synoptset 13 tabbed}{...}
{synopthdr :RE_statistic}
{synoptline}
{syntab:Main}
{synopt :{opt xb}}linear prediction; the default{p_end}
{synopt :{opt pu0}}probability of a positive outcome assuming the random effect is zero{p_end}
{synopt :{opt stdp}}standard error of the linear prediction{p_end}
{synoptline}
{p2colreset}{...}

{marker fixedeffects}{...}
{synoptset 13 tabbed}{...}
{synopthdr :FE_statistic}
{synoptline}
{syntab:Main}
{synopt :{opt p:c1}}probability of a positive outcome conditional on one positive outcome within group; the default{p_end}
{synopt :{opt pu0}}probability of a positive outcome assuming the fixed effect is zero{p_end}
{synopt :{opt xb}}linear prediction{p_end}
{synopt :{opt stdp}}standard error of the linear prediction{p_end}
{synoptline}
{p2colreset}{...}

{marker popaverage}{...}
{synoptset 13 tabbed}{...}
{synopthdr :PA_statistic}
{synoptline}
{syntab:Main}
{synopt :{opt mu}}probability of {depvar}; considers the {opt offset()}{p_end}
{synopt :{opt rate}}probability of {depvar}{p_end}
{synopt :{opt xb}}linear prediction{p_end}
{synopt :{opt stdp}}standard error of the linear prediction{p_end}
{synopt :{opt score}}first derivative of the log likelihood with respect to xb{p_end}
{synoptline}
{p2colreset}{...}

INCLUDE help esample
{p 4 6 2}
The predicted probability for the fixed-effects model is conditional
on there being only one outcome per group.  See {bf:[R] clogit} for details.


INCLUDE help menu_predict


{marker options_predict}{...}
{title:Options for predict}

{dlgtab:Main}

{phang}
{opt xb} calculates the linear prediction.  This is the default for the
random-effects model.

{phang}
{opt pc1} calculates the predicted probability of a positive outcome conditional
on one positive outcome within group.  This is the default for the
fixed-effects model.

{phang}
{opt mu} and {opt rate} both calculate the predicted probability of {depvar}.
{opt mu} takes into account the {opt offset()}, and {opt rate} ignores those
adjustments.  {opt mu} and {cmd:rate} are equivalent if you did not specify
{opt offset()}.  {opt mu} is the default for the population-averaged model.

{phang}
{opt pu0} calculates the probability of a positive outcome, assuming that the
fixed or random effect for that observation's panel is zero.  This
may not be similar to the proportion of observed outcomes in the group.

{phang}
{opt stdp} calculates the standard error of the linear prediction.

{phang}
{opt score} calculates the equation-level score.

{phang}
{opt nooffset} is relevant only if you specified {opth offset(varname)} for
{cmd:xtlogit}.  This option modifies the calculations made by {cmd:predict} so
that they ignore the offset variable; the linear prediction is treated as xb
rather than xb + offset.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse union}{p_end}

{pstd}Fit random-effects model{p_end}
{phang2}{cmd:. xtlogit union age grade i.south}{p_end}

{pstd}Compute probability of positive outcome, assuming random effect is zero
{p_end}
{phang2}{cmd:. predict prob, pu0}

{pstd}Fit population-averaged model{p_end}
{phang2}{cmd:. xtlogit union age grade i.south, pa}{p_end}

{pstd}Compute predicted probability of {cmd:union}{p_end}
{phang2}{cmd:. predict unionpr, mu}{p_end}

{pstd}Compute average marginal effect of {cmd:age} on probability of
{cmd:union}{p_end}
{phang2}{cmd:. margins, dydx(age)}{p_end}
