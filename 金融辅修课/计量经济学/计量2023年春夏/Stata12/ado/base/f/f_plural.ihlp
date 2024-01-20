{* *! version 1.0.3  11may2007}{...}
{pstd}{cmd:plural(}{it:n}{cmd:,}{it:s}{cmd:)} or
    {cmd:plural(}{it:n}{cmd:,}{it:s1}{cmd:,}{it:s2}{cmd:)}{p_end}
{p2colset 8 22 26 2}{...}
{p2col: Domain {it:n}:}real numbers{p_end}
{p2col: Domain {it:s}:}strings{p_end}
{p2col: Domain {it:s1}:}strings{p_end}
{p2col: Domain {it:s2}:}strings{p_end}
{p2col: Range:}strings{p_end}
{p2col: Description:}returns the plural of {it:s}, or {it:s1} in the
        3-argument case, if {bind:{it:n} != +/-1}.
	The plural is formed by adding "s" to {it:s} if you called 
	{cmd:plural(}{it:n}{cmd:,}{it:s}{cmd:)}.  If you called 
	{cmd:plural(}{it:n}{cmd:,}{it:s1}{cmd:,}{it:s2}{cmd:)} and {it:s2}
	begins with the character "{cmd:+}", the plural is formed by
	adding the remainder of {it:s2} to {it:s1}. If {it:s2} begins with the
	character "{cmd:-}", the plural is formed by subtracting the remainder
	of {it:s2} from {it:s1}.  If {it:s2} begins with neither "{cmd:+}"
	nor "{cmd:-}", then the plural is formed by returning {it:s2}.{p_end}
{p2col: }returns {it:s}, or {it:s1} in the 3-argument case, if {it:n} = +/-1.
{p_end}

{p2col 8 26 26 2:}{cmd:plural(1, "horse")} = {cmd:"horse"}{break}
	{cmd:plural(2, "horse")} = {cmd:"horses"}{break}
	{cmd:plural(2, "glass", "+es")} = {cmd:"glasses"}{break}
        {cmd:plural(1, "mouse", "mice")} = {cmd:"mouse"}{break}
        {cmd:plural(2, "mouse", "mice")} = {cmd:"mice"}{break}
	{cmd:plural(2, "abcdefg", "-efg")} = {cmd:"abcd"}{p_end}
{p2colreset}{...}
