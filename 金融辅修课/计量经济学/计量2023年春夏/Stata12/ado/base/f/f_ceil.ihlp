{* *! version 1.0.3  11may2007}{...}
    {cmd:ceil(}{it:x}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain:}-8e+307 to 8e+307{p_end}
{p2col: Range:}integers in -8e+307 to 8e+307{p_end}
{p2col: Description:}returns the unique integer {it:n} such that
	{bind:{it:n} - 1 < {it:x} {ul:<} {it:n}}.{p_end}
{p2col:}returns {it:x} (not "{cmd:.}") if {it:x} is missing, meaning that
	{cmd:ceil(.a)} = {cmd:.a}.{p_end}

{p2col:}Also see {help floor():{bf:floor(}{it:x}{bf:)}},
	{help int():{bf:int(}{it:x}{bf:)}}, and
        {help round():{bf:round(}{it:x}{bf:)}}.{p_end}
{p2colreset}{...}
