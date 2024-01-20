{smcl}
{* *! version 1.1.1  11feb2011}{...}
{vieweralsosee "[D] obs" "mansection D obs"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[D] describe" "help describe"}{...}
{viewerjumpto "Syntax" "obs##syntax"}{...}
{viewerjumpto "Description" "obs##description"}{...}
{viewerjumpto "Examples" "obs##examples"}{...}
{title:Title}

{p2colset 5 16 18 2}{...}
{p2col :{manlink D obs} {hline 2}}Increase the number of observations in a
dataset{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 13 2}
{cmd:set}
{opt ob:s}
{it:#}


{marker description}{...}
{title:Description}

{pstd}
{opt set obs} changes the number of observations in the current dataset.
{it:#} must be at least as large as the current number of observations.
If there are variables in memory, the values of all new observations are set
to missing.


{marker examples}{...}
{title:Examples}

{phang}{cmd:. drop _all}{space 6}(drop data from memory)          {p_end}
{phang}{cmd:. set obs 100}{space 4}(make 100 observations) {p_end}
{phang}{cmd:. gen x = _n}{space 5}(x = 1, 2, 3, .., 100)  {p_end}
{phang}{cmd:. gen y = x^2}{space 4}(y = 1, 4, 9, .., 10000){p_end}
{phang}{cmd:. scatter y x}{space 4}(make a graph)          {p_end}
