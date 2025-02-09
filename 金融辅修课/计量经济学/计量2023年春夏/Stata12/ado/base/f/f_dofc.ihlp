{* *! version 1.0.0  12may2011}{...}
    {cmd:dofC(}{it:e_tC}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain {it:e_tC}:}datetimes 01jan0100 00:00:00.000 to
           31dec9999 23:59:59.999
           (integers -58,695,840,000,000 to >253,717,919,999,999){p_end}
{p2col: Range:}{cmd:%td} dates 01jan0100 to 31dec9999
           (integers -679,350 to 2,936,549){p_end}
{p2col: Description:}returns the {it:e_d} date (days since 01jan1960) of
           datetime {it:e_tC} (ms. with leap seconds
           since 01jan1960 00:00:00.000).{p_end}
{p2colreset}{...}

    {cmd:dofc(}{it:e_tc}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain {it:e_tc}:}datetimes 01jan0100 00:00:00.000 to
           31dec9999 23:59:59.999
           (integers -58,695,840,000,000 to 253,717,919,999,999){p_end}
{p2col: Range:}{cmd:%td} dates 01jan0100 to 31dec9999
           (integers -679,350 to 2,936,549){p_end}
{p2col: Description:}returns the {it:e_d} date (days since 01jan1960) of
           datetime {it:e_tC} (ms. since 01jan1960 00:00:00.000).{p_end}
{p2colreset}{...}
