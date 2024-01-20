{* *! version 1.0.2  11may2007}{...}
    {cmd:max(}{it:x1}{cmd:,}{it:x2}{cmd:,}{it:...}{cmd:,}{it:xn}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain {it:x1}:}-8e+307 to 8e+307 and {it:missing}{p_end}
{p2col: Domain {it:x2}:}-8e+307 to 8e+307 and {it:missing}{p_end}
{p2col:...}{p_end}
{p2col: Domain {it:xn}:}-8e+307 to 8e+307 and {it:missing}{p_end}
{p2col: Range:}-8e+307 to 8e+307 and {it:missing}{p_end}
{p2col: Description:}returns the maximum value of {it:x1}, {it:x2}, ...,
        {it:xn}.
	Unless all arguments are {it:missing},
	missing values are ignored.{break}
	{cmd:max(2,10,.,7)} = {cmd:10}{break}
	{cmd:max(.,.,.)} = {cmd:.}{p_end}
{p2colreset}{...}
