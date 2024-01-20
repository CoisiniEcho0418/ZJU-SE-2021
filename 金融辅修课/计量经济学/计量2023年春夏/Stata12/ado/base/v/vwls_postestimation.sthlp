{smcl}
{* *! version 1.1.7  11feb2011}{...}
{viewerdialog predict "dialog vwls_p"}{...}
{vieweralsosee "[R] vwls postestimation" "mansection R vwlspostestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] vwls" "help vwls"}{...}
{viewerjumpto "Description" "vwls postestimation##description"}{...}
{viewerjumpto "Syntax for predict" "vwls postestimation##syntax_predict"}{...}
{viewerjumpto "Options for predict" "vwls postestimation##options_predict"}{...}
{viewerjumpto "Examples" "vwls postestimation##examples"}{...}
{title:Title}

{p2colset 5 32 34 2}{...}
{p2col :{manlink R vwls postestimation} {hline 2}}Postestimation tools for vwls
{p_end}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
The following postestimation commands are available after {cmd:vwls}:

{p2colset 5 20 22 2}{...}
{p2col:Command}Description{p_end}
{p2line}
INCLUDE help post_contrast
{p2col :{helpb estat}}VCE and estimation sample summary{p_end}
INCLUDE help post_estimates
INCLUDE help post_lincom
INCLUDE help post_linktest
INCLUDE help post_margins
INCLUDE help post_marginsplot
INCLUDE help post_nlcom
{p2col :{helpb vwls postestimation##predict:predict}}predictions, residuals,
influence statistics, and other diagnostic measures{p_end}
INCLUDE help post_predictnl
INCLUDE help post_pwcompare
INCLUDE help post_test
INCLUDE help post_testnl
{p2line}
{p2colreset}{...}


{marker syntax_predict}{...}
{marker predict}{...}
{title:Syntax for predict}

{p 8 17 2}
{cmd:predict} {dtype} {newvar} {ifin} [{cmd:,} {cmd:xb} {cmd:stdp}]

{phang}
These statistics are available both in and out of sample; type
{cmd:predict} {it:...} {cmd:if e(sample)} {it:...} if wanted only for the
estimation sample.


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
{phang2}{cmd:. webuse bp}{p_end}
{phang2}{cmd:. vwls bp gender race}{p_end}

{pstd}Linear prediction{p_end}
{phang2}{cmd:. predict p}

{pstd}Summary of linear prediction{p_end}
{phang2}{cmd:. margins}{p_end}
