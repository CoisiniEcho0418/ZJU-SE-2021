{* *! version 1.0.4  23mar2011}{...}
    {cmd:invnFtail(}{it:n1}{cmd:,}{it:n2}{cmd:,}{it:L}{cmd:,}{it:p}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain {it:n1}:}1e-323 to 8e+307 (may be nonintegral){p_end}
{p2col: Domain {it:n2}:}1e-323 to 8e+307 (may be nonintegral){p_end}
{p2col: Domain {it:L}:}0 to 1,000{p_end}
{p2col: Domain {it:p}:}0 to 1{p_end}
{p2col: Range:}0 to 8e+307{p_end}
{p2col: Description:}returns the inverse reverse cumulative
        (upper tail or survivor) noncentral F distribution: if
	{cmd:nFtail(}{it:n1}{cmd:,}{it:n2}{cmd:,}{it:L}{cmd:,}{it:f}{cmd:)} =
	{it:p}, then
	{cmd:invnFtail(}{it:n1}{cmd:,}{it:n2}{cmd:,}{it:L}{cmd:,}{it:p}{cmd:)}
	= {it:x}.{p_end}
{p2colreset}{...}
