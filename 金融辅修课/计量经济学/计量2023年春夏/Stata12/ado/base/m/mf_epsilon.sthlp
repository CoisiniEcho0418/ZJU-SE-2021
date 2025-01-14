{smcl}
{* *! version 1.1.1  11feb2011}{...}
{vieweralsosee "[M-5] epsilon()" "mansection M-5 epsilon()"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-5] edittozero()" "help mf_edittozero"}{...}
{vieweralsosee "[M-5] mindouble()" "help mf_mindouble"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-4] utility" "help m4_utility"}{...}
{viewerjumpto "Syntax" "mf_epsilon##syntax"}{...}
{viewerjumpto "Description" "mf_epsilon##description"}{...}
{viewerjumpto "Remarks" "mf_epsilon##remarks"}{...}
{viewerjumpto "Conformability" "mf_epsilon##conformability"}{...}
{viewerjumpto "Diagnostics" "mf_epsilon##diagnostics"}{...}
{viewerjumpto "Source code" "mf_epsilon##source"}{...}
{title:Title}

{p 4 8 2}
{manlink M-5 epsilon()} {hline 2} Unit roundoff error (machine precision)


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:real scalar}
{cmd:epsilon(}{it:real scalar x}{cmd:)}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:epsilon(}{it:x}{cmd:)} returns the unit roundoff error in quantities 
of size {cmd:abs(}{it:x}{cmd:)}.


{marker remarks}{...}
{title:Remarks}

{p 4 4 2}
On all computers on which Stata and Mata are currently implemented -- 
which are computers following IEEE standards -- 
{cmd:epsilon(1)} is 1.0X-34, or about 2.22045e-16.
This is the smallest amount by which a real number can differ from 1.

{p 4 4 2}
{cmd:epsilon(}{it:x}{cmd:)} is {cmd:abs(}{it:x}{cmd:)}{cmd:*epsilon(1)}.
This is an approximation of 
the smallest amount by which a real number can differ from 
{it:x}.  The approximation is exact at integer powers of 2.


{marker conformability}{...}
{title:Conformability}

    {cmd:epsilon(}{it:x}{cmd:)}:
		{it:x}:  1 {it:x} 1
	   {it:result}:  1 {it:x} 1


{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:epsilon(}{it:x}{cmd:)}
returns {cmd:.} if {it:x} is missing.


{marker source}{...}
{title:Source code}

{p 4 4 2}
Function is built in.
{p_end}
