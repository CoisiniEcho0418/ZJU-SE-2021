{smcl}
{* *! version 1.1.4  11feb2011}{...}
{vieweralsosee "[R] total postestimation" "mansection R totalpostestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] total" "help total"}{...}
{viewerjumpto "Description" "total postestimation##description"}{...}
{viewerjumpto "Examples" "total postestimation##examples"}{...}
{title:Title}

{p2colset 5 33 35 2}{...}
{p2col:{manlink R total postestimation} {hline 2}}Postestimation tools for total{p_end}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
The following postestimation commands are available after {opt total}:

{synoptset 13}{...}
{synopt:Command}Description{p_end}
{synoptline}
{synopt:{helpb estat}}VCE{p_end}
INCLUDE help post_svy_estat
INCLUDE help post_estimates
INCLUDE help post_lincom
INCLUDE help post_nlcom
INCLUDE help post_test
INCLUDE help post_testnl
{synoptline}
{p2colreset}{...}


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse total}{p_end}
{phang2}{cmd:. total heartatk [pw=swgt], over(sex)}{p_end}

{pstd}Show covariance matrix of coefficients{p_end}
{phang2}{cmd:. estat vce}

{pstd}Test that there are twice as many heart attacks among men as women in
the population{p_end}
{phang2}{cmd:. test _b[Male] = 2*_b[Female]}{p_end}
