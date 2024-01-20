{* *! version 1.0.5  23mar2011}{...}
    {cmd:gammaptail(}{it:a}{cmd:,}{it:x}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain {it:a}:}1e-10 to 1e+17{p_end}
{p2col: Domain {it:x}:}-8e+307 to 8e+307{p_end}
{p2col: }Interesting domain is {it:x} {ul:>} 0{p_end}
{p2col: Range:}0 to 1{p_end}
{p2col: Description:}returns the reverse (upper tail or survivor)
	cumulative gamma distribution with shape parameter {it:a}.
	{p_end}
{p2col: }returns {cmd:1} if {it:x} < 0.{p_end}

{p2col 8 22 22 2:}{cmd:gammaptail()} is also known as the complement to the
incomplete gamma function (ratio).{p_end}
{p2colreset}{...}
