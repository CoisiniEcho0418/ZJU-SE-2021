{smcl}
{* *! version 1.1.4  11feb2011}{...}
{viewerdialog twoway "dialog twoway"}{...}
{vieweralsosee "[G-2] graph twoway connected" "mansection G-2 graphtwowayconnected"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[G-2] graph twoway scatter" "help scatter"}{...}
{viewerjumpto "Syntax" "twoway_connected##syntax"}{...}
{viewerjumpto "Description" "twoway_connected##description"}{...}
{viewerjumpto "Options" "twoway_connected##options"}{...}
{viewerjumpto "Remarks" "twoway_connected##remarks"}{...}
{title:Title}

{p2colset 5 37 39 2}{...}
{p2col :{manlink G-2 graph twoway connected} {hline 2}}Twoway connected plots{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 55 2}
{cmdab:tw:oway}
{cmdab:con:nected}
{it:varlist}
{ifin}
{weight}
[{cmd:,}
{it:{help scatter:scatter_options}}]

{pstd}
where {it:varlist} is 

		{it:y_1} [{it:y_2} [...]] {it:x}


{pstd}
{cmd:aweight}s,
{cmd:fweight}s, and
{cmd:pweight}s are allowed; see {help weight}.


{title:Menu}

{phang}
{bf:Graphics > Twoway graph (scatter, line, etc.)}


{marker description}{...}
{title:Description}

{pstd}
{cmd:twoway} {cmd:connected} draws connected-line plots.  In a connected-line
plot, the markers are displayed and the points are connected.

{pstd}
{cmd:connected} is a {it:plottype} as
defined in {manhelp twoway G-2:graph twoway}.  Thus the syntax for
{cmd:connected} is

	{cmd:. graph twoway connected} ...

	{cmd:. twoway connected} ...

{pstd}
Being a plottype, {cmd:connected} may be combined with other plottypes in the
{helpb twoway} family, as in,

	{cmd:. twoway (connected} ...{cmd:) (scatter} ...{cmd:) (lfit} ...{cmd:)} ...


{marker options}{...}
{title:Options}

{phang}
{it:scatter_options}
    are any of the options allowed by the {cmd:graph} {cmd:twoway}
    {cmd:scatter} command; see {manhelp scatter G-2:graph twoway scatter}.


{marker remarks}{...}
{title:Remarks}

{pstd}
{cmd:connected} is, in fact, {cmd:scatter}, the difference being that by
default the points are connected:

	Default {cmd:connect()} option:  {cmd:connect(l ...)}

{pstd}
Thus you get the same results by typing

	{cmd:. twoway connected yvar xvar}

{pstd}
as typing

	{cmd:. scatter yvar xvar, connect(l)}

{pstd}
You can just as easily turn {cmd:connected} into {cmd:scatter}:  Typing

	{cmd:. scatter yvar xvar}

{pstd}
is the same as typing

	{cmd:. twoway connected yvar xvar, connect(none)}
