{* *! version 1.0.4  21jan2010}{...}
    {cmd:lnnormalden(}{it:z}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain:}-1e+154 to 1e+154{p_end}
{p2col: Range:}-5e+307 to -.91893853 = {cmd:lnnormalden(0)}{p_end}
{p2col: Description:}returns the natural logarithm of the standard normal
                      density.{p_end}
{p2colreset}{...}

    {cmd:lnnormalden(}{it:z}{cmd:,}{it:s}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain {it:z}:}-1e+154 to 1e+154{p_end}
{p2col: Domain {it:s}:}1e-323 to 8e+307{p_end}
{p2col: Range:}-5e+307 to 742.82799{p_end}
{p2col: Description:}returns the natural logarithm
	of the rescaled standard normal density.{break}
	{cmd:lnnormalden(}{it:z}{cmd:,1)} =
        {cmd:lnnormalden(}{it:z}{cmd:)}{break}
	{cmd:lnnormalden(}{it:z}{cmd:,}{it:s}{cmd:)} =
        {cmd:lnnormalden(}{it:z}{cmd:)} - ln({it:s}){p_end}
{p2colreset}{...}

    {cmd:lnnormalden(}{it:x}{cmd:,}{it:m}{cmd:,}{it:s}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain {it:x}:}-8e+307 to 8e+307{p_end}
{p2col: Domain {it:m}:}-8e+307 to 8e+307{p_end}
{p2col: Domain {it:s}:}1e-323 to 8e+307{p_end}
{p2col: Range:}1e-323 to 8e+307{p_end}
{p2col: Description:}returns the
	natural logarithm of the normal density with mean {it:m} and
	standard deviation {it:s}:{break}
	{cmd:lnnormalden(}{it:x}{cmd:,0,1)} = {cmd:lnnormalden(}{it:x}{cmd:)}
     and {cmd:lnnormalden(}{it:x}{cmd:,}{it:m}{cmd:,}{it:s}{cmd:)} =
	{cmd:lnnormalden(}({it:x}-{it:m})/{it:s}{cmd:) -}
	ln({it:s}).{p_end}
{p2colreset}{...}
