{smcl}
{* *! version 1.1.5  11feb2011}{...}
{vieweralsosee "[M-5] abbrev()" "mansection M-5 abbrev()"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-4] string" "help m4_string"}{...}
{viewerjumpto "Syntax" "mf_abbrev##syntax"}{...}
{viewerjumpto "Description" "mf_abbrev##description"}{...}
{viewerjumpto "Conformability" "mf_abbrev##conformability"}{...}
{viewerjumpto "Diagnostics" "mf_abbrev##diagnostics"}{...}
{viewerjumpto "Source code" "mf_abbrev##source"}{...}
{title:Title}

{phang}
{manlink M-5 abbrev()} {hline 2} Abbreviate strings


{marker syntax}{...}
{title:Syntax}

{phang2}
{it:string matrix}
{cmd:abbrev(}{it:string matrix s}{cmd:,}
{it:real matrix n}{cmd:)}


{marker description}{...}
{title:Description}

{pstd}
{cmd:abbrev(}{it:s}{cmd:,} {it:n}{cmd:)}
returns the {it:n}-character abbreviation of {it:s} such that the abbreviation
uniquely identifies a variable in Stata, if there are variables in Stata.
Otherwise, {cmd:abbrev(}{it:s}{cmd:,} {it:n}{cmd:)} returns the
{it:n}-character abbreviation of {it:s}.

{phang2}
1.  {it:n} is the abbreviation length and is assumed to contain integer
values in the range 5, 6, ..., {ccl namelen}.

{phang2}
2.  If {it:s} contains a period, {cmd:.}, and {it:n} < 8, then the value
{it:n} defaults to 8.  Otherwise, if {it:n} < 5, then {it:n} defaults to 5.

{phang2}
3.  If {it:n} is missing, the entire string (up to the first binary 0) is
returned.

{pstd}
If there is a binary 0 in {it:s}, the abbreviation is derived from the
beginning of the string up to but not including the binary 0.

{pstd}
When arguments are not scalar, {cmd:abbrev()} returns element-by-element
results.


{marker conformability}{...}
{title:Conformability}

    {cmd:abbrev(}{it:s}{cmd:,} {it:n}{cmd:)}:
            {it:s}:  {it:r1 x c1}
            {it:n}:  {it:r2 x c2}; {it:s} and {it:n} r-conformable
       {it:result}:  max({it:r1},{it:r2}) {it:x} max({it:c1},{it:c2})


{marker diagnostics}{...}
{title:Diagnostics}

{pstd}
{cmd:abbrev()} returns {cmd:""} if {it:s} is {cmd:""}.
{cmd:abbrev()} aborts with error if {it:s} is not a string.


{marker source}{...}
{title:Source code}

{pstd}
Function is built in.
{p_end}
