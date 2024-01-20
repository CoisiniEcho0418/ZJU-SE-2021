{* *! version 1.0.4  02jun2011}{...}
    {cmd:invpoissontail(}{it:k}{cmd:,}{it:q}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain {it:k}:}0 to 2^53-1{p_end}
{p2col: Domain {it:q}:}0 to 1 (exclusive){p_end}
{p2col: Range:}0 to 2^53 (left exclusive){p_end}
{p2col: Description:}returns the Poisson mean such that the 
	reverse cumulative Poisson distribution evaluated at {it:k} is 
	{it:q}: if {cmd:poissontail(}{it:m}{cmd:,}k{cmd:)} = {it:q}, then
	{cmd:invpoissontail(}{it:k}{cmd:,}{it:q}{cmd:)} = {it:m}.{p_end}

{p2col 8 22 22 2:}The inverse of the reverse cumulative Poisson distribution 
function is evaluated using the {cmd:invgammap()} function.
{p2colreset}{...}
