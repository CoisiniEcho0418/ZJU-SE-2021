{* *! version 1.0.2  16mar2007}{...}
    {cmd:epsfloat()}
{p2colset 8 22 26 2}{...}
{p2col: Range:}a floating-point number close to 0{p_end}
{p2col: Description:}returns the machine precision of a floating-point
	number.  If {bind:{it:d} < {cmd:epsfloat()}} and (float) {it:x} = 1,
	then {it:x} + {it:d} = (float) 1.  This function takes no arguments,
	but the parentheses must be included.{p_end}
{p2colreset}{...}
