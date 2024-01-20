{smcl}
{* *! version 1.2.1  11feb2011}{...}
{vieweralsosee "[G-4] scheme sj" "mansection G-4 schemesj"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[G-4] schemes intro" "help schemes"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[G-2] set scheme" "help set_scheme"}{...}
{vieweralsosee "[G-3] scheme_option" "help scheme_option"}{...}
{vieweralsosee "[R] sj" "help sj"}{...}
{viewerjumpto "Syntax" "scheme_sj##syntax"}{...}
{viewerjumpto "Description" "scheme_sj##description"}{...}
{viewerjumpto "Remarks" "scheme_sj##remarks"}{...}
{title:Title}

{p2colset 5 24 26 2}{...}
{p2col :{manlink G-4 scheme sj} {hline 2}}Scheme description:  sj{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

	{it:schemename}{col 22}Foreground{col 36}Background{col 48}Description
	{hline 70}
	{cmd:sj}{...}
{col 22}monochrome{...}
{col 36}white{...}
{col 48}{it:Stata Journal}
	{hline 70}

{pstd}
For instance, you might type

{p 8 16 2}
{cmd:. graph}
...{cmd:,}
...
{cmd:scheme(sj)}

{p 8 16 2}
{cmd:. set}
{cmd:scheme}
{cmd:sj}
[{cmd:,}
{cmdab:perm:anently}]

{pstd}
See {manhelpi scheme_option G-3} and {manhelp set_scheme G-2:set scheme}.


{marker description}{...}
{title:Description}

{pstd}
Schemes determine the overall look of a graph;
see {manhelp schemes G-4:schemes intro}.

{pstd}
Scheme {cmd:sj} is the official scheme of the {it:Stata} {it:Journal}; see
{manhelp sj R}.


{marker remarks}{...}
{title:Remarks}

{pstd}
When submitting articles to the {it:Stata Journal}, graphs should be
drawn using the scheme {cmd:sj}.

{pstd}
Before drawing graphs for inclusion with submissions, make sure that scheme
{cmd:sj} is up to date.  Schemes are updated along with all the rest of
Stata, so you just need to type

	{cmd:.} {bf:{stata update query}}

{pstd}
and follow any instructions given; see {manhelp update R}.

{pstd}
Also visit the {it:Stata Journal} website for any special instructions.
Point your browser to

	{bf:{browse "http://www.stata-journal.com"}}
