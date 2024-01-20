{smcl}
{* *! version 1.1.1  11feb2011}{...}
{vieweralsosee "[M-5] st_varrename()" "mansection M-5 st_varrename()"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-4] stata" "help m4_stata"}{...}
{viewerjumpto "Syntax" "mf_st_varrename##syntax"}{...}
{viewerjumpto "Description" "mf_st_varrename##description"}{...}
{viewerjumpto "Conformability" "mf_st_varrename##conformability"}{...}
{viewerjumpto "Diagnostics" "mf_st_varrename##diagnostics"}{...}
{viewerjumpto "Source code" "mf_st_varrename##source"}{...}
{title:Title}

{p 4 8 2}
{manlink M-5 st_varrename()} {hline 2} Rename Stata variable


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:void}
{cmd:st_varrename(}{it:scalar var}{cmd:,}
{it:string scalar newname}{cmd:)}


{p 4 4 2}
where {it:var} contains a Stata variable name or a Stata variable index.


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:st_varrename(}{it:var}{cmd:,} {it:newname}{cmd:)}
changes the name of {it:var} to {it:newname}.

{p 4 4 2}
If {it:var} is specified as a name, abbreviations are not allowed.


{marker conformability}{...}
{title:Conformability}

{p 4 4 2}
{cmd:st_varrename(}{it:var}{cmd:,} {it:newname}{cmd:)}:
{p_end}
	      {it:var}:  1 {it:x} 1
	  {it:newname}:  1 {it:x} 1
	   {it:result}:  {it:void}


{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:st_varrename(}{it:var}{cmd:,} {it:newname}{cmd:)}
aborts with error if {it:var} is not a valid Stata variable
or if {it:newname} is not a valid name or if a variable named 
{it:newname} already exists.


{marker source}{...}
{title:Source code}

{p 4 4 2}
Function is built in.
{p_end}
