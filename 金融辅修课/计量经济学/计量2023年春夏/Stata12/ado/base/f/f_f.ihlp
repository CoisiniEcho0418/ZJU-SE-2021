{* *! version 1.0.1  15mar2007}{...}
    {cmd:F(}{it:n1}{cmd:,}{it:n2}{cmd:,}{it:f}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain {it:n1}:}2e-10 to 2e+17 (may be nonintegral){p_end}
{p2col: Domain {it:n2}:}2e-10 to 2e+17 (may be nonintegral){p_end}
{p2col: Domain {it:f}:}-8e+307 to 8e+307{p_end}
{p2col: }Interesting domain is {it:f} {ul:>} 0{p_end}
{p2col: Range:}0 to 1{p_end}
{p2col: Description:}returns the
	cumulative F distribution with {it:n1} numerator and {it:n2}
	denominator degrees of freedom.{p_end}
{p2col: }returns {cmd:0} if {it:f} < 0.{p_end}
{p2colreset}{...}
