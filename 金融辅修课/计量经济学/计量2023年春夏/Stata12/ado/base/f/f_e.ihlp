{* *! version 1.0.3  02jun2011}{...}
    {cmd:e(}{it:name}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain:}names{p_end}
{p2col: Range:}strings, scalars, matrices, and {it:missing}{p_end}
{p2col: Description:}returns the value of saved  result
             {cmd:e(}{it:name}{cmd:)}; see {findalias frresult}.{p_end}
{p2col 8 26 40 2:}{cmd:e(}{it:name}{cmd:)} = scalar missing if the saved
                     result does not exist{p_end}
{p2col 8 26 40 2:}{cmd:e(}{it:name}{cmd:)} = specified matrix if the saved
                     result is a matrix{p_end}
{p2col 8 26 40 2:}{cmd:e(}{it:name}{cmd:)} = scalar numeric value if the saved
                     result is a scalar{p_end}
{p2col 8 26 40 2:}{cmd:e(}{it:name}{cmd:)} = a string containing the first 244
                     characters if the saved result is a string{p_end}
{p2colreset}{...}

    {cmd:e(sample)}
{p2colset 8 22 26 2}{...}
{p2col: Range:}0 to 1{p_end}
{p2col: Description:}returns {cmd:1} if the observation is in the
	estimation subsample and {cmd:0} otherwise.{p_end}
{p2colreset}{...}
