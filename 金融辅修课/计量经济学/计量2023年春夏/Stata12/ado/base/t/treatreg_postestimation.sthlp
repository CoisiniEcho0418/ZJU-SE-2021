{smcl}
{* *! version 1.1.8  11feb2011}{...}
{viewerdialog predict "dialog treatr_p"}{...}
{vieweralsosee "[R] treatreg postestimation" "mansection R treatregpostestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] treatreg" "help treatreg"}{...}
{viewerjumpto "Description" "treatreg postestimation##description"}{...}
{viewerjumpto "Syntax for predict" "treatreg postestimation##syntax_predict"}{...}
{viewerjumpto "Options for predict" "treatreg postestimation##options_predict"}{...}
{viewerjumpto "Examples" "treatreg postestimation##examples"}{...}
{title:Title}

{p2colset 5 36 38 2}{...}
{p2col:{manlink R treatreg postestimation} {hline 2}}Postestimation
tools for treatreg{p_end}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
The following postestimation commands are available after {opt treatreg}:

{synoptset 13 notes}{...}
{p2coldent:Command}Description{p_end}
{synoptline}
INCLUDE help post_contrast
{p2coldent:(1) {helpb estat}}AIC, BIC, VCE, and estimation sample summary{p_end}
INCLUDE help post_svy_estat
INCLUDE help post_estimates
INCLUDE help post_lincom
INCLUDE help post_lrtest_twostep
INCLUDE help post_margins
INCLUDE help post_marginsplot
INCLUDE help post_nlcom
{p2col :{helpb treatreg postestimation##predict:predict}}predictions, residuals, influence statistics, and other diagnostic measures{p_end}
INCLUDE help post_predictnl
INCLUDE help post_pwcompare
{p2coldent:(1) {helpb suest}}seemingly unrelated estimation{p_end}
INCLUDE help post_test
INCLUDE help post_testnl
{synoptline}
{p 4 6 2}
(1) {cmd:estat ic} and {cmd:suest} are not appropriate after
      {cmd:treatreg, twostep}.
{p_end}
INCLUDE help post_lrtest_twostep_msg


{marker syntax_predict}{...}
{marker predict}{...}
{title:Syntax for predict}

{pstd}
After ML or twostep

{p 8 16 2}
{cmd:predict}
{dtype}
{newvar}
{ifin}
[{cmd:,} {it:statistic}]

{pstd}
After ML

{p 8 16 2}
{cmd:predict}
{dtype}
{c -(}{it:stub*}{c |}{it:{help newvar:newvar_reg}}
    {it:{help newvar:newvar_treat}} {it:{help newvar:newvar_athrho}}
    {it:{help newvar:newvar_lnsigma}}{c )-}
{ifin}
{cmd:,}
{opt sc:ores}

{marker statistic}{...}
{synoptset 13 tabbed}{...}
{synopthdr:statistic}
{synoptline}
{syntab:Main}
{synopt:{opt xb}}linear prediction; the default{p_end}
{synopt:{opt stdp}}standard error of the prediction{p_end}
{synopt:{opt stdf}}standard error of the forecast{p_end}
{synopt:{opt yct:rt}}{it:E}(y | treatment = 1){p_end}
{synopt:{opt ycnt:rt}}{it:E}(y | treatment = 0){p_end}
{synopt:{opt pt:rt}}Pr(treatment = 1){p_end}
{synopt:{opt xbt:rt}}linear prediction for treatment equation{p_end}
{synopt:{opt stdpt:rt}}standard error of the linear prediction for treatment
equation{p_end}
{synoptline}
{p2colreset}{...}
INCLUDE help esample
{p 4 6 2}
{opt stdf} is not allowed with {cmd:svy} estimation results.
{p_end}


INCLUDE help menu_predict


{marker options_predict}{...}
{title:Options for predict}

{dlgtab:Main}

{phang}
{opt xb}, the default, calculates the linear predictions, xb.

{phang}
{opt stdp} calculates the standard error of the prediction, which can be
   thought of as the standard error of the predicted expected value or mean
   for the observation's covariate pattern.  The standard error of the
   prediction is also referred to as the standard error of the fitted value.

{phang}
{opt stdf} calculates the standard error of the forecast, which is the
   standard error of the point prediction for one observation.  It is
   commonly referred to as the standard error of the future or forecast value.
   By construction, the standard errors produced by {opt stdf} are always
   larger than those produced by {opt stdp}; see
   {it:{mansection R regressMethodsandformulas:Methods and formulas}} in
   {hi:[R] regress}.

{phang}
{opt yctrt} calculates the expected value of the dependent variable
   conditional on the presence of the treatment: {it:E}(y | treatment=1).

{phang}
{opt ycntrt} calculates the expected value of the dependent variable
   conditional on the absence of the treatment: {it:E}(y | treatment=0).

{phang}
{opt ptrt} calculates the probability of the presence of the treatment:
   Pr(treatment=1) = Pr(w_j*g + u_j > 0).

{phang}
{opt xbtrt} calculates the linear prediction for the treatment equation.

{phang}
{opt stdptrt} calculates the standard error of the linear prediction for the
   treatment equation.

{phang}
{opt scores}, not available with {opt twostep}, calculates equation-level
score variables.

{pmore}
The first new variable will contain the derivative of the log likelihood with
respect to the regression equation.

{pmore}
The second new variable will contain the derivative of the log likelihood with
respect to the treatment equation.

{pmore}
The third new variable will contain the derivative of the log likelihood with
respect to the third equation ({hi:athrho}).

{pmore}
The fourth new variable will contain the derivative of the log likelihood with
respect to the fourth equation ({hi:lnsigma}).


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse labor}{p_end}
{phang2}{cmd:. generate wc = 0}{p_end}
{phang2}{cmd:. replace wc = 1 if we > 12}{p_end}
{phang2}{cmd:. treatreg ww wa cit, treat(wc=wmed wfed)}{p_end}

{pstd}Fitted values{p_end}
{phang2}{cmd:. predict yhat}

{pstd}Same as above{p_end}
{phang2}{cmd:. predict yhat, xb}

{pstd}Standard error of the prediction{p_end}
{phang2}{cmd:. predict mystdp, stdp}

{pstd}Standard error of the forecast{p_end}
{phang2}{cmd:. predict mystdf, stdf}

{pstd}{it:E}({cmd:ww}|{cmd:wc} = 1){p_end}
{phang2}{cmd:. predict yctrt, yctrt}

{pstd}{it:E}({cmd:ww}|{cmd:wc} = 0){p_end}
{phang2}{cmd:. predict ycntrt, ycntrt}

{pstd}Pr({cmd:wc} = 1){p_end}
{phang2}{cmd:. predict probtrt, ptrt}{p_end}
