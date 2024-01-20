{* *! version 1.0.5  05may2009}{...}
    {cmd:nbinomialp(}{it:n}{cmd:,}{it:k}{cmd:,}{it:p}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain {it:n}:}1e-10 to 1e+6 (can be nonintegral){p_end}
{p2col: Domain {it:k}:}0 to 1e+10{p_end}
{p2col: Domain {it:p}:}0 to 1 (left exclusive){p_end}
{p2col: Range:}0 to 1{p_end}
{p2col: Description:}returns the negative binomial probability.
	When {it:n} is an integer, {cmd:nbinomialp()} returns the probability 
	of observing exactly {cmd:floor(}{it:k}{cmd:)} failures before the 
	{it:n}th success when the probability of a success on one trial is 
	{it:p}.{p_end}
{p2colreset}{...}
