{smcl}
{* *! version 1.1.2  11feb2011}{...}
{vieweralsosee "[M-5] strofreal()" "mansection M-5 strofreal()"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-5] strtoreal()" "help mf_strtoreal"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-4] string" "help m4_string"}{...}
{viewerjumpto "Syntax" "mf_strofreal##syntax"}{...}
{viewerjumpto "Description" "mf_strofreal##description"}{...}
{viewerjumpto "Conformability" "mf_strofreal##conformability"}{...}
{viewerjumpto "Diagnostics" "mf_strofreal##diagnostics"}{...}
{viewerjumpto "Source code" "mf_strofreal##source"}{...}
{title:Title}

{p 4 8 2}
{manlink M-5 strofreal()} {hline 2} Convert real to string


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:string matrix}
{cmd:strofreal(}{it:real matrix R}{cmd:)}

{p 8 12 2}
{it:string matrix}
{cmd:strofreal(}{it:real matrix R}{cmd:,}
{it:string matrix format}{cmd:)}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:strofreal(}{it:R}{cmd:)} returns {it:R} as a string using
Stata's {cmd:%9.0g} format.
{cmd:strofreal(}{it:R}{cmd:)} 
is equivalent to {cmd:strofreal(}{it:R}{cmd:, "%9.0g")}.

{p 4 4 2}
{cmd:strofreal(}{it:R}{cmd:,} {it:format}{cmd:)} returns {it:R} as a
string formatted using {it:format}.

{p 4 4 2}
Leading blanks are trimmed from the result.

{p 4 4 2}
When arguments are not scalar, {cmd:strofreal()} returns 
element-by-element results.


{marker conformability}{...}
{title:Conformability}

    {cmd:strofreal(}{it:R}{cmd:,} {it:format}{cmd:)}:
               {it:R}:  {it:r1 x c1}
          {it:format}:  {it:r2 x c2}, {it:R} and {it:format} r-conformable    (optional)
          {it:result}:  max({it:r1},{it:r2}) {it:x} max({it:c1},{it:c2})


{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:strofreal(}{it:R}{cmd:,} {it:format}{cmd:)} returns "." if {it:format}
is invalid.


{marker source}{...}
{title:Source code}

{p 4 4 2}
Function is built in.
{p_end}
