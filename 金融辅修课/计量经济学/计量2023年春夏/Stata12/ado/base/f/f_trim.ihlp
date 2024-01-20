{* *! version 1.0.1  16mar2007}{...}
    {cmd:trim(}{it:s}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain:}strings{p_end}
{p2col: Range:}strings without leading or trailing blanks{p_end}
{p2col: Description:}returns {it:s} without leading and trailing blanks; 
        equivalent to {cmd:ltrim(rtrim(}{it:s}{cmd:))}.
	{cmd:trim(" this ")} = {cmd:"this"}{p_end}
{p2colreset}{...}
