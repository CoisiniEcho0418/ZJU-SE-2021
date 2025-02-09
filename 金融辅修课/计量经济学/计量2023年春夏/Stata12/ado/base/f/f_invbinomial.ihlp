{* *! version 1.1.5  02jun2011}{...}
    {cmd:invbinomial(}{it:n}{cmd:,}{it:k}{cmd:,}{it:p}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain {it:n}:}1 to 1e+17{p_end}
{p2col: Domain {it:k}:}0 to {it:n} - 1{p_end}
{p2col: Domain {it:p}:}0 to 1 (exclusive){p_end}
{p2col: Range:}0 to 1{p_end}
{p2col: Description:}returns the inverse of the cumulative binomial; that is,
        it returns the probability of success on one trial such that the
	probability of observing {help floor():{bf:floor(}{it:k}{bf:)}} or fewer
	successes in {cmd:floor(}{it:n}{cmd:)} trials is {it:p}.{p_end}
{p2colreset}{...}
