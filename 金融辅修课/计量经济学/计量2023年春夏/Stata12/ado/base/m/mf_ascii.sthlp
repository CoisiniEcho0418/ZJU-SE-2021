{smcl}
{* *! version 1.1.1  11feb2011}{...}
{vieweralsosee "[M-5] ascii()" "mansection M-5 ascii()"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-4] string" "help m4_string"}{...}
{viewerjumpto "Syntax" "mf_ascii##syntax"}{...}
{viewerjumpto "Description" "mf_ascii##description"}{...}
{viewerjumpto "Conformability" "mf_ascii##conformability"}{...}
{viewerjumpto "Diagnostics" "mf_ascii##diagnostics"}{...}
{viewerjumpto "Source code" "mf_ascii##source"}{...}
{title:Title}

{p 4 8 2}
{manlink M-5 ascii()} {hline 2} Manipulate ASCII codes


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:real rowvector} {cmd:ascii(}{it:string scalar s}{cmd:)}

{p 8 12 2}
{it:string scalar}{bind:  }{cmd:char(}{it:real rowvector c}{cmd:)}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:ascii(}{it:s}{cmd:)}
returns a row vector containing the ASCII codes corresponding to {it:s}.  For
instance, {cmd:ascii("abc")} returns (97, 98, 99).

{p 4 4 2}
{cmd:char(}{it:c}{cmd:)}
returns a string consisting of the specified ASCII codes.
For instance, {cmd:char((97, 98, 99))} returns "abc".


{marker conformability}{...}
{title:Conformability}

    {cmd:ascii(}{it:s}{cmd:)}:
	    {it:s}:  1 {it:x} 1
       {it:result}:  1 {it:x} {cmd:strlen(}{it:s}{cmd:)}

    {cmd:char(}{it:c}{cmd:)}
	    {it:c}:  1 {it:x} {it:n}, {it:n}>=0
       {it:result}:  1 {it:x} 1


{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:ascii(}{it:s}{cmd:)} returns {cmd:J(1,0,.)}  if
{cmd:strlen(}{it:s}{cmd:)==0}.

{p 4 4 2}
In {cmd:char(}{it:c}{cmd:)}, if any element of {it:c} is outside the range 0
to 255, the returned string is terminated at that point.  For instance,
{cmd:char((97,98,99,1000,97,98,99))}="abc".

{p 4 4 2}
{cmd:char(J(1,0,.))} returns "".


{marker source}{...}
{title:Source code}

{p 4 4 2}
Functions are built in.
{p_end}
