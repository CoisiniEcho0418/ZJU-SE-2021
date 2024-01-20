{smcl}
{* *! version 1.1.1  11feb2011}{...}
{vieweralsosee "[M-5] sizeof()" "mansection M-5 sizeof()"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-4] programming" "help m4_programming"}{...}
{viewerjumpto "Syntax" "mf_sizeof##syntax"}{...}
{viewerjumpto "Description" "mf_sizeof##description"}{...}
{viewerjumpto "Remarks" "mf_sizeof##remarks"}{...}
{viewerjumpto "Conformability" "mf_sizeof##conformability"}{...}
{viewerjumpto "Diagnostics" "mf_sizeof##diagnostics"}{...}
{viewerjumpto "Source code" "mf_sizeof##source"}{...}
{title:Title}

{p 4 8 2}
{manlink M-5 sizeof()} {hline 2} Number of bytes consumed by object


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:real scalar}
{cmd:sizeof(}{it:transmorphic matrix A}{cmd:)}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:sizeof(}{it:A}{cmd:)} 
returns the number of bytes consumed by {it:A}.


{marker remarks}{...}
{title:Remarks}

{p 4 4 2}
{cmd:sizeof(}{it:A}{cmd:)} 
returns the same number as shown by {cmd:mata describe}; see
{bf:{help mata_describe:[M-3] mata describe}}.

{p 4 4 2}
A 500 {it:x} 5 real matrix consumes 20,000 bytes:

	: {cmd:sizeof(mymatrix)}
	  20000

{p 4 4 2}
A 500 {it:x} 5 view matrix, however, consumes only 24 bytes:

	: {cmd:sizeof(myview)}
	  24

{p 4 4 2}
To obtain the number of bytes consumed by a function, pass a 
dereferenced function pointer:

	: {cmd:sizeof(*&myfcn())}
	  320


{marker conformability}{...}
{title:Conformability}

    {cmd:sizeof(}{it:A}{cmd:)}:
		{it:A}:  {it:r x c}
	   {it:result}:  1 {it:x} 1


{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
The number returned by {cmd:sizeof(}{it:A}{cmd:)} does not include any
overhead, which usually amounts to 64 bytes, but can be less (as small 
as zero in the case of recently used scalars).

{p 4 4 2}
If {it:A} is a pointer matrix, the number returned reflects the amount of 
memory required to store {it:A} itself and does not include the memory 
consumed by its siblings.


{marker source}{...}
{title:Source code}

{p 4 4 2}
Function is built in.
{p_end}
