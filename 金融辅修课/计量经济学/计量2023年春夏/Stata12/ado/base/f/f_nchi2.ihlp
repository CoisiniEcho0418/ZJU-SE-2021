{* *! version 1.0.4  04nov2010}{...}
    {cmd:nchi2(}{it:n}{cmd:,}{it:L}{cmd:,}{it:x}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain {it:n}:}integers 1 to 200{p_end}
{p2col: Domain {it:L}:}0 to 1,000{p_end}
{p2col: Domain {it:x}:}-8e+307 to 8e+307{p_end}
{p2col: }Interesting domain is {it:x} {ul:>} 0{p_end}
{p2col: Range:}0 to 1{p_end}
{p2col: Description:}returns the
	cumulative noncentral chi-squared distribution, where {it:n}
	denotes the degrees of freedom, {it:L} is the noncentrality parameter,
	and {it:x} is the value of chi-squared.{p_end}
{p2col: }returns {cmd:0} if {it:x} < 0.{p_end}

{p2col 8 22 22 2: }{cmd:nchi2(}{it:n}{cmd:,0,}{it:x}{cmd:)} = 
         {cmd:chi2(}{it:n}{cmd:,}{it:x}{cmd:)}, but {cmd:chi2()} is the
	 preferred function to use for the central chi-squared distribution.
	 {cmd:nchi2()} is computed using the algorithm of 
	 {help density_functions##HGL1970:Haynam, Govindarajulu, and Leone (1970)}.
{p_end}
{p2colreset}{...}
