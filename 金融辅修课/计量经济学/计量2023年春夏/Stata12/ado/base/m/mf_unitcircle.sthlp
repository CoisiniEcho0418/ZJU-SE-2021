{smcl}
{* *! version 1.1.1  11feb2011}{...}
{vieweralsosee "[M-5] unitcircle()" "mansection M-5 unitcircle()"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-4] standard" "help m4_standard"}{...}
{viewerjumpto "Syntax" "mf_unitcircle##syntax"}{...}
{viewerjumpto "Description" "mf_unitcircle##description"}{...}
{viewerjumpto "Conformability" "mf_unitcircle##conformability"}{...}
{viewerjumpto "Diagnostics" "mf_unitcircle##diagnostics"}{...}
{viewerjumpto "Source code" "mf_unitcircle##source"}{...}
{title:Title}

{p 4 8 2}
{manlink M-5 unitcircle()} {hline 2} Complex vector containing unit circle


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:complex colvector} 
{cmd:unitcircle(}{it:real scalar n}{cmd:)}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:unitcircle(}{it:n}{cmd:)}
returns a column vector containing 
{cmd:C(cos(}{it:theta}{cmd:), sin(}{it:theta}{cmd:))} for
0<={it:theta}<=2*{cmd:pi()} in {it:n} points.


{marker conformability}{...}
{title:Conformability}

    {cmd:unitcircle(}{it:n}{cmd:)}:
		{it:n}:  1 {it:x} 1
	   {it:result}:  {it:n} {it:x} 1


{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
None.


{marker source}{...}
{title:Source code}

{p 4 4 2}
{view unitcircle.mata, adopath asis:unitcircle.mata}
{p_end}
