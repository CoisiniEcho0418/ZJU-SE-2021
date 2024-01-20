{* *! version 1.0.1  16mar2007}{...}
    {cmd:rtrim(}{it:s}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain:}strings{p_end}
{p2col: Range:}strings without trailing blanks{p_end}
{p2col: Description:}returns {it:s} without trailing blanks:
                     {cmd:rtrim("this ")} = {cmd:"this"}.{p_end}
{p2colreset}{...}
