{* *! version 1.0.5  02jun2011}{...}
    {cmd:invbinomialtail(}{it:n}{cmd:,}{it:k}{cmd:,}{it:p}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain {it:n}:}1 to 1e+17{p_end}
{p2col: Domain {it:k}:}1 to {it:n}{p_end}
{p2col: Domain {it:p}:}0 to 1 (exclusive){p_end}
{p2col: Range:}0 to 1{p_end}
{p2col: Description:}returns the inverse of the right cumulative binomial;
        that is, it returns the
	probability of success on one trial such that the probability of
	observing {help floor():{bf:floor(}{it:k}{bf:)}} or more successes in
	{cmd:floor(}{it:n}{cmd:)} trials is {it:p}.{p_end}
{p2colreset}{...}
