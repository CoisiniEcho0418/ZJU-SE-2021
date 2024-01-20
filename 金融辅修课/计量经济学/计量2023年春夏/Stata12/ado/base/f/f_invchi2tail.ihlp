{* *! version 1.0.1  15mar2007}{...}
    {cmd:invchi2tail(}{it:n}{cmd:,}{it:p}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain {it:n}:}2e-10 to 2e+17 (may be nonintegral){p_end}
{p2col: Domain {it:p}:}0 to 1{p_end}
{p2col: Range:}0 to 8e+307{p_end}
{p2col: Description:}returns the inverse of
	{cmd:chi2tail()}: if {cmd:chi2tail(}{it:n}{cmd:,}x{cmd:)} = {it:p},
	then {cmd:invchi2tail(}{it:n}{cmd:,}{it:p}{cmd:)} = {it:x}.{p_end}
{p2colreset}{...}
