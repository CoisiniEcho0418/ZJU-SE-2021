{smcl}
{* *! version 1.1.6  11feb2011}{...}
{viewerdialog "predict (re/be/fe/mle)" "dialog xtrefe_p"}{...}
{viewerdialog "predict (pa)" "dialog xtreg_pa_p"}{...}
{viewerdialog xttest0 "dialog xttest0"}{...}
{vieweralsosee "[XT] xtreg postestimation" "mansection XT xtregpostestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[XT] xtreg" "help xtreg"}{...}
{viewerjumpto "Description" "xtreg postestimation##description"}{...}
{viewerjumpto "Special-interest postestimation commands" "xtreg postestimation##special"}{...}
{viewerjumpto "Syntax for predict" "xtreg postestimation##syntax_predict"}{...}
{viewerjumpto "Options for predict" "xtreg postestimation##options_predict"}{...}
{viewerjumpto "Syntax for xttest0" "xtreg postestimation##syntax_xttest0"}{...}
{viewerjumpto "Examples" "xtreg postestimation##examples"}{...}
{viewerjumpto "Reference" "xtreg postestimation##reference"}{...}
{title:Title}

{p2colset 5 34 36 2}{...}
{p2col :{manlink XT xtreg postestimation} {hline 2}}Postestimation tools for xtreg{p_end}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
The following postestimation commands are of special interest after
{cmd:xtreg}:

