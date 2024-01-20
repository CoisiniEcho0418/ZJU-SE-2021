{* *! version 1.0.3  09feb2009}{...}
    {cmd:invlogit(}{it:x}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain:}-8e+307 to 8e+307{p_end}
{p2col: Range:}0 to 1 and {it:missing}{p_end}
{p2col: Description:}returns the inverse of the logit function of {it:x},{break}
	{cmd:invlogit(}{it:x}{cmd:)} = exp({it:x})/{1 + exp({it:x})}.{p_end}
{p2colreset}{...}
