{* *! version 1.0.4  14apr2011}{...}
    {cmd:subinword(}{it:s1}{cmd:,}{it:s2}{cmd:,}{it:s3}{cmd:,}{it:n}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain {it:s1}:}strings (to be substituted for){p_end}
{p2col: Domain {it:s2}:}strings (to be substituted from){p_end}
{p2col: Domain {it:s3}:}strings (to be substituted with){p_end}
{p2col: Domain {it:n}:}integers 0 to 244 and {it:missing}{p_end}
{p2col: Range:}strings{p_end}
{p2col: Description:}returns {it:s1}, where the first {it:n} occurrences 
        in {it:s1} of {it:s2} as a word have been replaced with {it:s3}.
	A word is defined as a space-separated token. A token at the beginning
	or end of {it:s1} is considered space-separated. If 
	{it:n} is {it:missing}, all occurrences are replaced.  Also see
	{helpb regexm()}, {cmd:regexr()}, and {cmd:regexs()}.{p_end}

{p2col 8 26 26 2:}{cmd:subinword("this is this","is","X",1)} = 
                          {cmd:"this X this"}{break}
                  {cmd:subinword("this is this","is","X",.)} =
		          {cmd:"this X this"}{break}
                  {cmd:subinword("this is this","th","X",.)} =
		          {cmd:"this is this"}{p_end}
{p2colreset}{...}
