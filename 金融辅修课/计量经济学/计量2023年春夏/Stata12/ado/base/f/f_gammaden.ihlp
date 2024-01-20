{* *! version 1.0.4  11may2007}{...}
    {cmd:gammaden(}{it:a}{cmd:,}{it:b}{cmd:,}{it:g}{cmd:,}{it:x}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain {it:a}:}1e-323 to 8e+307{p_end}
{p2col: Domain {it:b}:}1e-323 to 8e+307{p_end}
{p2col: Domain {it:g}:}-8e+307 to 8e+307{p_end}
{p2col: Domain {it:x}:}-8e+307 to 8e+307{p_end}
{p2col: }Interesting domain is {it:x} {ul:>} {it:g}{p_end}
{p2col: Range:}0 to 8e+307{p_end}
{p2col: Description:}returns the probability density function of the gamma
        distribution, where {it:a} is the shape parameter, {it:b} is the
	scale parameter, and {it:g} is the location parameter.{p_end}
{p2col: }returns {cmd:0} if {it:x} < {it:g}.{p_end}
{p2colreset}{...}
