{* *! version 1.0.0  16mar2007}{...}
    {cmd:invsym(}{it:M}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain:}{it:n} x {it:n} symmetric matrices{p_end}
{p2col: Range:}{it:n} x {it:n} symmetric matrices{p_end}
{p2col: Description:}returns the inverse of the {it:M} if {it:M} is positive
definite.  If {it:M} is not positive definite, rows will be inverted until the
diagonal terms are zero or negative; the rows and columns corresponding to
these terms will be set to 0, producing a g2 inverse.  The row names of the
result are obtained from the column names of {it:M}, and the column names of
the result are obtained from the row names of {it:M}.{p_end}
{p2colreset}{...}
