{smcl}
{* *! version 1.1.1  11feb2011}{...}
{vieweralsosee "[M-5] liststruct()" "mansection M-5 liststruct()"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-2] struct" "help m2_struct"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-4] io" "help m4_io"}{...}
{viewerjumpto "Syntax" "mf_liststruct##syntax"}{...}
{viewerjumpto "Description" "mf_liststruct##description"}{...}
{viewerjumpto "Remarks" "mf_liststruct##remarks"}{...}
{viewerjumpto "Conformability" "mf_liststruct##conformability"}{...}
{viewerjumpto "Diagnostics" "mf_liststruct##diagnostics"}{...}
{viewerjumpto "Source code" "mf_liststruct##source"}{...}
{title:Title}

{p 4 8 2}
{manlink M-5 liststruct()} {hline 2} List structure's contents


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:void}
{cmd:liststruct(}{it:struct whatever matrix x}{cmd:)}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:liststruct()} lists {it:x}'s contents, where {it:x} is an instance of
structure {it:whatever}.


{marker remarks}{...}
{title:Remarks}

{p 4 4 2}
{cmd:liststruct()} is often useful in debugging.

{p 4 4 2}
The dimension and type of all elements are listed, and the values of 
scalars are also shown.


{marker conformability}{...}
{title:Conformability}

    {cmd:liststruct(}{it:x}{cmd:)}
		{it:x}:  {it:r x c}
	   {it:result}:  {it:void}


{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
None.


{marker source}{...}
{title:Source code}

{p 4 4 2}
{view liststruct.mata, adopath asis:liststruct.mata}
{p_end}
