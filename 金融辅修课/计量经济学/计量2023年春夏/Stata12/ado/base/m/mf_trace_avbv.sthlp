{smcl}
{* *! version 1.1.2  27jun2011}{...}
{vieweralsosee undocumented "help undocumented"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-5] trace()" "help mf_trace"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-4] matrix" "help m4_matrix"}{...}
{viewerjumpto "Syntax" "mf_trace_avbv##syntax"}{...}
{viewerjumpto "Description" "mf_trace_avbv##description"}{...}
{viewerjumpto "Remarks" "mf_trace_avbv##remarks"}{...}
{viewerjumpto "Conformability" "mf_trace_avbv##conformability"}{...}
{viewerjumpto "Diagnostics" "mf_trace_avbv##diagnostics"}{...}
{viewerjumpto "Source code" "mf_trace_avbv##source"}{...}
{title:Title}

{p 4 8 2}
{bf:[M-5] trace_AVBV()} {hline 2} Obtain trace of a special-purpose matrix


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:real scalar}
{cmd:trace_AVBV(}{it:real matrix A}, {it:real matrix B}, 
{it:real vector v}{cmd:)}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:trace_AVBV(}{it:A}{cmd:,} {it:B}{cmd:,} {it:v}{cmd:)} returns
{cmd:trace((}{it:A}{cmd:*diag(}{it:v}{cmd:))*(}{it:B}{cmd:*diag(}{it:v}{cmd:)))},
calculated efficiently, where {it:A} and {it:B} are symmetric matrices with
zeros on their diagonals.

{p 4 4 2}
{cmd:trace_AVBV()} is an {help undocumented} function.


{marker remarks}{...}
{title:Remarks}

{p 4 4 2}
This calculation arises in certain spatial statistical calculations.


{marker conformability}{...}
{title:Conformability}

    {cmd:trace_AVBV(}{it:A}, {it:B}, {it:v}{cmd:)}:
		{it:A}:  {it:n x n} 
		{it:B}:  {it:n x n} 
		{it:v}:  {it:n x} 1


{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:trace_AVBV(}{it:A}{cmd:,} {it:B}{cmd:,} {it:v}{cmd:)} 
assumes, but does not check, that {it:A} and {it:B} are symmetric with zeros
on their diagonals.

{p 4 4 2}
{cmd:trace_AVBV(}{it:A}{cmd:,} {it:B}{cmd:,} {it:v}{cmd:)} 
aborts with error if {it:A}, {it:B}, or {it:v} is a view.


{marker source}{...}
{title:Source code}

{p 4 4 2}
Function is built in.
{p_end}
