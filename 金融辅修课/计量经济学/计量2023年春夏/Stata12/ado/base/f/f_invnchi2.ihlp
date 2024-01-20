{* *! version 1.0.1  15mar2007}{...}
    {cmd:invnchi2(}{it:n}{cmd:,}{it:L}{cmd:,}{it:p}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain {it:n}:}integers 1 to 200{p_end}
{p2col: Domain {it:L}:}0 to 1,000{p_end}
{p2col: Domain {it:p}:}0 to 1{p_end}
{p2col: Range:}0 to 8e+307{p_end}
{p2col: Description:}returns the
	inverse cumulative noncentral chi-squared distribution: if
	{cmd:nchi2(}{it:n}{cmd:,}{it:L}{cmd:,}x{cmd:)} = {it:p}, then
	{cmd:invnchi2(}{it:n}{cmd:,}{it:L}{cmd:,}{it:p}{cmd:)} = {it:x};
	{it:n} must be an integer.{p_end}
{p2colreset}{...}
