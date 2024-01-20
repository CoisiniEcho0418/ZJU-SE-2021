{smcl}
{* *! version 1.1.1  11feb2011}{...}
{vieweralsosee "[M-5] cond()" "mansection M-5 cond()"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-5] norm()" "help mf_norm"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-4] matrix" "help m4_matrix"}{...}
{viewerjumpto "Syntax" "mf_cond##syntax"}{...}
{viewerjumpto "Description" "mf_cond##description"}{...}
{viewerjumpto "Remarks" "mf_cond##remarks"}{...}
{viewerjumpto "Conformability" "mf_cond##conformability"}{...}
{viewerjumpto "Diagnostics" "mf_cond##diagnostics"}{...}
{viewerjumpto "Source code" "mf_cond##source"}{...}
{title:Title}

{p 4 8 2}
{manlink M-5 cond()} {hline 2} Condition number


{marker syntax}{...}
{title:Syntax}

{p 8 8 2}
{it:real scalar}{bind: }
{cmd:cond(}{it:numeric matrix A}{cmd:)}

{p 8 8 2}
{it:real scalar}{bind: }
{cmd:cond(}{it:numeric matrix A}, {it:real scalar p}{cmd:)}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:cond(}{it:A}{cmd:)} returns {cmd:cond(}{it:A}, 2{cmd:)}.

{p 4 4 2}
{cmd:cond(}{it:A}, {it:p}{cmd:)} returns the
value of the condition number of {it:A} for the specified
{help m6_glossary##norm:norm} {it:p}, 
where {it:p} may be 0, 1, 2, or {cmd:.} (missing).


{marker remarks}{...}
{title:Remarks}

{p 4 4 2}
The condition number of a matrix A is

{* TeX in math mode}{...}
		{it:cond}  =  norm({it:A}, {it:p}) * norm({it:A}^(-1), {it:p})

{p 4 4 2}
These functions return missing when A is singular.

{p 4 4 2}
Values near 1 indicate that the matrix is well conditioned, and large values
indicate ill conditioning.


{marker conformability}{...}
{title:Conformability}

    {cmd:cond(}{it:A}{cmd:)}:
		{it:A}:  {it:r x c}
    	   {it:result}:  1 {it:x} 1

    {cmd:cond(}{it:A}, {it:p}{cmd:)}:
		{it:A}:  {it:r x c}
		{it:p}:  1 {it:x} 1
    	   {it:result}:  1 {it:x} 1


{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
   {cmd:cond(}{it:A}{cmd:,} {it:p}{cmd:)} aborts with error if 
   {it:p} is not 0, 1, 2, or {cmd:.} (missing).

{p 4 4 2}
   {cmd:cond(}{it:A}{cmd:)} and
   {cmd:cond(}{it:A}{cmd:,} {it:p}{cmd:)}
   return missing when {it:A} is singular or if {it:A} contains missing values.

{p 4 4 2}
   {cmd:cond(}{it:A}{cmd:)} and
   {cmd:cond(}{it:A}{cmd:,} {it:p}{cmd:)}
   return 1 when {it:A} is void.

{p 4 4 2}
   {cmd:cond(}{it:A}{cmd:)} and
   {cmd:cond(}{it:A}{cmd:, 2)} return missing if the SVD algorithm fails 
   to converge, which is highly unlikely; see {bf:{help mf_svd:[M-5] svd()}}.


{marker source}{...}
{title:Source code}

{p 4 4 2}
{view cond.mata, adopath asis:cond.mata}
{p_end}
