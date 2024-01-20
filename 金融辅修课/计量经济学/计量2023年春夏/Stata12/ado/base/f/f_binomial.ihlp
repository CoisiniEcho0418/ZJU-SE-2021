{* *! version 1.0.4  02jun2011}{...}
    {cmd:binomial(}{it:n}{cmd:,}{it:k}{cmd:,}{it:p}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain {it:n}:}0 to 1e+17{p_end}
{p2col: Domain {it:k}:}-8e+307 to 8e+307{p_end}
{p2col:}Interesting domain is 0 {ul:<} {it:k} < {it:n}{p_end}
{p2col: Domain {it:p}:}0 to 1{p_end}
{p2col: Range:}0 to 1{p_end}
{p2col: Description:}returns the probability of observing
        {help floor():{bf:floor(}{it:k}{bf:)}} or fewer successes in
	{cmd:floor(}{it:n}{cmd:)} trials when
	the probability of a success on one trial is {it:p}.{p_end}
{p2col:}returns {cmd:0} if {it:k} < 0.{p_end}
{p2col:}returns {cmd:1} if {it:k} > {it:n}.{p_end}
{p2colreset}{...}
