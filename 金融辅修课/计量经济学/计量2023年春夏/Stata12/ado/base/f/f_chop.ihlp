{* *! version 1.0.1  16mar2007}{...}
    {cmd:chop(}{it:x}{cmd:,}{it:tol}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain {it:x}:}-8e+307 to 8e+307{p_end}
{p2col: Domain {it:tol}:}-8e+307 to 8e+307{p_end}
{p2col: Range:}-8e+307 to 8e+307{p_end}
{p2col: Description:}returns
	{cmd:round(}{it:x}{cmd:)} if
        {cmd:abs(}{it:x}{cmd:-round(}{it:x}{cmd:))} < {it:tol}; otherwise,
        returns {it:x}.{p_end}
{p2col: }returns {it:x} if {it:x} is missing.{p_end}
{p2colreset}{...}
