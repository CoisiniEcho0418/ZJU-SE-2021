{smcl}
{* *! version 1.1.3  11feb2011}{...}
{vieweralsosee "[G-4] scheme s1" "mansection G-4 schemes1"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[G-4] schemes intro" "help schemes"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[G-3] scheme_option" "help scheme_option"}{...}
{viewerjumpto "Syntax" "scheme_s1##syntax"}{...}
{viewerjumpto "Description" "scheme_s1##description"}{...}
{viewerjumpto "Remarks" "scheme_s1##remarks"}{...}
{title:Title}

{p2colset 5 24 26 2}{...}
{p2col :{manlink G-4 scheme s1} {hline 2}}Scheme description:  s1 family{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

	{cmd:s1} family{col 22}Foreground{col 36}Background{col 48}Description
	{hline 70}
	{cmd:s1rcolor}{...}
{col 22}color{...}
{col 36}black{...}
{col 48}color on black
{...}
	{cmd:s1color}{...}
{col 22}color{...}
{col 36}white{...}
{col 48}color on white
{...}
	{cmd:s1mono}{...}
{col 22}monochrome{...}
{col 36}white{...}
{col 48}gray on white
{...}
	{cmd:s1manual}{...}
{col 22}monochrome{...}
{col 36}white{...}
{col 48}{cmd:s1mono}, but smaller;
{col 50}used in some Stata manuals
	{hline 70}

{pstd}
For instance, you might type

{p 8 16 2}
{cmd:. graph}
...{cmd:,}
...
{cmd:scheme(s1color)}

{p 8 16 2}
{cmd:. set}
{cmd:scheme}
{cmd:s1rcolor}
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
The {cmd:s1} family of schemes is similar to the {cmd:s2}
family -- see {manhelp scheme_s2 G-4:scheme s2} -- except that {cmd:s1} uses a
plain background, meaning that no tint is applied to any part of the
background.


{marker remarks}{...}
{title:Remarks}

{pstd}
{cmd:s1} is a conservative family of schemes that some people prefer to
{cmd:s2}.

{pstd}
Of special interest is {cmd:s1rcolor}, which displays graphs on a black
background.  Because of pixel bleeding, monitors have higher resolution when
backgrounds are black rather than white.  Also, many users
experience less eye strain viewing graphs on a monitor when the background is
black.  Scheme {cmd:s1rcolor} looks good when printed, but other schemes look
better.

{pstd}
Schemes {cmd:s1color} and {cmd:s1mono} are derived from {cmd:s1rcolor}.
Either of these schemes will deliver a better printed result.
The important difference between {cmd:s1color} and {cmd:s1mono} is that
{cmd:s1color} uses solid lines of different colors to connect points,
whereas {cmd:s1mono} varies the line-pattern style.

{pstd}
Scheme {cmd:s1manual} is used in some of the Stata manuals, although it is
not used in this one.  {cmd:s1manual} is the same as {cmd:s1mono} but
presents graphs at a smaller overall size.
{p_end}
