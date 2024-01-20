{* *! version 1.0.3  02jun2011}{...}
    {cmd:invpoisson(}{it:k}{cmd:,}{it:p}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain {it:k}:}0 to 2^53-1{p_end}
{p2col: Domain {it:p}:}0 to 1 (exclusive){p_end}
{p2col: Range:}1.110e-16 to 2^53{p_end}
{p2col: Description:}returns the Poisson mean such that the 
	cumulative Poisson distribution evaluated at {it:k} is {it:p}: if
	{cmd:poisson(}{it:m}{cmd:,}k{cmd:)} = {it:p}, then
	{cmd:invpoisson(}{it:k}{cmd:,}{it:p}{cmd:)} = {it:m}.{p_end}

{p2col 8 22 22 2:}The inverse Poisson distribution function is evaluated using 
the {cmd:invgammaptail()} function.
{p2colreset}{...}
