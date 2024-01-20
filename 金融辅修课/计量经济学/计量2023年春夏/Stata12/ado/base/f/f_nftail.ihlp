{* *! version 1.0.5  23mar2011}{...}
    {cmd:nFtail(}{it:n1}{cmd:,}{it:n2}{cmd:,}{it:L}{cmd:,}{it:f}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain {it:n1}:}1e-323 to 8e+307 (may be nonintegral){p_end}
{p2col: Domain {it:n2}:}1e-323 to 8e+307 (may be nonintegral){p_end}
{p2col: Domain {it:L}:}0 to 1,000{p_end}
{p2col: Domain {it:f}:}-8e+307 to 8e+307{p_end}
{p2col: }Interesting domain is {it:f} {ul:>} 0{p_end}
{p2col: Range:}0 to 1{p_end}
{p2col: Description:}returns the reverse cumulative (upper tail or survivor)
        noncentral F distribution with {it:n1} numerator and {it:n2}
	denominator degrees of freedom and noncentrality parameter {it:L}.
	{p_end}
{p2col: }returns {cmd:1} if {it:f} < 0.

{p2col 8 22 22 2: }{cmd:nFtail()} is computed using {cmd:nibeta()} based on the
relationship between the noncentral beta and F distributions.
See {help density functions##JKB1995:Johnson, Kotz, and Balakrishnan (1995)}
for more details.{p_end}
{p2colreset}{...}
