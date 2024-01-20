{smcl}
{* *! version 1.1.5  18jun2011}{...}
{vieweralsosee "[G-4] scheme s2" "mansection G-4 schemes2"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[G-4] schemes intro" "help schemes"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[G-3] scheme_option" "help scheme_option"}{...}
{viewerjumpto "Syntax" "scheme_s2##syntax"}{...}
{viewerjumpto "Description" "scheme_s2##description"}{...}
{viewerjumpto "Remarks" "scheme_s2##remarks"}{...}
{title:Title}

{p2colset 5 24 26 2}{...}
{p2col :{manlink G-4 scheme s2} {hline 2}}Scheme description:  s2 family{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

	{it:schemename}{col 22}Foreground{col 36}Background{col 48}Description
	{hline 70}
	{cmd:s2color}{...}
{col 22}color{...}
{col 36}white{...}
{col 48}factory setting
{...}
	{cmd:s2mono}{...}
{col 22}monochrome{...}
{col 36}white{...}
{col 48}{cmd:s2color} in monochrome
{...}
	{cmd:s2manual}{...}
{col 22}monochrome{...}
{col 36}white{...}
{col 48}used in the Stata manuals
	{cmd:s2gmanual}{...}
{col 22}monochrome{...}
{col 36}white{...}
{col 48}used in the Stata [G] manual
	{cmd:s2gcolor}{...}
{col 22}color{...}
{col 36}white{...}
{col 48}{cmd:s2gmanual} in color
	{hline 70}

{pstd}
For instance, you might type

{p 8 16 2}
{cmd:. graph}
...{cmd:,}
...
{cmd:scheme(s2mono)}

{p 8 16 2}
{cmd:. set}
{cmd:scheme}
{cmd:s2mono}
[{cmd:,}
{cmdab:perm:anently}]

{pstd}
See {manhelpi scheme_option G-3} and {manhelp set_scheme G-2:set scheme}.


{marker description}{...}
{title:Description}

{pstd}
Schemes determine the overall look of a graph; see
{manhelp schemes G-4:schemes intro}.

{pstd}
The {cmd:s2} family of schemes is Stata's default scheme.


{marker remarks}{...}
{title:Remarks}

{pstd}
{cmd:s2} is the family of schemes that we like for displaying data.  It
provides a light background tint to give the graph better definition and make
it visually more appealing.  On the other hand, if you feel that the tinting
distracts from the graph, see {manhelp scheme_s1 G-4:scheme s1}; the {cmd:s1}
family is nearly identical to {cmd:s2} but does away with the extra tinting.

{pstd}
In particular, we recommend that you consider scheme {cmd:s1rcolor}; see 
{manhelp scheme_s1 G-4:scheme s1}.  {cmd:s1rcolor} uses a black background, and
for working at the monitor, it is difficult to find a better choice.

{pstd}
In any case, scheme {cmd:s2color} is Stata's default scheme.  It looks good on
the screen, good when printed on a color printer, and more than adequate when
printed on a monochrome printer.

{pstd}
Scheme {cmd:s2mono} has been optimized for printing on monochrome printers.
Also, rather than using the same symbol over and over and varying the
color, {cmd:s2mono} will vary the symbol's shape, and in connecting points,
{cmd:s2mono} varies the line pattern ({cmd:s2color} varies the color).

{pstd}
Scheme {cmd:s2manual} is the scheme used in printing many of the Stata
manuals.  It is basically {cmd:s2mono}, but smaller.

{pstd}
Scheme {cmd:s2gmanual} is the scheme used in printing the Stata Graphics
manual.  It is similar to {cmd:s2manual} except that connecting lines are
solid and gray scales rather than patterned and black.

{pstd}
Scheme {cmd:s2gcolor} is the same scheme as {cmd:s2gmanual} except that color
is used.

{pin}
{it:Technical note:}{break}
The colors used in the {cmd:s2color} scheme were changed slightly after Stata
8 to improve printing on color inkjet printers and printing
presses -- the amount of cyan in the some colors was reduced to prevent
an unintended casting toward purple.  You probably will not notice the
difference, but if you want the original colors, they are available in the
scheme {cmd:s2color8}.
{p_end}
