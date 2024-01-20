{smcl}
{* *! version 1.1.4  11feb2011}{...}
{vieweralsosee "[G-3] scheme_option" "mansection G-3 scheme_option"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[G-2] set scheme" "help set_scheme"}{...}
{vieweralsosee "[G-4] schemes intro" "help schemes"}{...}
{viewerjumpto "Syntax" "scheme_option##syntax"}{...}
{viewerjumpto "Description" "scheme_option##description"}{...}
{viewerjumpto "Option" "scheme_option##option"}{...}
{viewerjumpto "Remarks" "scheme_option##remarks"}{...}
{title:Title}

{p2colset 5 28 30 2}{...}
{p2col :{manlinki G-3 scheme_option} {hline 2}}Option for specifying scheme{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{synoptset 20}{...}
{p2col:{it:scheme_option}}Description{p_end}
{p2line}
{p2col:{cmdab:sch:eme:(}{it:{help scheme intro:schemename}}{cmd:)}}specify scheme to be used{p_end}
{p2line}
{p2colreset}{...}
{p 4 6 2}
{cmd:scheme()} is {it:unique}; see {help repeated options}.


{marker description}{...}
{title:Description}

{pstd}
Option {cmd:scheme()} specifies the graphics scheme to be used.
The scheme specifies the overall look of the graph.


{marker option}{...}
{title:Option}

{phang}
{cmd:scheme(}{it:schemename}{cmd:)} specifies the scheme to be used.  If
{cmd:scheme()} is not specified the default scheme is used; see
{manhelp schemes G-4:schemes intro}.


{marker remarks}{...}
{title:Remarks}

{pstd}
See {manhelp schemes G-4:schemes intro}.
{p_end}
