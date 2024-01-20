{* *! version 1.0.1  15mar2007}{...}
    {cmd:invF(}{it:n1}{cmd:,}{it:n2}{cmd:,}{it:p}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain {it:n1}:}2e-10 to 2e+17 (may be nonintegral){p_end}
{p2col: Domain {it:n2}:}2e-10 to 2e+17 (may be nonintegral){p_end}
{p2col: Domain {it:p}:}0 to 1{p_end}
{p2col: Range:}0 to 8e+307{p_end}
{p2col: Description:}returns the
	inverse cumulative F distribution: if
	{cmd:F(}{it:n1}{cmd:,}{it:n2}{cmd:,}f{cmd:)} = {it:p}, then
	{cmd:invF(}{it:n1}{cmd:,}{it:n2}{cmd:,}{it:p}{cmd:)} = {it:f}.{p_end}
{p2colreset}{...}
