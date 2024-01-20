{smcl}
{* *! version 1.0.0  28apr2011}{...}
{vieweralsosee "[R] set" "mansection R set"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] query" "help query"}{...}
{viewerjumpto "Syntax" "lstretch##syntax"}{...}
{viewerjumpto "Description" "lstretch##description"}{...}
{viewerjumpto "Option" "lstretch##option"}{...}
{title:Title}

{phang}
Specify whether to automatically widen the coefficient table


{marker syntax}{...}
{title:Syntax}

{p 8 22 2}
	{cmd:set lstretch} {c -(} {cmd:on} | {cmd:off} {c )-}
	[{cmd:,} {cmdab:perm:anently}]


{marker description}{...}
{title:Description}

{pstd}
{cmd:set lstretch} specifies whether to automatically widen the coefficient
table up to the width of the Results window to accommodate longer variable
names. The default value is {cmd:on}.


{marker option}{...}
{title:Option}

{phang}
{cmd:permanently} specifies that, in addition to making the change right now,
the setting be remembered and become the default setting when you invoke Stata.
{p_end}
