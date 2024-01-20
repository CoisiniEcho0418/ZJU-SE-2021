{* *! version 1.0.1  16mar2007}{...}
    {cmd:strmatch(}{it:s1}{cmd:,}{it:s2}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain:}strings{p_end}
{p2col: Range:}0 or 1{p_end}
{p2col: Description:}returns {cmd:1} if {it:s1} matches the pattern {it:s2};
                     otherwise, it returns {cmd:0}.
		     {cmd:strmatch("17.4","1??4")} returns {cmd:1}. In
		     {it:s2}, {cmd:"?"} means that one character goes here,
		     and {cmd:"*"} means that zero or more characters go here.
		     Also see {helpb regexm()}, {cmd:regexr()}, and 
		     {cmd:regexs()}.
{p2colreset}{...}
