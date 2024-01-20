{* *! version 1.0.4  10apr2009}{...}
    {cmd:invnbinomialtail(}{it:n}{cmd:,}{it:k}{cmd:,}{it:q}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain {it:n}:}1e-10 to 1e+17 (can be nonintegral){p_end}
{p2col: Domain {it:k}:}1 to 2^53-1{p_end}
{p2col: Domain {it:q}:}0 to 1 (exclusive){p_end}
{p2col: Range:}0 to 1 (exclusive){p_end}
{p2col: Description:}returns the value of the negative binomial parameter,
{it:p}, such that 
{it:q = }{cmd:nbinomialtail(}{it:n}{cmd:,}{it:k}{cmd:,}{it:p}{cmd:)}.{p_end}

{p2col 8 22 22 2:}{cmd:invnbinomialtail()} is evaluated using 
{cmd:invibetatail()}.{p_end}
{p2colreset}{...}
