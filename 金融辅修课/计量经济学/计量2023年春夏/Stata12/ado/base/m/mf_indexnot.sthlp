{smcl}
{* *! version 1.1.1  11feb2011}{...}
{vieweralsosee "[M-5] indexnot()" "mansection M-5 indexnot()"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-4] string" "help m4_string"}{...}
{viewerjumpto "Syntax" "mf_indexnot##syntax"}{...}
{viewerjumpto "Description" "mf_indexnot##description"}{...}
{viewerjumpto "Conformability" "mf_indexnot##conformability"}{...}
{viewerjumpto "Diagnostics" "mf_indexnot##diagnostics"}{...}
{viewerjumpto "Source code" "mf_indexnot##source"}{...}
{title:Title}

{p 4 8 2}
{manlink M-5 indexnot()} {hline 2} Find character not in list


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:real matrix}
{cmd:indexnot(}{it:string matrix s1}{cmd:,}
{it:string matrix s2}{cmd:)}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:indexnot(}{it:s1}{cmd:,} {it:s2}{cmd:)} returns the position of the first
character of {it:s1} not found in {it:s2}, or it returns 0 if all characters of
{it:s1} are found in {it:s2}.


{marker conformability}{...}
{title:Conformability}

    {cmd:indexnot(}{it:s1}{cmd:,} {it:s2}{cmd:)}:
	       {it:s1}:  {it:r1 x c1}
	       {it:s2}:  {it:r2 x c2}, {it:s1} and {it:s2} r-conformable
	   {it:result}:  max({it:r1},{it:r2}) {it:x} max({it:c1},{it:c2})


{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:indexnot(}{it:s1}{cmd:,} {it:s2}{cmd:)}
returns 0 if all characters of {it:s1} are found in {it:s2}.


{marker source}{...}
{title:Source code}

{p 4 4 2}
Function is built in.
{p_end}
