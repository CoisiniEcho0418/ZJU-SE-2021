{* *! version 1.0.1  16mar2007}{...}
    {cmd:substr(}{it:s}{cmd:,}{it:n1}{cmd:,}{it:n2}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain {it:s}:}strings{p_end}
{p2col: Domain {it:n1}:}integers 1 to 244 and -1 to -244{p_end}
{p2col: Domain {it:n2}:}integers 1 to 244 and -1 to -244{p_end}
{p2col: Range:}strings{p_end}
{p2col: Description:}returns the
	substring of {it:s}, starting at column {it:n1}, for a length of
	{it:n2}. If {it:n1} < 0, {it:n1} is interpreted as distance from the
	end of the string; if {it:n2} = {cmd:.} ({it:missing}),
	the remaining portion of the string is returned.{p_end}

{p2col 8 26 26 2:}{cmd:substr("abcdef",2,3)} = {cmd:"bcd"}{break}
                  {cmd:substr("abcdef",-3,2)} = {cmd:"de"}{break}
		  {cmd:substr("abcdef",2,.)} = {cmd:"bcdef"}{break}
		  {cmd:substr("abcdef",-3,.)} = {cmd:"def"}{break}
		  {cmd:substr("abcdef",2,0)} = {cmd:""}{break}
		  {cmd:substr("abcdef",15,2)} = {cmd:""}{break}
{p2colreset}{...}
