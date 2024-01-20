{* *! version 1.0.5  02jun2011}{...}
    {cmd:autocode(}{it:x}{cmd:,}{it:n}{cmd:,}{it:x0}{cmd:,}{it:x1}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain {it:x}:}-8e+307 to 8e+307{p_end}
{p2col: Domain {it:n}:}integers 1 to 8e+307{p_end}
{p2col: Domain {it:x0}:}-8e+307 to 8e+307{p_end}
{p2col: Domain {it:x1}:}{it:x0} to 8e+307{p_end}
{p2col: Range:}{it:x0} to {it:x1}{p_end}
{p2col: Description:} partitions the interval from {it:x0} to {it:x1} into
        {it:n} equal-length intervals and returns the upper bound of the
	interval that contains {it:x}.  This function is an automated version
	of {helpb recode()}.
	See {findalias frcatvars} for an example.
	{p_end}
{p2colreset}{...}
