{smcl}
{* *! version 1.1.1  11feb2011}{...}
{vieweralsosee "[M-5] _fillmissing()" "mansection M-5 _fillmissing()"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-4] manipulation" "help m4_manipulation"}{...}
{viewerjumpto "Syntax" "mf__fillmissing##syntax"}{...}
{viewerjumpto "Description" "mf__fillmissing##description"}{...}
{viewerjumpto "Remarks" "mf__fillmissing##remarks"}{...}
{viewerjumpto "Conformability" "mf__fillmissing##conformability"}{...}
{viewerjumpto "Diagnostics" "mf__fillmissing##diagnostics"}{...}
{viewerjumpto "Source code" "mf__fillmissing##source"}{...}
{title:Title}

{p 4 8 2}
{manlink M-5 _fillmissing()} {hline 2} Fill matrix with missing values


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:void}
{cmd:_fillmissing(}{it:transmorphic matrix A}{cmd:)}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:_fillmissing(}{it:transmorphic matrix A}{cmd:)}
changes the contents of {it:A} to missing values.


{marker remarks}{...}
{title:Remarks}

{p 4 4 2}
The definition of missing depends on the storage type of {it:A}:

		Storage type           Contents
		{hline 31}
		real                     {cmd:.}
		complex                  {cmd:C(.)}
		string                   {cmd:""}
		pointer                  {cmd:NULL}
		{hline 31}


{marker conformability}{...}
{title:Conformability}

    {cmd:_fillmissing(}{it:A}{cmd:)}:
	{it:input:}
		{it:A}:  {it:r x c}
	{it:output:}
		{it:A}:  {it:r x c}

{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
None.


{marker source}{...}
{title:Source code}

{p 4 4 2}
Function is built in.
{p_end}
