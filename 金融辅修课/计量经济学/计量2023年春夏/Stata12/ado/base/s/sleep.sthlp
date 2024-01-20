{smcl}
{* *! version 1.1.2  27jun2011}{...}
{vieweralsosee "[P] sleep" "mansection P sleep"}{...}
{viewerjumpto "Syntax" "sleep##syntax"}{...}
{viewerjumpto "Description" "sleep##description"}{...}
{viewerjumpto "Example" "sleep##example"}{...}
{title:Title}

{p2colset 5 18 20 2}{...}
{p2col :{manlink P sleep} {hline 2}}Pause for a specified time{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

	{cmd:sleep} {it:#}

{pstd}where {it:#} is the number of milliseconds (1,000 ms = 1 second).


{marker description}{...}
{title:Description}

{pstd}
{cmd:sleep} tells Stata to pause for {it:#} ms before continuing
with the next command.


{marker example}{...}
{title:Example}

	{cmd:. sleep 10000}

{pstd}pauses for 10 seconds{p_end}
