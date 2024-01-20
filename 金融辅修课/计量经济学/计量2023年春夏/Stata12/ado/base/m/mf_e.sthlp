{smcl}
{* *! version 1.1.1  11feb2011}{...}
{vieweralsosee "[M-5] e()" "mansection M-5 e()"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-4] standard" "help m4_standard"}{...}
{viewerjumpto "Syntax" "mf_e##syntax"}{...}
{viewerjumpto "Description" "mf_e##description"}{...}
{viewerjumpto "Conformability" "mf_e##conformability"}{...}
{viewerjumpto "Diagnostics" "mf_e##diagnostics"}{...}
{viewerjumpto "Source code" "mf_e##source"}{...}
{title:Title}

{p 4 8 2}
{manlink M-5 e()} {hline 2} Unit vectors


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:real rowvector}
{cmd:e(}{it:real scalar i}{cmd:,}
{it:real scalar n}{cmd:)}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:e(}{it:i}{cmd:,} {it:n}{cmd:)}
returns a 1 {it:x} {it:n} unit vector, a vector with all elements equal to 
zero except for the {it:i}th, which is set to one.


{marker conformability}{...}
{title:Conformability}

    {cmd:e(}{it:i}{cmd:,} {it:n}{cmd:)}:
		{it:i}:  1 {it:x} {it:1}
		{it:n}:  1 {it:x} {it:1}
	   {it:result}:  1 {it:x} {it:n}


{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:e(}{it:i}{cmd:,} {it:n}{cmd:)}
aborts with error if {it:n}<1 or if {it:i}<1 or if {it:i}>{it:n}.
Arguments {it:i} and {it:n} are interpreted as 
{cmd:trunc(}{it:i}{cmd:)} and 
{cmd:trunc(}{it:n}{cmd:)}.


{marker source}{...}
{title:Source code}

{p 4 4 2}
{view e.mata, adopath asis:e.mata}
{p_end}
