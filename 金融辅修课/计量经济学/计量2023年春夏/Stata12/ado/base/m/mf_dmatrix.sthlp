{smcl}
{* *! version 1.1.4  11feb2011}{...}
{vieweralsosee "[M-5] Dmatrix()" "mansection M-5 Dmatrix()"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-5] Kmatrix()" "help mf_kmatrix"}{...}
{vieweralsosee "[M-5] Lmatrix()" "help mf_lmatrix"}{...}
{vieweralsosee "[M-5] vec()" "help mf_vec"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-4] standard" "help m4_standard"}{...}
{viewerjumpto "Syntax" "mf_dmatrix##syntax"}{...}
{viewerjumpto "Description" "mf_dmatrix##description"}{...}
{viewerjumpto "Remarks" "mf_dmatrix##remarks"}{...}
{viewerjumpto "Conformability" "mf_dmatrix##conformability"}{...}
{viewerjumpto "Diagnostics" "mf_dmatrix##diagnostics"}{...}
{viewerjumpto "Source code" "mf_dmatrix##source"}{...}
{viewerjumpto "Reference" "mf_dmatrix##reference"}{...}
{title:Title}

{p 4 8 2}
{manlink M-5 Dmatrix()} {hline 2} Duplication matrix


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:real matrix}
{cmd:Dmatrix(}{it:real scalar n}{cmd:)}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:Dmatrix(}{it:n}{cmd:)} 
returns the {it:n}^2 {it:x} {it:n}*({it:n}+1)/2 duplication
matrix {cmd:D} for which {cmd:D}*{cmd:vech(}{it:X}{cmd:)} {cmd:=}
{cmd:vec(}{it:X}{cmd:)}, where {it:X} is an arbitrary {it:n x n} symmetric
matrix.


{marker remarks}{...}
{title:Remarks}

{p 4 4 2}
Duplication matrices are frequently used in computing derivatives of
functions of symmetric matrices.  Section 9.5 of
{help mf_dmatrix##L1996:L{c u:}tkepohl (1996)} lists many
useful properties of duplication matrices.


{marker conformability}{...}
{title:Conformability}

    {cmd:Dmatrix(}{it:n}{cmd:)}:
		{it:n}:    1 {it:x} 1
	   {it:result}:  {it:n}^2 {it:x n}*({it:n} + 1)/2


{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:Dmatrix(}{it:n}{cmd:)} aborts with error if {it:n} is less than 0 or is
missing.  {it:n} is interpreted as {helpb mf_trunc:trunc({it:n})}.


{marker source}{...}
{title:Source code}

{p 4 4 2}
{view dmatrix.mata, adopath asis:dmatrix.mata}
{p_end}


{marker reference}{...}
{title:Reference}

{marker L1996}{...}
{p 4 4 2}
L{c u:}tkepohl, H. 1996.  {it:Handbook of Matrices}. New York: Wiley.
{p_end}
