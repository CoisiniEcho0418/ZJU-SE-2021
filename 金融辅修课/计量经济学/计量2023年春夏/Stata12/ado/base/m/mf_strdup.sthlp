{smcl}
{* *! version 1.1.1  11feb2011}{...}
{vieweralsosee "[M-5] strdup()" "mansection M-5 strdup()"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-4] string" "help m4_string"}{...}
{viewerjumpto "Syntax" "mf_strdup##syntax"}{...}
{viewerjumpto "Description" "mf_strdup##description"}{...}
{viewerjumpto "Conformability" "mf_strdup##conformability"}{...}
{viewerjumpto "Diagnostics" "mf_strdup##diagnostics"}{...}
{viewerjumpto "Source code" "mf_strdup##source"}{...}
{title:Title}

{p 4 8 2}
{manlink M-5 strdup()} {hline 2} String duplication


{marker syntax}{...}
{title:Syntax}

	{it:n} {cmd:*} {it:s}

	{it:s} {cmd:*} {it:n}

	{it:n} {cmd::*} {it:s}

	{it:s} {cmd::*} {it:n}


{p 4 4 2}
where {it:n} is real and {it:s} is string.


{marker description}{...}
{title:Description}

{p 4 4 2}
There is no {cmd:strdup()} function.  Instead, the multiplication operator is
used:  

	3*"example" = "exampleexampleexample"

	   0*"this" = ""


{marker conformability}{...}
{title:Conformability}

    {it:n}{cmd:*}{it:s}, {it:s}{cmd:*}{it:n}:
		{it:n}:  1 {it:x} 1
		{it:s}:  {it:r x c}
	   {it:result}:  {it:r x c}

    {it:n}{cmd::*}{it:s}, {it:s}{cmd::*}{it:n}:
		{it:n}:  {it:r1 x c1}
		{it:s}:  {it:r2 x c2}, {it:n} and {it:s} c-conformable
	   {it:result}:  max({it:r1},{it:r2}) {it:x} max({it:c1},{it:c2})


{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
If {it:n}<0, the result is as if {it:n}=0:  {cmd:""} is returned.

{p 4 4 2}
If {it:n} is not an integer, the result is as if
{cmd:trunc(}{it:n}{cmd:)} were specified.


{marker source}{...}
{title:Source code}

{p 4 4 2}
Function is built in.
{p_end}
