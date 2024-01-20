{* *! version 1.0.4  05may2009}{...}
    {cmd:poissonp(}{it:m}{cmd:,}{it:k}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain {it:m}:}1e-10 to 1e+8{p_end}
{p2col: Domain {it:k}:}0 to 1e+9{p_end}
{p2col: Range:}0 to 1{p_end}
{p2col: Description:}returns the probability of observing 
{cmd:floor(}{it:k}{cmd:)} outcomes that are 
distributed as Poisson with mean {it:m}.{p_end}

{p2col 8 22 22 2:}The Poisson probability function is evaluated using 
the {cmd:gammaden()} function.
{p2colreset}{...}
