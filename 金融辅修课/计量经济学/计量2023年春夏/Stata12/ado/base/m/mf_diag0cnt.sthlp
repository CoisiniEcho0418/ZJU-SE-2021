{smcl}
{* *! version 1.1.1  11feb2011}{...}
{vieweralsosee "[M-5] diag0cnt()" "mansection M-5 diag0cnt()"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-5] invsym()" "help mf_invsym"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-4] utility" "help m4_utility"}{...}
{viewerjumpto "Syntax" "mf_diag0cnt##syntax"}{...}
{viewerjumpto "Description" "mf_diag0cnt##description"}{...}
{viewerjumpto "Remarks" "mf_diag0cnt##remarks"}{...}
{viewerjumpto "Conformability" "mf_diag0cnt##conformability"}{...}
{viewerjumpto "Diagnostics" "mf_diag0cnt##diagnostics"}{...}
{viewerjumpto "Source code" "mf_diag0cnt##source"}{...}
{title:Title}

{p 4 8 2}
{manlink M-5 diag0cnt()} {hline 2} Count zeros on diagonal


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:real scalar}
{cmd:diag0cnt(}{it:real matrix X}{cmd:)}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:diag0cnt(}{it:X}{cmd:)} returns the number of principal diagonal
elements of {it:X} that are 0.


{marker remarks}{...}
{title:Remarks}

{p 4 4 2}
    {cmd:diag0cnt()} is often used after {helpb mf_invsym:invsym()}
    to count the number of columns dropped because of collinearity.


{marker conformability}{...}
{title:Conformability}

    {cmd:diag0cnt(}{it:X}{cmd:)}:
	     {it:X}:  {it:r x c}
	{it:result}:  1 {it:x} 1


{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:diag0cnt(}{it:X}{cmd:)} returns 0 if {it:X} is void.


{marker source}{...}
{title:Source code}

{p 4 4 2}
{view diag0cnt.mata, adopath asis:diag0cnt.mata}
{p_end}
