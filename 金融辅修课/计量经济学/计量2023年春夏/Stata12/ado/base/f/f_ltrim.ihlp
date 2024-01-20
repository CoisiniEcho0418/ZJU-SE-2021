{* *! version 1.0.1  15mar2007}{...}
    {cmd:ltrim(}{it:s}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain:}strings{p_end}
{p2col: Range:}strings without leading blanks{p_end}
{p2col: Description:}returns {it:s} without leading blanks.{break}
                     {cmd:ltrim(" this")} = {cmd:"this"}{p_end}
{p2colreset}{...}
