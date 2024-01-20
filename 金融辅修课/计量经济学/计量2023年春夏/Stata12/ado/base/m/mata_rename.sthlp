{smcl}
{* *! version 1.1.1  11feb2011}{...}
{vieweralsosee "[M-3] mata rename" "mansection M-3 matarename"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-3] intro" "help m3_intro"}{...}
{viewerjumpto "Syntax" "mata_rename##syntax"}{...}
{viewerjumpto "Description" "mata_rename##description"}{...}
{title:Title}

{phang}
{manlink M-3 mata rename} {hline 2} Rename matrix or function


{marker syntax}{...}
{title:Syntax}

{p 8 16 2}
: {cmd:mata} {cmd:rename} 
{it:oldmatrixname} {it:newmatrixname}

{p 8 16 2}
: {cmd:mata} {cmd:rename} 
{it:oldfcnname}{cmd:()}{bind:  }{it:newfcnname}{cmd:()}


{p 4 4 2}
This command is for use in Mata mode following Mata's colon prompt.
To use this command from Stata's dot prompt, type

		. {cmd:mata: mata rename} ...


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:mata} {cmd:rename} changes the names of functions and global matrices.
{p_end}
