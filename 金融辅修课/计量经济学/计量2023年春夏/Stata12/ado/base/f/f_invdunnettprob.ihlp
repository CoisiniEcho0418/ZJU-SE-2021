{* *! version 1.0.3  02jun2011}{...}
    {cmd:invdunnettprob(}{it:k}{cmd:,}{it:df}{cmd:,}{it:p}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain {it:k}:}2 to 1e+6{p_end}
{p2col: Domain {it:df}:}2 to 1e+6{p_end}
{p2col: Domain {it:p}:}0 to 1 (right exclusive){p_end}
{p2col: Range:}0 to 8e+307{p_end}
{p2col: Description:}returns the inverse cumulative multiple range distribution 
	that is used in Dunnett's multiple-comparison method with {it:k} 
	ranges and {it:df} degrees of freedom.  If 
	{cmd:dunnettprob(}{it:k}{cmd:,}{it:df}{cmd:,}{it:x}{cmd:)} = {it:p}, then
	{cmd:invdunnettprob(}{it:k}{cmd:,}{it:df}{cmd:,}{it:p}{cmd:)} = {it:x}.{p_end}
	
{p2col 8 22 22 2: }{cmd:invdunnettprob()} is computed using an algorithm
		 described in {help density_functions##M1981:Miller (1981)}.

{p2colreset}{...}
