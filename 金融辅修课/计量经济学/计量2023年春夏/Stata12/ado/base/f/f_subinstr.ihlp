{* *! version 1.0.1  16mar2007}{...}
    {cmd:subinstr(}{it:s1}{cmd:,}{it:s2}{cmd:,}{it:s3}{cmd:,}{it:n}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain {it:s1}:}strings (to be substituted into){p_end}
{p2col: Domain {it:s2}:}strings (to be substituted from){p_end}
{p2col: Domain {it:s3}:}strings (to be substituted with){p_end}
{p2col: Domain {it:n}:}integers 0 to 244 and {it:missing}{p_end}
{p2col: Range:}strings{p_end}
{p2col: Description:}returns {it:s1}, where the first {it:n} occurrences
        in {it:s1} of {it:s2} have been replaced with {it:s3}.  If {it:n} is
	{it:missing}, all occurrences are replaced. Also see
	{helpb regexm()}, {cmd:regexr()}, and {cmd:regexs()}.{p_end}

{p2col 8 26 26 2:}{cmd:subinstr("this is this","is","X",1)} = 
	          {cmd:"thX is this"}{break}
        {cmd:subinstr("this is this","is","X",2)} =
	          {cmd:"thX X this"}{break}
        {cmd:subinstr("this is this","is","X",.)} = 
	          {cmd:"thX X thX"}{p_end}
{p2colreset}{...}
