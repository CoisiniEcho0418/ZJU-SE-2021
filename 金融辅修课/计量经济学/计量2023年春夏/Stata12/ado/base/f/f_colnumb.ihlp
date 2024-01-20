{* *! version 1.0.1  02jun2011}{...}
    {cmd:colnumb(}{it:M}{cmd:,}{it:s}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain {it:M}:}matrices{p_end}
{p2col: Domain {it:s}:}strings{p_end}
{p2col: Range:}integer scalars 1 to {cmd:matsize} and {it:missing}{p_end}
{p2col: Description:}returns the column number of {it:M} associated with
              column name {it:s}.{p_end}
{p2col: }returns {it:missing} if the column cannot be found.{p_end}
{p2colreset}{...}
