{* *! version 1.0.0  16mar2007}{...}
    {cmd:el(}{it:s}{cmd:,}{it:i}{cmd:,}{it:j}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain {it:s}:}strings containing matrix name{p_end}
{p2col: Domain {it:i}:}scalars 1 to {cmd:matsize}{p_end}
{p2col: Domain {it:j}:}scalars 1 to {cmd:matsize}{p_end}
{p2col: Range:}scalars -8e+307 to 8e+307 and {it:missing}{p_end}
{p2col: Description:}returns
          {it:s}{cmd:[floor(}{it:i}{cmd:),floor(}{it:j}{cmd:)]}, the
	  {it:i},{it:j} element of the matrix named {it:s}.{p_end}
{p2col: }returns missing if {it:i} or {it:j} are out of range or if matrix
          {it:s} does not exist.{p_end}
{p2colreset}{...}
