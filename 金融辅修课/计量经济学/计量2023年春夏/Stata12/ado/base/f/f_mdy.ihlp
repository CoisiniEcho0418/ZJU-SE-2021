{* *! version 1.0.0  12may2011}{...}
    {cmd:mdy(}{it:M}{cmd:,}{it:D}{cmd:,}{it:Y}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain {it:M}:}integers 1 to 12{p_end}
{p2col: Domain {it:D}:}integers 1 to 31{p_end}
{p2col: Domain {it:Y}:}integers 0100 to 9999 (but probably 1800 to 2100){p_end}
{p2col: Range:}{cmd:%td} dates 01jan0100 to 31dec9999 (integers -679,350 to
           2,936,549) and {it:missing}{p_end}
{p2col: Description:}returns the {it:e_d} date (days since 01jan1960)
           corresponding to {it:M}, {it:D}, {it:Y}.{p_end}
{p2colreset}{...}
