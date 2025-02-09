{smcl}
{* *! version 1.1.12  20jun2011}{...}
{viewerdialog predict "dialog arima_p"}{...}
{viewerdialog estat "dialog arima_estat"}{...}
{viewerdialog psdensity "dialog psdensity"}{...}
{vieweralsosee "[TS] arima postestimation" "mansection TS arimapostestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[TS] arima" "help arima"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[TS] psdensity" "help psdensity"}{...}
{viewerjumpto "Description" "arima postestimation##description"}{...}
{viewerjumpto "Syntax for predict" "arima postestimation##syntax_predict"}{...}
{viewerjumpto "Options for predict" "arima postestimation##options_predict"}{...}
{viewerjumpto "Examples" "arima postestimation##examples"}{...}
{title:Title}

{p2colset 5 34 36 2}{...}
{p2col:{manlink TS arima postestimation} {hline 2}}Postestimation tools for
arima{p_end}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
The following postestimation command is of special interest after {cmd:arima}:

{synoptset 18}{...}
{p2coldent :Command}Description{p_end}
{synoptline}
{synopt :{helpb psdensity}}estimate the spectral density{p_end}
{synoptline}
{p2colreset}{...}

{pstd}
The following standard postestimation commands are also available:

{synoptset 11}{...}
{synopt:Command}Description{p_end}
{synoptline}
INCLUDE help post_estat
INCLUDE help post_estimates
INCLUDE help post_lincom
INCLUDE help post_lrtest
INCLUDE help post_margins
INCLUDE help post_marginsplot
INCLUDE help post_nlcom
{p2col :{helpb arima postestimation##predict:predict}}predictions, residuals, influence statistics, and other diagnostic measures{p_end}
INCLUDE help post_predictnl
INCLUDE help post_test
INCLUDE help post_testnl
{synoptline}


{marker syntax_predict}{...}
{marker predict}{...}
{title:Syntax for predict}

{p 8 16 2}
{cmd:predict}
{dtype}
{newvar}
{ifin}
[{cmd:,} {it:statistic} {it:options}]

{marker statistic}{...}
{synoptset 26 tabbed}{...}
{synopthdr:statistic}
{synoptline}
{syntab:Main}
{synopt:{opt xb}}predicted values for mean equation -- the differenced series; the default{p_end}
{synopt:{opt stdp}}standard error of the linear prediction{p_end}
{synopt:{opt y}}predicted values for the mean equation in {it:y} -- the undifferenced series{p_end}
{synopt:{opt mse}}mean squared error of the predicted values{p_end}
{synopt:{opt r:esiduals}}residuals or predicted innovations{p_end}
{synopt:{opt yr:esiduals}}residuals or predicted innovations in y, reversing any
time-series operators{p_end}
{synoptline}
INCLUDE help esample
{phang}
Predictions are not available for conditional ARIMA models fit to panel
data.

{marker options}{...}
{synopthdr:options}
{synoptline}
{syntab:Options}
{synopt:{opt d:ynamic(time_constant)}}how to handle lags of y_t{p_end}
{synopt:{opt t0(time_constant)}}set starting point for the recursions to {it:time_constant}{p_end}
{synopt:{opt str:uctural}}calculate considering the structural component only
{p_end}
{synoptline}
{p 4 6 2}
{p2colreset}{...}
{it:time_constant} is a {it:#} or a time literal, such as {cmd:td(1jan1995)} 
or {cmd:tq(1995q1)}.  See 
{it:{help datetime##s9:Conveniently typing SIF values}}
in
{manhelp datetime D}.


INCLUDE help menu_predict


{marker options_predict}{...}
{title:Options for predict}

{dlgtab:Main}

{phang}
{opt xb}, the default, calculates the predictions from the model.  If
   {opt D.}{depvar} is the dependent variable, these predictions are of
   {opt D.}{it:depvar} and not of {it:depvar} itself.

{phang}
{opt stdp} calculates the standard error of the linear prediction {opt xb}.
   {opt stdp} does not include the variation arising from the 
   disturbance equation; use {opt mse} to calculate standard errors and 
   confidence bands around the predicted values.

{phang}
{opt y} specifies that predictions of {depvar} be made, even
   if the model was specified in terms of, say, {cmd:D.}{it:depvar}.

{phang}
{opt mse} calculates the MSE of the predictions.

{phang}
{opt residuals} calculates the residuals.
   If no other options are specified, these are the predicted innovations;
   that is, they include the ARMA component.  If {opt structural} is specified,
   these are the residuals from the structural equation; see
   {helpb arima postestimation##structural:structural} below.

{phang}
{opt yresiduals} calculates the residuals in terms of {depvar}, even
   if the model was specified in terms of, say, {opt D.}{it:depvar}.  As with
   {opt residuals}, the {opt yresiduals} are computed from the model, including
   any ARMA component.  If {opt structural} is specified, any ARMA component
   is ignored, and {opt yresiduals} are the residuals from the structural
   equation; see {helpb arima postestimation##structural:structural} below.

{dlgtab:Options}

{phang}
{opt dynamic(time_constant)} specifies how lags of y_t in the model are to be
   handled.  If {opt dynamic()} is not specified, actual values are used
   everywhere that lagged values of y_t appear in the model to produce
   one-step-ahead forecasts.

{pmore}
   {opt dynamic(time_constant)} produces dynamic (also known as recursive)
   forecasts.  {it:time_constant} specifies when the forecast is to switch
   from one step ahead to dynamic.  In dynamic forecasts, references to y_t
   evaluate to the prediction of y_t for all periods at or after
   {it:time_constant}; they evaluate to the actual value of y_t for all prior
   periods.

{pmore}
   For example, {cmd:dynamic(10)} would calculate predictions in which any
   reference to y_t with t < 10 evaluates to the actual value of y_t and any
   reference of y_t with t{ul:>}10 evaluates to the prediction of y_t.  This
   means that one-step-ahead predictions are calculated for t < 10 and dynamic
   predictions thereafter.  Depending on the lag structure of the model, the
   dynamic predictions might still refer to some actual values of y_t.

{pmore}
   You may also specify {cmd:dynamic(.)} to have {opt predict}
   automatically switch from one-step-ahead to dynamic predictions at p + q,
   where p is the maximum AR lag and q is the maximum MA lag.

{phang}
{opt t0(time_constant)} specifies the starting point for the
   recursions to compute the predicted statistics; disturbances are assumed to
   be 0 for t < {opt t0()}.  The default is to set {opt t0()} to the minimum t
   observed in the estimation sample, meaning that observations before that
   are assumed to have disturbances of 0.
  
{pmore}
   {opt t0()} is irrelevant if {opt structural} is specified, because
   then all observations are assumed to have disturbances of 0.

{pmore}
   {cmd:t0(5)} would begin recursions at t=5.  If the data were quarterly, you
   might instead type {cmd:t0(tq(1961q2))} to obtain the same result.

{pmore}
   The ARMA component of ARIMA models is recursive and depends
   on the starting point of the predictions.  This includes one-step-ahead
   predictions.

{marker structural}{...}
{phang}
{opt structural} specifies that the calculation be made considering the
   structural component only, ignoring the ARMA terms, producing the
   steady-state equilibrium predictions.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse wpi1}{p_end}

{pstd}Fit ARIMA model with additive seasonal effects{p_end}
{phang2}{cmd:. arima D.ln_wpi, ar(1) ma(1 4)}{p_end}

{pstd}Compute predictions for {cmd:D.ln_wpi}{p_end}
{phang2}{cmd:. predict xb}{p_end}

{pstd}Consider structural component only -- ignore ARMA terms -- when making
predictions{p_end}
{phang2}{cmd:. predict xbs, structural}{p_end}

{pstd}Compute predictions for {cmd:ln_wpi}, reversing any time-series
operators applied in estimation{p_end}
{phang2}{cmd:. predict y, y}

{pstd}Compute predictions for {cmd:ln_wpi}, using lagged forecasted values for
predictions after 1970q1 instead of lagged actual values{p_end}
{phang2}{cmd:. predict yd, y dynamic(tq(1970q1))}

{pstd}Graph time-series line plot{p_end}
{phang2}{cmd:. tsline y yd}{p_end}
