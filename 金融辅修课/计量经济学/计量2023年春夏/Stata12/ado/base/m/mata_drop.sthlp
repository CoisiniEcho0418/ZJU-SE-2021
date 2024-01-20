{smcl}
{* *! version 1.1.1  11feb2011}{...}
{vieweralsosee "[M-3] mata drop" "mansection M-3 matadrop"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-3] mata clear" "help mata_clear"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-3] intro" "help m3_intro"}{...}
{viewerjumpto "Syntax" "mata_drop##syntax"}{...}
{viewerjumpto "Description" "mata_drop##description"}{...}
{viewerjumpto "Remarks" "mata_drop##remarks"}{...}
{title:Title}

{phang}
{manlink M-3 mata drop} {hline 2} Drop matrix or function


{marker syntax}{...}
{title:Syntax}

{p 8 16 2}
: {cmd:mata} {cmd:drop}
{it:namelist}


{p 4 4 2}
where {it:namelist} is as defined in 
{bf:{help m3_namelists:[M-3] namelists}}.

{p 4 4 2}
This command is for use in Mata mode following Mata's colon prompt.
To use this command from Stata's dot prompt, type

		. {cmd:mata: mata drop} ...


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:mata} {cmd:drop} 
clears from memory the specified matrices and functions.


{marker remarks}{...}
{title:Remarks}

{p 4 4 2}
Use {cmd:mata describe} (see {bf:{help mata_describe:[M-3] mata describe}})
to determine what is in memory.  
Use {cmd:mata clear} (see {bf:{help mata_clear:[M-3] mata clear}})
to drop all matrices and functions, or use Stata's {cmd:clear mata} command
(see {bf:{help clear:[D] clear}}).

{p 4 4 2}
To drop a matrix named {cmd:A}, type 

	: {cmd:mata drop A}

{p 4 4 2}
To drop a function named {cmd:foo()}, type 

	: {cmd:mata drop foo()}

{p 4 4 2}
To drop a matrix named {cmd:A} and a function named {cmd:foo()}, type 

	: {cmd:mata drop A foo()}
