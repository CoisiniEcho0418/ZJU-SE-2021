{smcl}
{* *! version 1.1.11  11feb2011}{...}
{viewerdialog predict "dialog mprobit_p"}{...}
{vieweralsosee "[R] mprobit postestimation" "mansection R mprobitpostestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] mprobit" "help mprobit"}{...}
{viewerjumpto "Description" "mprobit postestimation##description"}{...}
{viewerjumpto "Syntax for predict" "mprobit postestimation##syntax_predict"}{...}
{viewerjumpto "Options for predict" "mprobit postestimation##options_predict"}{...}
{viewerjumpto "Examples" "mprobit postestimation##examples"}{...}
{title:Title}

{p2colset 5 35 37 2}{...}
{p2col :{manlink R mprobit postestimation} {hline 2}}Postestimation tools for mprobit{p_end}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
The following postestimation commands are available after {opt mprobit}:

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
{synopt :{helpb mprobit postestimation##predict:predict}}predicted
probabilities, linear predictions, and standard errors{p_end}
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
{synopt :{cmdab:p:r}}probability of a positive outcome; the default{p_end}
{synopt :{cmd:xb}}linear prediction{p_end}
{synopt :{cmd:stdp}}standard error of the linear prediction{p_end}
{synoptline}
{p2colreset}{...}
{p 4 6 2}
If you do not specify {cmd:outcome()}, {cmd:pr} (with one new variable
specified), {cmd:xb}, and {cmd:stdp} assume {cmd:outcome(#1)}.{p_end}
{p 4 6 2}
You specify one or k new variables with {cmd:pr}, where {it:k} is the number
of outcomes.{p_end}
{p 4 6 2}
You specify one new variable with {cmd:xb} and {cmd:stdp}.{p_end}
INCLUDE help esample


INCLUDE help menu_predict


{marker options_predict}{...}
{title:Options for predict}

{dlgtab:Main}

{phang}
{opt pr}, the default, calculates the probability of each of the categories of
the dependent variable or the probability of the level specified in
{opt outcome()}.  If you specify the {opt outcome()} option, you need to
specify only one new variable; otherwise, you must specify a new variable for
each category of the dependent variable.

{phang}
{opt xb} calculates the linear prediction, x_{it:i} a_{it:j}, for 
alternative {it:j} and individual {it:i}.  The index, {it:j}, corresponds 
to the outcome specified in {opt outcome()}.

{phang}
{opt stdp} calculates the standard error of the linear prediction.

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
{opt scores} calculates the equation-level score variables.  The {it:j}th new
variable will contain the scores for the {it:j}th fitted equation.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse sysdsn1}{p_end}
{phang2}{cmd:. mprobit insure age male nonwhite i.site}{p_end}

{pstd}Test that the coefficients on {cmd:2.site} and {cmd:3.site} are 0 in all
equations{p_end}
{phang2}{cmd:. test 2.site 3.site}{p_end}

{pstd}Test that all coefficients in equation {cmd:Uninsure} are 0{p_end}
{phang2}{cmd:. test [Uninsure]}{p_end}

{pstd}Test that {cmd:2.site} and {cmd:3.site} are jointly 0 in the {cmd:Prepaid}
equation{p_end}
{phang2}{cmd:. test [Prepaid]: 2.site 3.site}{p_end}

{pstd}Test that coefficients in equations {cmd:Prepaid} and {cmd:Uninsure} are
equal{p_end}
{phang2}{cmd:. test [Prepaid=Uninsure]}{p_end}

{pstd}Predict probability that a person belongs to the {cmd:Prepaid} insurance
category{p_end}
{phang2}{cmd:. predict p1 if e(sample), outcome(2)}{p_end}
