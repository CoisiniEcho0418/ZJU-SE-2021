{smcl}
{* *! version 1.1.1  11feb2011}{...}
{vieweralsosee "[M-5] fileexists()" "mansection M-5 fileexists()"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-4] io" "help m4_io"}{...}
{viewerjumpto "Syntax" "mf_fileexists##syntax"}{...}
{viewerjumpto "Description" "mf_fileexists##description"}{...}
{viewerjumpto "Conformability" "mf_fileexists##conformability"}{...}
{viewerjumpto "Diagnostics" "mf_fileexists##diagnostics"}{...}
{viewerjumpto "Source code" "mf_fileexists##source"}{...}
{title:Title}

{p 4 8 2}
{manlink M-5 fileexists()} {hline 2} Whether file exists


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:real scalar}
{cmd:fileexists(}{it:string scalar fn}{cmd:)}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:fileexists(}{it:fn}{cmd:)}
returns 1 if file {it:fn} exists and is readable and returns 0 otherwise.


{marker conformability}{...}
{title:Conformability}

    {cmd:fileexists(}{it:fn}{cmd:)}:
	      {it:fn}:  1 {it:x} 1
	   {it:result}: 1 {it:x} 1


{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
None.


{marker source}{...}
{title:Source code}

{p 4 4 2}
{view fileexists.mata, adopath asis:fileexists.mata}
{p_end}
