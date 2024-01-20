{* *! version 1.0.1  16mar2007}{...}
    {cmd:indexnot(}{it:s1}{cmd:,}{it:s2}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain {it:s1}:}strings (to be searched){p_end}
{p2col: Domain {it:s2}:}strings of individual characters (to search for){p_end}
{p2col: Range:}integers 0 to 244{p_end}
{p2col: Description:}returns the position in {it:s1} of
	the first character of {it:s1} not found in {it:s2}, or {cmd:0} if all
	characters of {it:s1} are found in {it:s2}.{p_end}
{p2colreset}{...}
