{smcl}
{* *! version 1.1.2  11feb2011}{...}
{vieweralsosee "[M-5] all()" "mansection M-5 all()"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-4] utility" "help m4_utility"}{...}
{viewerjumpto "Syntax" "mf_all##syntax"}{...}
{viewerjumpto "Description" "mf_all##description"}{...}
{viewerjumpto "Remarks" "mf_all##remarks"}{...}
{viewerjumpto "Conformability" "mf_all##conformability"}{...}
{viewerjumpto "Diagnostics" "mf_all##diagnostics"}{...}
{viewerjumpto "Source code" "mf_all##source"}{...}
{title:Title}

{p 4 8 2}
{manlink M-5 all()} {hline 2} Element comparisons


{marker syntax}{...}
{title:Syntax}

{p 8 8 2}
{it:real scalar} {cmd:all(}{it:real matrix L}{cmd:)}

{p 8 8 2}
{it:real scalar} {cmd:any(}{it:real matrix L}{cmd:)}


{p 8 8 2}
{it:real scalar}
{cmd:allof(}{it:transmorphic matrix P}{cmd:,}
{it:transmorphic scalar s}{cmd:)}

{p 8 8 2}
{it:real scalar}
{cmd:anyof(}{it:transmorphic matrix P}{cmd:,}
{it:transmorphic scalar s}{cmd:)}
 

{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:all(}{it:L}{cmd:)} is equivalent to
{cmd:sum(!}{it:L}{cmd:)==0} but is significantly faster.

{p 4 4 2}
{cmd:any(}{it:L}{cmd:)} is equivalent to 
{cmd:sum(}{it:L}{cmd:)!=0} but
is slightly faster.

{p 4 4 2}
{cmd:allof(}{it:P}{cmd:,} {it:s}{cmd:)} returns 1 if every element of {it:P}
equals {it:s} and returns 0 otherwise.
{cmd:allof(}{it:P}{cmd:,} {it:s}{cmd:)} is faster and consumes less memory
than the equivalent construction {cmd:all(}{it:P}{cmd::==}{it:s}{cmd:)}.

{p 4 4 2}
{cmd:anyof(}{it:P}{cmd:,} {it:s}{cmd:)} returns 1 if any element of {it:P}
equals {it:s} and returns 0 otherwise.
{cmd:anyof(}{it:P}{cmd:,} {it:s}{cmd:)} is faster and consumes less memory
than the equivalent 
{cmd:any(}{it:P}{cmd::==}{it:s}{cmd:)}.


{marker remarks}{...}
{title:Remarks}

{p 4 4 2}
These functions are fast, so their use is encouraged over alternative
constructions.  

{p 4 4 2}
{cmd:all()} and {cmd:any()} are typically used with logical expressions
to detect special cases, such as 

	{cmd:if (any(x :< 0)) {c -(}}
		...
	{cmd:{c )-}}

{p 4 4 2}
or

	{cmd:if (all(x :>= 0)) {c -(}}
		...
	{cmd:{c )-}}

{p 4 4 2}
{cmd:allof()} and {cmd:anyof()} are used to look for special values:

	{cmd:if (allof(x, 0)) {c -(}}
		...
	{cmd:{c )-}}

{p 4 4 2}
or 

	{cmd:if (anyof(x, 0)) {c -(}}
		...
	{cmd:{c )-}}

{p 4 4 2}
Do not use {cmd:allof()} and {cmd:anyof()} to check for missing values --
for example, {cmd:anyof(x, .)} -- because to really check, you would have to
check not only {cmd:.} but also {cmd:.a}, {cmd:.b}, ..., {cmd:.z}.  Instead use
{cmd:missing()}; see {bf:{help mf_missing:[M-5] missing()}}.


{marker conformability}{...}
{title:Conformability}

    {cmd:all(}{it:L}{cmd:)}, {cmd:any(}{it:L}{cmd:)}:
		{it:L}:  {it:r x c}
	   {it:result}:  1 {it:x} 1


    {cmd:allof(}{it:P}{cmd:,} {it:s}{cmd:)}, {cmd:anyof(}{it:P}{cmd:,} {it:s}{cmd:)}:
		{it:P}:  {it:r x c}
		{it:s}:  1 {it:x} 1
	   {it:result}:  1 {it:x} 1


{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:all(}{it:L}{cmd:)} and 
{cmd:any(}{it:L}{cmd:)} treat missing values in {it:L} as true.

{p 4 4 2}
{cmd:all(}{it:L}{cmd:)} and {cmd:any(}{it:L}{cmd:)} 
return 0 (false) if {it:L} is {it:r x} 0, 0 {it:x c}, or 0 {it:x} 0.

{p 4 4 2}
{cmd:allof(}{it:P}{cmd:,} {it:s}{cmd:)} and
{cmd:anyof(}{it:P}{cmd:,} {it:s}{cmd:)}
return 0 (false) if {it:P} is {it:r x} 0, 0 {it:x c}, or 0 {it:x} 0.


{marker source}{...}
{title:Source code}

{p 4 4 2}
Functions are built in.
{p_end}
