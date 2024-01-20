{smcl}
{* *! version 1.1.1  11feb2011}{...}
{vieweralsosee "[M-5] isreal()" "mansection M-5 isreal()"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-5] eltype()" "help mf_eltype"}{...}
{vieweralsosee "[M-5] isrealvalues()" "help mf_isrealvalues"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-4] utility" "help m4_utility"}{...}
{viewerjumpto "Syntax" "mf_isreal##syntax"}{...}
{viewerjumpto "Description" "mf_isreal##description"}{...}
{viewerjumpto "Remarks" "mf_isreal##remarks"}{...}
{viewerjumpto "Conformability" "mf_isreal##conformability"}{...}
{viewerjumpto "Diagnostics" "mf_isreal##diagnostics"}{...}
{viewerjumpto "Source code" "mf_isreal##source"}{...}
{title:Title}

{p 4 8 2}
{manlink M-5 isreal()} {hline 2} Storage type of matrix


{marker syntax}{...}
{title:Syntax}

{p 8 8 2}
{it:real scalar}
{cmd:isreal(}{it:transmorphic matrix X}{cmd:)}

{p 8 8 2}
{it:real scalar}
{cmd:iscomplex(}{it:transmorphic matrix X}{cmd:)}

{p 8 8 2}
{it:real scalar}
{cmd:isstring(}{it:transmorphic matrix X}{cmd:)}

{p 8 8 2}
{it:real scalar}
{cmd:ispointer(}{it:transmorphic matrix X}{cmd:)}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:isreal(}{it:X}{cmd:)}
returns 1 if {it:X} is a {cmd:real} and returns 0 otherwise.

{p 4 4 2}
{cmd:iscomplex(}{it:X}{cmd:)}
returns 1 if {it:X} is a {cmd:complex} and returns 0 otherwise.

{p 4 4 2}
{cmd:isstring(}{it:X}{cmd:)}
returns 1 if {it:X} is a {cmd:string} and returns 0 otherwise.

{p 4 4 2}
{cmd:ispointer(}{it:X}{cmd:)}
returns 1 if {it:X} is a {cmd:pointer} and returns 0 otherwise.


{marker remarks}{...}
{title:Remarks}

{p 4 4 2}
These functions base their results on storage type.
{cmd:isreal()} is not the way to check whether a number is real,
since it might be stored as a complex and yet still be a real number, 
such as 2+0i.  To determine whether {it:x} is real, you want to 
use {cmd:isrealvalues(}{it:X}{cmd:)};  see
{bf:{help mf_isrealvalues:[M-5] isrealvalues()}}.


{marker conformability}{...}
{title:Conformability}

{p 4 4 2}
{cmd:isreal(}{it:X}{cmd:)},
{cmd:iscomplex(}{it:X}{cmd:)},
{cmd:isstring(}{it:X}{cmd:)},
{cmd:ispointer(}{it:X}{cmd:)}:
{p_end}
		{it:X}:  {it:r x c}
	   {it:result}:  1 {it:x} 1


{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
These functions return 1 or 0; they cannot fail.


{marker source}{...}
{title:Source code}

{p 4 4 2}
Functions are built in.
{p_end}
