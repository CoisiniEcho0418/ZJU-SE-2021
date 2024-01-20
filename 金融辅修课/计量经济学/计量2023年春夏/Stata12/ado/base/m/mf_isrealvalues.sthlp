{smcl}
{* *! version 1.1.1  11feb2011}{...}
{vieweralsosee "[M-5] isrealvalues()" "mansection M-5 isrealvalues()"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-5] isreal()" "help mf_isreal"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-4] utility" "help m4_utility"}{...}
{viewerjumpto "Syntax" "mf_isrealvalues##syntax"}{...}
{viewerjumpto "Description" "mf_isrealvalues##description"}{...}
{viewerjumpto "Remarks" "mf_isrealvalues##remarks"}{...}
{viewerjumpto "Conformability" "mf_isrealvalues##conformability"}{...}
{viewerjumpto "Diagnostics" "mf_isrealvalues##diagnostics"}{...}
{viewerjumpto "Source code" "mf_isrealvalues##source"}{...}
{title:Title}

{p 4 8 2}
{manlink M-5 isrealvalues()} {hline 2} Whether matrix contains only real values


{marker syntax}{...}
{title:Syntax}

{p 8 8 2}
{it:real scalar}
{cmd:isrealvalues(}{it:numeric matrix X}{cmd:)}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:isrealvalues(}{it:X}{cmd:)}
returns 1 if {it:X} is of storage type real
or if {it:X} is of storage type complex and all elements are real or missing;
0 is returned otherwise.


{marker remarks}{...}
{title:Remarks}

{p 4 4 2}
{cmd:isrealvalues(}{it:X}{cmd:)} is logically equivalent to 
{it:X}{cmd:==Re(}{it:X}{cmd:)} but is significantly faster and requires 
less memory.


{marker conformability}{...}
{title:Conformability}

    {cmd:isrealvalues(}{it:X}{cmd:)}:
		{it:X}:  {it:r x c}
	   {it:result}:  1 {it:x} 1


{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:isrealvalues(}{it:X}{cmd:)} returns 1 if {it:X} is void and complex.


{marker source}{...}
{title:Source code}

{p 4 4 2}
Function is built in.
{p_end}
