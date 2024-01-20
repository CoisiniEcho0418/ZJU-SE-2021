{smcl}
{* *! version 1.1.3  22mar2011}{...}
{vieweralsosee "[P] plugin" "mansection P plugin"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-0] mata" "help mata"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[P] automation" "help automation"}{...}
{vieweralsosee "[P] program" "help program"}{...}
{viewerjumpto "Syntax" "plugin##syntax"}{...}
{viewerjumpto "Description" "plugin##description"}{...}
{viewerjumpto "Options" "plugin##options"}{...}
{viewerjumpto "Remarks" "plugin##remarks"}{...}
{title:Title}

{p2colset 5 19 21 2}{...}
{p2col :{manlink P plugin} {hline 2}}Load a plugin{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 16 2}
{cmdab:pr:ogram} {it:handle} , {cmdab:plug:in}
           [{cmd:using(}{it:filespec}{cmd:)}]


{marker description}{...}
{title:Description}

{pstd}
In addition to using ado-files and Mata, you can add new commands to Stata
by using the C language by following a set of programming conventions and
dynamically linking your compiled library into Stata.  The {cmd:program}
command with the {cmd:plugin} option finds plugins and loads (dynamically
links) them into Stata.


{marker options}{...}
{title:Options}

{phang}
{opt plugin} specifies that plugins be found and loaded into Stata.

{phang}
{opt using(filespec)} specifies a file, {it:filespec}, containing the plugin.
If you do not specify {cmd:using()}, {cmd:program} assumes that the file is
named {it:handle}{cmd:.plugin} and can be found along the
{help adopath:ado-path}.


{marker remarks}{...}
{title:Remarks}

{pstd}
Plugins are most useful for methods that require the greatest possible speed
and involve heavy looping, recursion, or other computationally demanding
approaches.  They may also be useful if you have a solution that is already
programmed in C.

{pstd}
For complete documentation on plugin programming and loading compiled programs
into Stata, see

{pin}
      {browse "http://www.stata.com/plugins/"}
{p_end}
