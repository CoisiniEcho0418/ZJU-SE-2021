{smcl}
{* *! version 1.1.2  21apr2011}{...}
{vieweralsosee "[M-2] op_kronecker" "mansection M-2 op_kronecker"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-2] exp" "help m2_exp"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-2] intro" "help m2_intro"}{...}
{viewerjumpto "Syntax" "m2_op_kronecker##syntax"}{...}
{viewerjumpto "Description" "m2_op_kronecker##description"}{...}
{viewerjumpto "Remarks" "m2_op_kronecker##remarks"}{...}
{viewerjumpto "Conformability" "m2_op_kronecker##conformability"}{...}
{viewerjumpto "Diagnostics" "m2_op_kronecker##diagnostics"}{...}
{viewerjumpto "Reference" "m2_op_kronecker##reference"}{...}
{title:Title}

{phang}
{manlink M-2 op_kronecker} {hline 2} Kronecker direct-product operator


{marker syntax}{...}
{title:Syntax}

	{it:A} {cmd:#} {it:B}

{p 4 4 2}
where {it:A} and {it:B} may be real or complex.


{marker description}{...}
{title:Description}

{p 4 4 2}
{it:A}{cmd:#}{it:B} returns the Kronecker direct product.  

{p 4 4 2}
{cmd:#} binds tightly:  
{it:X}{cmd:*}{it:A}{cmd:#}{it:B}{cmd:*}{it:Y} 
is interpreted 
as 
{it:X}{cmd:*(}{it:A}{cmd:#}{it:B}{cmd:)*}{it:Y}.


{marker remarks}{...}
{title:Remarks}

{p 4 4 2}
The Kronecker direct product is also known as the Kronecker product, the
direct product, the tensor product, and the outer product.

{p 4 4 2}
The Kronecker product {it:A}{cmd:#}{it:B} is the matrix 
||{it:a}_{it:ij}*{it:B}||.


{marker conformability}{...}
{title:Conformability}

    {it:A}{cmd:#}{it:B}:
	{it:A}:  {it:r1 x c1}
	{it:B}:  {it:r2 x c2}
   {it:result}:  {it:r1}*{it:r2} {it:x} {it:c1}*{it:c2}


{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
None.
{p_end}


{marker reference}{...}
{title:Reference}

{phang}
James, I. 2002.
{it:Remarkable Mathematicians: From Euler to von Neumann}.
Cambridge: Cambridge University Press.
{p_end}
