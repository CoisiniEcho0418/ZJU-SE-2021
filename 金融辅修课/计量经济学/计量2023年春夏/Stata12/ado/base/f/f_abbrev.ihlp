{* *! version 1.0.4  15mar2011}{...}
    {cmd:abbrev(}{it:s},{it:n}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain {it:s}:}strings{p_end}
{p2col: Domain {it:n}:}5 to 32{p_end}
{p2col: Range:}strings{p_end}
{p2col: Description:}returns name {it:s}, abbreviated to {it:n} characters.
{p_end}

{p2col 8 22 22 2:}If any of the characters of {it:s} are a period, "{cmd:.}",
and {it:n} < 8, then the value {it:n} defaults to a value of 8.  Otherwise, if
{it:n} < 5, then {it:n} defaults to a value of 5.  If {it:n} is {it:missing},
{cmd:abbrev()} will return the entire string {it:s}. {cmd:abbrev()} is
typically used with variable names and variable names with factor-variable or
time-series operators (the period case). 
{cmd:abbrev("displacement",8)} is {cmd:displa~t}.{p_end}
{p2colreset}{...}
