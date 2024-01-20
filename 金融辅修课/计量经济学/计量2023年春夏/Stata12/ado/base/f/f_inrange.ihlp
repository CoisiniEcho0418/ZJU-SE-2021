{* *! version 1.0.2  13may2007}{...}
    {cmd:inrange(}{it:z}{cmd:,}{it:a}{cmd:,}{it:b}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain:}all reals or all strings{p_end}
{p2col: Range:}0 or 1{p_end}
{p2col: Description:}returns {cmd:1} if it is known that
        {it:a} {ul:<} {it:z} {ul:<} {it:b}; otherwise,
	returns {cmd:0}.  The following ordered rules apply:{break}
	{it:z} {ul:>} {cmd:.} returns {cmd:0}.{break}
	{it:a} {ul:>} {cmd:.} and {it:b} = {cmd:.} returns {cmd:1}.{break}
	{it:a} {ul:>} {cmd:.} returns {cmd:1} if {it:z} {ul:<} {it:b};
	     otherwise, it returns {cmd:0}.{break}
	{it:b} {ul:>} {cmd:.} returns {cmd:1} if {it:a} {ul:<} {it:z};
	     otherwise, it returns {cmd:0}.{break}
        Otherwise, {cmd:1} is returned if {it:a} {ul:<} {it:z} {ul:<} {it:b}.
	      {break}
        If the arguments are strings, "{cmd:.}" is interpreted as
	{cmd:""}.{p_end}
{p2colreset}{...}
