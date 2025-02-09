{smcl}
{* *! version 1.1.2  11feb2011}{...}
{vieweralsosee "[M-5] blockdiag()" "mansection M-5 blockdiag()"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-4] standard" "help m4_standard"}{...}
{viewerjumpto "Syntax" "mf_blockdiag##syntax"}{...}
{viewerjumpto "Description" "mf_blockdiag##description"}{...}
{viewerjumpto "Remarks" "mf_blockdiag##remarks"}{...}
{viewerjumpto "Conformability" "mf_blockdiag##conformability"}{...}
{viewerjumpto "Diagnostics" "mf_blockdiag##diagnostics"}{...}
{viewerjumpto "Source code" "mf_blockdiag##source"}{...}
{title:Title}

{p 4 8 2}
{manlink M-5 blockdiag()} {hline 2} Block-diagonal matrix


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:numeric matrix}
{cmd:blockdiag(}{it:numeric matrix Z1}{cmd:,}
{it:numeric matrix Z2}{cmd:)}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:blockdiag(}{it:Z1}{cmd:,} {it:Z2}{cmd:)} 
returns a block-diagonal matrix with {it:Z1} in the upper-left corner and
{it:Z2} in the lower right, that is, 

			{c TLC}{c -}      {c -}{c TRC}
			{c |} {it:Z1}   {bf:0} {c |}
			{c |}  {bf:0}  {it:Z2} {c |}
			{c BLC}{c -}      {c -}{c BRC}

{p 4 4 2}
{it:Z1} and {it:Z2} may be either real or complex and need not be of the 
same type.


{marker remarks}{...}
{title:Remarks}

{p 4 4 2}
To create a block diagonal matrix of {it:Z1}, {it:Z2}, {it:Z3}, code

	: {cmd:blockdiag(}{it:Z1}{cmd:, blockdiag(}{it:Z2}{cmd:,}{it:Z3}{cmd:))}


{marker conformability}{...}
{title:Conformability}

    {cmd:blockdiag(}{it:Z1}{cmd:,} {it:Z2}{cmd:)}:
	       {it:Z1}:  {it:r1 x c1}
	       {it:Z2}:  {it:r2 x c2}
	   {it:result}:  {it:r1}+{it:r2} {it:x} {it:c1}+{it:c2}


{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
None.  Either or both {it:Z1} and {it:Z2} may be void.


{marker source}{...}
{title:Source code}

{p 4 4 2}
{view blockdiag.mata, adopath asis:blockdiag.mata}
{p_end}
