{* *! version 1.0.0  12may2011}{...}
    {cmd:Cdhms(}{it:e_d}{cmd:,}{it:h}{cmd:,}{it:m}{cmd:,}{it:s}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain {it:e_d}:}{cmd:%td} dates 01jan0100 to 31dec9999
          (integers -679,350 to 2,936,549){p_end}
{p2col: Domain {it:h}:}integers 0 to 23{p_end}
{p2col: Domain {it:m}:}integers 0 to 59{p_end}
{p2col: Domain {it:s}:}reals 0.000 to 60.999{p_end}
{p2col: Range:}datetimes 01jan0100 00:00:00.000 to 31dec9999 23:59:59.999
           (integers -58,695,840,000,000 to >253,717,919,999,999) and
           {it:missing}{p_end}
{p2col: Description:}returns the {it:e_tC} datetime (ms. with leap seconds
           since 01jan1960 00:00:00.000) corresponding to {it:e_d}, {it:h},
           {it:m}, {it:s}.{p_end}
{p2colreset}{...}
