{* *! version 1.0.5  02jun2011}{...}
    {cmd:nbetaden(}{it:a}{cmd:,}{it:b}{cmd:,}{it:L}{cmd:,}{it:x}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain {it:a}:}1e-323 to 8e+307{p_end}
{p2col: Domain {it:b}:}1e-323 to 8e+307{p_end}
{p2col: Domain {it:L}:}0 to 1,000{p_end}
{p2col: Domain {it:x}:}-8e+307 to 8e+307{p_end}
{p2col: }Interesting domain is 0 {ul:<} {it:x} {ul:<} 1{p_end}
{p2col: Range:}0 to 8e+307{p_end}
{p2col: Description:}returns the probability density function of the noncentral
                     beta distribution, where {it:a} and {it:b} are shape
		     parameters, {it:L} is the noncentrality parameter, and 
		     {it:x} is the value of a beta random variable.{p_end}
{p2col: }returns {cmd:0} if {it:x} < 0 or {it:x} > 1.{p_end}

{p2col 8 22 22 2: }{cmd:nbetaden(}{it:a}{cmd:,}{it:b}{cmd:,0,}{it:x}{cmd:)}=
         {cmd:betaden(}{it:a}{cmd:,}{it:b}{cmd:,}{it:x}{cmd:)}, but 
	 {helpb betaden()} is the preferred function to use for the central beta
	 distribution. {cmd:nbetaden()} is computed using an algorithm
	 described in 
         {help f_nbetaden##JKB1995:Johnson, Kotz, and Balakrishnan (1995)}.
{p2colreset}{...}
