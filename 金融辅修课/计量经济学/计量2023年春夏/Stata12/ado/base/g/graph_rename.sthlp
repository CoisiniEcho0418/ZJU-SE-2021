{smcl}
{* *! version 1.1.4  27jun2011}{...}
{viewerdialog "graph rename" "dialog graph_rename"}{...}
{vieweralsosee "[G-2] graph rename" "mansection G-2 graphrename"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[G-2] graph manipulation" "help graph_manipulation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[G-2] graph copy" "help graph_copy"}{...}
{viewerjumpto "Syntax" "graph rename##syntax"}{...}
{viewerjumpto "Description" "graph rename##description"}{...}
{viewerjumpto "Option" "graph rename##option"}{...}
{viewerjumpto "Remarks" "graph rename##remarks"}{...}
{title:Title}

{p2colset 5 27 29 2}{...}
{p2col :{manlink G-2 graph rename} {hline 2}}Rename graph in memory{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 23 2}
{cmdab:gr:aph}
{cmd:rename}
[{it:oldname}]
{it:newname}
[{cmd:,}
{cmd:replace}]

{pstd}
If {it:oldname} is not specified, the name of the current graph is assumed.


{title:Menu}

{phang}
{bf:Graphics > Manage graphs > Rename graph in memory}


{marker description}{...}
{title:Description}

{pstd}
{cmd:graph} {cmd:rename} changes the name of a graph stored in memory.


{marker option}{...}
{title:Option}

{phang}
{cmd:replace}
    specifies that it is okay to replace {it:newname} if it already
    exists.


{marker remarks}{...}
{title:Remarks}

{pstd}
See {manhelp graph_manipulation G-2:graph manipulation} for an introduction to
the graph manipulation commands.

{pstd}
{cmd:graph} {cmd:rename} is most commonly used to rename the current
graph -- the graph currently displayed in the Graph window -- when
creating the pieces for {cmd:graph} {cmd:combine}:

	{cmd:. graph} ...{cmd:,} ...

	{cmd:. graph rename p1}

	{cmd:. graph} ...{cmd:,} ...

	{cmd:. graph rename p2}

	{cmd:. graph combine p1 p2,} ...
