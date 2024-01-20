{smcl}
{* *! version 1.1.2  11feb2011}{...}
{vieweralsosee "[M-5] strmatch()" "mansection M-5 strmatch()"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-4] string" "help m4_string"}{...}
{viewerjumpto "Syntax" "mf_strmatch##syntax"}{...}
{viewerjumpto "Description" "mf_strmatch##description"}{...}
{viewerjumpto "Remarks" "mf_strmatch##remarks"}{...}
{viewerjumpto "Conformability" "mf_strmatch##conformability"}{...}
{viewerjumpto "Diagnostics" "mf_strmatch##diagnostics"}{...}
{viewerjumpto "Source code" "mf_strmatch##source"}{...}
{title:Title}

{p 4 8 2}
{manlink M-5 strmatch()} {hline 2} Determine whether string matches pattern


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:real matrix}
{cmd:strmatch(}{it:string matrix s}{cmd:,} 
{it:string matrix pattern}{cmd:)}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:strmatch(}{it:s}{cmd:,} {it:pattern}{cmd:)} returns 1 if {it:s} matches
{it:pattern} and 0 otherwise.  

{p 4 4 2}
When arguments are not scalar, {cmd:strmatch()} returns element-by-element
results.


{marker remarks}{...}
{title:Remarks}

{p 4 4 2}
In {it:pattern}, {cmd:*} means that 0 or more characters go here and 
{cmd:?} means that exactly one character goes here.
Thus {it:pattern}{cmd:="*"} matches anything and 
{it:pattern}{cmd:="?p*x"} matches all strings whose second character is
{it:p} and whose last character is {it:x}.

{p 4 4 2}
Stata understands {cmd:strmatch()} as a synonym for its own {helpb strmatch()}
function, so you can use the {cmd:strmatch()} function in both your Stata 
and Mata code.


{marker conformability}{...}
{title:Conformability}

    {cmd:strmatch(}{it:s}{cmd:,} {it:pattern}{cmd:)}:
	    {it:s}:  {it:r1 x c1} 
      {it:pattern}:  {it:r2 x c2}, {it:s} and {it:pattern} r-conformable
       {it:result}:  max({it:r1},{it:r2}) {it:x} max({it:c1},{it:c2})


{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
In {cmd:strmatch(}{it:s}{cmd:,} {it:pattern}{cmd:)}, if {it:s} or {it:pattern}
contain a binary 0 (they usually would not), the strings are considered to end
at that point.


{marker source}{...}
{title:Source code}

{p 4 4 2}
Function is built in.
{p_end}
