{smcl}
{* *! version 1.1.3  11feb2011}{...}
{vieweralsosee "[G-2] palette" "mansection G-2 palette"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[G-2] graph" "help graph"}{...}
{vieweralsosee "[G-2] graph query" "help graph_query"}{...}
{viewerjumpto "Syntax" "palette##syntax"}{...}
{viewerjumpto "Description" "palette##description"}{...}
{viewerjumpto "Options" "palette##options"}{...}
{viewerjumpto "Remarks" "palette##remarks"}{...}
{title:Title}

{p2colset 5 22 24 2}{...}
{p2col :{manlink G-2 palette} {hline 2}}Display palettes of available selections{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 16 2}
{cmd:palette}
{cmd:color}
{it:{help colorstyle}}
[{it:{help colorstyle}}]
[{cmd:,}
{helpb scheme_option:{ul:sch}eme({it:schemename})}
{cmd:cmyk}]

{p 8 16 2}
{cmd:palette}
{cmdab:line:palette}
[{cmd:,}
{helpb scheme_option:{ul:sch}eme({it:schemename})}]

{p 8 16 2}
{cmd:palette}
{cmdab:symbol:palette}
[{cmd:,}
{helpb scheme_option:{ul:sch}eme({it:schemename})}]


{marker description}{...}
{title:Description}

{pstd}
{cmd:palette} produces graphs showing various selections available.

{pstd}
{cmd:palette} {cmd:color} shows how a particular color looks and allows
you to compare two colors; see {manhelpi colorstyle G-4}.

{pstd}
{cmd:palette} {cmd:linepalette} shows you the different
{it:linepatternstyles}; see {manhelpi linepatternstyle G-4}.

{pstd}
{cmd:palette} {cmd:symbolpalette} shows you the different
{it:symbolstyles}; see {manhelpi symbolstyle G-4}.


{marker options}{...}
{title:Options}

{phang}
{cmd:scheme(}{it:schemename}{cmd:)}
     specifies the scheme to be used to draw the graph.  With this command,
     {cmd:scheme()} is rarely specified.
     We recommend specifying {cmd:scheme(color)} if you plan to print the
     graph on a color printer; see {manhelpi scheme_option G-3}.

{phang}
{cmd:cmyk} specifies that the color value be reported in CMYK rather than in 
RGB; see {manhelpi colorstyle G-4}.


{marker remarks}{...}
{title:Remarks}

{pstd}
The {cmd:palette} command is more a part of the documentation of {cmd:graph}
than a useful command in its own right.
{p_end}
