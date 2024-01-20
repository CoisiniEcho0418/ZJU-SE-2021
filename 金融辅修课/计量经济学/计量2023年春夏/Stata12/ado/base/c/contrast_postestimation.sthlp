{smcl}
{* *! version 1.0.4  30may2011}{...}
{vieweralsosee "[R] contrast postestimation" "mansection R contrastpostestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] contrast" "help contrast"}{...}
{viewerjumpto "Description" "contrast postestimation##description"}{...}
{viewerjumpto "Example" "contrast postestimation##example"}{...}
{title:Title}

{p2colset 5 36 38 2}{...}
{p2col :{manlink R contrast postestimation} {hline 2}}Postestimation tools for
contrast{p_end}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
The following postestimation commands are 
available after {cmd:contrast}{cmd:, post}:

{synoptset 13}{...}
{p2coldent :Command}Description{p_end}
{synoptline}
{synopt:{bf:{help estat}}}VCE; {cmd:estat vce} only{p_end}
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
{phang2}{cmd:. webuse cholesterol}{p_end}
{phang2}{cmd:. anova chol agegrp}{p_end}
{phang2}{cmd:. contrast p.agegrp, post}

{pstd}Test whether the quadratic, cubic, and quartic effects are 
jointly zero{p_end}
{phang2}{cmd:. test p2.agegrp p3.agegrp p4.agegrp}{p_end}
