{smcl}
{* *! version 1.1.9  03may2011}{...}
{viewerdialog predict "dialog reg3_p"}{...}
{vieweralsosee "[R] sureg postestimation" "mansection R suregpostestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] sureg" "help sureg"}{...}
{viewerjumpto "Description" "sureg postestimation##description"}{...}
{viewerjumpto "Syntax for predict" "sureg postestimation##syntax_predict"}{...}
{viewerjumpto "Options for predict" "sureg postestimation##options_predict"}{...}
{viewerjumpto "Examples" "sureg postestimation##examples"}{...}
{title:Title}

{p2colset 5 33 35 2}{...}
{p2col:{manlink R sureg postestimation} {hline 2}}Postestimation tools for
sureg{p_end}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
The following postestimation commands are available after {opt sureg}:

{synoptset 13}{...}
{synopt:Command}Description{p_end}
{synoptline}
INCLUDE help post_contrast
INCLUDE help post_estat
INCLUDE help post_estimates
INCLUDE help post_lincom
INCLUDE help post_margins
INCLUDE help post_marginsplot
INCLUDE help post_nlcom
{synopt:{helpb sureg postestimation##predict:predict}}predictions, residuals, influence statistics, and other diagnostic measures{p_end}
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
{cmd:predict}
{dtype} {newvar} {ifin}
[{cmd:,}
{cmdab:eq:uation:(}{it:eqno}[{cmd:,}{it:eqno}]{cmd:)}
{it:statistic}]

{synoptset 13 tabbed}{...}
{synopthdr:statistic}
{synoptline}
{syntab:Main}
{synopt:{opt xb}}linear prediction; the default{p_end}
{synopt:{opt stdp}}standard error of the linear prediction{p_end}
{synopt:{opt r:esiduals}}residuals{p_end}
{synopt:{opt d:ifference}}difference between the linear predictions of two
equations{p_end}
{synopt:{opt stddp}}standard error of the difference in linear predictions{p_end}
{synoptline}
{p2colreset}{...}
INCLUDE help esample


INCLUDE help menu_predict


{marker options_predict}{...}
{title:Options for predict}

{dlgtab:Main}

{phang}
{cmd:equation(}{it:eqno}[{cmd:,}{it:eqno}]{cmd:)}
  specifies to which equation(s) you are referring.

{pmore}
{opt equation()} is filled in with one {it:eqno} for the {opt xb},
{opt stdp}, and {opt residuals} options.  {cmd:equation(#1)} would mean the
calculation is to be made for the first equation, {cmd:equation(#2)} would mean
the second, and so on.  You could also refer to the equations by
their names.  {cmd:equation(income)} would refer to the equation named income
and {cmd:equation(hours)} to the equation named hours.

{pmore}
If you do not specify {opt equation()}, the results are the same as if you
specified {cmd:equation(#1)}.

{pmore}
{opt difference} and {opt stddp} refer to between-equation concepts.
To use these options, you must specify two equations, for example,
{cmd:equation(#1,#2)} or {cmd:equation(income,hours)}.  When two equations
must be specified, {opt equation()} is required.

{phang}
{opt xb}, the default, calculates the linear prediction (fitted values) -- the
prediction of xb for the specified equation.

{phang}
{opt stdp} calculates the standard error of the prediction for the specified
equation.  It can be thought of as the standard error of the predicted
expected value or mean for the observation's covariate pattern.  The standard
error of the prediction is also referred to as the standard error of the
fitted value.

{phang}
{opt residuals} calculates the residuals.

{phang}
{opt difference} calculates the difference between the linear
predictions of two equations in the system.
With {cmd:equation(#1,#2)}, {opt difference} computes the prediction of
{cmd:equation(#1)} minus the prediction of {cmd:equation(#2)}.

{phang}
{opt stddp} 
is allowed only after you have previously fit a multiple-equation model.
The standard error of the difference in linear predictions between equations 1
and 2 is calculated.

{pstd}
For more information on using {opt predict} after multiple-equation
estimation, see {manhelp predict R}.


{marker examples}{...}
{title:Examples}

    {hline}
    Setup
{phang2}{cmd:. sysuse auto}{p_end}
{phang2}{cmd:. sureg (price foreign weight length) (mpg foreign weight) (displ foreign weight)}

{pstd}Test that the coefficients on {cmd:foreign} are 0 in all equations{p_end}
{p 8 12 2}{cmd:. test foreign}

{pstd}Test that the coefficients on {cmd:foreign} are 0 in the {cmd:mpg} and 
{cmd:displ} equations{p_end}
{p 8 12 2}{cmd:. test [mpg]foreign [displacement]foreign}

{pstd}Test an across-equation equality{p_end}
{p 8 12 2}{cmd:. test [price]foreign = [mpg]foreign}{p_end}
{p 8 12 2}{cmd:. test [displacement]foreign = [mpg]foreign, accum}

{pstd}Test a general linear combination{p_end}
{p 8 12 2}{cmd:. test [price]foreign-[mpg]weight = [displacement]foreign - [displacement]weight}

    {hline}
    Setup
{phang2}{cmd:. sysuse auto}{p_end}
{phang2}{cmd:. sureg (mpg price weight length) (gear price weight length)}{p_end}

{pstd}Calculate fitted values for the first equation{p_end}
{phang2}{cmd:. predict mpghat, xb equation(#1)}{p_end}

{pstd}Calculate the standard error of the prediction for the second
equation{p_end}
{phang2}{cmd:. predict gearstdp, stdp equation(#2)}{p_end}

    {hline}
{pstd}Setup{p_end}
{phang2}{cmd:. webuse margex, clear}

{pstd}Fit seemingly unrelated regression model{p_end}
{phang2}{cmd:. sureg (y = i.sex age) (distance = i.sex i.group)}

{pstd}Estimate marginal means of {cmd:y} for men and women{p_end}
{phang2}{cmd:. margins sex, predict(equation(y))}

    {hline}
