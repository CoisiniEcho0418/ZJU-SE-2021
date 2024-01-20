{* *! version 1.0.2  15mar2007}{...}
    {cmd:invgammap(}{it:a}{cmd:,}{it:p}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain {it:a}:}1e-10 to 1e+17{p_end}
{p2col: Domain {it:p}:}0 to 1{p_end}
{p2col: Range:}0 to 8e+307{p_end}
{p2col: Description:}returns the inverse
	cumulative gamma distribution: if
	{cmd:gammap(}{it:a}{cmd:,}x{cmd:)} = {it:p}, then
	{cmd:invgammap(}{it:a}{cmd:,}{it:p}{cmd:)} = {it:x}.{p_end}
{p2colreset}{...}
