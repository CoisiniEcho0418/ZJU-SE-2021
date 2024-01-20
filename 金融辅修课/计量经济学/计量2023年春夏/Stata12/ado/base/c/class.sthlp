{smcl}
{* *! version 1.1.4  11feb2011}{...}
{vieweralsosee "[P] class" "mansection P class"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-2] class" "help m2_class"}{...}
{title:Title}

{p2colset 5 18 20 2}{...}
{p2col :{manlink P class} {hline 2}}Class programming
{p_end}
{p2colreset}{...}


{title:Description}

{pstd}
For information on class programming, see

	Full documentation:
		{help classman}             class programming
        	{helpb classutil}            {cmd:classutil} utility command
		{helpb class exit}           {cmd:class exit} programming command

	Quick reference and syntax diagrams:
		{help classdeclare}         the {cmd:class} command
		{help classassign}          {it:lvalue} {cmd:=} {it:rvalue} details
        	{help classmacro}           {cmd:`.}{it:id}[{cmd:.}{it:id}[...]] ...{cmd:'} substitution
		{help classbi}              built ins


{pstd}
Stata's two programming languages, ado and Mata, each support object-oriented
programming.  {manlink P class} explains object-oriented programming in
ado.  Most users interested in object-oriented programming will wish to do so
in Mata.  See {manhelp m2_class M-2:class} to learn about object-oriented
programming in Mata.

{pstd}
Ado classes are a programming feature of Stata that are especially useful for
dealing with graphics and GUI problems, although their use need not be
restricted to those topics.  Ado class programming is an advanced programming
topic and will not be useful to most programmers.
{p_end}
