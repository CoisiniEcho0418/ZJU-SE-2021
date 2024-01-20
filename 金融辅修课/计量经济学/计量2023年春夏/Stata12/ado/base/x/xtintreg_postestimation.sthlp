{smcl}
{* *! version 1.1.9  05may2011}{...}
{viewerdialog predict "dialog xtintreg_p"}{...}
{vieweralsosee "[XT] xtintreg postestimation" "mansection XT xtintregpostestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[XT] xtintreg" "help xtintreg"}{...}
{viewerjumpto "Description" "xtintreg postestimation##description"}{...}
{viewerjumpto "Syntax for predict" "xtintreg postestimation##syntax_predict"}{...}
{viewerjumpto "Options for predict" "xtintreg postestimation##options_predict"}{...}
{viewerjumpto "Examples" "xtintreg postestimation##examples"}{...}
{title:Title}

{p2colset 5 37 39 2}{...}
{p2col :{manlink XT xtintreg postestimation} {hline 2}}Postestimation tools for xtintreg{p_end}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
The following postestimation commands are available after {cmd:xtintreg}:

{synoptset 15}{...}
{p2coldent :Command}Description{p_end}
{synoptline}
INCLUDE help post_contrast
INCLUDE help post_estat
INCLUDE help post_estimates
INCLUDE help post_lincom
INCLUDE help post_lrtest
INCLUDE help post_margins
INCLUDE help post_marginsplot
INCLUDE help post_nlcom
{synopt :{helpb xtintreg postestimation##predict:predict}}predictions, residuals, influence statistics, and other diagnostic measures{p_end}
INCLUDE help post_predictnl
INCLUDE help post_pwcompare
INCLUDE help post_test
INCLUDE help post_testnl
{synoptline}
{p2colreset}{...}


{marker syntax_predict}{...}
{marker predict}{...}
{title:Syntax for predict}

{p 8 16 2}
{cmd:predict} {dtype} {newvar} {ifin} [{cmd:,} {it:statistic} {opt nooff:set}]

{synoptset 15 tabbed}{...}
{synopthdr :statistic}
{synoptline}
{syntab:Main}
{synopt :{opt xb}}linear prediction assuming a zero random effect, the default{p_end}
{synopt :{opt stdp}}standard error of the linear prediction{p_end}
{synopt :{opt stdf}}standard error of the linear forecast{p_end}
{synopt :{opt p:r0(a,b)}}Pr({it:a} < y < {it:b}) assuming a zero random effect{p_end}
{synopt :{opt e:0(a,b)}}{it:E}(y | {it:a} < y < {it:b}) assuming a zero random effect{p_end}
{synopt :{opt ys:tar0(a,b)}}{it:E}(y*), y*=max{a,min(y,b)} assuming a zero random effect{p_end}
{synoptline}
{p2colreset}{...}
INCLUDE help esample

INCLUDE help whereab


INCLUDE help menu_predict


{marker options_predict}{...}
{title:Options for predict}

{dlgtab:Main}

{phang}
{cmd:xb}, the default, calculates the linear prediction.

{phang}
{opt stdp} calculates the standard error of the linear prediction.

{phang}
{opt stdf} calculates the standard error of the linear forecast.
This is the standard error of the point prediction for 1 observation.  It is
commonly referred to as the standard error of the future or forecast value.  By
construction, the standard errors produced by {opt stdf} are always larger than
those produced by {opt stdp}; see
{mansection R regressMethodsandformulas:{it:Methods and formulas}} in
{bf:[R] regress}.

{phang}
{opt pr0(a,b)} calculates estimates of
{bind:Pr({it:a} < y < {it:b})} assuming u_i is zero, which is the probability
that y would be observed in the interval (a,b), given the current values of
the predictors, {bf:x}_{it:it}, and given a zero random effect.

{pmore}
{it:a} and {it:b} may be specified as numbers or variable names;{break}
{cmd:pr0(20,30)} calculates {bind:Pr(20 < y < 30)};{break}
{cmd:pr0(lb,ub)} calculates {bind:Pr(lb < y < ub)}; and{break}
{cmd:pr0(20,ub)} calculates {bind:Pr(20 < y < ub)}.

{pmore}
{it:a} missing {bind:({it:a} {ul:>} .)} means minus infinity;
{cmd:pr0(.,30)} calculates {bind:Pr(y < 30)} and
{cmd:pr0(lb,30)} calculates {bind:Pr(y < 30)} in observations for which
{bind:lb {ul:>} .} (and calculates {bind:Pr(lb < y < 30)} elsewhere).

{pmore}
{it:b} missing {bind:({it:b} {ul:>} .)} means plus infinity;
{cmd:pr0(20,.)} calculates {bind:Pr(y > 20)} and
{cmd:pr0(20,ub)} calculates {bind:Pr(y > 20)} in observations for which
{bind:ub {ul:>} .} (and calculates {bind:Pr(20 < y < ub)} elsewhere).

{phang}
{opt e0(a,b)} calculates estimates of {bind:{it:E}(y | {it:a} < y < {it:b})}
assuming u_i is zero, which is the expected value of y conditional on y being
in the interval (a,b), meaning that y is truncated.  {it:a} and {it:b} are
specified as they are for {cmd:pr0()}.

{phang}
{opt ystar0(a,b)} calculates estimates of {it:E}(Y*) assuming u_i
is zero, where {bind:Y* = {it:a}} if {bind:y {ul:<} {it:a}}, {bind:Y* = {it:b}}
if {bind:y {ul:>} {it:b}}, and {bind:Y* = y} otherwise, meaning that Y* is the
censored version of y.  {it:a} and {it:b} are specified as they are for
{cmd:pr0()}.

{phang}
{opt nooffset} is relevant only if you specified {opth offset(varname)} for
{cmd:xtintreg}.  It modifies the calculations made by {cmd:predict} so that
they ignore the offset variable; the linear prediction is treated as xb rather
than xb + offset.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse nlswork5}{p_end}
{phang2}{cmd:. xtset idcode}{p_end}
{phang2}{cmd:. xtintreg ln_wage1 ln_wage2 i.union age grade south##c.year}
             {cmd:occ_code}{p_end}

{pstd}Summarize variables in model{p_end}
{phang2}{cmd:. estat summarize}{p_end}

{pstd}Obtain effect of union status on probability that log of wages
is less than 1.3{p_end}
{phang2}{cmd:. margins, dydx(union) predict(pr0(.,1.3))}{p_end}

{pstd}Compute the linear prediction{p_end}
{phang2}{cmd:. predict yhat, xb}{p_end}

{pstd}Compute the standard error of the linear prediction{p_end}
{phang2}{cmd:. predict ystdp, stdp}{p_end}
