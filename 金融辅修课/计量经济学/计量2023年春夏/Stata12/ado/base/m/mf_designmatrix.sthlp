{smcl}
{* *! version 1.1.1  11feb2011}{...}
{vieweralsosee "[M-5] designmatrix()" "mansection M-5 designmatrix()"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-4] standard" "help m4_standard"}{...}
{viewerjumpto "Syntax" "mf_designmatrix##syntax"}{...}
{viewerjumpto "Description" "mf_designmatrix##description"}{...}
{viewerjumpto "Remarks" "mf_designmatrix##remarks"}{...}
{viewerjumpto "Conformability" "mf_designmatrix##conformability"}{...}
{viewerjumpto "Diagnostics" "mf_designmatrix##diagnostics"}{...}
{viewerjumpto "Source code" "mf_designmatrix##source"}{...}
{title:Title}

{p 4 8 2}
{manlink M-5 designmatrix()} {hline 2} Design matrices


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:real matrix}
{cmd:designmatrix(}{it:real colvector v}{cmd:)}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:designmatrix(}{it:v}{cmd:)}
returns a {cmd:rows(}{it:v}{cmd:)}
{it:x}
{cmd:colmax(}{it:v}{cmd:)} matrix with ones in the 
indicated columns and zero everywhere else.


{marker remarks}{...}
{title:Remarks}

{p 4 4 2}
{cmd:designmatrix((1\2\3))} is equal to {cmd:I(3)}, the 3 {it:x} 3 identity
matrix.


{marker conformability}{...}
{title:Conformability}

    {cmd:designmatrix(}{it:v}{cmd:)}:
		{it:v}:  {it:r} {it:x} 1
	   {it:result}:  {it:r} {it:x} {cmd:colmax(}{it:v}{cmd:)} (0 {it:x} 0 if {it:r}=0)


{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:designmatrix(}{it:v}{cmd:)}
aborts with error if any element of {it:v} is <1.


{marker source}{...}
{title:Source code}

{p 4 4 2}
{view designmatrix.mata, adopath asis:designmatrix.mata}
{p_end}
