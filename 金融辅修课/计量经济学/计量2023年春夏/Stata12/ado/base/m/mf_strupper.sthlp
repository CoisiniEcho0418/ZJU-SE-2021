{smcl}
{* *! version 1.1.2  11feb2011}{...}
{vieweralsosee "[M-5] strupper()" "mansection M-5 strupper()"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-4] string" "help m4_string"}{...}
{viewerjumpto "Syntax" "mf_strupper##syntax"}{...}
{viewerjumpto "Description" "mf_strupper##description"}{...}
{viewerjumpto "Remarks" "mf_strupper##remarks"}{...}
{viewerjumpto "Conformability" "mf_strupper##conformability"}{...}
{viewerjumpto "Diagnostics" "mf_strupper##diagnostics"}{...}
{viewerjumpto "Source code" "mf_strupper##source"}{...}
{title:Title}

{p 4 8 2}
{manlink M-5 strupper()} {hline 2} Convert string to uppercase (lowercase)


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:string matrix} {cmd:strupper(}{it:string matrix s}{cmd:)}

{p 8 12 2}
{it:string matrix} {cmd:strlower(}{it:string matrix s}{cmd:)}

{p 8 12 2}
{it:string matrix} {cmd:strproper(}{it:string matrix s}{cmd:)}



{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:strupper(}{it:s}{cmd:)} returns {it:s}, converted to uppercase.

{p 4 4 2}
{cmd:strlower(}{it:s}{cmd:)} returns {it:s}, converted to lowercase.

{p 4 4 2}
{cmd:strproper(}{it:s}{cmd:)} returns a string with the first letter capitalized
and any other letters capitalized that immediately follow characters that are
not letters; all other letters are converted to lowercase.

{p 4 4 2}
When {it:s} is not a scalar, these functions return element-by-element
results.


{marker remarks}{...}
{title:Remarks}

{p 4 4 2}
{cmd:strproper("mR. joHn a. sMitH")} returns "Mr. John A. Smith".

{p 4 4 2}
{cmd:strproper("jack o'reilly")} returns "Jack O'Reilly".

{p 4 4 2}
{cmd:strproper("2-cent's worth")} returns "2-Cent'S Worth".

{p 4 4 2}
Also, Stata understands 
{cmd:strupper()}, {cmd:strlower()}, and {cmd:strproper()} as
synonyms for its own 
{helpb upper()}, {helpb lower()}, and {helpb proper()} functions, so you can 
use the {cmd:str*()} names in both your Stata and Mata code.


{marker conformability}{...}
{title:Conformability}

{p 4 4 2}
{cmd:strupper(}{it:s}{cmd:)},
{cmd:strlower(}{it:s}{cmd:)},
{cmd:strproper(}{it:s}{cmd:)}:
{p_end}
	    {it:s}:  {it:r x c}
       {it:result}:  {it:r x c}


{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
None.


{marker source}{...}
{title:Source code}

{p 4 4 2}
Functions are built in.
{p_end}
