{* *! version 1.0.6  02jun2011}{...}
    {cmd:int(}{it:x}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain:}-8e+307 to 8e+307{p_end}
{p2col: Range:}integers in -8e+307 to 8e+307{p_end}
{p2col: Description:}returns the integer obtained by truncating {it:x} toward
                     0; thus,{break}
                     {cmd:int(5.2)} = 5{break}
	             {cmd:int(-5.8)} = -5{p_end}
{p2col:}returns {it:x} (not "{cmd:.}") if {it:x} is missing, meaning that
	{cmd:int(.a)} = {cmd:.a}.{p_end}

{p2col 8 22 22 2:}One way to obtain the closest integer to {it:x} is 
        {cmd:int(}{it:x}{cmd:+sign(}{it:x}{cmd:)/2)}, which simplifies to
	{cmd:int(}{it:x}{cmd:+0.5)} for {it:x} {ul:>} 0.  However, use of the
	{cmd:round()} function is preferred.  Also see
	{help round():{bf:round(}{it:x}{bf:)}},
	{help ceil():{bf:ceil(}{it:x}{bf:)}}, and
        {help floor():{bf:floor(}{it:x}{bf:)}}.{p_end}
{p2colreset}{...}
