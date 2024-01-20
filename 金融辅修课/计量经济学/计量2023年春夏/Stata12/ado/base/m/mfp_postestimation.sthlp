{smcl}
{* *! version 1.1.9  15mar2011}{...}
{viewerdialog fracplot "dialog fracplot"}{...}
{viewerdialog fracpred "dialog fracpred"}{...}
{vieweralsosee "[R] mfp postestimation" "mansection R mfppostestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] mfp" "help mfp"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] fracpoly postestimation" "help fracpoly_postestimation"}{...}
{viewerjumpto "Description" "mfp postestimation##description"}{...}
{viewerjumpto "Examples" "mfp postestimation##examples"}{...}
{title:Title}

{p2colset 5 31 33 2}{...}
{p2col :{manlink R mfp postestimation} {hline 2}}Postestimation tools for mfp{p_end}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
The following postestimation commands are of special interest after {cmd:mfp}:

{synoptset 11}{...}
{p2coldent :Command}Description{p_end}
{synoptline}
{synopt :{helpb fracpoly postestimation##fracplot/fracpred:fracplot}}plot data and fit from most recently fit fractional polynomial model{p_end}
{synopt :{helpb fracpoly postestimation##fracplot/fracpred:fracpred}}create variable containing prediction, deviance residuals, or SEs of fitted values{p_end}
{synoptline}

{pstd}
The following standard postestimation commands are also available if
available after {it:regression_cmd}:

{p2coldent :Command}Description{p_end}
{synoptline}
INCLUDE help post_estat
INCLUDE help post_estimates
INCLUDE help post_lincom
INCLUDE help post_linktest
INCLUDE help post_lrtest
INCLUDE help post_nlcom
INCLUDE help post_test
INCLUDE help post_testnl
{synoptline}
{p2colreset}{...}


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. sysuse auto}{p_end}
{phang2}{cmd:. mfp: regress mpg weight displacement foreign}{p_end}

{pstd}Plot data and fit against {cmd:displacement}{p_end}
{phang2}{cmd:. fracplot displacement}{p_end}

{pstd}Create new variable {cmd:dfit} containing partial prediction for
{cmd:displacement}{p_end}
{phang2}{cmd:. fracpred dfit, for(displacement)}{p_end}
