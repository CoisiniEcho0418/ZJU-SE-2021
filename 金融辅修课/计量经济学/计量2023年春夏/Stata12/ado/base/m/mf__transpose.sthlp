{smcl}
{* *! version 1.1.2  11feb2011}{...}
{vieweralsosee "[M-5] _transpose()" "mansection M-5 _transpose()"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-2] op_transpose" "help m2_op_transpose"}{...}
{vieweralsosee "[M-5] conj()" "help mf_conj"}{...}
{vieweralsosee "[M-5] transposeonly()" "help mf_transposeonly"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-4] manipulation" "help m4_manipulation"}{...}
{viewerjumpto "Syntax" "mf__transpose##syntax"}{...}
{viewerjumpto "Description" "mf__transpose##description"}{...}
{viewerjumpto "Remarks" "mf__transpose##remarks"}{...}
{viewerjumpto "Conformability" "mf__transpose##conformability"}{...}
{viewerjumpto "Diagnostics" "mf__transpose##diagnostics"}{...}
{viewerjumpto "Source code" "mf__transpose##source"}{...}
{title:Title}

{p 4 8 2}
{manlink M-5 _transpose()} {hline 2} Transposition in place


{marker syntax}{...}
{title:Syntax}

{p 8 8 2}
{it:void}
{cmd:_transpose(}{it:numeric matrix} {it:A}{cmd:)}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:_transpose(}{it:A}{cmd:)} replaces {it:A} with {it:A}{bf:'}.  Coding
{cmd:_transpose(}{it:A}{cmd:)} is equivalent to coding 
{bind:{it:A} {cmd:=} {it:A}{cmd:'}}, except that execution can take a little
longer and less memory is used.
When {it:A} is complex, {it:A} is replaced with its conjugate transpose;
see {bf:{help mf_transposeonly:[M-5] transposeonly()}} if transposition
without conjugation is desired.


{marker remarks}{...}
{title:Remarks}

{p 4 4 2}
In some calculation, you need {it:A}{bf:'} 

		{it:X} = ... {it:calculation using A}{bf:'} ...

{p 4 4 2}
If {it:A} is large, you can save considerable memory by coding 

		{cmd:_transpose(}{it:A}{cmd:)}
		{it:X} = ... {it:calculation using A} ...
		{cmd:_transpose(}{it:A}{cmd:)}


{marker conformability}{...}
{title:Conformability}

    {cmd:_transpose(}{it:A}{cmd:)}:
	{it:input:}
		{it:A}:  {it:r x c}
	{it:output:}
		{it:A}:  {it:c x r}


{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:_transpose(}{it:A}{cmd:)}
aborts with error if {it:A} is a view.


{marker source}{...}
{title:Source code}

{pstd}
Function is built in.
{p_end}
