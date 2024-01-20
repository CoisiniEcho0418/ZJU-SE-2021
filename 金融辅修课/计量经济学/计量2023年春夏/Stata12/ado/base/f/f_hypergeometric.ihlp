{* *! version 1.0.3  05may2009}{...}
    {cmd:hypergeometric(}{it:N}{cmd:,}{it:K}{cmd:,}{it:n}{cmd:,}{it:k}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain {it:N}:}2 to 1e+5{p_end}
{p2col: Domain {it:K}:}1 to {it:N}-1{p_end}
{p2col: Domain {it:n}:}1 to {it:N}-1{p_end}
{p2col: Domain {it:k}:}{cmd:max(}0{cmd:,}{it:n-N+K}{cmd:)} to 
{cmd:min(}{it:K}{cmd:,}{it:n}{cmd:)}{p_end}
{p2col: Range:}0 to 1{p_end}
{p2col: Description:}returns the cumulative probability of the hypergeometric
	distribution.  {it:N} is the population size, {it:K} is the number of
	elements in the population that have the attribute of interest, and
	{it:n} is the sample size.  Returned is the probability of observing
	{it:k} or fewer elements from a sample of size {it:n} that have
	the attribute of interest.
{p2colreset}{...}
