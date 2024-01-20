{smcl}
{* *! version 1.1.2  11feb2011}{...}
{viewerdialog xtsum "dialog xtsum"}{...}
{vieweralsosee "[XT] xtsum" "mansection XT xtsum"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[XT] xtdescribe" "help xtdescribe"}{...}
{vieweralsosee "[XT] xttab" "help xttab"}{...}
{viewerjumpto "Syntax" "xtsum##syntax"}{...}
{viewerjumpto "Description" "xtsum##description"}{...}
{viewerjumpto "Examples" "xtsum##examples"}{...}
{title:Title}

{p2colset 5 19 21 2}{...}
{p2col :{manlink XT xtsum} {hline 2}}Summarize xt data{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 14 2}{cmd:xtsum} [{varlist}] [{it:{help if}}]

{phang}
A panel variable must be specified; use {helpb xtset}.{p_end}
{phang}
{it:varlist} may contain time-series operators; see {help tsvarlist}.{p_end}
{phang}
{cmd:by} is allowed; see {manhelp by D}.


{title:Menu}

{phang}
{bf:Statistics > Longitudinal/panel data > Setup and utilities >}
        {bf:Summarize xt data}


{marker description}{...}
{title:Description}

{pstd}
{cmd:xtsum}, a generalization of {helpb summarize}, reports means and
standard deviations for panel data; it differs from
{cmd:summarize} in that it decomposes the standard deviation into between and
within components.


{marker examples}{...}
{title:Examples}

{phang}{cmd:. webuse nlswork}{p_end}
{phang}{cmd:. xtsum hours}{p_end}
{phang}{cmd:. xtsum birth_yr}{p_end}
