{smcl}
{* *! version 1.1.8  14mar2011}{...}
{vieweralsosee "[R] jackknife postestimation" "mansection R jackknifepostestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] jackknife" "help jackknife"}{...}
{viewerjumpto "Description" "jackknife postestimation##description"}{...}
{viewerjumpto "Syntax for predict" "jackknife postestimation##syntax_predict"}{...}
{viewerjumpto "Examples" "jackknife postestimation##examples"}{...}
{title:Title}

{p2colset 5 37 39 2}{...}
{p2col :{manlink R jackknife postestimation} {hline 2}}Postestimation tools for
jackknife{p_end}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
The following postestimation commands are available after {opt jackknife}:

{synoptset 13 tabbed}{...}
{p2coldent :Command}Description{p_end}
{synoptline}
{p2coldent :* {bf:{help contrast}}}contrasts and ANOVA-style joint tests of
     estimates{p_end}
INCLUDE help post_estat
INCLUDE help post_estimates
INCLUDE help post_lincom
{p2coldent :* {bf:{help margins}}}marginal means, predictive margins, marginal
                effects, and average marginal effects{p_end}
{p2coldent :* {bf:{help marginsplot}}}graph the results from margins
               (profile plots, interaction plots, etc.){p_end}
INCLUDE help post_nlcom
{p2coldent :* {helpb predict}}predictions, residuals, influence statistics, and other diagnostic measures{p_end}
{p2coldent :* {helpb predictnl}}point estimates, standard errors, testing, and inference for nonlinear combinations of coefficients{p_end}
{p2coldent :* {bf:{help pwcompare}}}pairwise comparisons of estimates{p_end}
INCLUDE help post_test
INCLUDE help post_testnl
{synoptline}
{p2colreset}{...}
{p 4 6 2}* This postestimation command is allowed only if it may be used after {it:command}.{p_end}


{marker syntax_predict}{...}
{marker predict}{...}
{title:Syntax for predict}

{pstd}
The syntax of {opt predict} (and whether {opt predict} is even allowed)
following {opt jackknife} depends on the {it:command} used with
{opt jackknife}.{p_end}


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse regress}{p_end}
{phang2}{cmd:. jackknife: regress y x1 x2 x3}

{pstd}Estimate linear combination of coefficients{p_end}
{phang2}{cmd:. lincom x2-x1}

{pstd}Test that coefficients of {cmd:x1} and {cmd:x3} are both zero{p_end}
{phang2}{cmd:. test x1 x3}{p_end}
