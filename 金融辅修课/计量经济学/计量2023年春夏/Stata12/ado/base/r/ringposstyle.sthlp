{smcl}
{* *! version 1.1.4  11feb2011}{...}
{vieweralsosee "[G-4] ringposstyle" "mansection G-4 ringposstyle"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[G-3] title_options" "help title_options"}{...}
{vieweralsosee "[G-4] clockposstyle" "help clockposstyle"}{...}
{viewerjumpto "Syntax" "ringposstyle##syntax"}{...}
{viewerjumpto "Description" "ringposstyle##description"}{...}
{viewerjumpto "Remarks" "ringposstyle##remarks"}{...}
{title:Title}

{p2colset 5 27 29 2}{...}
{p2col :{manlinki G-4 ringposstyle} {hline 2}}Choices for location:  Distance from plot region{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{pstd}
{it:ringposstyle} is

	{it:#}         0 <= {it:#} <= 100, {it:#} real


{marker description}{...}
{title:Description}

{pstd}
{it:ringposstyle} is specified inside options such as {cmd:ring()} and is
typically used in conjunction with {it:cloctposstyle} (see
{manhelpi clockposstyle G-4}) to specify a position for titles, subtitles, etc.


{marker remarks}{...}
{title:Remarks}

{pstd}
See {it:{help title_options##remarks3:Positioning of titles}} under
{it:Remarks} of {manhelpi title_options G-3}.
{p_end}
