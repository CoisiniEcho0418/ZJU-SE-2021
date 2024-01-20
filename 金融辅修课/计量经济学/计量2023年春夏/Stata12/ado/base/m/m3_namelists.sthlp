{smcl}
{* *! version 1.1.2  21apr2011}{...}
{vieweralsosee "[M-3] namelists" "mansection M-3 namelists"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-3] intro" "help m3_intro"}{...}
{viewerjumpto "Syntax" "m3_namelists##syntax"}{...}
{viewerjumpto "Description" "m3_namelists##description"}{...}
{viewerjumpto "Remarks" "m3_namelists##remarks"}{...}
{title:Title}

{phang}
{manlink M-3 namelists} {hline 2} Specifying matrix and function names


{marker syntax}{...}
{title:Syntax}

{p 4 4 2}
Many {cmd:mata} commands allow or require a {it:namelist}, such as


{p 8 16 2}
: {cmd:mata} {cmdab:d:escribe} 
[{it:namelist}] 
[{cmd:,} 
{cmd:all}]


{p 4 4 2}
A {it:namelist} is defined as a list of matrix and/or function names, such 
as

		{cmd:alpha beta foo()}

{p 4 4 2} 
The above {it:namelist} refers to the matrices {cmd:alpha} and {cmd:beta} 
along with the function named {cmd:foo()}.

{p 4 4 2}
Function names always end in {cmd:()}, hence

		{cmd:alpha}     refers to the matrix named {cmd:alpha}

		{cmd:alpha()}   refers to the function of the same name


{p 4 4 2}
Names may also be specified using the {cmd:*} and {cmd:?} wildcard
characters:

		{cmd:*}          means zero or more characters go here

                {cmd:?}          means exactly one character goes here

{p 4 4 2}
hence, 

		{cmd:*}          means all matrices
		{cmd:*()}        means all functions
		{cmd:* *()}      means all matrices and all functions

		{cmd:s*}         means all matrices that start with {it:s}
		{cmd:s*()}       means all functions that start with {it:s}

		{cmd:*e}         means all matrices that end with {it:e}
		{cmd:*e()}       means all functions that end with {it:e}

		{cmd:s*e}        means all matrices that start with {it:s} and end with {it:e}
		{cmd:s*e()}      means all functions that start with {it:s} and end with {it:e}

		{cmd:s?e}        means all matrices that start with {it:s} and end with {it:e}
				and have one character in between
		{cmd:s?e()}      means all functions that start with {it:s} and end with {it:e}
				and have one character in between


{marker description}{...}
{title:Description}

{p 4 4 2}
{it:Namelists} appear in syntax diagrams.  


{marker remarks}{...}
{title:Remarks}

{p 4 4 2}
Some {it:namelists} allow only matrices, and some allow only functions.
Even when only functions are allowed, you must include the {cmd:()} suffix.
{p_end}
