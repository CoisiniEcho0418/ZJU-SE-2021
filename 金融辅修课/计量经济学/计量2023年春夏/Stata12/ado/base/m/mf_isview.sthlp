{smcl}
{* *! version 1.1.1  11feb2011}{...}
{vieweralsosee "[M-5] isview()" "mansection M-5 isview()"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-5] eltype()" "help mf_eltype"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-4] utility" "help m4_utility"}{...}
{viewerjumpto "Syntax" "mf_isview##syntax"}{...}
{viewerjumpto "Description" "mf_isview##description"}{...}
{viewerjumpto "Remarks" "mf_isview##remarks"}{...}
{viewerjumpto "Conformability" "mf_isview##conformability"}{...}
{viewerjumpto "Diagnostics" "mf_isview##diagnostics"}{...}
{viewerjumpto "Source code" "mf_isview##source"}{...}
{title:Title}

{p 4 8 2}
{manlink M-5 isview()} {hline 2} Whether matrix is view


{marker syntax}{...}
{title:Syntax}

{p 8 8 2}
{it:real scalar} {cmd:isview(}{it:transmorphic matrix X}{cmd:)}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:isview(}{it:X}{cmd:)} returns 1 if {it:X} is a view and 0 otherwise.

{p 4 4 2}
See {bf:{help m6_glossary:[M-6] Glossary}} 
for a definition of a {help m6_glossary##view:view}.


{marker remarks}{...}
{title:Remarks}

{p 4 4 2}
View matrices are created by {cmd:st_view()}; see
{bf:{help mf_st_view:[M-5] st_view()}}.


{marker conformability}{...}
{title:Conformability}

    {cmd:isview(}{it:X}{cmd:)}:
		{it:X}:  {it:r x c}
	   {it:result}:  1 {it:x} 1


{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
None.


{marker source}{...}
{title:Source code}

{p 4 4 2}
Function is built in.
{p_end}
