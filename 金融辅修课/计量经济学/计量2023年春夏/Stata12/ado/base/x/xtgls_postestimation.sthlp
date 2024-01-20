{smcl}
{* *! version 1.1.7  08mar2011}{...}
{viewerdialog predict "dialog xtgls_p"}{...}
{vieweralsosee "[XT] xtgls postestimation" "mansection XT xtglspostestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[XT] xtgls" "help xtgls"}{...}
{viewerjumpto "Description" "xtgls postestimation##description"}{...}
{viewerjumpto "Syntax for predict" "xtgls postestimation##syntax_predict"}{...}
{viewerjumpto "Options for predict" "xtgls postestimation##options_predict"}{...}
{viewerjumpto "Examples" "xtgls postestimation##examples"}{...}
{title:Title}

{p2colset 5 34 36 2}{...}
{p2col :{manlink XT xtgls postestimation} {hline 2}}Postestimation tools for xtgls{p_end}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
The following postestimation commands are available after {cmd:xtgls}:

{synoptset 13 notes}{...}
{p2coldent :Command}Description{p_end}
{synoptline}
INCLUDE help post_contrast
{p2coldent:(1) {bf:{help estat}}}AIC, BIC, VCE, and estimation sample summary{p_end}
INCLUDE help post_estimates
INCLUDE help post_lincom
{p2coldent:(2) {bf:{help lrtest}}}likelihood-ratio test{p_end}
INCLUDE help post_margins
INCLUDE help post_marginsplot
INCLUDE help post_nlcom
{p2col :{helpb xtgls postestimation##predict:predict}}predictions, residuals,
 influence statistics, and other diagnostic measures{p_end}
INCLUDE help post_predictnl
INCLUDE help post_pwcompare
INCLUDE help post_test
INCLUDE help post_testnl
{synoptline}
{p2colreset}{...}
{p 4 8 2}(1) AIC and BIC are available only if {cmd:igls} and {cmd:corr(independent)} were specified at estimation.{p_end}
{p 4 8 2}(2) Likelihood-ratio tests are available only if {cmd:igls} and {cmd:corr(independent)} were specified at estimation.


{marker syntax_predict}{...}
{marker predict}{...}
{title:Syntax for predict}

{p 8 16 2}
{cmd:predict} {dtype} {newvar} {ifin} [{cmd:,} {opt xb} {opt stdp}]

INCLUDE help esample


INCLUDE help menu_predict


{marker options_predict}{...}
{title:Options for predict}

{dlgtab:Main}

{phang}
{opt xb}, the default, calculates the linear prediction.

{phang}
{opt stdp} calculates the standard error of the linear prediction.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse invest2}{p_end}
{phang2}{cmd:. xtset company time}{p_end}
{phang2}{cmd:. xtgls invest market stock, panels(correlated) corr(ar1)}{p_end}

{pstd}Test that coefficients on {cmd:market} and {cmd:stock} are jointly zero
{p_end}
{phang2}{cmd:. test market stock}

{pstd}Linear prediction{p_end}
{phang2}{cmd:. predict ihat}{p_end}

{pstd}Standard error of linear prediction{p_end}
{phang2}{cmd:. predict serr, stdp}{p_end}
