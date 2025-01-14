{smcl}
{* *! version 1.1.4  11feb2011}{...}
{viewerdialog "graph drop" "dialog graph_drop"}{...}
{vieweralsosee "[G-2] graph drop" "mansection G-2 graphdrop"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[G-2] graph manipulation" "help graph_manipulation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[P] discard" "help discard"}{...}
{vieweralsosee "[D] erase" "help erase"}{...}
{viewerjumpto "Syntax" "graph_drop##syntax"}{...}
{viewerjumpto "Description" "graph_drop##description"}{...}
{viewerjumpto "Remarks" "graph_drop##remarks"}{...}
{title:Title}

{p2colset 5 25 27 2}{...}
{p2col :{manlink G-2 graph drop} {hline 2}}Drop graphs from memory{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 23 2}
{cmdab:gr:aph}
{cmd:drop}
{it:name}
[{it:name} ...]

{p 8 23 2}
{cmdab:gr:aph}
{cmd:drop}
{cmd:_all}


{title:Menu}

{phang}
{bf:Graphics > Manage graphs > Drop graphs}


{marker description}{...}
{title:Description}

{pstd}
{cmd:graph drop} {it:name} drops (discards) the specified
graphs from memory and closes any associated graph windows.

{pstd}
{cmd:graph} {cmd:drop} {cmd:_all} drops all graphs from memory and closes all
associated graph windows.


{marker remarks}{...}
{title:Remarks}

{pstd}
See {manhelp graph_manipulation G-2:graph manipulation} for an introduction to
the graph manipulation commands.

{pstd}
Remarks are presented under the following headings:

	{help graph drop##remarks1:Typical use}
	{help graph drop##remarks2:Relationship between graph drop _all and discard}
	{help graph drop##remarks3:Erasing graphs on disk}


{marker remarks1}{...}
{title:Typical use}

{pstd}
Graphs contain the data they display, so when datasets are large, graphs can
consume much memory.  {cmd:graph} {cmd:drop} frees that memory.  {cmd:Graph}
is the name of a graph when you do not specify otherwise.

{phang2}
	{cmd:. graph twoway scatter faminc educ, ms(p)}

	{cmd:.} ...

	{cmd:. graph drop Graph}

{pstd}
We often use graphs in memory to prepare the pieces for {cmd:graph}
{cmd:combine}:

	{cmd:. graph} ... {cmd:,} ... {cmd:name(p1)}

	{cmd:. graph} ... {cmd:,} ... {cmd:name(p2)}

	{cmd:. graph} ... {cmd:,} ... {cmd:name(p3)}

{phang2}
	{cmd:. graph combine p1 p2 p3,} ... {cmd:saving(result, replace)}

	{cmd:. graph drop _all}


{marker remarks2}{...}
{title:Relationship between graph drop _all and discard}

{pstd}
The {cmd:discard} command performs {cmd:graph} {cmd:drop} {cmd:_all} and
more:

{phang2}
    1.  {cmd:discard} eliminates prior estimation results and
	automatically loaded programs and thereby frees even more memory.

{phang2}
    2.  {cmd:discard} closes any open dialog boxes and thereby frees
	even more memory.

{pstd}
We nearly always type {cmd:discard} in preference to {cmd:graph}
{cmd:drop} {cmd:_all} if only because {cmd:discard} has fewer characters.
The exception to that is when we have fit a model and still
plan on redisplaying prior results, performing tests on that model,
or referring to {cmd:_b[]}, {cmd:_se[]}, etc.

{pstd}
See {manhelp discard P} for a description of the {cmd:discard} command.


{marker remarks3}{...}
{title:Erasing graphs on disk}

{pstd}
{cmd:graph} {cmd:drop} is not used to erase {cmd:.gph} files; instead, use
Stata's standard {cmd:erase} command:

	{cmd:. erase matfile.gph}
