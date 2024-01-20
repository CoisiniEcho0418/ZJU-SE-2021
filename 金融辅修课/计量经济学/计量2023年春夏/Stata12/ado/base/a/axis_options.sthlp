{smcl}
{* *! version 1.2.1  03mar2011}{...}
{vieweralsosee "[G-3] axis_options" "mansection G-3 axis_options"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[G-3] axis_label_options" "help axis_label_options"}{...}
{vieweralsosee "[G-3] axis_scale_options" "help axis_scale_options"}{...}
{vieweralsosee "[G-3] axis_title_options" "help axis_title_options"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[G-3] axis_choice_options" "help axis_choice_options"}{...}
{vieweralsosee "[G-3] region_options" "help region_options"}{...}
{viewerjumpto "Syntax" "axis_options##syntax"}{...}
{viewerjumpto "Description" "axis_options##description"}{...}
{viewerjumpto "Options" "axis_options##options"}{...}
{viewerjumpto "Remarks" "axis_options##remarks"}{...}
{title:Title}

{p2colset 5 27 29 2}{...}
{p2col :{manlinki G-3 axis_options} {hline 2}}Options for specifying numeric axes{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{synoptset 32}{...}
{p2col:{it:axis_scale_options}}Description{p_end}
{p2line}
{p2col:{c -(}{cmdab:y:}|{cmdab:x:}|{cmdab:t:}|{cmdab:z:}{c )-}{cmdab:sc:ale:(}{it:axis_description}{cmd:)}}log scales, range, appearance{p_end}
{p2line}
{p 4 6 2}See {manhelpi axis_scale_options G-3}.

{p2col:{it:axis_label_options}}Description{p_end}
{p2line}
{p2col:{c -(}{cmdab:y:}|{cmdab:x:}|{cmdab:t:}|{cmdab:z:}{c )-}{cmdab:lab:el:(}{it:rule_or_values}{cmd:)}}major ticks plus labels{p_end}
{p2col:{c -(}{cmdab:y:}|{cmdab:x:}|{cmdab:t:}|{cmdab:z:}{c )-}{cmdab:tic:k:(}{it:rule_or_values}{cmd:)}}major ticks only{p_end}
{p2col:{c -(}{cmdab:y:}|{cmdab:x:}|{cmdab:t:}|{cmdab:z:}{c )-}{cmdab:mlab:el:(}{it:rule_or_values}{cmd:)}}minor ticks plus labels{p_end}
{p2col:{c -(}{cmdab:y:}|{cmdab:x:}|{cmdab:t:}|{cmdab:z:}{c )-}{cmdab:mti:ck:(}{it:rule_or_values}{cmd:)}}minor ticks only{p_end}
{p2line}
{p 4 6 2}(also allows control of grid lines; see
        {manhelpi axis_label_options G-3})

{p2col:{it:axis_title_options}}Description{p_end}
{p2line}
{p2col:{c -(}{cmdab:y:}|{cmdab:x:}|{cmdab:t:}|{cmdab:z:}{c )-}{cmdab:ti:tle:(}{it:axis_title}{cmd:)}}specify axis title{p_end}
{p2line}
{p2colreset}{...}
{p 4 6 2}See {manhelpi axis_title_options G-3}.


{marker description}{...}
{title:Description}

{pstd}
Axes are the graphical elements that indicate the scale.


{marker options}{...}
{title:Options}

{phang}
{cmd:yscale()},
{cmd:xscale()},
{cmd:tscale()}, and
{cmd:zscale()}
    specify how the {it:y}, {it:x}, {it:t}, and {it:z} axes are scaled
    (arithmetic, log, reversed), the range of the axes, and the look of the
    lines that are the axes.  See {manhelpi axis_scale_options G-3}.
    {cmd:tscale()} is an extension of {cmd:xscale()}.  {cmd:zscale()} applies
    to the axis in the {help clegend_option:contour legend} of a graph with a 
    {help twoway_contour:contour plot}.

{phang}
{cmd:ylabel()},
{cmd:ytick()},
{cmd:ymlabel()},
{cmd:ymtick()},
{cmd:xlabel()},
...,
{cmd:xmtick()},
{cmd:tlabel()},
...,
{cmd:tmtick()},
and
{cmd:zlabel()},
...,
{cmd:zmtick()}
    specify how the axes should be labeled and ticked.  These options allow
    you to control the placement of major and minor ticks and labels. Also, 
    these options allow you to add or to suppress grid lines on your
    graphs.  See {manhelpi axis_label_options G-3}.
{cmd:tlabel()},
...,
{cmd:tmtick()} are extensions of
{cmd:xlabel()},
...,
{cmd:xmtick()},
respectively.

{phang}
{cmd:ytitle()}, {cmd:xtitle()}, {cmd:ttitle()}, and {cmd:ztitle()}
    specify the titles to appear next to the axes.
    See {manhelpi axis_title_options G-3}.
    {cmd:ttitle()} is a synonym of {cmd:xtitle()}.


{marker remarks}{...}
{title:Remarks}

{pstd}
Numeric axes are allowed with
{helpb graph twoway}
and
{helpb graph matrix}
and are allowed for one of the axes of
{helpb graph bar},
{helpb graph dot},
and
{helpb graph box}.
They are also allowed on the contour key of a legend on a 
{help twoway_contour:contour plot}.
How the numeric axes look is affected by the {it:axis_options}.

{pstd}
Remarks are presented under the following headings:

	{help axis_options##remarks1:Use of axis-appearance options with graph twoway}
	{help axis_options##remarks2:Multiple y and x scales}
	{help axis_options##remarks3:Axis on the left, axis on the right?}
	{help axis_options##remarks4:Contour axes -- zscale(), zlabel(), etc.}


{marker remarks1}{...}
{title:Use of axis-appearance options with graph twoway}

{pstd}
When you type

	{cmd:. scatter yvar xvar}

{pstd}
the resulting graph will have {it:y} and {it:x} axes.  How the axes look will
be determined by the scheme; see {manhelp schemes G-4:schemes intro}.  The
{it:axis_options} allow you to modify the look of the axes in terms
of whether the {it:y} axis is on the left or on the right, whether the {it:x}
axis is on the bottom or on the top, the number of major and minor ticks that
appear on each axis, the values that are labeled, and the titles that appear
along each.

{pstd}
For instance, you might type

{p 8 16 2}
{cmd}. scatter yvar xvar,
ylabel(#6) ymtick(##10)
ytitle("values of y")
xlabel(#6) xmtick(##10)
xtitle("values of x"){txt}

{pstd}
to draw a graph of {cmd:yvar} versus {cmd:xvar}, putting on each axis
approximately six labels and major ticks and 10 minor ticks between major ticks,
and labeling the
{it:y} axis "values of y" and the
{it:x} axis "values of x".

{p 8 16 2}
{cmd}. scatter yvar xvar,
ylabel(0(5)30) ymtick(0(1)30)
ytitle("values of y")
xlabel(0(10)100) xmtick(0(5)100)
xtitle("values of x"){txt}

{pstd}
would draw the same graph, putting major ticks on the {it:y} axis at 0, 5, 10,
..., 30 and minor ticks at every integer over the same range, and putting
major ticks on the {it:x} axis at 0, 10, ..., 100 and minor ticks at every
five units over the same range.

{pstd}
The way we have illustrated it, it appears that the axis options are
options of {cmd:scatter}, but that is not so.  Here they are options
of {cmd:twoway}, and the "right" way to write the last command is

{p 8 16 2}
{cmd}. twoway (scatter yvar xvar),
ylabel(0(5)30) ymtick(0(1)30)
ytitle("values of y")
xlabel(0(10)100) xmtick(0(5)100)
xtitle("values of x"){txt}

{pstd}
The parentheses around {cmd:(scatter yvar xvar)} and the placing of the
axis-appearance options outside the parentheses make clear that the options
are aimed at {cmd:twoway} rather than at {cmd:scatter}.  Whether you use the
{cmd:||}-separator notation or the {cmd:()}-binding notation makes no
difference, but it is important to understand that there is only one set of
axes, especially when you type more complicated commands, such as{cmd}

	. twoway (scatter yvar xvar)
		 (scatter y2var x2var)
		 , ylabel(0(5)30) ymtick(0(1)30) ytitle("values of y")
		   xlabel(0(10)100) xmtick(0(5)100) xtitle("values of x"){txt}

{pstd}
There is one set of axes in the above, and it just so happens that both
{cmd:yvar} versus {cmd:xvar} and {cmd:y2var} versus {cmd:x2var} appear on it.
You are free to type the above command how you please, such as{cmd}

	. scatter yvar  xvar ||
	  scatter y2var x2var ||,
		ylabel(0(5)30) ymtick(0(1)30) ytitle("values of y")
		xlabel(0(10)100) xmtick(0(5)100) xtitle("values of x"){txt}

{pstd}
or{cmd}

	. scatter yvar  xvar ||
	  scatter y2var x2var, ylabel(0(5)30) ymtick(0(1)30)
			       ytitle("values of y") xlabel(0(10)100)
			       xmtick(0(5)100) xtitle("values of x"){txt}

{pstd}
or{cmd}

	. scatter yvar xvar, ylabel(0(5)30) ymtick(0(1)30)
			     ytitle("values of y") xlabel(0(10)100)
			     xmtick(0(5)100) xtitle("values of x") ||
	  scatter y2var x2var{txt}

{pstd}
The above all result in the same graph, even though the last makes it
appear that the axis options are associated with just the first {cmd:scatter},
and the next to the last makes it appear that they are associated with just
the second.  However you type it, the command is really {cmd:twoway}.
{cmd:twoway} draws twoway graphs with one set of axes (or one
set per by-group), and all the plots that appear on the twoway graph share
that set.


{marker remarks2}{...}
{title:Multiple y and x scales}

{pstd}
Actually, a twoway graph can have more than one set of axes.  Consider
the command:

{p 8 16 2}
{cmd}. twoway (scatter yvar xvar) (scatter y2var x2var, yaxis(2)){txt}

{pstd}
The above graphs {cmd:yvar} versus {cmd:xvar} and {cmd:y2var} versus
{cmd:x2var}, but two {it:y} scales are provided.  The first (which will appear
on the left) applies to {cmd:yvar}, and the second (which will appear on the
right) applies to {cmd:y2var}.  The {cmd:yaxis(2)} option says that the {it:y}
axis of the specified scatter is to appear on the second {it:y} scale.

{pstd}
See {manhelpi axis_choice_options G-3}.


{marker remarks3}{...}
{title:Axis on the left, axis on the right?}

{pstd}
When there is only one {it:y} scale, whether the axis appears on the
left or the right is determined by the scheme; see
{manhelp schemes G-4:schemes intro}.
The default scheme puts the {it:y} axis on the left, but the scheme
that mirrors the style used by {it:The Economist} puts it on the right:

	{cmd:scatter yvar xvar, scheme(economist)}

{pstd}
Specifying {cmd:scheme(economist)} will change other things about the
appearance of the graph, too.  If you just want to move the {it:y} axis
to the right, you can type

	{cmd:scatter yvar xvar, yscale(alt)}

{pstd}
As explained in {manhelpi axis_scale_options G-3}, {cmd:yscale(alt)}
switches the axis from one side to the other, so if you typed

{phang2}
	{cmd:scatter yvar xvar, scheme(economist) yscale(alt)}

{pstd}
you would get {it:The Economist} scheme but with the {it:y} axis on the
left.

{pstd}
{cmd:xscale(alt)} switches the {it:x} axis from the bottom to
the top or from the top to the bottom; see {manhelpi axis_scale_options G-3}.


{marker remarks4}{...}
{title:Contour axes -- zscale(), zlabel(), etc.}

{pstd}
The {cmd:zscale()}, {cmd:zlabel()}, {cmd:ztitle()}, and other {cmd:z} options
are unusual in that they apply not to axes on the plot region, but to the axis
that shows the scale of a {help clegend_option:contour legend}.  They
have effect only when the graph includes a {cmd:twoway contour} plot;
see {helpb twoway_contour:[G-2] graph twoway contour}.  In
all other respects, they act like the {cmd:x}{it:*}, {cmd:y}{it:*}, and
{cmd:t}{it:*} options.
{p_end}
