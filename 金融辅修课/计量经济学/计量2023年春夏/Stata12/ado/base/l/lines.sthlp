{smcl}
{* *! version 1.1.4  11feb2011}{...}
{vieweralsosee "[G-4] concept: lines" "mansection G-4 conceptlines"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[G-4] linepatternstyle" "help linepatternstyle"}{...}
{vieweralsosee "[G-4] linestyle" "help linestyle"}{...}
{vieweralsosee "[G-4] linewidthstyle" "help linewidthstyle"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[G-4] colorstyle" "help colorstyle"}{...}
{vieweralsosee "[G-3] connect_options" "help connect_options"}{...}
{viewerjumpto "Syntax" "lines##syntax"}{...}
{viewerjumpto "Description" "lines##description"}{...}
{viewerjumpto "Remarks" "lines##remarks"}{...}
{title:Title}

{p2colset 5 29 31 2}{...}
{p2col :{bf:{mansection G-4 conceptlines:[G-4] concept: lines}} {hline 2}}Using lines{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{pstd}
The following affects how a line appears:

{synoptset 20}{...}
{p2line}
{p2col:{it:{help linestyle}}}overall style{p_end}
{p2col:{it:{help linepatternstyle}}}whether solid, dashed, etc.{p_end}
{p2col:{it:{help linewidthstyle}}}its thickness{p_end}
{p2col:{it:{help colorstyle}}}its color{p_end}
{p2line}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
Lines occur in many contexts -- in borders, axes, the ticks on axes, the
outline around symbols, the connecting of points in a plot, and more.
{it:linestyle}, {it:linepatternstyle}, {it:linewidthstyle}, and
{it:colorstyle} define the look of the line.


{marker remarks}{...}
{title:Remarks}

{pstd}
Remarks are presented under the following headings:

         {help lines##remarks1:linestyle}
         {help lines##remarks2:linepatternstyle}
         {help lines##remarks3:linewidthstyle}
         {help lines##remarks4:colorstyle}

{pstd}
{it:linestyle}, {it:linepatternstyle}, {it:linewidthstyle}, and
{it:colorstyle} are specified inside options that control how the line
is to appear.  Regardless of the object, these options usually have the same
names:

	{cmd:lstyle(}{it:linestyle}{cmd:)}
	{cmd:lpattern(}{it:linepatternstyle}{cmd:)}
	{cmd:lwidth(}{it:linewidthstyle}{cmd:)}
	{cmd:lcolor(}{it:colorstyle}{cmd:)}

{pstd}
Though for a few objects, such as markers, the form of the names is

	<{it:object}>{cmd:lstyle(}{it:linestyle}{cmd:)}
	<{it:object}>{cmd:lpattern(}{it:linepatternstyle}{cmd:)}
	<{it:object}>{cmd:lwidth(}{it:linewidthstyle}{cmd:)}
	<{it:object}>{cmd:lcolor(}{it:colorstyle}{cmd:)}

{pstd}
For instance,

{p 8 11 2}
o{space 2}The options to specify how the lines connecting points in a plot are
to appear are specified by the options {cmd:lstyle()}, {cmd:lpattern()},
{cmd:lwidth()}, and {cmd:lcolor()}; see {manhelpi connect_options G-3}.

{p 8 11 2}
o{space 2}The suboptions to specify how the border around a textbox, such as a
title, are to appear are named {cmd:lstyle()}, {cmd:lpattern()},
{cmd:lwidth()}, and {cmd:lcolor()}; see {manhelpi textbox_options G-3}.

{p 8 11 2}
o{space 2}The options to specify how the outline around markers 
is to appear are specified by the options {cmd:mlstyle()},
{cmd:mlpattern()}, {cmd:mlwidth()}, and {cmd:mlcolor()}; see 
{manhelpi marker_options G-3}.

{pstd}
Wherever these options arise, they always come in a group of four, and the
four pieces have the same meaning.


{marker remarks1}{...}
{title:linestyle}

{pstd}
{it:linestyle} is specified inside the {cmd:lstyle()} option or sometimes
inside the <{it:object}>{cmd:lstyle()} option.

{pstd}
{it:linestyle} specifies the overall style of the line:  its pattern
(solid, dashed, etc.), thickness, and color.

{pstd}
You need not specify the {cmd:lstyle()} option just because
there is something you want to change about the look of the line and, in fact,
most of the time you do not.  You specify
{cmd:lstyle()} when another style exists that is exactly what you
desire or when another style would allow you to specify fewer changes to
obtain what you want.

{pstd}
See {manhelpi linestyle G-4} for the list of what may be specified inside
the {cmd:lstyle()} option.


{marker remarks2}{...}
{title:linepatternstyle}

{pstd}
{it:linepatternstyle} is specified inside the {cmd:lpattern()} or
<{it:object}>{cmd:lpattern()} option.

{pstd}
{it:linepatternstyle} specifies whether the line is solid, dashed, etc.

{pstd}
See {manhelpi linepatternstyle G-4} for the list of what may be specified
inside the {cmd:lpattern()} option.


{marker remarks3}{...}
{title:linewidthstyle}

{pstd}
{it:linewidthstyle} is specified inside the {cmd:lwidth()} or
<{it:object}>{cmd:lwidth()} option.

{pstd}
{it:linewidthstyle} specifies the thickness of the line.

{pstd}
See {manhelpi linewidthstyle G-4} for the list of what may be specified
inside the {cmd:lwidth()} option.


{marker remarks4}{...}
{title:colorstyle}

{pstd}
{it:colorstyle} is specified inside the {cmd:lcolor()} or
<{it:object}>{cmd:lcolor()} option.

{pstd}
{it:colorstyle} specifies the color of the line.

{pstd}
See {manhelpi colorstyle G-4} for the list of what may be specified inside
the {cmd:lcolor()} option.
{p_end}
