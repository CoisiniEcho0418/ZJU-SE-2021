{* *! version 1.0.0  12may2011}{...}
    {cmd:hms(}{it:h}{cmd:,}{it:m}{cmd:,}{it:s}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain {it:h}:}integers 0 to 23{p_end}
{p2col: Domain {it:m}:}integers 0 to 59{p_end}
{p2col: Domain {it:s}:}reals 0.000 to 59.999{p_end}
{p2col: Range:}datetimes 01jan1960 00:00:00.000 to 01jan1960 23:59:59.999
           (integers 0 to 86,399,999 and {it:missing}){p_end}
{p2col: Description:}returns the {it:e_tc} datetimes (ms. since 01jan1960
           00:00:00.000) corresponding to {it:h}, {it:m}, {it:s} on 01jan1960.
           {p_end}
{p2colreset}{...}
