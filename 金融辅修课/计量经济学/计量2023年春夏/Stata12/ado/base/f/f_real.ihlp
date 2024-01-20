{* *! version 1.0.1  16mar2007}{...}
    {cmd:real(}{it:s}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain:}strings{p_end}
{p2col: Range:}-8e+307 to 8e+307 and {it:missing}{p_end}
{p2col: Description:}returns {it:s} converted to numeric, or returns
	{it:missing}.{break}
	{cmd:real("5.2")+1} = {cmd:6.2}{break}
	{cmd:real("hello")} = {cmd:.}{p_end}
{p2colreset}{...}
