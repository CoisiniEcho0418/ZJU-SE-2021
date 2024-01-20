{smcl}
{* *! version 1.0.3  16jun2011}{...}
{vieweralsosee "[R] pwmean postestimation" "mansection R pwmeanpostestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] pwmean" "help pwmean"}{...}
{viewerjumpto "Description" "pwmean postestimation##description"}{...}
{viewerjumpto "Example" "pwmean postestimation##example"}{...}
{title:Title}

{p2colset 5 34 36 2}{...}
{p2col :{manlink R pwmean postestimation} {hline 2}}Postestimation tools for
pwmean{p_end}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
The following postestimation commands are available after {cmd:pwmean}:

{synoptset 13}{...}
{p2coldent :Command}Description{p_end}
{synoptline}
{synopt:{bf:{help estat}}}VCE; {cmd:estat vce} only{p_end}
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
{phang2}{cmd:. webuse yield}{p_end}

{pstd}Pairwise comparisons of the mean yields for each pair of
fertilizers{p_end}
{phang2}{cmd:. pwmean yield, over(fertilizer)}{p_end}

{pstd}Test whether the mean yield for fertilizer 4 is 10% larger than the 
mean yield for fertilizer 5{p_end}
{phang2}
{cmd:. testnl (_b[4.fertilizer] - _b[5.fertilizer])/_b[5.fertilizer] = 0.1}
{p_end}
