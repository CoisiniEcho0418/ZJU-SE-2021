{* *! version 1.0.2  30apr2009}{...}
    {cmd:normalden(}{it:z}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain:}-8e+307 to 8e+307{p_end}
{p2col: Range:}0 to 0.39894 ...{p_end}
{p2col: Description:}returns the standard normal density.{p_end}
{p2colreset}{...}

    {cmd:normalden(}{it:z}{cmd:,}{it:s}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain {it:z}:}-8e+307 to 8e+307{p_end}
{p2col: Domain {it:s}:}1e-308 to 8e+307{p_end}
{p2col: Range:}0 to 8e+307{p_end}
{p2col: Description:}returns the rescaled standard
        normal density. {break}
	{cmd:normalden(}{it:z}{cmd:,}1{cmd:)} =
	{cmd:normalden(}{it:x}{cmd:)}  and
	{cmd:normalden(}{it:z}{cmd:,}{it:s}{cmd:)} =
        {cmd:normalden(}{it:z}{cmd:)}/{it:s}.{p_end}
{p2colreset}{...}

    {cmd:normalden(}{it:x}{cmd:,}{it:m}{cmd:,}{it:s}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain {it:x}:}-8e+307 to 8e_307{p_end}
{p2col: Domain {it:m}:}-8e+307 to 8e_307{p_end}
{p2col: Domain {it:s}:}1e-308 to 8e+307{p_end}
{p2col: Range:}0 to 8e+307{p_end}
{p2col: Description:}returns the
	normal density with mean {it:m} and standard deviation {it:s}.{break}
	{cmd:normalden(}{it:x}{cmd:,0,}1{cmd:)} =
	{cmd:normalden(}{it:x}{cmd:)}{break}
	{cmd:normalden(}{it:x}{cmd:,}{it:m}{cmd:,}{it:s}{cmd:)} =
	{cmd:normalden((}{it:x}-{it:m}{cmd:)/}{it:s}{cmd:)/}{it:s}
{p2colreset}{...}
