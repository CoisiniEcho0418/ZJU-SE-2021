{smcl}
{* *! version 1.1.4  11feb2011}{...}
{viewerdialog estat "dialog expoisson_estat"}{...}
{vieweralsosee "[R] expoisson postestimation" "mansection R expoissonpostestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] expoisson" "help expoisson"}{...}
{viewerjumpto "Description" "expoisson postestimation##description"}{...}
{viewerjumpto "Special-interest postestimation commands" "expoisson postestimation##special"}{...}
{viewerjumpto "Syntax for estat se" "expoisson postestimation##syntax_estat_se"}{...}
{viewerjumpto "Option for estat se" "expoisson postestimation##option_estat_se"}{...}
{viewerjumpto "Examples" "expoisson postestimation##examples"}{...}
{title:Title}

{p2colset 5 37 39 2}{...}
{p2col :{manlink R expoisson postestimation} {hline 2}}Postestimation tools for
expoisson{p_end}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
The following postestimation command is of special interest after
{cmd:expoisson}:

{synoptset 17}{...}
{p2coldent :Command}Description{p_end}
{synoptline}
{synopt :{helpb expoisson postestimation##estatse:estat se}}report
coefficients or IRRs and their asymptotic standard errors {p_end}
{synoptline}
{p2colreset}{...}

{pstd}
The following standard postestimation command is also available:

{synoptset 17}{...}
{p2coldent :Command}Description{p_end}
{synoptline}
{synopt:{bf:{help estat summarize}}}estimation sample summary{p_end}
{synoptline}
{p2colreset}{...}
{p 4 6 2}


{marker special}{...}
{title:Special-interest postestimation command}

{pstd}
{cmd:estat se} reports coefficient or incidence-rate asymptotic standard
errors.  The estimates are stored in the matrix {cmd:r(estimates)}.


{marker syntax_estat_se}{...}
{marker estatse}{...}
{title:Syntax for estat se}

{p 8 14 2}
{cmd:estat} {opt se}  
[{cmd:,} {cmd:irr}]


INCLUDE help menu_estat


{marker option_estat_se}{...}
{title:Option for estat se}

{phang}
{cmd:irr} requests that the incidence-rate ratios and their asymptotic standard
errors be reported.  The default is to report the coefficients and their
asymptotic standard errors.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse smokes}

{pstd}Perform exact Poisson regression of {cmd:cases} on {cmd:smokes} using
exposure {cmd:peryrs}{p_end}
{phang2}{cmd:. expoisson cases smokes, exposure(peryrs) irr}{p_end}

{pstd}Report the estimated incidence rates and their asymptotic standard 
errors{p_end}
{phang2}{cmd:. estat se, irr}{p_end}
