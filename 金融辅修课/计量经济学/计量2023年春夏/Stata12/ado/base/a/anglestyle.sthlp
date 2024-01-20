{smcl}
{* *! version 1.1.3  11feb2011}{...}
{vieweralsosee "[G-4] anglestyle" "mansection G-4 anglestyle"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[G-3] marker_label_options" "help marker_label_options"}{...}
{viewerjumpto "Syntax" "anglestyle##syntax"}{...}
{viewerjumpto "Description" "anglestyle##description"}{...}
{viewerjumpto "Remarks" "anglestyle##remarks"}{...}
{title:Title}

{p2colset 5 25 27 2}{...}
{p2col :{manlinki G-4 anglestyle} {hline 2}}Choices for the angle at which text is displayed{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{synoptset 20}{...}
{p2col : {it:anglestyle}}Description{p_end}
{p2line}
{p2col : {cmd:horizontal}}horizontal; reads left to right{p_end}
{p2col : {cmd:vertical}}vertical; reads bottom to top{p_end}
{p2col : {cmd:rvertical}}vertical; reads top to bottom{p_end}
{p2col : {cmd:rhorizontal}}horizontal; upside down{p_end}

{p2col : {cmd:0}}0 degrees; same as {cmd:horizontal}{p_end}
{p2col : {cmd:45}}45 degrees{p_end}
{p2col : {cmd:90}}90 degrees; same as {cmd:vertical}{p_end}
{p2col : {cmd:180}}180 degrees; same as {cmd:rhorizontal}{p_end}
{p2col : {cmd:270} or {cmd:-90}}270 degrees; same as {cmd:rvertical}{p_end}

{p2col : {it:#}}{it:#} degrees; whatever you desire; {it:#} may be positive
         or negative{p_end}
{p2line}
{p2colreset}{...}
{p 4 11 11}
Note:  under Unix, only angles
{cmd:0},
{cmd:90},
{cmd:180},
and {cmd:270} display correctly on the screen.
Angles are correctly rendered when printed.

{p 4 6 2}
Other {it:anglestyles} may be available; type

	    {cmd:.} {bf:{stata graph query anglestyle}}

{p 4 6 2}
to obtain the full list installed on your computer.
If other {it:anglestyles} do exist, they are merely words attached to
numeric values.


{marker description}{...}
{title:Description}

{pstd}
{it:anglestyle} specifies the angle at which text is to be displayed.


{marker remarks}{...}
{title:Remarks}

{pstd}
{it:anglestyle} is specified inside options such as the marker-label option
{cmd:mlabangle()} (see {manhelpi marker_label_options G-3}),

{p 8 16 2}
{cmd:. graph}
...{cmd:,} ...
{cmd:mlabel(...) mlabangle(}{it:anglestylelist}{cmd:)} ...

{pstd}
or the axis-label suboption {cmd:angle()}
(see {manhelpi axis_label_options G-3}):

{p 8 16 2}
{cmd:. graph}
...{cmd:,} ...
{cmd:ylabel(}...{cmd:, angle(}{it:anglestyle}{cmd:)} ...{cmd:)} ...

{pstd}
For {cmd:mlabangle()}, an {it:anglestylelist} is allowed.  An
{it:anglestylelist} is a sequence of {it:anglestyles} separated by spaces.
Shorthands are allowed to make specifying the list easier; see 
{manhelpi stylelists G-4}.
{p_end}
