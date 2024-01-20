{* *! version 1.0.0  16mar2007}{...}
    {cmd:rownumb(}{it:M}{cmd:,}{it:s}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain {it:M}:}matrices{p_end}
{p2col: Domain {it:s}:}strings{p_end}
{p2col: Range:}integer scalars 1 to {cmd:matsize} and {it:missing}{p_end}
{p2col: Description:}returns the row number of {it:M} associated with row name
               {it:s}.{p_end}
{p2col: }returns {it:missing} if the row cannot be found.{p_end}
{p2colreset}{...}
