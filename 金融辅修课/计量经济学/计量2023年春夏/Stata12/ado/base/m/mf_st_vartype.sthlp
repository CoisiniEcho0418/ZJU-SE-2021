{smcl}
{* *! version 1.1.1  11feb2011}{...}
{vieweralsosee "[M-5] st_vartype()" "mansection M-5 st_vartype()"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-4] stata" "help m4_stata"}{...}
{viewerjumpto "Syntax" "mf_st_vartype##syntax"}{...}
{viewerjumpto "Description" "mf_st_vartype##description"}{...}
{viewerjumpto "Remarks" "mf_st_vartype##remarks"}{...}
{viewerjumpto "Conformability" "mf_st_vartype##conformability"}{...}
{viewerjumpto "Diagnostics" "mf_st_vartype##diagnostics"}{...}
{viewerjumpto "Source code" "mf_st_vartype##source"}{...}
{title:Title}

{p 4 8 2}
{manlink M-5 st_vartype()} {hline 2} Storage type of Stata variable


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:string scalar}
{cmd:st_vartype(}{it:scalar var}{cmd:)}

{p 8 12 2}
{it:real scalar}{bind:  }
{cmd:st_isnumvar(}{it:scalar var}{cmd:)}

{p 8 12 2}
{it:real scalar}{bind:  }
{cmd:st_isstrvar(}{it:scalar var}{cmd:)}


{p 4 4 2}
where {it:var} contains a Stata variable name or a Stata variable index.


{marker description}{...}
{title:Description}

{p 4 4 2}
In all the functions, if {it:var} is specified as a name, abbreviations 
are not allowed.

{p 4 4 2}
{cmd:st_vartype(}{it:var}{cmd:)}
returns the {help data_types:storage type} of the {it:var}, such as {cmd:float},
{cmd:double}, or {cmd:str18}.

{p 4 4 2}
{cmd:st_isnumvar(}{it:var}{cmd:)}
returns 1 if {it:var} is a numeric variable and 0 otherwise.

{p 4 4 2}
{cmd:st_isstrvar(}{it:var}{cmd:)}
returns 1 if {it:var} is a string variable and 0 otherwise.


{marker remarks}{...}
{title:Remarks}

{p 4 4 2}
{cmd:st_isstrvar(}{it:var}{cmd:)}
and 
{cmd:st_isnumvar(}{it:var}{cmd:)}
are antonyms.  Both functions are provided merely for convenience; they 
tell you nothing that you cannot discover from 
{cmd:st_vartype(}{it:var}{cmd:)}.


{marker conformability}{...}
{title:Conformability}

{p 4 4 2}
{cmd:st_vartype(}{it:var}{cmd:)}:
{p_end}
	      {it:var}:  1 {it:x} 1
	   {it:result}:  1 {it:x} 1

{p 4 4 2}
{cmd:st_isnumvar(}{it:var}{cmd:)},
{cmd:st_isstrvar(}{it:var}{cmd:)}:
{p_end}
	      {it:var}:  1 {it:x} 1
	   {it:result}:  1 {it:x} 1


{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
All functions abort with error if {it:var} is not a valid Stata variable.


{marker source}{...}
{title:Source code}

{p 4 4 2}
Functions are built in.
{p_end}
