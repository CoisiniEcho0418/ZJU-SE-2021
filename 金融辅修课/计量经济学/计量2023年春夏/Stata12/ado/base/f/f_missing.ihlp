{* *! version 1.0.2  11may2007}{...}
    {cmd:missing(}{it:x1}{cmd:,}{it:x2}{cmd:,}{it:...}{cmd:,}{it:xn}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain {it:xi}:}any string or numeric expression{p_end}
{p2col: Range:}0 and 1{p_end}
{p2col: Description:}returns {cmd:1} if any of the arguments evaluates to
        {it:missing}; otherwise, returns {cmd:0}.

{p2col 8 22 22 2:}Stata has two concepts of missing values:
	a numeric missing value ({cmd:.}, {cmd:.a}, {cmd:.b}, ...,
	{cmd:.z}) and a string missing value ({cmd:""}). 
	{cmd:missing()} returns {cmd:1} (meaning {it:true}) if any
	expression {it:xi} evaluates to {it:missing}. 
	 If {it:x} is numeric, {cmd:missing(}{it:x}{cmd:)} is 
	 equivalent to {it:x} {ul:>} {cmd:.}. If {it:x} is string,
	 {cmd:missing(}{it:x}{cmd:)} is equivalent to {it:x}{cmd:==""}.
	 {p_end}
{p2colreset}{...}
