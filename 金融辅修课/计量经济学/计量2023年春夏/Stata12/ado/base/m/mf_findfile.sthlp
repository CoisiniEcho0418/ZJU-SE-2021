{smcl}
{* *! version 1.1.2  11feb2011}{...}
{vieweralsosee "[M-5] findfile()" "mansection M-5 findfile()"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-4] io" "help m4_io"}{...}
{viewerjumpto "Syntax" "mf_findfile##syntax"}{...}
{viewerjumpto "Description" "mf_findfile##description"}{...}
{viewerjumpto "Remarks" "mf_findfile##remarks"}{...}
{viewerjumpto "Conformability" "mf_findfile##conformability"}{...}
{viewerjumpto "Diagnostics" "mf_findfile##diagnostics"}{...}
{viewerjumpto "Source code" "mf_findfile##source"}{...}
{title:Title}

{p 4 8 2}
{manlink M-5 findfile()} {hline 2} Find file


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:string scalar}
{cmd:findfile(}{it:string scalar fn}{cmd:,}
{it:string scalar} {it:dirlist}{cmd:)}

{p 8 12 2}
{it:string scalar}
{cmd:findfile(}{it:string scalar fn}{cmd:)}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:findfile(}{it:fn}{cmd:,} {it:dirlist}{cmd:)}
looks for file {it:fn} along the semicolon-separated list of directories 
{it:dirlist} and returns the fully qualified path and filename if 
{it:fn} is found.  {cmd:findfile()} returns "" if the file is not found.

{p 4 4 2}
{cmd:findfile(}{it:fn}{cmd:)} 
is equivalent to {cmd:findfile(}{it:fn}{cmd:, c("adopath"))}.
{cmd:findfile()} with one argument looks along the official Stata 
ado-path for file {it:fn}.


{marker remarks}{...}
{title:Remarks}

{p 4 4 2}
For instance, 

	{cmd:findfile("kappa.ado")}

{p 4 4 2}
might return "{cmd:C:\Program Files\Stata12\ado\updates\k\kappa.ado}".


{marker conformability}{...}
{title:Conformability}

    {cmd:findfile(}{it:fn}{cmd:,} {it:dirlist}{cmd:)}:
	      {it:fn}:  1 {it:x} 1
	 {it:dirlist}:  1 {it:x} 1  (optional)
	   {it:result}: 1 {it:x} 1


{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:findfile(}{it:fn}{cmd:,} {it:dirlist}{cmd:)}
and 
{cmd:findfile(}{it:fn}{cmd:)} 
return "" if the file is not found.
If the file is found, the returned fully qualified path and filename is 
guaranteed to exist and be readable at the instant {cmd:findfile()} 
concluded.


{marker source}{...}
{title:Source code}

{p 4 4 2}
{view findfile.mata, adopath asis:findfile.mata}
{p_end}
