{smcl}
{* *! version 1.1.2  11feb2011}{...}
{vieweralsosee "[M-5] sqrt()" "mansection M-5 sqrt()"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-5] cholesky()" "help mf_cholesky"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-4] scalar" "help m4_scalar"}{...}
{viewerjumpto "Syntax" "mf_sqrt##syntax"}{...}
{viewerjumpto "Description" "mf_sqrt##description"}{...}
{viewerjumpto "Conformability" "mf_sqrt##conformability"}{...}
{viewerjumpto "Diagnostics" "mf_sqrt##diagnostics"}{...}
{viewerjumpto "Source code" "mf_sqrt##source"}{...}
{title:Title}

{p 4 8 2}
{manlink M-5 sqrt()} {hline 2} Square root


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:numeric matrix} 
{cmd:sqrt(}{it:numeric matrix Z}{cmd:)}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:sqrt(}{it:Z}{cmd:)} returns the elementwise square root of {it:Z}.


{marker conformability}{...}
{title:Conformability}

    {cmd:sqrt(}{it:Z}{cmd:)}
	     {it:Z}:  {it:r x c}
	{it:result}:  {it:r x c}


{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:sqrt(}{it:Z}{cmd:)}
returns missing when {it:Z} is real and {it:Z}<0; that is,
{cmd:sqrt(}-4{cmd:)} = {cmd:.} but {cmd:sqrt(}-4+0i{cmd:)} = 2i.


{marker source}{...}
{title:Source code}

{p 4 4 2}
Function is built in.
{p_end}
