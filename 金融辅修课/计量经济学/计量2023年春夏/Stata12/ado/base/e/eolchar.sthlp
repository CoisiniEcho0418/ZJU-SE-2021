{smcl}
{* *! version 1.0.5  11feb2011}{...}
{vieweralsosee "[R] set" "mansection R set"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] query" "help query"}{...}
{viewerjumpto "Syntax" "eolchar##syntax"}{...}
{viewerjumpto "Description" "eolchar##description"}{...}
{viewerjumpto "Option" "eolchar##option"}{...}
{title:Title}

{phang}
Set the default end-of-line delimiter for text files (Mac only)


{marker syntax}{...}
{title:Syntax}

{p 8 22 2}
	{cmd:set} {cmdab:eolch:ar} {c -(} {cmd:mac} | {cmd:unix} {c )-}
	[{cmd:,} {cmdab:perm:anently}]


{marker description}{...}
{title:Description}

{pstd}
{cmd:set eolchar} sets the default end-of-line delimiter for text files
created in Stata.  The standard end-of-line delimiter for text files on Mac OS
X and Unix systems is a line-feed character ('\n').  The end-of-line delimiter
for text files on Mac systems prior to Mac OS X is a carriage return ('\r').

{pstd}
The default value of {cmd:eolchar} is {cmd:unix}, and most users will never
want to change this.


{marker option}{...}
{title:Option}

{phang}
{cmd:permanently} specifies that, in addition to making the change right now,
the setting be remembered and become the default setting when you invoke Stata.
{p_end}
