{* *! version 1.0.4  02jun2011}{...}
    {cmd:irecode(}{it:x}{cmd:,}{it:x1}{cmd:,}{it:x2}{cmd:,}{it:...}{cmd:,}{it:xn}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain {it:x}:}-8e+307 to 8e+307{p_end}
{p2col: Domain {it:xi}:}-8e+307 to 8e+307{p_end}
{p2col: Range:}nonnegative integers{p_end}
{p2col: Description:}returns {it:missing} if {it:x} is missing or
	{it:x1},{it:x2},...,{it:xn} is not weakly increasing.{p_end}
{p2col: }returns {cmd:0} if {it:x} {ul:<} {it:x1}.{p_end}
{p2col: }returns {cmd:1} if {it:x1} < {it:x} {ul:<} {it:x2}.{p_end}
{p2col: }returns {cmd:2} if {it:x2} < {it:x} {ul:<} {it:x3}.{p_end}
{p2col: }...{p_end}
{p2col: }returns {it:n} if {it:x} > {it:xn}.{p_end}

{p2col 8 22 22 2:}Also see {helpb autocode()} and {helpb recode()} for
	other styles of recode functions.{p_end}

{p2col 8 22 26 2:}{cmd:irecode(3, -10, -5, -3, -3, 0, 15, .)} = {cmd:5}
{p_end}
{p2colreset}{...}
