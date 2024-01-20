{smcl}
{* *! version 1.1.15  03apr2011}{...}
{viewerdialog predict "dialog mlogit_p"}{...}
{vieweralsosee "[R] mlogit postestimation" "mansection R mlogitpostestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] mlogit" "help mlogit"}{...}
{viewerjumpto "Description" "mlogit postestimation##description"}{...}
{viewerjumpto "Syntax for predict" "mlogit postestimation##syntax_predict"}{...}
{viewerjumpto "Options for predict" "mlogit postestimation##options_predict"}{...}
{viewerjumpto "Examples" "mlogit postestimation##examples"}{...}
{title:Title}

{p2colset 5 34 36 2}{...}
{p2col :{manlink R mlogit postestimation} {hline 2}}Postestimation tools for mlogit{p_end}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
The following postestimation commands are available after {opt mlogit}:

{synoptset 13 notes}{...}
{p2coldent :Command}Description{p_end}
{synoptline}
INCLUDE help post_contrast
INCLUDE help post_estat
INCLUDE help post_svy_estat
INCLUDE help post_estimates
INCLUDE help post_hausman
INCLUDE help post_lincom
INCLUDE help post_lrtest_star
INCLUDE help post_margins
INCLUDE help post_marginsplot
INCLUDE help post_nlcom
{synopt :{helpb mlogit postestimation##predict:predict}}predictions, residuals,
influence statistics, and other diagnostic measures{p_end}
INCLUDE help post_predictnl
INCLUDE help post_pwcompare
INCLUDE help post_suest
INCLUDE help post_test
INCLUDE help post_testnl
{synoptline}
{p2colreset}{...}
INCLUDE help post_lrtest_star_msg


{marker syntax_predict}{...}
{marker predict}{...}
{title:Syntax for predict}

{p 8 16 2}
{cmd:predict}
{dtype}
{c -(}{it:stub}{cmd:*} | {it:{help newvar}} | {it:{help newvarlist}}{c )-}
{ifin}
[{cmd:,} {it:statistic} {opt o:utcome(outcome)}]

{p 8 16 2}
{cmd:predict}
{dtype}
{c -(}{it:stub}{cmd:*} | {it:{help newvarlist}}{c )-}
{ifin}
{cmd:,} {opt sc:ores}

{synoptset 11 tabbed}{...}
{synopthdr :statistic}
{synoptline}
{syntab :Main}
{synopt :{opt p:r}}probability of a positive outcome; the default{p_end}
{synopt :{cmd:xb}}linear prediction{p_end}
{synopt :{cmd:stdp}}standard error of the linear prediction{p_end}
{synopt :{cmd:stddp}}standard error of the difference in two linear
predictions{p_end}
{synoptline}
{p2colreset}{...}
{p 4 6 2}
If you do not specify {cmd:outcome()}, {cmd:pr} (with one new variable
specified), {cmd:xb}, and {cmd:stdp} assume {cmd:outcome(#1)}.  You must
specify {cmd:outcome()} with the {cmd:stddp} option.{p_end}
{p 4 6 2}
You specify one or k new variables with {cmd:pr}, where {it:k} is the number
of outcomes.{p_end}
{p 4 6 2}
You specify one new variable with {cmd:xb}, {cmd:stdp}, and {cmd:stddp}.{p_end}
INCLUDE help esample


INCLUDE help menu_predict


{marker options_predict}{...}
{title:Options for predict}

{dlgtab:Main}

{phang}
{opt pr}, the default, calculates the probability of each of the categories of
the dependent variable or the probability of the level specified in
{opt outcome(outcome)}.  If you specify the {opt outcome(outcome)} option, you
need to specify only one new variable; otherwise, you must specify a new
variable for each category of the dependent variable.

{phang}
{opt xb} calculates the linear prediction.  You must also specify the
{opt outcome(outcome)} option.

{phang}
{opt stdp} calculates the standard error of the linear prediction.
You must also specify the {opt outcome(outcome)} option.

{phang}
{opt stddp} calculates the standard error of the difference in two
linear predictions.  You must specify the {opt outcome(outcome)} option,
and here you specify the two particular outcomes of interest inside
the parentheses, for example, {cmd:predict sed, stdp outcome(1,3)}.

{phang}
{opt outcome(outcome)} specifies the outcome for which the statistic is to be
calculated.  {opt equation()} is a synonym for {opt outcome()}: it does not
matter which you use.  {opt outcome()} or {opt equation()} can be specified
using 

{pin2}
{cmd:#1}, {cmd:#2}, ..., where {cmd:#1} means the first category of
the dependent variable, {cmd:#2} means the second category, etc.; 

{pin2}
the values of the dependent variable; or 

{pin2}
the value labels of the dependent variable if they exist.

{phang}
{opt scores} calculates equation-level score variables.  The number of
score variables created will be one less than the number of outcomes in the
model.  If the number of outcomes in the model were k, then

{pmore}
the first new variable will contain the first derivative of the log
likelihood with respect to the first equation;

{pmore}
the second new variable will contain the first derivative of the log
likelihood with respect to the second equation;

{pmore}
...

{pmore}
the (k-1)th new variable will contain the first derivative of the log
likelihood with respect to the (k-1)st equation.


{marker examples}{...}
{title:Examples}

    {hline}
{pstd}Setup{p_end}
{phang2}{cmd:. webuse sysdsn1}{p_end}
{phang2}{cmd:. mlogit insure age male nonwhite i.site}{p_end}

{pstd}Test joint significance of {cmd:2.site} and {cmd:3.site} in all equations
{p_end}
{phang2}{cmd:. test 2.site 3.site}{p_end}

{pstd}Test joint significance of coefficients in {cmd:Prepaid} equation{p_end}
{phang2}{cmd:. test [Prepaid]}{p_end}

{pstd}Test joint significance of {cmd:2.site} and {cmd:3.site} in {cmd:Uninsure}
equation{p_end}
{phang2}{cmd:. test [Uninsure]: 2.site 3.site}{p_end}

{pstd}Test if coefficients in {cmd:Prepaid} and {cmd:Uninsure} equations are
equal{p_end}
{phang2}{cmd:. test [Prepaid=Uninsure]}{p_end}

{pstd}Predict probabilities of outcome 1 for estimation sample{p_end}
{phang2}{cmd:. predict p1 if e(sample), outcome(1)}{p_end}

{pstd}Display summary statistics of {cmd:p1}{p_end}
{phang2}{cmd:. summarize p1}{p_end}

{pstd}Compute linear prediction for {cmd:Indemnity} equation{p_end}
{phang2}{cmd:. predict idx1, outcome(Indemnity) xb}{p_end}

    {hline}
{pstd}Setup{p_end}
{phang2}{cmd:. sysuse auto, clear}{p_end}
{phang2}{cmd:. mlogit rep78 mpg displ}{p_end}

{pstd}Compute the average marginal effect of each regressor on the probability
of each of the outcomes 1-3{p_end}
{phang2}{cmd:. margins, dydx(*) predict(outcome(1))}{p_end}
{phang2}{cmd:. margins, dydx(*) predict(outcome(2))}{p_end}
{phang2}{cmd:. margins, dydx(*) predict(outcome(3))}{p_end}
    {hline}
