{smcl}
{* *! version 1.0.3  11feb2011}{...}
{vieweralsosee undocumented "help undocumented"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[D] data types" "help data_types"}{...}
{vieweralsosee "[D] format" "help format"}{...}
{viewerjumpto "Syntax" "inten##syntax"}{...}
{viewerjumpto "Description" "inten##description"}{...}
{viewerjumpto "Examples" "inten##examples"}{...}
{viewerjumpto "Saved results" "inten##saved_results"}{...}
{viewerjumpto "Bugs" "inten##bugs"}{...}
{title:Title}

{p 4 20 2}
{hi:[P] inbase} {hline 2} Base conversion


{marker syntax}{...}
{title:Syntax}

	{cmd:inbase} {it:#1} {it:#2}

	{cmd:inten}  {it:#1} {it:#2}

{phang}
where{break}
{it:#1} is the base and {it:#2} the number to be converted.{break}
{it:#1} must be between 2 and 62, inclusive.


{marker description}{...}
{title:Description}

{pstd}
{cmd:inbase} converts decimal numbers to the specified base.

{pstd}
{cmd:inten} converts numbers of the specified base into decimal numbers.


{marker examples}{...}
{title:Examples}

	{cmd:. inbase 16 29}
	1d

	{cmd:. inbase 2 29}
	11101

	{cmd:. inten 16 1d}
	29

	{cmd:. inten 2 11101}
	29


{marker saved_results}{...}
{title:Saved results}

    {cmd:inten} returns

	scalar {cmd:r(ten)}    containing number in base 10

    {cmd:inbase} returns

	local  {cmd:r(base)}   containing number in specified base


{marker bugs}{...}
{title:Bugs}

{pstd}
{cmd:inten} does not verify that you do not use digits beyond the base.
For instance, you can type {cmd:inten 16 1g}.
{p_end}
