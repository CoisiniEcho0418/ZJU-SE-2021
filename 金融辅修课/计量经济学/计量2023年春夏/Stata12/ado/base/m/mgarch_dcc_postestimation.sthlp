{smcl}
{* *! version 1.0.3  29jun2011}{...}
{viewerdialog predict "dialog mgarch_dcc_p"}{...}
{vieweralsosee "[TS] mgarch dcc postestimation" "mansection TS mgarchdccpostestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[TS] mgarch dcc" "help mgarch dcc"}{...}
{viewerjumpto "Description" "mgarch dcc postestimation##description"}{...}
{viewerjumpto "Syntax for predict" "mgarch dcc postestimation##syntax_predict"}{...}
{viewerjumpto "Options for predict" "mgarch dcc postestimation##options_predict"}{...}
{viewerjumpto "Examples" "mgarch dcc postestimation##examples"}{...}
{title:Title}

{p2colset 5 39 43 2}{...}
{p2col :{manlink TS mgarch dcc postestimation} {hline 2}}Postestimation tools
for mgarch dcc{p_end}


{marker description}{...}
{title:Description}

{pstd}
The following standard postestimation commands are available after
{cmd:mgarch dcc}:

{synoptset 14}{...}
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
{synopt :{helpb mgarch dcc postestimation##predict:predict}}predictions, residuals, influence statistics, and other diagnostic measures{p_end}
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
{cmd:predict} {dtype}
{c -(}{it:stub}{cmd:*}{c |}{it:{help newvarlist}}{c )-}
{ifin}
[{cmd:,} {it:statistic} {it:options}]

{synoptset 23 tabbed}{...}
{synopthdr:statistic}
{synoptline}
{syntab:Main}
{synopt :{opt xb}}linear prediction; the default{p_end}
{synopt :{opt r:esiduals}}residuals{p_end}
{synopt :{opt v:ariance}}conditional variances and covariances{p_end}
{synoptline}
INCLUDE help esample
{p2colreset}{...}

{synoptset 23 tabbed}{...}
{synopthdr:options}
{synoptline}
{syntab:Options}
{synopt :{opt e:quation(eqnames)}}names of equations for which
             predictions are made{p_end}
{synopt :{opt dyn:amic(time_constant)}}begin dynamic forecast at specified time
{p_end}
{synoptline}
{p2colreset}{...}


INCLUDE help menu_predict


{marker options_predict}{...}
{title:Options for predict}

{dlgtab:Main}

{phang}
{opt xb}, the default, calculates the linear predictions of the dependent
variables.

{phang}
{opt residuals} calculates the residuals.

{phang}
{opt variance} predicts the conditional variances and conditional covariances.

{dlgtab:Options}

{phang}
{opt equation(eqnames)} specifies the equation for which the
predictions are calculated.  Use this option to predict a statistic for a
particular equation.  Equation names, such as {cmd:equation(income)}, are used
to identify equations.

{pmore}
One equation name may be specified when predicting the dependent variable, 
the residuals, or the conditional variance.  For example, specifying
{cmd:equation(income)} causes {cmd:predict} to predict {cmd:income}, and
specifying {cmd:variance equation(income)} causes predict to predict the
conditional variance of income.

{pmore}
Two equations may be specified when predicting a conditional variance or
covariance. For example, specifying
{cmd:equation(income, consumption)} {cmd:variance} causes {cmd:predict} to
predict the conditional covariance of {cmd:income} and {cmd:consumption}.

{phang}
{opt dynamic(time_constant)} specifies when {cmd:predict} starts
producing dynamic forecasts.  The specified {it:time_constant} must be in the
scale of the time variable specified in {cmd:tsset}, and the {it:time_constant}
must be inside a sample for which observations on the dependent variables are
available.  For example, {cmd:dynamic(tq(2008q4))} causes dynamic predictions
to begin in the fourth quarter of 2008, assuming that your time variable is
quarterly; see {manhelp datetime D:datetime}.  If the model
contains exogenous variables, they must be present for the whole predicted
sample.  {cmd:dynamic()} may not be specified with {cmd:residuals}.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse stocks}{p_end}
{phang2}{cmd:. mgarch dcc (toyota nissan = , noconstant) (honda = , noconstant), arch(1) garch(1)}{p_end}

{pstd}Forecast conditional variances 50 time periods into the future, using dynamic
predictions beginning in time period 2016, and then graph the forecasts{p_end}
{phang2}{cmd:. tsappend, add(50)}{p_end}
{phang2}{cmd:. predict H*, variance dynamic(2016)}{p_end}
{phang2}{cmd:. tsline H_toyota_toyota H_nissan_nissan H_honda_honda if t>1600, legend(rows(3)) xline(2015)}{p_end}
