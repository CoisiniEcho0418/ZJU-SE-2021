{* *! version 1.0.1  16mar2007}{...}
    {cmd:strpos(}{it:s1}{cmd:,}{it:s2}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain {it:s1}:}strings (to be searched){p_end}
{p2col: Domain {it:s2}:}strings (to search for){p_end}
{p2col: Range:}integers 0 to 244{p_end}
{p2col: Description:}returns the position in {it:s1} at which {it:s2} is
                     first found; otherwise, it returns {cmd:0}.{break}
		     {cmd:strpos("this","is")} = {cmd:3}{break}
		     {cmd:strpos("this","it")} = {cmd:0}{p_end}
{p2colreset}{...}
