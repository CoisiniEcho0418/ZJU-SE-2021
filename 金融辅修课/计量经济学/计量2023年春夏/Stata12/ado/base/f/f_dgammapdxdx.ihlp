{* *! version 1.0.2  15mar2007}{...}
    {cmd:dgammapdxdx(}{it:a}{cmd:,}{it:x}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain {it:a}:}1e-10 to 1e+17{p_end}
{p2col: Domain {it:x}:}-8e+307 to 8e+307{p_end}
{p2col: }Interesting domain is {it:x} {ul:>} 0{p_end}
{p2col: Range:}0 to 1e+40{p_end}
{p2col: Description:}returns the 2nd partial
	derivative of the cumulative gamma distribution
	{cmd:gammap(}{it:a}{cmd:,}{it:x}{cmd:)}
	with respect to {it:x}, for {it:a} > 0.{p_end}
{p2col: }returns {cmd:0} if {it:x} < 0.{p_end}
{p2colreset}{...}
