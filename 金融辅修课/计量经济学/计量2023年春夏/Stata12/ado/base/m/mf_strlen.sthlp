{smcl}
{* *! version 1.1.1  11feb2011}{...}
{vieweralsosee "[M-5] strlen()" "mansection M-5 strlen()"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-5] fmtwidth()" "help mf_fmtwidth"}{...}
{vieweralsosee "[M-5] strpost()" "help mf_strpos"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-4] string" "help m4_string"}{...}
{viewerjumpto "Syntax" "mf_strlen##syntax"}{...}
{viewerjumpto "Description" "mf_strlen##description"}{...}
{viewerjumpto "Remarks" "mf_strlen##remarks"}{...}
{viewerjumpto "Conformability" "mf_strlen##conformability"}{...}
{viewerjumpto "Diagnostics" "mf_strlen##diagnostics"}{...}
{viewerjumpto "Source code" "mf_strlen##source"}{...}
{title:Title}

{p 4 8 2}
{manlink M-5 strlen()} {hline 2} Length of string


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:real matrix} {cmd:strlen(}{it:string matrix s}{cmd:)}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:strlen(}{it:s}{cmd:)} returns the length of -- the number of characters 
contained in -- the string {it:s}.

{p 4 4 2}
When {it:s} is not a scalar, {cmd:strlen()} returns element-by-element
results.


{marker remarks}{...}
{title:Remarks}

{p 4 4 2}
Stata understands {cmd:strlen()} as a synonym for its own
{helpb length()} function, so you can use the function named {cmd:strlen()} in
both your Stata and Mata code.  Do not, however, use {helpb mf_length:length()}
in Mata when you mean {cmd:strlen()}.  Mata's {cmd:length()} function returns
the length (number of elements) of a vector.


{marker conformability}{...}
{title:Conformability}

    {cmd:strlen(}{it:s}{cmd:)}:
	{it:s}:  {it:r x c}
   {it:result}:  {it:r x c}


{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:strlen(}{it:s}{cmd:)}, when {it:s} is a binary string (a string
containing binary 0), returns the overall length of the string, not the
location of the binary 0.  Use {cmd:strpos(}{it:s}{cmd:, char(0))} if you want
the location of the binary 0; see {helpb mf_strpos:[M-5] strpos()}.


{marker source}{...}
{title:Source code}

{p 4 4 2}
Function is built in.
{p_end}
