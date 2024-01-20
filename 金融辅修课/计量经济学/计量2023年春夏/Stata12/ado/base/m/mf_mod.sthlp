{smcl}
{* *! version 1.1.1  11feb2011}{...}
{vieweralsosee "[M-5] mod()" "mansection M-5 mod()"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-4] scalar" "help m4_scalar"}{...}
{viewerjumpto "Syntax" "mf_mod##syntax"}{...}
{viewerjumpto "Description" "mf_mod##description"}{...}
{viewerjumpto "Conformability" "mf_mod##conformability"}{...}
{viewerjumpto "Diagnostics" "mf_mod##diagnostics"}{...}
{viewerjumpto "Source code" "mf_mod##source"}{...}
{title:Title}

{p 4 8 2}
{manlink M-5 mod()} {hline 2} Modulus


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:real matrix} {cmd:mod(}{it:real matrix x}{cmd:,} {it:real matrix y}{cmd:)}


{marker description}{...}
{title:Description}

{p 4 4 2}
    {cmd:mod(}{it:x}{cmd:,} {it:y}{cmd:)} returns the elementwise modulus
    of {it:x} with respect to {it:y}.  
    {cmd:mod()} is defined

	{cmd:mod(}{it:x}{cmd:,} {it:y}{cmd:)} = {it:x} - {it:y}*trunc({it:x}/{it:y})


{marker conformability}{...}
{title:Conformability}

    {cmd:mod(}{it:x}{cmd:,} {it:y}{cmd:)}:
                {it:x}:  {it:r1 x c1}
                {it:y}:  {it:r2 x c2}, {it:x} and {it:y} r-conformable
           {it:result}:  max({it:r1},{it:r2}) {it:x} max({it:c1},{it:c2}) (elementwise calculation)


{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
    {cmd:mod(}{it:x}{cmd:,} {it:y}{cmd:)} returns missing when either argument
    is missing or when {it:y}=0.


{marker source}{...}
{title:Source code}

{p 4 4 2}
Function is built in.
{p_end}
