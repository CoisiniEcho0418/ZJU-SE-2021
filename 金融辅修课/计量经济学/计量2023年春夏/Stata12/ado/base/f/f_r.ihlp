{* *! version 1.0.4  02jun2011}{...}
    {cmd:r(}{it:name}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain:}names{p_end}
{p2col: Range:}strings, scalars, matrices, and {it:missing}{p_end}
{p2col: Description:}returns the value of saved  result
             {cmd:r(}{it:name}{cmd:)}; see {findalias frresult}.{p_end}
{p2col 8 26 40 2:}{cmd:r(}{it:name}{cmd:)} = scalar missing if the saved
                     result does not exist{p_end}
{p2col 8 26 40 2:}{cmd:r(}{it:name}{cmd:)} = specified matrix if the saved
                     result is a matrix{p_end}
{p2col 8 26 40 2:}{cmd:r(}{it:name}{cmd:)} = scalar numeric value if the saved
                     result is a scalar that can be interpreted as a number
		     {p_end}
{p2col 8 26 40 2:}{cmd:r(}{it:name}{cmd:)} = a string containing the first 244
                     characters if the saved result is a string{p_end}
{p2colreset}{...}
