{smcl}
{* *! version 1.1.5  11feb2011}{...}
{viewerdialog predict "dialog svar_p"}{...}
{vieweralsosee "[TS] var svar postestimation" "mansection TS varsvarpostestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[TS] var svar" "help var svar"}{...}
{viewerjumpto "Description" "svar postestimation##description"}{...}
{viewerjumpto "Syntax for predict" "svar postestimation##syntax_predict"}{...}
{viewerjumpto "Options for predict" "svar postestimation##options_predict"}{...}
{viewerjumpto "Examples" "svar postestimation##examples"}{...}
{title:Title}

{p2colset 5 37 39 2}{...}
{p2col:{manlink TS var svar postestimation} {hline 2}}Postestimation tools for
svar{p_end}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
The following postestimation commands are of special interest after {opt svar}:

{synoptset 15}{...}
{synopt:Command}Description{p_end}
{synoptline}
{synopt:{helpb fcast compute}}obtain dynamic forecasts{p_end}
{synopt:{helpb fcast graph}}graph dynamic forecasts obtained from {opt fcast compute}{p_end}
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
INCLUDE help post_nlcom
{p2col :{helpb svar postestimation##predict:predict}}predictions, residuals, influence statistics, and other diagnostic measures{p_end}
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
[{cmd:,}
{it:statistic}
{opt eq:uation(eqno|eqname)}]

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
    options {opt xb}, {opt stdp}, and {opt residuals}.  {cmd:equation(#1})
    would mean that the calculation is to be made for the first equation,
    {cmd:equation(#2)} would mean the second, and so on.  You could also refer
    to the equation by its name; thus, {cmd:equation(income)} would refer to
    the equation named income and {cmd:equation(hours)}, to the equation named
    hours.

{pmore}
   If you do not specify {opt equation()}, the results are the same as if you
   specified {cmd:equation(#1)}.

{pstd}
For more information on using {opt predict} after multiple-equation commands,
see {manhelp predict R}.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse lutkepohl2}{p_end}
{phang2}{cmd:. matrix A = (1,0,0\.,1,0\.,.,1)}{p_end}
{phang2}{cmd:. matrix B = (.,0,0\0,.,0\0,0,.)}

{pstd}Short-run just-identified SVAR model{p_end}
{phang2}{cmd:. svar dln_inv dln_inc dln_consump, aeq(A) beq(B)}{p_end}

{pstd}Perform Lagrange-multiplier test for residual autocorrelation after
{cmd:svar}{p_end}
{phang2}{cmd:. varlmar}

{pstd}Test for normally distributed disturbances after {cmd:svar}{p_end}
{phang2}{cmd:. varnorm}

{pstd}Estimate IRFs and FEVDs and save under {cmd:order1} in {cmd:myirf1.irf}
{p_end}
{phang2}{cmd:. irf create order1, set(myirf1)}

{pstd}Create table of orthogonalized impulse-response functions{p_end}
{phang2}{cmd:. irf table oirf}

{pstd}Calculate linear prediction{p_end}
{phang2}{cmd:. predict xb}{p_end}
