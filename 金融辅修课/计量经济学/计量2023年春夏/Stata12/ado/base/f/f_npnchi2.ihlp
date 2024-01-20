{* *! version 1.0.3  30apr2007}{...}
    {cmd:npnchi2(}{it:n}{cmd:,}{it:x}{cmd:,}{it:p}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain {it:n}:}integers 1 to 200{p_end}
{p2col: Domain {it:x}:}0 to 8e+307{p_end}
{p2col: Domain {it:p}:}1e-138 to 1 - 2^(-52){p_end}
{p2col: Range:}0 to 1,000{p_end}
{p2col: Description:}returns the
	noncentrality parameter, {it:L}, for the noncentral chi-squared:
	if {cmd:nchi2(}{it:n}{cmd:,}{it:L}{cmd:,}{it:x}{cmd:)} =
	{it:p}, then {cmd:npnchi2(}{it:n}{cmd:,}{it:x}{cmd:,}{it:p}{cmd:)}
	= {it:L}.
	{p_end}
{p2colreset}{...}
