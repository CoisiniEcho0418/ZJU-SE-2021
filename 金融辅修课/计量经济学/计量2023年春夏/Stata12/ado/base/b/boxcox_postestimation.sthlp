{smcl}
{* *! version 1.1.8  11feb2011}{...}
{viewerdialog predict "dialog boxcox_p"}{...}
{vieweralsosee "[R] boxcox postestimation" "mansection R boxcoxpostestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] boxcox" "help boxcox"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] lnskew0" "help lnskew0"}{...}
{viewerjumpto "Description" "boxcox postestimation##description"}{...}
{viewerjumpto "Syntax for predict" "boxcox postestimation##syntax_predict"}{...}
{viewerjumpto "Options for predict" "boxcox postestimation##options_predict"}{...}
{viewerjumpto "Remarks" "boxcox postestimation##remarks"}{...}
{viewerjumpto "Examples" "boxcox postestimation##examples"}{...}
{title:Title}

{p2colset 5 34 36 2}{...}
{p2col : {manlink R boxcox postestimation} {hline 2}}Postestimation tools for boxcox{p_end}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
The following postestimation commands are available after {cmd:boxcox}:

{synoptset 13 tabbed}{...}
{p2coldent :Command}Description{p_end}
{synoptline}
INCLUDE help post_estat
INCLUDE help post_estimates
{p2coldent:* {bf:{help lincom}}}point estimates, standard errors, testing, and
inference for linear combinations of coefficients{p_end}
{p2coldent:* {bf:{help nlcom}}}point estimates, standard errors, testing, and
inference for nonlinear combinations of coefficients{p_end}
{synopt :{helpb boxcox postestimation##predict:predict}}predictions, residuals, influence statistics, and other diagnostic measures{p_end}
{p2coldent:* {helpb test}}Wald tests of simple and composite linear
hypotheses{p_end}
{p2coldent:* {helpb testnl}}Wald tests of nonlinear hypotheses{p_end}
{synoptline}
{p2colreset}{...}
{p 4 6 2}* Inference is valid only for hypotheses concerning lambda and theta.


{marker syntax_predict}{...}
{marker predict}{...}
{title:Syntax for predict}

{p 8 16 2}
{cmd:predict} {dtype} {newvar} {ifin} [{cmd:,} {it:statistic}]

{synoptset 13 tabbed}
{synopthdr:statistic}
{synoptline}
{syntab :Main}
{synopt :{opt xbt}}transformed linear prediction; the default{p_end}
{synopt :{opt yhat}}predicted value of y{p_end}
{synopt :{opt res:iduals}}residuals{p_end}
{synoptline}
{p2colreset}{...}
INCLUDE help esample


INCLUDE help menu_predict


{marker options_predict}{...}
{title:Options for predict}

{dlgtab:Main}

{phang}
{opt xbt}, the default, calculates the "linear" prediction.  For all models
except {cmd:model(lhsonly)}, all the {indepvars} except those specified in
the {helpb boxcox##notrans():notrans()} option of {cmd:boxcox} are
transformed.

{phang}
{opt yhat} calculates the predicted value of y. 

{phang}
{opt residuals} calculates the residuals after the predicted value of y
has been subtracted from the actual value. 


{marker remarks}{...}
{title:Remarks}

{pstd}
{cmd:boxcox} estimates variances only for the lambda and theta parameters
(see the {mansection R boxcoxRemarkstechnote:technical note} in
{hi:[R] boxcox}), so the extent to which
postestimation commands can be used following {cmd:boxcox} is limited.
Formulas used in {cmd:lincom}, {cmd:nlcom}, {cmd:test}, and {cmd:testnl}
are dependent on the estimated variances.  Therefore, the use of these
commands is limited and generally applicable only to inferences on the lambda
and theta coefficients.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. sysuse auto}{p_end}
{phang2}{cmd:. boxcox mpg weight price}{p_end}

{pstd}Calculate transformed linear prediction{p_end}
{phang2}{cmd:. predict linpred}

{pstd}Calculate predicted value of {cmd:mpg}{p_end}
{phang2}{cmd:. predict mpghat, yhat}{p_end}
