{* *! version 1.0.0  16mar2007}{...}
    {cmd:inv(}{it:M}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain:}{it:n} x {it:n} nonsingular matrices{p_end}
{p2col: Range:}{it:n} x {it:n} matrices{p_end}
{p2col: Description:}returns the inverse of the matrix {it:M}.  If {it:M}
is singular, this will result in an error.{p_end}

{p2col 8 22 22 2:}The function {helpb invsym()} should be used in preference
to {cmd:inv()} because {cmd:invsym()} is more accurate.  The row names of the
result are obtained from the column names of {it:M}, and the column names of
the results are obtained from the row names of {it:M}.{p_end}
{p2colreset}{...}
