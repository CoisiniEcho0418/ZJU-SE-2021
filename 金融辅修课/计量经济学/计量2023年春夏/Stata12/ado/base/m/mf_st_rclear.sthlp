{smcl}
{* *! version 1.1.1  11feb2011}{...}
{vieweralsosee "[M-5] st_rclear()" "mansection M-5 st_rclear()"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-5] st_global()" "help mf_st_global"}{...}
{vieweralsosee "[M-5] st_matrix()" "help mf_st_matrix"}{...}
{vieweralsosee "[M-5] st_numscalar()" "help mf_st_numscalar"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-4] stata" "help m4_stata"}{...}
{viewerjumpto "Syntax" "mf_st_rclear##syntax"}{...}
{viewerjumpto "Description" "mf_st_rclear##description"}{...}
{viewerjumpto "Remarks" "mf_st_rclear##remarks"}{...}
{viewerjumpto "Conformability" "mf_st_rclear##conformability"}{...}
{viewerjumpto "Diagnostics" "mf_st_rclear##diagnostics"}{...}
{viewerjumpto "Source code" "mf_st_rclear##source"}{...}
{title:Title}

{p 4 8 2}
{manlink M-5 st_rclear()} {hline 2} Clear r(), e(), or s()


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:void}
{cmd:st_rclear()}

{p 8 12 2}
{it:void}
{cmd:st_eclear()}

{p 8 12 2}
{it:void}
{cmd:st_sclear()}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:st_rclear()} clears Stata's {cmd:r()} saved results.

{p 4 4 2}
{cmd:st_eclear()} clears Stata's {cmd:e()} saved results.

{p 4 4 2}
{cmd:st_sclear()} clears Stata's {cmd:s()} saved results.


{marker remarks}{...}
{title:Remarks}

{p 4 4 2}
Returning results in {cmd:r()}, {cmd:e()}, or {cmd:s()} is one way 
of communicating results calculated in Mata back to Stata; 
see {bf:{help m1_ado:[M-1] ado}}.
See {bf:{help return:[R] saved results}} for a description of 
{cmd:e()}, {cmd:r()}, and {cmd:s()}.

{p 4 4 2}
Use {cmd:st_rclear()}, {cmd:st_eclear()}, or {cmd:st_sclear()}
to clear results, and then use 
{cmd:st_global()} to define macros, 
{cmd:st_numscalar()} to define scalars, 
and {cmd:st_matrix()} to define Stata matrices in {cmd:r()}, {cmd:e()}, 
or {cmd:s()}.  For example, 

	{cmd:st_rclear()}
	{cmd:st_global("r(name)", "tab")}{...}
{col 50}<- see {bf:{help mf_st_global:[M-5] st_global()}}
	{cmd:st_numscalar("r(N)", n1+n2)}{...}
{col 50}<- see {bf:{help mf_st_numscalar:[M-5] st_numscalar()}}
	{cmd:st_matrix("r(table)", X+Y)}{...}
{col 50}<- see {bf:{help mf_st_matrix:[M-5] st_matrix()}}

{p 4 4 2}
It is not necessary to clear before saving, but it is considered good style
unless it is your intention to add to previously saved results.  

{p 4 4 2}
If a saved result already exists, {cmd:st_global()}, {cmd:st_numscalar()},
and {cmd:st_matrix()} may be used to redefine it and even to redefine it to a
different type.  For instance, continuing with our example, later in the same
code might appear

	{cmd:if (}...{cmd:) {c -(}}
		{cmd:st_matrix("r(name)", X)}
	{cmd:{c )-}}

{p 4 4 2}
Saved result {cmd:r(name)} was previously defined as a macro containing
{cmd:"tab"}, and, even so, can now be redefined to become a matrix.

{p 4 4 2}
If you want to eliminate a particular saved result, use {cmd:st_global()}
to change its contents to {cmd:""}:

	{cmd:st_global("r(name)", "")}

{p 4 4 2}
Do this regardless of the type of the saved result.  Here
we use {cmd:st_global()} to clear saved result {cmd:r(name)}, 
which might be a macro and might be a matrix.


{marker conformability}{...}
{title:Conformability}

{p 4 4 2}
{cmd:st_rclear()}, 
{cmd:st_eclear()}, and
{cmd:st_sclear()}
take no arguments and return void.


{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:st_rclear()}, 
{cmd:st_eclear()}, and
{cmd:st_sclear()}
cannot fail.


{marker source}{...}
{title:Source code}

{p 4 4 2}
Functions are built in.
{p_end}
