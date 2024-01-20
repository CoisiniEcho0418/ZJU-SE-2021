{* *! version 1.0.3  11may2007}{...}
    {cmd:twithin(}{it:d1}{cmd:,} {it:d2}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain {it:d1}:}date or time literals recorded in units of {it:t}
                previously {cmd:tsset}{p_end}
{p2col: Domain {it:d2}:}date or time literals recorded in units of {it:t}
                previously {cmd:tsset}{p_end}
{p2col: Range:}0 and 1, 1 means {it:true}{p_end}
{p2col: Description:}{it:true} if {it:d1} < {it:t} < {it:d2}, where {it:t} is
the time variable previously {cmd:tsset}; see the {helpb tin()} function;
{cmd:twithin()} is similar, except the range is exclusive.{p_end}
{p2colreset}{...}
