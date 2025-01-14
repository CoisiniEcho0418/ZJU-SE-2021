{smcl}
{* *! version 1.1.1  11feb2011}{...}
{vieweralsosee "[M-3] mata clear" "mansection M-3 mataclear"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-3] mata drop" "help mata_drop"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-3] intro" "help m3_intro"}{...}
{viewerjumpto "Syntax" "mata_clear##syntax"}{...}
{viewerjumpto "Description" "mata_clear##description"}{...}
{viewerjumpto "Remarks" "mata_clear##remarks"}{...}
{title:Title}

{phang}
{manlink M-3 mata clear} {hline 2} Clear Mata's memory


{marker syntax}{...}
{title:Syntax}

{p 8 16 2}
	: {cmd:mata clear}


{p 4 4 2}
This command is for use in Mata mode following Mata's colon prompt.
To use this command from Stata's dot prompt, type

		. {cmd:mata: mata clear}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:mata clear} clears Mata's memory, in effect resetting Mata.  All
functions, matrices, etc., are freed.


{marker remarks}{...}
{title:Remarks}

{p 4 4 2}
Stata can call Mata which can call Stata, which can call Mata, etc.
In such cases, {cmd:mata clear} releases only resources that are not in use
by prior invocations of Mata.

{p 4 4 2}
Stata's {cmd:clear all} command 
(see {bf:{help clear:[D] clear}})
performs a {cmd:mata clear}, among other
things. 

{p 4 4 2}
See {bf:{help mata_drop:[M-3] mata drop}} 
for clearing individual matrices or functions.
{p_end}
