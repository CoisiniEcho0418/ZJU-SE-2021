{* *! version 1.0.3  02jun2011}{...}
    {cmd:logit(}{it:x}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain:}0 to 1 (exclusive){p_end}
{p2col: Range:}-8e+307 to 8e+307 and {it:missing}{p_end}
{p2col: Description:}returns the log of the odds ratio of {it:x},{break}
	{cmd:logit(}{it:x}{cmd:)} = ln{c -(}{it:x}/(1-{it:x}){c )-}.{p_end}
{p2colreset}{...}
