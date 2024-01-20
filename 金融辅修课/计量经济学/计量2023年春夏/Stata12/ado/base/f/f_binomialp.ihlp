{* *! version 1.0.4  02jun2011}{...}
    {cmd:binomialp(}{it:n}{cmd:,}{it:k}{cmd:,}{it:p}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain {it:n}:}1 to 1e+6{p_end}
{p2col: Domain {it:k}:}0 to n{p_end}
{p2col: Domain {it:p}:}0 to 1{p_end}
{p2col: Range:}0 to 1{p_end}
{p2col: Description:}returns the probability of observing
        {help floor():{bf:floor(}{it:k}{bf:)}} successes in
	{cmd:floor(}{it:n}{cmd:)} trials when
	the probability of a success on one trial is {it:p}.{p_end}
{p2colreset}{...}
