{* *! version 1.0.3  05may2009}{...}
    {cmd:poissontail(}{it:m}{cmd:,}{it:k}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain {it:m}:}1e-10 to 2^53-1{p_end}
{p2col: Domain {it:k}:}0 to 2^53-1{p_end}
{p2col: Range:}0 to 1{p_end}
{p2col: Description:}returns the probability of observing 
{cmd:floor(}{it:k}{cmd:)} or more outcomes that are 
distributed as Poisson with mean {it:m}.{p_end}

{p2col 8 22 22 2:}The reverse cumulative Poisson distribution function is 
evaluated using the {cmd:gammap()} function.
{p2colreset}{...}
