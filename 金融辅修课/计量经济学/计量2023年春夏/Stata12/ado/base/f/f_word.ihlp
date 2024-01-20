{* *! version 1.0.1  16mar2007}{...}
    {cmd:word(}{it:s}{cmd:,}{it:n}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain {it:s}:}strings{p_end}
{p2col: Domain {it:n}:}integers ...,-2,-1,0,1,2,...{p_end}
{p2col: Range:}strings{p_end}
{p2col: Description:}returns the {it:n}th word in {it:s}.
        Positive numbers count words from the beginning of
	{it:s}, and negative numbers count words from the
	end of {it:s}. ({cmd:1} is the first word in {it:s}, and {cmd:-1}
	is the last word in {it:s}.)  Returns {it:missing} ({cmd:""}) if 
	{it:n} is missing.{p_end}
{p2colreset}{...}
