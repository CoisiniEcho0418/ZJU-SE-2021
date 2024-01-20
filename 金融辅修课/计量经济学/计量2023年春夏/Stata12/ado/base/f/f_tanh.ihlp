{* *! version 1.0.2  09feb2009}{...}
    {cmd:tanh(}{it:x}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain:}-8e+307 to 8e+307{p_end}
{p2col: Range:}-1 to 1 and {it:missing}{p_end}
{p2col: Description:}returns the hyperbolic tangent of {it:x},{break}
        {cmd:tanh(}{it:x}{cmd:)} =
	{exp({it:x}) - exp(-{it:x})}/{exp({it:x}) + exp(-{it:x})}.{p_end}
{p2colreset}{...}
