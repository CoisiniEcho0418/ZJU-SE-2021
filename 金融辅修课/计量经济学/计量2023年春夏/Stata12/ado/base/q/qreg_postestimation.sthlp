{smcl}
{* *! version 1.1.9  07apr2011}{...}
{viewerdialog "predict for qreg, iqreg, bsqreg" "dialog qreg_p"}{...}
{viewerdialog "predict for sqreg" "dialog sqreg_p"}{...}
{vieweralsosee "[R] qreg postestimation" "mansection R qregpostestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] qreg" "help qreg"}{...}
{viewerjumpto "Description" "qreg postestimation##description"}{...}
{viewerjumpto "Syntax for predict" "qreg postestimation##syntax_predict"}{...}
{viewerjumpto "Options for predict" "qreg postestimation##options_predict"}{...}
{viewerjumpto "Examples" "qreg postestimation##examples"}{...}
{title:Title}

{p2colset 5 32 34 2}{...}
{p2col :{manlink R qreg postestimation} {hline 2}}Postestimation tools for qreg,
iqreg, bsqreg, and sqreg{p_end}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
The following postestimation commands are available after {cmd:qreg},
{cmd:iqreg}, {cmd:bsqreg}, and {cmd:sqreg}:

{synoptset 11}{...}
{p2coldent :Command}Description{p_end}
{synoptline}
{synopt :{helpb estat}}VCE and estimation sample summary{p_end}
INCLUDE help post_estimates
INCLUDE help post_lincom
INCLUDE help post_linktest
INCLUDE help post_margins
INCLUDE help post_marginsplot
INCLUDE help post_nlcom
{synopt :{helpb qreg postestimation##predict:predict}}predictions, residuals, influence statistics, and other diagnostic measures{p_end}
INCLUDE help post_predictnl
INCLUDE help post_test
INCLUDE help post_testnl
{synoptline}
{p2colreset}{...}


{marker syntax_predict}{...}
{marker predict}{...}
{title:Syntax for predict}

{phang}
For qreg, iqreg, and bsqreg

{p 8 16 2}
{cmd:predict} {dtype} {newvar} {ifin}
	[{cmd:,} [{opt xb}{c |}{opt stdp}{c |}{opt r:esiduals}]]

{phang}
For sqreg

{p 8 16 2}
{cmd:predict} {dtype} {newvar} {ifin}
	[{cmd:,} {cmdab:eq:uation:(}{it:eqno}[{cmd:,}{it:eqno}]{cmd:)}
          {it:statistic}]

{synoptset 13 tabbed}{...}
{synopthdr :statistic}
{synoptline}
{syntab :Main}
{synopt :{opt xb}}linear prediction; the default{p_end}
{synopt :{opt stdp}}standard error of the linear prediction{p_end}
{synopt :{opt stddp}}standard error of the difference in linear predictions{p_end}
{synopt :{opt r:esiduals}}residuals{p_end}
{synoptline}
{p2colreset}{...}
INCLUDE help esample


INCLUDE help menu_predict


{marker options_predict}{...}
{title:Options for predict}

{dlgtab:Main}

{phang}{opt xb}, the default, calculates the linear prediction.

{phang}{opt stdp} calculates the standard error of the linear prediction.

{phang}{opt stddp} is allowed only after you have fit a model using
{cmd:sqreg}.  The standard error of the difference in linear predictions
between equations 1 and 2 is calculated.

{phang}{opt residuals} calculates the residuals, that is, y - xb.

{phang}{cmd:equation(}{it:eqno}[{cmd:,}{it:eqno}]{cmd:)} specifies the
equation to which you are making the calculation.  

{pmore} {opt equation()} is filled in
with one {it:eqno} for the {opt xb}, {opt stdp}, and {opt residuals} options.
{cmd:equation(#1)} would mean that the calculation is to be made for the first
equation, {cmd:equation(#2)} would mean the second, and so on.  
You could also refer to the equations by their names.  {cmd:equation(income)}
would refer to the equation named income and {cmd:equation(hours)} to the
equation named hours.

{pmore} If you do not specify {opt equation()}, results are the same as if you
had specified {cmd:equation(#1)}.

{pmore}To use {opt stddp}, you must specify two equations.  You might specify
{cmd:equation(#1, #2)} or {cmd:equation(q80, q20)} to indicate the 80th and
20th quantiles.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. sysuse auto}{p_end}
{phang2}{cmd:. qreg price weight length foreign}{p_end}

{pstd}Obtain predicted values{p_end}
{phang2}{cmd:. predict hat}

{pstd}Obtain residuals{p_end}
{phang2}{cmd:. predict r, resid}{p_end}
