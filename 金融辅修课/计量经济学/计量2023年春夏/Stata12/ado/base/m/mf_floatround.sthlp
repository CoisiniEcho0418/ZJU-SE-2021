{smcl}
{* *! version 1.1.1  11feb2011}{...}
{vieweralsosee "[M-5] floatround()" "mansection M-5 floatround()"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-4] utility" "help m4_utility"}{...}
{viewerjumpto "Syntax" "mf_floatround##syntax"}{...}
{viewerjumpto "Description" "mf_floatround##description"}{...}
{viewerjumpto "Remarks" "mf_floatround##remarks"}{...}
{viewerjumpto "Conformability" "mf_floatround##conformability"}{...}
{viewerjumpto "Diagnostics" "mf_floatround##diagnostics"}{...}
{viewerjumpto "Source code" "mf_floatround##source"}{...}
{title:Title}

{p 4 8 2}
{manlink M-5 floatround()} {hline 2} Round to float precision


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:real matrix}
{cmd:floatround(}{it:real matrix x}{cmd:)}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:floatround(}{it:x}{cmd:)} returns {it:x} rounded to 
IEEE 4-byte real (float) precision.
{cmd:floatround()} is the element-by-element equivalent of 
Stata's {helpb float()} function.  The Mata function could not 
be named {cmd:float()} because the word {cmd:float} is reserved in 
Mata.


{marker remarks}{...}
{title:Remarks}

        : {cmd:printf("  %21x\n", .1)}
           +1.999999999999aX-004
 
        : {cmd:printf("  %21x\n", floatround(.1))}
           +1.99999a0000000X-004


{marker conformability}{...}
{title:Conformability}

    {cmd:floatround(}{it:x}{cmd:)}:
		{it:x}:  {it:r x c}
	   {it:result}:  {it:r x c}


{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:floatround(}{it:x}{cmd:)}
returns missing ({cmd:.}) if 
{it:x} < -1.fffffeX+7e
(approximately -1.70141173319e+38)
or 
{it:x} > 1.fffffeX+7e
(approximately 1.70141173319e+38).

{p 4 4 2}
In contrast with most functions,
{cmd:floatround(}{it:x}{cmd:)}
returns the same kind of missing value as {it:x} if 
{it:x} contains missing; 
{cmd:.} if {it:x}=={cmd:.}, 
{cmd:.a} if {it:x}=={cmd:.a}, 
{cmd:.b} if {it:x}=={cmd:.b}, ..., and
{cmd:.z} if {it:x}=={cmd:.z}. 


{marker source}{...}
{title:Source code}

{p 4 4 2}
Function is built in.
{p_end}
