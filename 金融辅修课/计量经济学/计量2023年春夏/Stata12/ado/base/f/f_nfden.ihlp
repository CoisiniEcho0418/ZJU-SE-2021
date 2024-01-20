{* *! version 1.0.3  11may2007}{...}
    {cmd:nFden(}{it:n1}{cmd:,}{it:n2}{cmd:,}{it:L}{cmd:,}{it:x}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain {it:n1}:}1e-323 to 8e+307 (may be nonintegral){p_end}
{p2col: Domain {it:n2}:}1e-323 to 8e+307 (may be nonintegral){p_end}
{p2col: Domain {it:L}:}0 to 1,000{p_end}
{p2col: Domain {it:x}:}-8e+307 to 8e+307{p_end}
{p2col: }Interesting domain is {it:f} {ul:>} 0{p_end}
{p2col: Range:}0 to 8e+307{p_end}
{p2col: Description:}returns the probability density function of the
        noncentral F density with {it:n1} numerator and
	{it:n2} denominator degrees of freedom and noncentrality parameter
	{it:L}.{p_end}
{p2col: }returns {cmd:0} if {it:f} < 0.{p_end}

{p2col 8 22 22 2:}{cmd:nFden(}{it:n1}{cmd:,}{it:n2}{cmd:,0,}{it:F}{cmd:)} =
         {cmd:Fden(}{it:n1}{cmd:,}{it:n2}{cmd:,}{it:F}{cmd:)}, but 
	 {cmd:Fden()} is the preferred function to use for the central F
	 distribution.{p_end}

{p2col 8 22 22 2:}Also, if {it:F} follows the noncentral {it:F} distribution
      with {it:n1} and {it:n2} degrees of freedom and noncentrality parameter
      {it:L}, then

                                 {it:n1 F}
		               {hline 9}
		               {it:n2} + {it:n1 F}

{p2col 8 22 22 2:}follows a noncentral beta distribution with shape parameters
            {it:a}={it:v1}/2, {it:b}={it:v2}/2, and noncentrality parameter
	    {it:L}, as given in {cmd:nbetaden()}.  {cmd:nFden()} is computed
	    based on this relationship.{p_end}
{p2colreset}{...}
