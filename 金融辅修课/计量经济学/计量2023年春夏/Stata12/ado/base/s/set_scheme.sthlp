{smcl}
{* *! version 1.1.3  11feb2011}{...}
{vieweralsosee "[G-2] set scheme" "mansection G-2 setscheme"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[G-3] scheme_option" "help scheme_option"}{...}
{vieweralsosee "[G-4] schemes intro" "help schemes"}{...}
{viewerjumpto "Syntax" "set_scheme##syntax"}{...}
{viewerjumpto "Description" "set_scheme##description"}{...}
{viewerjumpto "Option" "set_scheme##option"}{...}
{viewerjumpto "Remarks" "set_scheme##remarks"}{...}
{title:Title}

{p2colset 5 25 27 2}{...}
{p2col :{manlink G-2 set scheme} {hline 2}}Set default scheme{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 16 2}
{cmdab:q:uery}
{cmdab:graph:ics}

{p 8 16 2}
{cmd:set}
{cmd:scheme}
{it:{help schemes intro:schemename}}
[{cmd:,} {cmdab:perm:anently}]


{marker description}{...}
{title:Description}

{pstd}
{cmd:query} {cmd:graphics} shows the graphics settings, which includes
the graphics scheme.

{pstd}
{cmd:set} {cmd:scheme} allows you to set the graphics scheme to be used.
The default setting is {cmd:s2color}.


{marker option}{...}
{title:Option}

{phang}
{cmd:permanently}
specifies that in addition to making the change right now,
the {cmd:scheme} setting be remembered and become the default setting when you
invoke Stata.


{marker remarks}{...}
{title:Remarks}

{pstd}
The graphics scheme specifies the overall look for the graph.
You can specify the scheme to be used for an individual graph
by specifying the {cmd:scheme()} option on the {cmd:graph} command,
or you can specify the scheme once and for all by using
{cmd:set scheme}.

{pstd}
See {manhelp schemes G-4:schemes_intro} for a description of schemes and a list
of available {it:schemenames}.

{pstd}
One of the available {it:schemenames} is {cmd:economist}, which roughly
corresponds to the style used by {it:The Economist} magazine.
If you wanted to make the {cmd:economist} scheme the default for the rest of
this session, you could type

	{cmd:. set scheme economist}

{pstd}
and if you wanted to make {cmd:economist} your default, even in subsequent
sessions, you could type

	{cmd:. set scheme economist, permanently}