{synoptset 13}{...}
{p2coldent :Command}Description{p_end}
{synoptline}
{synopt :{cmd:{helpb xtreg_postestimation##xttest0:xttest0}}}Breusch and Pagan LM test for random effects{p_end}
{synoptline}
{p2colreset}{...}

{phang}
The following standard postestimation commands are also available:

{synoptset 13 notes}{...}
{p2coldent :Command}Description{p_end}
{synoptline}
INCLUDE help post_contrast
{p2coldent :(1) {helpb estat}}AIC, BIC, VCE, and estimation sample summary{p_end}
INCLUDE help post_estimates
INCLUDE help post_hausman
INCLUDE help post_lincom
INCLUDE help post_lrtest
INCLUDE help post_margins
INCLUDE help post_marginsplot
INCLUDE help post_nlcom
{synopt :{helpb xtreg postestimation##predict:predict}}predictions, residuals, influence statistics, and other diagnostic measures{p_end}
INCLUDE help post_predictnl
INCLUDE help post_pwcompare
INCLUDE help post_test
INCLUDE help post_testnl
{synoptline}
{p2colreset}{...}
{p 4 6 2}
(1) {cmd:estat ic} is not appropriate after {cmd:xtreg} with the
{cmd:be}, {cmd:pa}, or {cmd:re} option.
{p_end}


{marker special}{...}
{title:Special-interest postestimation commands}

{pstd}
{cmd:xttest0}, for use after {cmd:xtreg, re}, presents the 
{help xtreg_postestimation##BP1980:Breusch and Pagan (1980)}
Lagrange multiplier test for random effects, a test that Var(v_i)=0.


{marker syntax_predict}{...}
{marker predict}{...}
{title:Syntax for predict}

{phang}
For all but the population-averaged model

{p 8 16 2}
{cmd:predict} {dtype} {newvar} {ifin} [{cmd:,} 
{it:statistic} {opt nooff:set}]


{phang}
Population-averaged model

{p 8 16 2}
{cmd:predict} {dtype} {newvar} {ifin} [{cmd:,} 
{it:PA_statistic} {opt nooff:set}]


{marker statistic}{...}
{synoptset 13 tabbed}{...}
{synopthdr :statistic}
{synoptline}
{syntab:Main}
{synopt :{opt xb}}xb, fitted values; the default{p_end}
{synopt :{opt stdp}}calculate standard error of the fitted values{p_end}
{synopt :{opt ue}}u_i + e_it, the combined residual{p_end}
{p2coldent :* {opt xbu}}xb + u_i, prediction including effect{p_end}
{p2coldent :* {opt u}}u_i, the fixed- or random-error component{p_end}
{p2coldent :* {opt e}}e_it, the overall error component{p_end}
{synoptline}
{p2colreset}{...}
INCLUDE help unstarred


{marker pastatistic}{...}
{synoptset 13 tabbed}{...}
{synopthdr :PA_statistic}
{synoptline}
{syntab:Main}
{synopt :{opt mu}}probability of {depvar}; considers the {opt offset()}{p_end}
{synopt :{opt rate}}probability of {depvar}{p_end}
{synopt :{opt xb}}calculate linear prediction{p_end}
{synopt :{opt stdp}}calculate standard error of the linear prediction{p_end}
{synopt :{opt sc:ore}}first derivative of the log likelihood with respect to xb{p_end}
{synoptline}
{p2colreset}{...}
INCLUDE help esample


INCLUDE help menu_predict


{marker options_predict}{...}
{title:Options for predict}

{dlgtab:Main}

{phang}
{opt xb} calculates the linear prediction, that is, a + bx_it.  This is the
default for all except the population-averaged model.

{phang}
{opt stdp} calculates the standard error of the linear prediction. 
For the fixed-effects model, this excludes the variance due to
uncertainty about the estimate of u_i.

{phang}
{opt mu} and {opt rate} both calculate the predicted probability of {depvar}.
{opt mu} takes into account the {opt offset()}, and {opt rate} ignores those
adjustments.  {opt mu} and {cmd:rate} are equivalent if you did not specify
{opt offset()}.  {opt mu} is the default for the population-averaged model.

{phang}
{opt ue} calculates the prediction of u_it + e_it.

{phang}
{opt xbu} calculates the prediction of a + bx_it + u_i, the prediction
including the fixed or random component.

{phang}
{opt u} calculates the prediction of u_i, the estimated fixed or random effect.

{phang}
{opt e} calculates the prediction of e_it.

{phang}
{opt score} calculates the equation-level score.

{phang}
{opt nooffset} is relevant only if you specified {opth offset(varname)} for
{cmd:xtreg}.  It modifies the calculations made by {cmd:predict} so that
they ignore the offset variable; the linear prediction is treated as xb rather
than xb + offset.


{marker syntax_xttest0}{...}
{marker xttest0}{...}
{title:Syntax for xttest0}

        {cmd:xttest0}


{title:Menu}

{phang}
{bf:Statistics > Longitudinal/panel data > Linear models >}
     {bf:Lagrange multiplier test for random effects}


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse nlswork}{p_end}
{phang2}{cmd:. xtset idcode}{p_end}

{pstd}Fit random-effects model{p_end}
{phang2}{cmd:. xtreg ln_w grade age c.age#c.age ttl_exp c.ttl_exp#c.ttl_exp}
   {cmd:tenure c.tenure#c.tenure 2.race not_smsa south, re}

{pstd}Store random-effects results for later use{p_end}
{phang2}{cmd:. estimates store random_effects}{p_end}

{pstd}Breusch and Pagan Lagrangian multiplier test for random effects{p_end}
{phang2}{cmd:. xttest0}

{pstd}Fit fixed-effects model{p_end}
{phang2}{cmd:. xtreg ln_w grade age c.age#c.age ttl_exp c.ttl_exp#c.ttl_exp}
   {cmd:tenure c.tenure#c.tenure 2.race not_smsa south, fe}

{pstd}Hausman specification test{p_end}
{phang2}{cmd:. hausman . random_effects}{p_end}


{marker reference}{...}
{title:Reference}

{marker BP1980}{...}
{phang}
Breusch, T. S., and A. R. Pagan. 1980. The Lagrange multiplier test and its
applications to model specification in econometrics. 
{it:Review of Economic Studies} 47: 239-253.
{p_end}
