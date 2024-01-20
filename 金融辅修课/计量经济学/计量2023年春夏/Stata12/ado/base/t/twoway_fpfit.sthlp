{smcl}
{* *! version 1.1.6  11feb2011}{...}
{viewerdialog twoway "dialog twoway"}{...}
{vieweralsosee "[G-2] graph twoway fpfit" "mansection G-2 graphtwowayfpfit"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[G-2] graph twoway fpfitci" "help twoway_fpfitci"}{...}
{vieweralsosee "[G-2] graph twoway line" "help line"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[G-2] graph twoway lfit" "help twoway_lfit"}{...}
{vieweralsosee "[G-2] graph twoway qfit" "help twoway_qfit"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[G-2] graph twoway mband" "help twoway_mband"}{...}
{vieweralsosee "[G-2] graph twoway mspline" "help twoway_mspline"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] fracpoly" "help fracpoly"}{...}
{viewerjumpto "Syntax" "twoway_fpfit##syntax"}{...}
{viewerjumpto "Description" "twoway_fpfit##description"}{...}
{viewerjumpto "Options" "twoway_fpfit##options"}{...}
{viewerjumpto "Remarks" "twoway_fpfit##remarks"}{...}
{title:Title}

{p2colset 5 33 35 2}{...}
{p2col :{manlink G-2 graph twoway fpfit} {hline 2}}Twoway fractional-polynomial prediction plots{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 60 2}
{cmdab:tw:oway}
{cmd:fpfit}
{it:yvar} {it:xvar}
{ifin}
{weight}
[{cmd:,}
{it:options}]

{synoptset 27}{...}
{p2col:{it:options}}Description{p_end}
{p2line}
{p2col:{cmdab:estc:md:(}{it:estcmd}{cmd:)}}estimation command; default is
       {cmd:regress}{p_end}
{p2col:{cmdab:est:opts:(}{it:{help fracpoly##fracpoly_options:fracpoly_options}}{cmd:)}}options for
       {cmd:fracpoly} {it:estcmd}{p_end}
{p2col:{cmdab:pred:opts:(}{it:{help regress postestimation##predict:predict_options}}{cmd:)}}options for
       {cmd:predict}{p_end}

{p2col:{it:{help cline_options}}}change look of predicted line{p_end}

INCLUDE help gr_axlnk

INCLUDE help gr_twopt
{p2line}
{p2colreset}{...}
{p 4 6 2}
Options {cmd:estcmd()}, {cmd:estopts()},
and {cmd:predopts()} are {it:unique}; see {help repeated options}.{p_end}
{p 4 6 2}
{cmd:aweight}s,
{cmd:fweight}s, and
{cmd:pweight}s are allowed.  Weights, if specified, affect estimation but
not how the weighted results are plotted.  See {help weight}.


{title:Menu}

{phang}
{bf:Graphics > Twoway graph (scatter, line, etc.)}


{marker description}{...}
{title:Description}

{pstd}
{cmd:twoway} {cmd:fpfit} calculates the prediction for {it:yvar} from 
estimation of a fractional polynomial of {it:xvar} and plots the resulting
curve.


{marker options}{...}
{title:Options}

{phang}
{cmd:estcmd(}{it:estcmd}{cmd:)}
    specifies the estimation command to be used;
    {cmd:estcmd(regress)} is the default.

{phang}
{cmd:estopts(}{it:fracpoly_options}{cmd:)}
    specifies options to be passed along to {cmd:fracpoly} to
    estimate the fractional polynomial regression from which the curve will be
    predicted; see {manhelp fracpoly R}.

{phang}
{cmd:predopts(}{it:predict_options}{cmd:)}
    specifies options to be passed along to {cmd:predict} to
    obtain the predictions after estimation by {cmd:fracpoly:} {cmd:regress};
    see {manhelp regress_postestimation R:regress postestimation}.
    {cmd:predopts()} may be used only with {cmd:estcmd(regress)}.
    Predictions in all cases are calculated at all the {it:xvar} values
    in the data.

{phang}
{it:cline_options}
     specify how the prediction line is rendered; see
     {manhelpi cline_options G-3}.

INCLUDE help gr_axlnkf

INCLUDE help gr_twoptf


{marker remarks}{...}
{title:Remarks}

{pstd}
Remarks are presented under the following headings:

	{help twoway fpfit##remarks1:Typical use}
	{help twoway fpfit##remarks2:Cautions}
	{help twoway fpfit##remarks3:Use with by()}


{marker remarks1}{...}
{title:Typical use}

{pstd}
{cmd:twoway} {cmd:fpfit} is nearly always used in conjunction with
other {cmd:twoway} plottypes, such as

	{cmd:. sysuse auto}

	{cmd:. scatter mpg weight || fpfit mpg weight}
	  {it:({stata "gr_example auto: scatter mpg weight || fpfit mpg weight":click to run})}
{* graph gtfpfit1}{...}

{pstd}
Results are visually the same as typing

	{cmd}. fracpoly regress mpg weight
	. predict fitted
	. scatter mpg weight || line fitted weight{txt}


{marker remarks2}{...}
{title:Cautions}

{pstd}
Do not use {cmd:twoway} {cmd:fpfit} when specifying the
{it:axis_scale_options} {helpb axis_scale_options:yscale(log)} or
{helpb axis_scale_options:xscale(log)}
to create log scales.  Typing

{phang2}
	{cmd:. scatter mpg weight, xscale(log) || fpfit mpg weight}

{pstd}
will produce a curve that will be fit from a fractional polynomial
regression of {cmd:mpg} on {cmd:weight} rather than {cmd:log(weight)}.


{marker remarks3}{...}
{title:Use with by()}

{pstd}
{cmd:fpfit} may be used with {cmd:by()} (as can all the {cmd:twoway} plot
commands):

{phang2}
	{cmd:. scatter mpg weight || fpfit mpg weight ||, by(foreign, total row(1))}
{p_end}
	  {it:({stata "gr_example auto: scatter mpg weight || fpfit mpg weight ||, by(foreign, total row(1))":click to run})}
{* graph gtfpfit2}{...}
