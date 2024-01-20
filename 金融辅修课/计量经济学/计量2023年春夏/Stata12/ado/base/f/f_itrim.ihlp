{* *! version 1.0.1  16mar2007}{...}
    {cmd:itrim(}{it:s}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain:}strings{p_end}
{p2col: Range:}strings with no multiple, consecutive internal blanks{p_end}
{p2col: Description:}returns {it:s} with multiple, consecutive internal
	blanks collapsed to one blank.{break}
	{cmd:itrim("hello}{space 5}{cmd:there")} =
	{cmd:"hello there"}
{p_end}
{p2colreset}{...}
