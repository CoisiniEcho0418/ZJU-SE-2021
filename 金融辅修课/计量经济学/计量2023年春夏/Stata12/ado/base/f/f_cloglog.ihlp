{* *! version 1.0.2  09feb2009}{...}
    {cmd:cloglog(}{it:x}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain:}0 to 1{p_end}
{p2col: Range:}-8e+307 to 8e+307{p_end}
{p2col: Description:}returns the complementary log-log of {it:x},{break}
	{cmd:cloglog(}{it:x}{cmd:)} = ln{-ln(1-{it:x})}.{p_end}
{p2colreset}{...}
