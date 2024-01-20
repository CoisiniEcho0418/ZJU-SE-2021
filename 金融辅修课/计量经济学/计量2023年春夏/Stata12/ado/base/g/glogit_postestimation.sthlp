{smcl}
{* *! version 1.1.8  18mar2011}{...}
{viewerdialog predict "dialog glogit_p"}{...}
{vieweralsosee "[R] glogit postestimation" "mansection R glogitpostestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] glogit" "help glogit"}{...}
{viewerjumpto "Description" "glogit postestimation##description"}{...}
{viewerjumpto "Syntax for predict" "glogit postestimation##syntax_predict"}{...}
{viewerjumpto "Options for predict" "glogit postestimation##options_predict"}{...}
{viewerjumpto "Examples" "glogit postestimation##examples"}{...}
{title:Title}

{p2colset 5 34 36 2}{...}
{p2col :{manlink R glogit postestimation} {hline 2}}Postestimation tools for
glogit, gprobit, blogit, and bprobit{p_end}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
The following postestimation commands are available after {cmd:glogit},
{cmd:gprobit}, {cmd:blogit}, and {cmd:bprobit}:

{synoptset 13 tabbed}{...}
{p2coldent :Command}Description{p_end}
{synoptline}
INCLUDE help post_contrast
{p2coldent :* {helpb estat}}AIC, BIC, VCE, and estimation sample summary{p_end}
INCLUDE help post_estimates
INCLUDE help post_lincom
{p2coldent :* {helpb lrtest}}likelihood-ratio test{p_end}
INCLUDE help post_margins
INCLUDE help post_marginsplot
INCLUDE help post_nlcom
{synopt :{helpb glogit postestimation##predict:predict}}predictions, residuals, influence statistics, and other diagnostic measures{p_end}
INCLUDE help post_predictnl
INCLUDE help post_pwcompare
INCLUDE help post_test
INCLUDE help post_testnl
{synoptline}
{p2colreset}{...}
{p 4 6 2}
* {opt estat ic} and {opt lrtest} are not appropriate after {opt glogit} and
{opt gprobit}.


{marker syntax_predict}{...}
{marker predict}{...}
{title:Syntax for predict}

{p 8 16 2}
{cmd:predict}
{dtype}
{newvar}
{ifin}
[{cmd:,} {it:statistic}]

{synoptset 13 tabbed}{...}
{synopthdr :statistic}
{synoptline}
{syntab :Main}
{synopt :{opt n}}predicted count; the default{p_end}
{synopt :{opt p:r}}probability of a positive outcome{p_end}
{synopt :{opt xb}}linear prediction{p_end}
{synopt :{opt stdp}}standard error of the linear prediction{p_end}
{synoptline}
{p2colreset}{...}
INCLUDE help esample


INCLUDE help menu_predict


{marker options_predict}{...}
{title:Options for predict}

{dlgtab:Main}

{phang}
{opt n}, the default, calculates the expected count, that is, the
estimated probability times {it:pop_var}, which is the total population.

{phang}
{opt pr} calculates the predicted probability of a positive outcome.

{phang}
{opt xb} calculates the linear prediction.

{phang}
{opt stdp} calculates the standard error of the linear prediction.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse xmpl2}{p_end}
{phang2}{cmd:. bprobit deaths pop agecat exposed}{p_end}

{pstd}Expected number of deaths{p_end}
{phang2}{cmd:. predict number}{p_end}

{pstd}Probability of death{p_end}
{phang2}{cmd:. predict p if e(sample), pr}{p_end}
