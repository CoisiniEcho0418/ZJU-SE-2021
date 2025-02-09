{smcl}
{* *! version 1.1.3  11feb2011}{...}
{vieweralsosee "[D] rmdir" "mansection D rmdir"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[D] cd" "help cd"}{...}
{vieweralsosee "[D] copy" "help copy"}{...}
{vieweralsosee "[D] dir" "help dir"}{...}
{vieweralsosee "[D] erase" "help erase"}{...}
{vieweralsosee "[D] mkdir" "help mkdir"}{...}
{vieweralsosee "[D] shell" "help shell"}{...}
{vieweralsosee "[D] type" "help type"}{...}
{viewerjumpto "Syntax" "rmdir##syntax"}{...}
{viewerjumpto "Description" "rmdir##description"}{...}
{viewerjumpto "Examples" "rmdir##examples"}{...}
{title:Title}

{p 4 15 2}
{manlink D rmdir} {hline 2} Remove directory


{marker syntax}{...}
{title:Syntax}

{p 8 13 2}{cmd:rmdir} {it:directory_name}


{pstd}
Double quotes may be used to enclose the directory name, and the quotes
must be used if the directory name contains embedded blanks.


{marker description}{...}
{title:Description}

{pstd}{cmd:rmdir} removes an empty directory (folder).


{marker examples}{...}
{title:Examples}

{pstd}Stata for Windows:

{phang2}{cmd:. rmdir myproj}{p_end}
{phang2}{cmd:. rmdir c:\projects\myproj}{p_end}
{phang2}{cmd:. rmdir "c:\My Projects\Project 1"}

{pstd}Stata for Mac and Unix:

{phang2}{cmd:. rmdir myproj}{p_end}
{phang2}{cmd:. rmdir ~/projects/myproj}{p_end}
