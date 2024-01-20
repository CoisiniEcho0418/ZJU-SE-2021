{* *! version 1.0.4  30apr2009}{...}
    {cmd:sum(}{it:x}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain:}all real numbers and {it:missing}{p_end}
{p2col: Range:}-8e+307 to 8e+307 (excluding {it:missing}){p_end}
{p2col: Description:}returns the running sum of {it:x},
	treating missing values as zero.{p_end}
	
{p2col 8 22 22 2:}For example, following the command
{cmd:generate y=sum(x)}, the {it:j}th observation on {cmd:y} contains the sum
of the first through {it:j}th observations on {cmd:x}.  See {manhelp egen D}
for an alternative sum function, {cmd:total()}, that produces a constant equal
to the overall sum.{p_end}
{p2colreset}{...}
