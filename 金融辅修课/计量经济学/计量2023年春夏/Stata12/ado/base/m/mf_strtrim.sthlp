{smcl}
{* *! version 1.1.2  11feb2011}{...}
{vieweralsosee "[M-5] strtrim()" "mansection M-5 strtrim()"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-4] string" "help m4_string"}{...}
{viewerjumpto "Syntax" "mf_strtrim##syntax"}{...}
{viewerjumpto "Description" "mf_strtrim##description"}{...}
{viewerjumpto "Remarks" "mf_strtrim##remarks"}{...}
{viewerjumpto "Conformability" "mf_strtrim##conformability"}{...}
{viewerjumpto "Diagnostics" "mf_strtrim##diagnostics"}{...}
{viewerjumpto "Source code" "mf_strtrim##source"}{...}
{title:Title}

{p 4 8 2}
{manlink M-5 strtrim()} {hline 2} Remove blanks


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:string matrix} {cmd:stritrim(}{it:string matrix s}{cmd:)}

{p 8 12 2}
{it:string matrix} {cmd:strltrim(}{it:string matrix s}{cmd:)}

{p 8 12 2}
{it:string matrix} {cmd:strrtrim(}{it:string matrix s}{cmd:)}

{p 8 12 2}
{it:string matrix} {cmd:strtrim(}{it:string matrix s}{cmd:)}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:stritrim(}{it:s}{cmd:)}
returns {it:s} with all consecutive, internal blanks collapsed to one 
blank.

{p 4 4 2}
{cmd:strltrim(}{it:s}{cmd:)}
returns {it:s} with leading blanks removed.

{p 4 4 2}
{cmd:strrtrim(}{it:s}{cmd:)}
returns {it:s} with trailing blanks removed.

{p 4 4 2}
{cmd:strtrim(}{it:s}{cmd:)}
returns {it:s} with leading and trailing blanks removed.

{p 4 4 2}
When {it:s} is not a scalar, these functions return element-by-element
results.


{marker remarks}{...}
{title:Remarks}

{p 4 4 2}
Stata understands {cmd:stritrim()}, {cmd:strltrim()}, {cmd:strrtrim()}, and
{cmd:strtrim()}, as synonyms for its own {helpb itrim()}, {helpb ltrim()},
{helpb rtrim()}, and {helpb trim()} functions, so you can use the {cmd:str*()}
names in both your Stata and Mata code.


{marker conformability}{...}
{title:Conformability}

{p 4 4 2}
{cmd:stritrim(}{it:s}{cmd:)},
{cmd:strltrim(}{it:s}{cmd:)},
{cmd:strrtrim(}{it:s}{cmd:)},
{cmd:strtrim(}{it:s}{cmd:)}:
{p_end}
		{it:s}:  {it:r x c}
	   {it:result}:  {it:r x c}


{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
None.


{marker source}{...}
{title:Source code}

{p 4 4 2}
Functions are built in.
{p_end}
