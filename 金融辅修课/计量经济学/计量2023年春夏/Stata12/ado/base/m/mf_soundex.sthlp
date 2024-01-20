{smcl}
{* *! version 1.1.3  11feb2011}{...}
{vieweralsosee "[M-5] soundex()" "mansection M-5 soundex()"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-4] string" "help m4_string"}{...}
{viewerjumpto "Syntax" "mf_soundex##syntax"}{...}
{viewerjumpto "Description" "mf_soundex##description"}{...}
{viewerjumpto "Remarks" "mf_soundex##remarks"}{...}
{viewerjumpto "Conformability" "mf_soundex##conformability"}{...}
{viewerjumpto "Diagnostics" "mf_soundex##diagnostics"}{...}
{viewerjumpto "Source code" "mf_soundex##source"}{...}
{title:Title}

{p 4 8 2}
{manlink M-5 soundex()} {hline 2} Convert string to soundex code


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:string matrix} {bind:     }{cmd:soundex(}{it:string matrix s}{cmd:)}

{p 8 12 2}
{it:string matrix} {cmd:soundex_nara(}{it:string matrix s}{cmd:)}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:soundex(}{it:s}{cmd:)} returns the soundex code for a string, {it:s}. 
The soundex code consists of a letter followed by three numbers: the letter is
the first letter of the name and the numbers encode the remaining consonants.
Similar sounding consonants are encoded by the same number.

{p 4 4 2}
{cmd:soundex_nara(}{it:s}{cmd:)} returns the U.S. Census soundex code 
for a string, {it:s}.  The soundex code consists of a letter followed by three 
numbers: the letter is the first letter of the name and the numbers 
encode the remaining consonants.  Similar sounding consonants are encoded 
by the same number.

{p 4 4 2}
When {it:s} is not a scalar, these functions return element-by-element results.


{marker remarks}{...}
{title:Remarks}

{p 4 4 2}
{cmd:soundex("Ashcraft")} returns {cmd:"A226"}.

{p 4 4 2}
{cmd:soundex_nara("Ashcraft")} returns {cmd:"A261"}.


{marker conformability}{...}
{title:Conformability}

{p 4 4 2}
{cmd:soundex(}{it:s}{cmd:)},
{cmd:soundex_nara(}{it:s}{cmd:)}:
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
