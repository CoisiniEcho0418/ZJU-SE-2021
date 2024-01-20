{smcl}
{* *! version 1.1.4  11feb2011}{...}
{vieweralsosee "[G-2] set graphics" "mansection G-2 setgraphics"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[G-3] nodraw_option" "help nodraw_option"}{...}
{viewerjumpto "Syntax" "set_graphics##syntax"}{...}
{viewerjumpto "Description" "set_graphics##description"}{...}
{viewerjumpto "Remarks" "set_graphics##remarks"}{...}
{title:Title}

{p2colset 5 27 29 2}{...}
{p2col :{manlink G-2 set graphics} {hline 2}}Set whether graphs are displayed{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 16 2}
{cmdab:q:uery}
{cmdab:graph:ics}

{p 8 16 2}
{cmd:set}
{cmdab:g:raphics}
{c -(}{cmd:on} | {cmd:off}{c )-}


{marker description}{...}
{title:Description}

{pstd}
{cmd:query} {cmd:graphics} shows the graphics settings.

{pstd}
{cmd:set} {cmd:graphics} allows you to change whether graphs are
displayed.


{marker remarks}{...}
{title:Remarks}

{pstd}
If you type

	{cmd:. set graphics off}

{pstd}
when you type a {cmd:graph} command, such as

	{cmd:. scatter yvar xvar, saving(mygraph)}

{pstd}
the graph will be "drawn" and saved in file {cmd:mygraph.gph}, but it will not
be displayed.  If you type

	{cmd:. set graphics on}

{pstd}
graphs will be displayed once again.

{pstd}
Drawing graphs without displaying them is sometimes useful in programming
contexts, although in such contexts, it is better to specify the {cmd:nodraw}
option; see {manhelpi nodraw_option G-3}.  Typing

	{cmd:. scatter yvar xvar, saving(mygraph) nodraw}

{pstd}
has the same effect as typing

	{cmd:. set graphics off}
	{cmd:. scatter yvar xvar, saving(mygraph)}
	{cmd:. set graphics on}

{pstd}
The advantage of the former is not only does it require less typing, but if
the user should press {hi:Break}, {cmd:set} {cmd:graphics} will not be left
{cmd:off}.
{p_end}
