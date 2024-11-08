{smcl}
{* *! version 1.1.8  31mar2011}{...}
{viewerdialog predict "dialog vec_p"}{...}
{vieweralsosee "[TS] vec postestimation" "mansection TS vecpostestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[TS] vec" "help vec"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[TS] vec intro" "help vec_intro"}{...}
{viewerjumpto "Description" "vec postestimation##description"}{...}
{viewerjumpto "Syntax for predict" "vec postestimation##syntax_predict"}{...}
{viewerjumpto "Options for predict" "vec postestimation##options_predict"}{...}
{viewerjumpto "Examples" "vec postestimation##examples"}{...}
{title:Title}

{p2colset 5 32 34 2}{...}
{p2col :{manlink TS vec postestimation} {hline 2}}Postestimation tools for vec{p_end}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
The following postestimation commands are of special interest after {cmd:vec}:

{synoptset}{...}
{p2col :Command}Description{p_end}
{synoptline}
{synopt :{helpb fcast compute}}obtain dynamic forecasts{p_end}
{synopt :{helpb fcast graph}}graph dynamic forecasts obtained from 
{cmd:fcast compute}{p_end}
{synopt :{helpb irf}}create and analyze IRFs and FEVDs{p_end}
{synopt :{helpb veclmar}}LM test for autocorrelation in residuals{p_end}
{synopt :{helpb vecnorm}}test for normally distributed residuals{p_end}
{synopt :{helpb vecstable}}check stability condition of estimates{p_end}
{synoptline}
{p2colreset}{...}

{pstd}
The following standard postestimation commands are also available:

{synoptset}{...}
{p2col :Command}Description{p_end}
{synoptline}
INCLUDE help post_estat
INCLUDE help post_estimates
INCLUDE help post_lincom
INCLUDE help post_lrtest
INCLUDE help post_margins
INCLUDE help post_marginsplot
INCLUDE help post_nlcom
{synopt :{helpb vec postestimation##predict:predict}}predictions, residuals, 
influence statistics, and other diagnostic measures{p_end}
{synopt :{helpb predictnl}}point estimates, standard errors, testing, and
inference for generalized predictions{p_end}
INCLUDE help post_test
INCLUDE help post_testnl
{synoptline}
{p2colreset}{...}


{marker syntax_predict}{...}
{marker predict}{...}
{title:Syntax for predict}

{p 8 19 2}
{cmd:predict} {dtype} {newvar} {ifin} 
  [{cmd:,} {it:statistic}
 {opt eq:uation}{cmd:(}{it:eqno}|{it:eqname}{cmd:)}]

{synoptset tabbed}{...}
{synopthdr:statistic}
{synoptline}
{syntab:Main}
{synopt :{cmd:xb}}fitted value for the specified equation; the default{p_end}
{synopt :{cmd:stdp}}standard error of the linear prediction{p_end}
{synopt :{opt r:esiduals}}residuals{p_end}
{synopt :{cmd:ce}}the predicted value of the specified cointegrating equation{p_end}
{synopt :{opt l:evels}}one-step prediction of the level of the endogenous 
  variable{p_end}
{synopt :{opth u:sece(varlist:varlist_ce)}}compute the predictions using
   previously predicted cointegrating equations{p_end}
{synoptline}
{p2colreset}{...}
{p 4 6 2}These statistics are available both in and out of sample; type
{cmd:predict} {it:...} {cmd:if} {cmd:e(sample)} {it:...} if wanted only for
the estimation sample.


INCLUDE help menu_predict


{marker options_predict}{...}
{title:Options for predict}

{dlgtab:Main}

{phang}
{opt xb}, the default, calculates the fitted values for the specified
equation.  The form of the VECM implies that these fitted values
are the one-step predictions for the first-differenced variables.

{phang}
{opt stdp} calculates the standard error of the linear prediction for the
specified equation.

{phang}
{opt residuals} calculates the residuals from the specified equation of the
VECM. 

{phang}
{opt ce} calculates the predicted value of the specified cointegrating
equation.

{phang}
{opt levels} calculates the one-step prediction of the level of the endogenous
variable in the requested equation.

{phang}
{opth usece:(varlist:varlist_ce)} specifies that previously predicted
cointegrating equations saved under the names in {it:varlist_ce} be used to
compute the predictions.  The number of variables in the {it:varlist_ce} must
equal the number of cointegrating equations specified in the model.

{phang}
{opt equation(eqno|eqname)} specifies to which equation you are referring.

{pmore}
{opt equation()} is filled in with one {it:eqno} or {it:eqname} for
{opt xb}, {opt residuals}, {opt stdp}, {opt ce}, and {opt levels} options.
{cmd:equation(#1}) would mean that the calculation is to be made for the first
equation, {cmd:equation(#2)} would mean the second, and so on.  You could also
refer to the equation by its name.  {cmd:equation(D_income)} would refer to
the equation named D_income and {cmd:equation(_ce1)}, to the first
cointegrating equation, which is named _ce1 by {cmd:vec}.

{pmore}
If you do not specify {opt equation()}, the results are as if you specified
{cmd:equation(#1)}.

{phang}
For more information on using {cmd:predict} after multiple-equation estimation
commands, see {manhelp predict R}.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse urates}

{pstd}Fit VECM, including a restricted constant in the model, using 2
cointegrating equations{p_end}
{phang2}{cmd:. vec missouri indiana kentucky illinois, trend(rconstant) rank(2)}
{p_end}

{pstd}Test for normally distributed disturbances after {cmd:vec}{p_end}
{phang2}{cmd:. vecnorm}{p_end}

{pstd}Perform Lagrange-multiplier test for residual autocorrelation{p_end}
{phang2}{cmd:. veclmar}{p_end}

{pstd}Estimate IRFs and FEVDs, using 50 as forecast horizon, and save under
{cmd:vec1} in {cmd:vecirfs.irf}{p_end}
{phang2}{cmd:. irf create vec1, set(vecirfs) step(50)}{p_end}

{pstd}Graph the orthogonalized impulse-response function{p_end}
{phang2}{cmd:. irf graph oirf}{p_end}

{pstd}Calculate predicted value of cointegrating equation{p_end}
{phang2}{cmd:. predict ce, ce}{p_end}
