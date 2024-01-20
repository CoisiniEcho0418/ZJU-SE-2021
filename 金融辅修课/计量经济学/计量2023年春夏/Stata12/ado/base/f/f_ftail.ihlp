{* *! version 1.0.2  23mar2011}{...}
    {cmd:Ftail(}{it:n1}{cmd:,}{it:n2}{cmd:,}{it:f}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain {it:n1}:}2e-10 to 2e+17 (may be nonintegral){p_end}
{p2col: Domain {it:n2}:}2e-10 to 2e+17 (may be nonintegral){p_end}
{p2col: Domain {it:f}:}-8e+307 to 8e+307{p_end}
{p2col: }Interesting domain is {it:f} {ul:>} 0{p_end}
{p2col: Range:}0 to 1{p_end}
{p2col: Description:}returns the
	reverse cumulative (upper tail or survivor) F distribution with
	{it:n1} numerator and {it:n2} denominator degrees of freedom.
	{cmd:Ftail(}{it:n1}{cmd:,}{it:n2}{cmd:,}{it:f}{cmd:)} =
	1 - {cmd:F(}{it:n1}{cmd:,}{it:n2}{cmd:,}{it:f}{cmd:)}{p_end}
{p2col: }returns {cmd:1} if {it:f} < 0.{p_end}
{p2colreset}{...}
