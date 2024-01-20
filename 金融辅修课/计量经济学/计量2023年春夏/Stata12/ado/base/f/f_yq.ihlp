{* *! version 1.0.0  12may2011}{...}
    {cmd:yq(}{it:Y}{cmd:,}{it:Q}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain {it:Y}:}integers 1000 to 9999 (but probably 1800 to 2100){p_end}
{p2col: Domain {it:Q}:}integers 1 to 4{p_end}
{p2col: Range:}{cmd:%tq} dates 1000q1 to 9999q4
                    (integers -3,840 to 32,159){p_end}
{p2col: Description:}returns the {it:e_q} quarterly date (quarters since
               1960q1) corresponding to  year {it:Y}, quarter {it:Q}.{p_end}
{p2colreset}{...}
