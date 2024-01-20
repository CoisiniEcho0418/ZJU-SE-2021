{smcl}
{* *! version 1.1.2  11feb2011}{...}
{vieweralsosee "[M-1] help" "mansection M-1 help"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] help" "help help"} {...}
{vieweralsosee "[M-3] mata help" "help mata_help"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-1] intro" "help m1_intro"}{...}
{viewerjumpto "Syntax" "m1_help##syntax"}{...}
{viewerjumpto "Description" "m1_help##description"}{...}
{viewerjumpto "Remarks" "m1_help##remarks"}{...}
{title:Title}

{phang}
{manlink M-1 help} {hline 2} Obtaining online help


{marker syntax}{...}
{title:Syntax}

{phang2}
{cmd:help} {cmd:m}{it:#}{bind:   }{it:entryname}

{phang2}
{cmd:help} {cmd:mata} {it:functionname}{cmd:()}


{pstd}
The {cmd:help} command may be issued at either Stata's dot prompt or 
Mata's colon prompt.


{marker description}{...}
{title:Description}

{pstd}
Help for Mata is available online in Stata.  This entry describes how 
to access it.


{marker remarks}{...}
{title:Remarks}

{pstd}
To see this entry online, type 

	. {cmd:help m1 help}

{pstd}
at Stata's dot prompt or Mata's colon prompt.  
You type that because this entry is {bf:[M-1] help}.

{pstd}
To see the entry for function {cmd:max()}, for example, type

	. {cmd:help mata max()}

{pstd}
{cmd:max()} is documented in 
{bf:{help mf_minmax:[M-5] minmax()}}, but that will not matter; Stata will 
find the appropriate entry.

{pstd}
To enter the Mata help system from the top, from whence you can click your
way to any section or function, type 

	. {cmd:help mata}

{pstd}
To access Mata's PDF manual, click on the title.
{p_end}
