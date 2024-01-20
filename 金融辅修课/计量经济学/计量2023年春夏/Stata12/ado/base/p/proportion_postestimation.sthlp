{smcl}
{* *! version 1.1.4  11feb2011}{...}
{vieweralsosee "[R] proportion postestimation" "mansection R proportionpostestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] proportion" "help proportion"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[SVY] svy postestimation" "help svy_postestimation"}{...}
{viewerjumpto "Description" "proportion postestimation##description"}{...}
{viewerjumpto "Example" "proportion postestimation##example"}{...}
{title:Title}

{p2colset 5 38 40 2}{...}
{p2col :{manlink R proportion postestimation} {hline 2}}Postestimation tools for proportion{p_end}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
The following postestimation commands are available after {cmd:proportion}:

{synoptset 11}{...}
{p2coldent :Command}Description{p_end}
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


{marker example}{...}
{title:Example}

{pstd}Setup{p_end}
{phang2}{cmd:. sysuse auto}{p_end}
{phang2}{cmd:. proportion rep78, over(foreign)}{p_end}

{pstd}Test whether coefficients on {cmd:Domestic} and {cmd:Foreign} are equal
in equation {cmd:_prop_4}{p_end}
{phang2}{cmd:. test [_prop_4]Domestic = [_prop_4]Foreign}{p_end}
