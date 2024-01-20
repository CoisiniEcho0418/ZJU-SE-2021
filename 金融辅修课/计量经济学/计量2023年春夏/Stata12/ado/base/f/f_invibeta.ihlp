{* *! version 1.0.3  12jun2008}{...}
    {cmd:invibeta(}{it:a}{cmd:,}{it:b},{it:p}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain {it:a}:}1e-10 to 1e+17{p_end}
{p2col: Domain {it:b}:}1e-10 to 1e+17{p_end}
{p2col: Domain {it:p}:}0 to 1{p_end}
{p2col: Range:}0 to 1{p_end}
{p2col: Description:}returns the inverse
	cumulative beta distribution: if
	{cmd:ibeta(}{it:a}{cmd:,}{it:b}{cmd:,}x{cmd:)} = {it:p}, then
	{cmd:invibeta(}{it:a}{cmd:,}{it:b},{it:p}{cmd:)} = {it:x}.{p_end}
{p2colreset}{...}
