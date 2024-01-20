{smcl}
{* *! version 1.1.11  18mar2011}{...}
{viewerdialog predict "dialog heckma_p"}{...}
{vieweralsosee "[R] heckman postestimation" "mansection R heckmanpostestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] heckman" "help heckman"}{...}
{viewerjumpto "Description" "heckman postestimation##description"}{...}
{viewerjumpto "Syntax for predict" "heckman postestimation##syntax_predict"}{...}
{viewerjumpto "Options for predict" "heckman postestimation##options_predict"}{...}
{viewerjumpto "Examples" "heckman postestimation##examples"}{...}
{viewerjumpto "Reference" "heckman postestimation##reference"}{...}
{title:Title}

{p2colset 5 35 37 2}{...}
{p2col :{manlink R heckman postestimation} {hline 2}}Postestimation tools for heckman{p_end}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
The following postestimation commands are available after {cmd:heckman}:

{synoptset 13 notes}{...}
{p2coldent :Command}Description{p_end}
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
{synopt :{helpb heckman postestimation##predict:predict}}predictions, residuals, influence statistics, and other diagnostic measures{p_end}
INCLUDE help post_predictnl
INCLUDE help post_pwcompare
{p2coldent:(1) {helpb suest}}seemingly unrelated estimation{p_end}
INCLUDE help post_test
INCLUDE help post_testnl
{synoptline}
{p2colreset}{...}
{p 4 6 2}
(1) {cmd:estat ic} and {cmd:suest} are not appropriate after
{cmd:heckman, twostep}.
{p_end}
INCLUDE help post_lrtest_twostep_msg


{marker syntax_predict}{...}
{marker predict}{...}
{title:Syntax for predict}

{phang}
After ML or twostep

{p 8 16 2}
{cmd:predict}
{dtype}
{newvar} {ifin} [{cmd:,}
{it:statistic} {opt nooff:set}]


{phang}
After ML

{p 8 16 2}
{cmd:predict}
{dtype} {c -(}{it:stub*}{c |}{it:{help newvar:newvar_reg}}
{it:{help newvar:newvar_sel}}
{it:{help newvar:newvar_athrho}}
{it:{help newvar:newvar_lnsigma}}{c )-}
{ifin}
{cmd:,} {opt sc:ores}
 

{synoptset 21 tabbed}{...}
{synopthdr :statistic}
{synoptline}
{syntab :Main}
{synopt :{opt xb}}linear prediction; the default{p_end}
{synopt :{opt stdp}}standard error of the prediction{p_end}
{synopt :{opt stdf}}standard error of the forecast{p_end}
{synopt :{opt xbs:el}}linear prediction for selection equation{p_end}
{synopt :{opt stdps:el}}standard error of the linear prediction for selection equation{p_end}
{synopt :{opt p:r(a,b)}}Pr(y {c |} {it:a} < y < {it:b}){p_end}
{synopt :{opt e(a,b)}}{it:E}(y {c |} {it:a} < y < {it:b}){p_end}
{synopt :{opt ys:tar(a,b)}}{it:E}(y*), y* = max{c -(}{it:a},min(y,{it:b}){c )-}{p_end}
{synopt :{opt yc:ond}}{it:E}(y {c |} y observed){p_end}
{synopt :{opt ye:xpected}}{it:E}(y*), y taken to be 0 where unobserved{p_end}
{synopt :{opt ns:hazard} or {opt m:ills}}nonselection hazard (also called inverse of Mills' ratio{p_end}
{synopt :{opt ps:el}}Pr(y observed){p_end}
{synoptline}
{p2colreset}{...}
INCLUDE help esample
{p 4 6 2}
{opt stdf} is not allowed with {cmd:svy} estimation results.
{p_end}

INCLUDE help whereab


INCLUDE help menu_predict


{marker options_predict}{...}
{title:Options for predict}

{dlgtab:Main}

{phang}
{opt xb}, the default, calculates the linear prediction.

{phang}
{opt stdp} calculates the standard error of the prediction, which can be
thought of as the standard error of the predicted expected value or mean for
the observation's covariate pattern.  The standard error of the prediction is
also referred to as the standard error of the fitted value.

{phang}
{opt stdf} calculates the standard error of the forecast, which is the
standard error of the point prediction for 1 observation.  It is
commonly referred to as the standard error of the future or forecast value.
By construction, the standard errors produced by {opt stdf} are always larger
than those produced by {opt stdp}; see
{mansection R regressMethodsandformulas:{it:Methods and formulas}} in
{bf:[R] regress}.

{phang}
{opt xbsel} calculates the linear prediction for the selection
equation.

{phang}
{opt stdpsel} calculates the standard error of the linear prediction
for the selection equation.

{phang}
{opt pr(a,b)} calculates {bind:Pr({it:a} < xb + u < {it:b})}, the
probability that y|x would be observed in the interval ({it:a},{it:b}).

{pmore}
{it:a} and {it:b} may be specified as numbers or variable names; {it:lb} and 
{it:ub} are variable names;{break}
{cmd:pr(20,30)} calculates {bind:Pr(20 < xb + u < 30)};{break}
{opt pr(lb,ub)} calculates {bind:Pr({it:lb} < xb + u < {it:ub})}; and{break}
{cmd:pr(20,}{it:ub}{cmd:)} calculates {bind:Pr(20 < xb + u < {it:ub})}.

{pmore}
{it:a} missing {bind:({it:a} {ul:>} .)} means minus infinity;
{cmd:pr(.,30)} calculates {bind:Pr(xb + u < 30)};{break}
{cmd:pr(}{it:lb}{cmd:,30)} calculates {bind:Pr(xb + u < 30)} in
observations for which {bind:{it:lb} {ul:>} .}{break}
and calculates {bind:Pr({it:lb} < xb + u < 30)} elsewhere.

{pmore}
{it:b} missing {bind:({it:b} {ul:>} .)} means plus infinity; {cmd:pr(20,.)}
calculates {bind:Pr(xb + u > 20)}; {break}
{cmd:pr(20,}{it:ub}{cmd:)} calculates {bind:Pr(xb + u > 20)} in
observations for which {bind:{it:ub} {ul:>} .}{break}
and calculates {bind:Pr(20 < xb + u < {it:ub})} elsewhere.

{phang}
{opt e(a,b)} calculates
{bind:{it:E}(xb + u | {it:a} < xb + u < {it:b})}, the expected value of
y|x conditional on y|x being in the interval ({it:a},{it:b}), meaning that 
y|x is truncated.  {it:a} and {it:b} are specified as they are for
{opt pr()}.

{phang}
{opt ystar(a,b)} calculates {it:E}(y*),
where {bind:y* = {it:a}} if {bind:xb + u {ul:<} {it:a}}, {bind:y* = {it:b}}
if {bind:xb + u {ul:>} {it:b}}, and {bind:y* = xb + u} otherwise, meaning
that y* is censored.  {it:a} and {it:b} are specified as they are for
{opt pr()}.

{phang}
{opt ycond} calculates the expected value of the dependent variable conditional on the dependent variable being observed, that is, selected.

{phang}
{opt yexpected} calculates the expected value of the dependent variable
(y*), where that value is taken to be 0 when it is expected to be unobserved.

{pmore}
The assumption of 0 is valid for many cases where nonselection implies
nonparticipation (for example, unobserved wage levels, insurance claims from
those who are uninsured) but may be inappropriate for some problems (for
example, unobserved disease incidence).

{phang}
{opt nshazard} and {cmd:mills} are synonyms; both calculate the
nonselection hazard -- what
{help heckman postestimation##H1979:Heckman (1979)} referred to as the inverse
of the Mills' ratio -- from the selection equation.

{phang}
{opt psel} calculates the probability of selection (or being observed).

{phang}
{opt nooffset} is relevant when you specify {opth offset(varname)} for
{cmd:heckman}.  It modifies the calculations made by {cmd:predict} so that
they ignore the offset variable; the linear prediction is treated as xb rather
than as xb + offset.

{phang}
{opt scores}, not available with {opt twostep}, calculates equation-level score variables.

{pmore}
The first new variable will contain the derivative of the log likelihood with
respect to the regression equation.

{pmore}
The second new variable will contain the derivative of the log likelihood with
respect to the selection equation.

{pmore}
The third new variable will contain the derivative of the log likelihood with
respect to the third equation ({hi:athrho}).

{pmore}
The fourth new variable will contain the derivative of the log likelihood with
respect to the fourth equation ({hi:lnsigma}).


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse womenwk}{p_end}
{phang2}{cmd:. heckman wage educ age, select(married children educ age)}{p_end}

{pstd}Predicted wage conditional on it being observed{p_end}
{phang2}{cmd:. predict ycond, ycond}{p_end}

{pstd}Probability of wage being observed{p_end}
{phang2}{cmd:. predict probseen, psel}{p_end}


{marker reference}{...}
{title:Reference}

{marker H1979}{...}
{phang}
Heckman, J. 1979. Sample selection bias as a specification error.
{it:Econometrica} 47: 153-161.
{p_end}
