{smcl}
{* *! version 1.1.1  11feb2011}{...}
{vieweralsosee "[M-5] direxternal()" "mansection M-5 direxternal()"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-5] findexternal()" "help mf_findexternal"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-4] programming" "help m4_programming"}{...}
{viewerjumpto "Syntax" "mf_direxternal##syntax"}{...}
{viewerjumpto "Description" "mf_direxternal##description"}{...}
{viewerjumpto "Remarks" "mf_direxternal##remarks"}{...}
{viewerjumpto "Conformability" "mf_direxternal##conformability"}{...}
{viewerjumpto "Diagnostics" "mf_direxternal##diagnostics"}{...}
{viewerjumpto "Source code" "mf_direxternal##source"}{...}
{title:Title}

{p 4 8 2}
{manlink M-5 direxternal()} {hline 2} Obtain list of existing external globals


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:string}
{it:colvector}
{cmd:direxternal(}{it:string scalar pattern}{cmd:)}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:direxternal(}{it:pattern}{cmd:)}
returns a column vector containing the names matching {it:pattern} 
of the existing external globals.  
{cmd:direxternal()} returns {cmd:J(0,1,"")} if there are no such globals.

{p 4 4 2}
{it:pattern} is interpreted by {bf:{help mf_strmatch:[M-5] strmatch()}}.


{marker remarks}{...}
{title:Remarks}

{p 4 4 2}
See {bf:{help mf_findexternal:[M-5] findexternal()}} for the definition of a
global.  

{p 4 4 2}
A list of all globals can be obtained 
by {cmd:direxternal("*")}.


{marker conformability}{...}
{title:Conformability}

    {cmd:direxternal(}{it:pattern}{cmd:)}:
	  {it:pattern}:  1 {it:x} 1
	   {it:result}:  {it:n} {it:x} 1


{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:direxternal(}{it:pattern}{cmd:)}
returns {cmd:J(0,1,"")} when there are no globals matching {it:pattern}.


{marker source}{...}
{title:Source code}

{p 4 4 2}
Function is built in.
{p_end}
