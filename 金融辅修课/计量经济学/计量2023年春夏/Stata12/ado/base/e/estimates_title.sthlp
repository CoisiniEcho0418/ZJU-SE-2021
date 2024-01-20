{smcl}
{* *! version 2.1.2  11feb2011}{...}
{viewerdialog "estimates title" "dialog estimates_title"}{...}
{vieweralsosee "[R] estimates title" "mansection R estimatestitle"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] estimates" "help estimates"}{...}
{viewerjumpto "Syntax" "estimates_title##syntax"}{...}
{viewerjumpto "Description" "estimates_title##description"}{...}
{viewerjumpto "Remarks" "estimates_title##remarks"}{...}
{viewerjumpto "Example" "estimates_title##example"}{...}
{title:Title}

{p2colset 5 28 30 2}{...}
{p2col :{manlink R estimates title} {hline 2}}Set title for estimation results{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{opt est:imates} {cmd:title:}
[{it:text}]

{p 8 12 2}
{opt est:imates} {cmd:title}


{title:Menu}

{phang}
{bf:Statistics > Postestimation > Manage estimation results >}
     {bf:Title/retitle results}


{marker description}{...}
{title:Description}

{pstd}
{cmd:estimates} {cmd:title:} (note the colon) sets or clears the 
title for the current estimation results.  The title is used
by 
{helpb estimates table}
and
{helpb estimates stats}.

{pstd}
{cmd:estimates} {cmd:title} without the colon displays the current 
title.


{marker remarks}{...}
{title:Remarks}

{pstd}
After setting the title, if estimates have been stored, do not 
forget to store them again.


{marker example}{...}
{title:Example}

{pstd}Setup{p_end}
{phang2}{cmd:. sysuse auto}{p_end}
{phang2}{cmd:. regress mpg gear turn}

{pstd}Add a title to estimates and store the results{p_end}
{phang2}{cmd:. estimates title: The final model}{p_end}
{phang2}{cmd:. estimates store reg}

{pstd}Replay results{p_end}
{phang2}{cmd:. estimates replay reg}{p_end}
