{smcl}
{* *! version 1.1.4  11feb2011}{...}
{vieweralsosee "[G-4] linepatternstyle" "mansection G-4 linepatternstyle"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[G-4] concept: lines" "help lines"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[G-4] colorstyle" "help colorstyle"}{...}
{vieweralsosee "[G-4] linestyle" "help linestyle"}{...}
{vieweralsosee "[G-4] linewidthstyle" "help linewidthstyle"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[G-4] connectstyle" "help connectstyle"}{...}
{viewerjumpto "Syntax" "linepatternstyle##syntax"}{...}
{viewerjumpto "Description" "linepatternstyle##description"}{...}
{viewerjumpto "Remarks" "linepatternstyle##remarks"}{...}
{title:Title}

{p2colset 5 31 33 2}{...}
{p2col :{manlinki G-4 linepatternstyle} {hline 2}}Choices for whether lines are solid, dashed, etc.{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{synoptset 20}{...}
{p2col:{it:linepatternstyle}}Description{p_end}
{p2line}
{p2col:{cmd:solid}}solid line{p_end}
{p2col:{cmd:dash}}dashed line{p_end}
{p2col:{cmd:dot}}dotted line{p_end}
{p2col:{cmd:dash_dot}}{p_end}
{p2col:{cmd:shortdash}}{p_end}
{p2col:{cmd:shortdash_dot}}{p_end}
{p2col:{cmd:longdash}}{p_end}
{p2col:{cmd:longdash_dot}}{p_end}
{p2col:{cmd:blank}}invisible line{p_end}
{p2col:{cmd:"}{it:formula}{cmd:"}}e.g., {cmd:"-."} or {cmd:"--.."} etc.{p_end}
{p2line}
{p 4 6 2}
A {it:formula} is composed of any combination of{p_end}
{p2col 17 34 36 2: {cmd:l}}solid line{p_end}
{p2col 17 34 36 2: {cmd:_}}(underscore) a long dash{p_end}
{p2col 17 34 36 2: {cmd:-}}(hyphen) a medium dash{p_end}
{p2col 17 34 36 2: {cmd:.}}short dash (almost a dot){p_end}
{p2col 17 34 36 2: {cmd:#}}small amount of blank space{p_end}
{p2line}
{p2colreset}{...}

{pstd}
For a palette displaying each of the above named line styles, type

	    {cmd:.} {bf:{stata palette linepalette}} {...}
[{cmd:,} {cmdab:sch:eme:(}{it:schemename}{cmd:)}]

{pstd}
Other {it:linepatternstyles} may be available; type

{phang3}
{cmd:. {bf:{stata graph query linepatternstyle}}}

{pstd}
to obtain the complete list of {it:linepatternstyles} installed on your
computer.


{marker description}{...}
{title:Description}

{pstd}
A line's look is determined by its pattern, thickness, and color; see 
{help lines}.  {it:linepatternstyle} specifies the pattern.

{pstd}
{it:linepatternstyle} is specified via options named

{phang2}
	<{it:object}><{cmd:l} or {cmd:li} or {cmd:line}>{cmd:pattern()}

{pstd}
or

	<{cmd:l} or {cmd:li} or {cmd:line}>{cmd:pattern()}

{pstd}
For instance, for connecting lines (the lines used to connect
points in a plot) used by {cmd:graph} {cmd:twoway} {cmd:function}, the option
is named {cmd:lpattern()}:

{phang2}
	{cmd:. twoway function} ...{cmd:, lpattern(}{it:linepatternstyle}{cmd:)} ...

{pstd}
Sometimes you will see that a {it:linepatternstylelist} is allowed:

{phang2}
	{cmd:. twoway line} ...{cmd:, lpattern(}{it:linepatternstylelist}{cmd:)} ...

{pstd}
A {it:linepatternstylelist} is a sequence of {it:linepatterns} separated by
spaces.  Shorthands are allowed to make specifying the list easier;
see {manhelpi stylelists G-4}.


{marker remarks}{...}
{title:Remarks}

{pstd}
Alhtough you may choose a prerecorded pattern (for example, {cmd:solid} or
{cmd:dash}), you can build any pattern you wish by specifying a line-pattern
formula.  For example,

{synoptset 20}{...}
{p2col:Formula}Description{p_end}
{p2line}
{p2col:{cmd:"l"}}solid line, same as {cmd:solid}{p_end}
{p2col:{cmd:"_"}}a long dash{p_end}
{p2col:{cmd:"_-"}}a long dash followed by a short dash{p_end}
{p2col:{cmd:"_--"}}a long dash followed by two short dashes{p_end}
{p2col:{cmd:"_--_#"}}a long dash, two short dashes, a long dash, and a bit of space{p_end}
{p2col:{it:etc.}}{p_end}
{p2line}

{pstd}
When you specify a formula, you must enclose it in double quotes.
{p_end}
