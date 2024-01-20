{smcl}
{* *! version 1.1.3  11feb2011}{...}
{vieweralsosee "[G-4] relativesize" "mansection G-4 relativesize"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[G-4] markersizestyle" "help markersizestyle"}{...}
{vieweralsosee "[G-4] textsizestyle" "help textsizestyle"}{...}
{viewerjumpto "Syntax" "relativesize##syntax"}{...}
{viewerjumpto "Description" "relativesize##description"}{...}
{viewerjumpto "Remarks" "relativesize##remarks"}{...}
{title:Title}

{p2colset 5 27 29 2}{...}
{p2col :{manlinki G-4 relativesize} {hline 2}}Choices for sizes of objects{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{synoptset 20}{...}
{p2col:{it:relativesize}}Description{p_end}
{p2line}
{p2col:{it:#}}specify size;
	size 100 = minimum of width and height of graph;
	{it:#} must be >= 0, depending on context{p_end}

{p2col:{cmd:*}{it:#}}specify size change via multiplication;
	{cmd:*1} means no change, {cmd:*2} twice as large, {cmd:*.5} half;
	{it:#} must be >= 0, depending on context{p_end}
{p2line}
{p 4 6 2}
Negative sizes are allowed in certain contexts, such as for gaps;
in other cases, such as the size of symbol, the size must be nonnegative, and
negative sizes, if specified, are ignored.

{phang}
Examples:{break}

{p2col:{it:example}}Description{p_end}
{p2line}
{p2col:{cmd:msize(2)}}make marker diameter 2% of {it:g}{p_end}
{p2col:{cmd:msize(1.5)}}make marker diameter 1.5% of {it:g}{p_end}
{p2col:{cmd:msize(.5)}}make marker diameter .5% of {it:g}{p_end}
{p2col:{cmd:msize(*2)}}make marker size twice as large as default{p_end}
{p2col:{cmd:msize(*1.5)}}make marker size 1.5 times as large as default{p_end}
{p2col:{cmd:msize(*.5)}}make marker size half as large as default{p_end}

{p2col:{cmd:xsca(titlegap(2))}}make gap 2% of {it:g}{p_end}
{p2col:{cmd:xsca(titlegap(.5))}}make gap .5% of {it:g}{p_end}
{p2col:{cmd:xsca(titlegap(-2))}}make gap -2% of {it:g}{p_end}
{p2col:{cmd:xsca(titlegap(-.5))}}make gap -.5% of {it:g}{p_end}
{p2col:{cmd:xsca(titlegap(*2))}}make gap twice as large as default{p_end}
{p2col:{cmd:xsca(titlegap(*.5))}}make gap half as large as default{p_end}
{p2col:{cmd:xsca(titlegap(*-2))}}make gap -2 times as large as default{p_end}
{p2col:{cmd:xsca(titlegap(*-.5))}}make gap -.5 times as large as default{p_end}
{p2line}
{p2colreset}{...}
{p 4 6 2}
where {it:g} = min(width of graph, height of graph)


{marker description}{...}
{title:Description}

{pstd}
A {it:relativesize} specifies a size relative to the graph (or subgraph) being
drawn.  Thus as the size of the graph changes, so does the size of the
object.


{marker remarks}{...}
{title:Remarks}

{pstd}
{it:relativesize} is allowed, for instance, as a {it:textsizestyle} or
a {it:markersizestyle} -- see {manhelpi textsizestyle G-4} and
{manhelpi markersizestyle G-4} -- and as the size of many other things, as
well.

{pstd}
Relative sizes are not restricted to being integers; relative
sizes of .5, 1.25, 15.1, etc., are allowed.
{p_end}
