{* *! version 1.0.4  02jun2011}{...}
    {cmd:chi2(}{it:n}{cmd:,}{it:x}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain {it:n}:}2e-10 to 2e+17 (may be nonintegral){p_end}
{p2col: Domain {it:x}:}-8e+307 to 8e+307{p_end}
{p2col:}Interesting domain is {it:x} {ul:>} 0{p_end}
{p2col: Range:}0 to 1{p_end}
{p2col: Description:}returns the cumulative
	chi-squared distribution with {it:n} degrees of freedom,
	{cmd:chi2(}{it:n}{cmd:,}{it:x}{cmd:)} =
	{help gammap():{bf:gammap(}{it:n}/2{bf:,}{it:x}/2{bf:)}}.{p_end}
{p2col: }returns {cmd:0} if {it:x} < 0.{p_end}
{p2colreset}{...}
