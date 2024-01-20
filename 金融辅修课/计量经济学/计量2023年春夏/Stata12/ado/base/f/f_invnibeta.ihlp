{* *! version 1.0.2  15mar2007}{...}
    {cmd:invnibeta(}{it:a}{cmd:,}{it:b}{cmd:,}{it:L}{cmd:,}{it:p}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain {it:a}:}1e-323 to 8e+307{p_end}
{p2col: Domain {it:b}:}1e-323 to 8e+307{p_end}
{p2col: Domain {it:L}:}0 to 1,000{p_end}
{p2col: Domain {it:p}:}0 to 1{p_end}
{p2col: Range:}0 to 1{p_end}
{p2col: Description:}returns the inverse cumulative noncentral beta
        distribution: if
	{cmd:nibeta(}{it:a}{cmd:,}{it:b}{cmd:,}{it:L}{cmd:,}x{cmd:)} = {it:p},
	then
	{cmd:invnibeta(}{it:a}{cmd:,}{it:b}{cmd:,}{it:L}{cmd:,}{it:p}{cmd:)}
	= {it:x}.{p_end}
{p2colreset}{...}
