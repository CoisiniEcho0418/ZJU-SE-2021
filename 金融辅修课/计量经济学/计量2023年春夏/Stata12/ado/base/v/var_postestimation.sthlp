{smcl}
{* *! version 1.1.10  31mar2011}{...}
{viewerdialog predict "dialog var_p"}{...}
{vieweralsosee "[TS] var postestimation" "mansection TS varpostestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[TS] var" "help var"}{...}
{viewerjumpto "Description" "var postestimation##description"}{...}
{viewerjumpto "Syntax for predict" "var postestimation##syntax_predict"}{...}
{viewerjumpto "Options for predict" "var postestimation##options_predict"}{...}
{viewerjumpto "Examples" "var postestimation##examples"}{...}
{title:Title}

{p2colset 5 32 34 2}{...}
{p2col:{manlink TS var postestimation} {hline 2}}Postestimation tools for var{p_end}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
The following postestimation commands are of special interest after {opt var}:

{synoptset 15}{...}
{synopt:Command}Description{p_end}
{synoptline}
{synopt:{helpb fcast compute}}obtain dynamic forecasts{p_end}
{synopt:{helpb fcast graph}}graph dynamic forecasts obtained from {cmd:fcast compute}{p_end}
{synopt:{helpb irf}}create and analyze IRFs and FEVDs{p_end}
{synopt:{helpb vargranger}}Granger causality tests{p_end}
{synopt:{helpb varlmar}}LM test for autocorrelation in residuals{p_end}
{synopt:{helpb varnorm}}test for normally distributed residuals{p_end}
{synopt:{helpb varsoc}}lag-order selection criteria{p_end}
{synopt:{helpb varstable}}check stability condition of estimates{p_end}
{synopt:{helpb varwle}}Wald lag-exclusion statistics{p_end}
{synoptline}
{p2colreset}{...}

{pstd}
The following standard postestimation commands are also available:

{synoptset 15}{...}
{synopt:Command}Description{p_end}
{synoptline}
INCLUDE help post_estat
INCLUDE help post_estimates
INCLUDE help post_lincom
INCLUDE help post_lrtest
INCLUDE help post_margins
INCLUDE help post_marginsplot
INCLUDE help post_nlcom
{p2col :{helpb var postestimation##predict:predict}}predictions, residuals, influence statistics, and other diagnostic measures{p_end}
INCLUDE help post_predictnl
INCLUDE help post_test
INCLUDE help post_testnl
{synoptline}
{p2colreset}{...}


{marker syntax_predict}{...}
{marker predict}{...}
{title:Syntax for predict}

{p 8 16 2}
{cmd:predict}
{dtype}
{newvar}
{ifin}
[{cmd:,} {it:statistic} {opt eq:uation(eqno|eqname)}]

{synoptset 15 tabbed}{...}
{synopthdr:statistic}
{synoptline}
{syntab:Main}
{synopt:{opt xb}}linear prediction; the default{p_end}
{synopt:{opt stdp}}standard error of the linear prediction{p_end}
{synopt:{opt r:esiduals}}residuals{p_end}
{synoptline}
{p2colreset}{...}
INCLUDE help esample


INCLUDE help menu_predict


{marker options_predict}{...}
{title:Options for predict}

{dlgtab:Main}

{phang}
{opt xb}, the default, calculates the linear prediction for the specified
equation.

{phang}
{opt stdp} calculates the standard error of the linear prediction for the
specified equation.

{phang}
{opt residuals} calculates the residuals.

{phang}
{opt equation(eqno|eqname)} specifies the equation to which you are referring.

{pmore}
    {opt equation()} is filled in with one {it:eqno} or {it:eqname} for
    the {opt xb}, {opt stdp}, and {opt residuals} options.  For example, 
    {cmd:equation(#1}) would mean that the calculation is to be made for the
    first equation, {cmd:equation(#2)} would mean the second, and so on.
    You could also refer to the equation by its name; thus,
    {cmd:equation(income)} would refer to the equation named income and
    {cmd:equation(hours)}, to the equation named hours.

{pmore}
    If you do not specify {opt equation()}, the results are the same as if you
    specified {cmd:equation(#1)}.

{pstd}
For more information on using {opt predict} after multiple-equation
estimation commands, see {manhelp predict R}.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse lutkepohl2}{p_end}

{pstd}Fit a vector autoregressive model{p_end}
{phang2}{cmd:. var dln_inv dln_inc dln_consump}{p_end}

{pstd}Test for normally distributed disturbances after {cmd:var}{p_end}
{phang2}{cmd:. varnorm}

{pstd}Obtain lag-order selection statistics after {cmd:var}{p_end}
{phang2}{cmd:. varsoc}

{pstd}Estimate IRFs and FEVDs and save under {cmd:order1} in {cmd:myirf1.irf}
{p_end}
{phang2}{cmd:. irf create order1, set(myirf1)}

{pstd}Graph the orthogonalized impulse-response function, using {cmd:dln_inc}
as the impulse variable and {cmd:dln_consump} as the response variable{p_end}
{phang2}{cmd:. irf graph oirf, impulse(dln_inc) response(dln_consump)}

{pstd}Compute forecasts for next 4 periods{p_end}
{phang2}{cmd:. fcast compute f_, step(4)}

{pstd}Graph forecasts just made{p_end}
{phang2}{cmd:. fcast graph f_dln_inv f_dln_inc f_dln_consump}{p_end}
