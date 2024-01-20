{* *! version 1.0.2  30apr2009}{...}
    {cmd:clip(}{it:x}{cmd:,}{it:a}{cmd:,}{it:b}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain {it:x}:}-8e+307 to 8e+307{p_end}
{p2col: Domain {it:a}:}-8e+307 to 8e+307{p_end}
{p2col: Domain {it:b}:}-8e+307 to 8e+307{p_end}
{p2col: Range:}-8e+307 to 8e+307{p_end}
{p2col: Description:}returns {it:x} if
	{it:a} < {it:x} < {it:b}, {it:b} if {it:x} {ul:>} {it:b}, {it:a} if
	{it:x} {ul:<} {it:a}, and {it:missing} if {it:x} is missing
	or if {it:a} > {it:b}. If {it:a} or {it:b} is missing,
	this is interpreted as {it:a} = -inf or {it:b} = +inf,
	respectively.{p_end}
{p2col: }returns {it:x} if {it:x} is missing.{p_end}
{p2colreset}{...}
