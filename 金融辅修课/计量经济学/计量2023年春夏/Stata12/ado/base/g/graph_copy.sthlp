{smcl}
{* *! version 1.1.3  11feb2011}{...}
{viewerdialog "graph copy" "dialog graph_copy"}{...}
{vieweralsosee "[G-2] graph copy" "mansection G-2 graphcopy"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[G-2] graph manipulation" "help graph_manipulation"}{...}
{vieweralsosee "[G-2] graph rename" "help graph_rename"}{...}
{viewerjumpto "Syntax" "graph_copy##syntax"}{...}
{viewerjumpto "Description" "graph_copy##description"}{...}
{viewerjumpto "Option" "graph_copy##option"}{...}
{viewerjumpto "Remarks" "graph_copy##remarks"}{...}
{title:Title}

{p2colset 5 25 27 2}{...}
{p2col :{manlink G-2 graph copy} {hline 2}}Copy graph in memory{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 23 2}
{cmdab:gr:aph}
{cmd:copy}
[{it:oldname}]
{it:newname}
[{cmd:,}
{cmd:replace}]

{pstd}
If {it:oldname} is not specified, the name of the current graph is assumed.


{title:Menu}

{phang}
{bf:Graphics > Manage graphs > Copy graph in memory}


{marker description}{...}
{title:Description}

{pstd}
{cmd:graph} {cmd:copy} makes a copy of a graph stored in memory under a new
name.


{marker option}{...}
{title:Option}

{phang}
{cmd:replace}
    specifies that it is okay to replace {it:newname}, if it already
    exists.


{marker remarks}{...}
{title:Remarks}

{pstd}
See {manhelp graph_manipulation G-2:graph manipulation} for an introduction to
the graph manipulation commands.

{pstd}
{cmd:graph} {cmd:copy} is rarely used.
Perhaps you have a graph displayed in the Graph window (known as the
current graph), and you wish to experiment with changing its aspect ratio or
scheme using the {cmd:graph} {cmd:display} command.  Before starting your
experiments, you make a copy of the original:

	{cmd:. graph copy backup}

	{cmd:. graph display} ...
