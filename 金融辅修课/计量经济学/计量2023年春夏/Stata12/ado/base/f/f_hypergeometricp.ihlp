{* *! version 1.0.2  10apr2009}{...}
    {cmd:hypergeometricp(}{it:N}{cmd:,}{it:K}{cmd:,}{it:n}{cmd:,}{it:k}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain {it:N}:}2 to 1e+5{p_end}
{p2col: Domain {it:K}:}1 to {it:N}-1{p_end}
{p2col: Domain {it:n}:}1 to {it:N}-1{p_end}
{p2col: Domain {it:k}:}{cmd:max(}0{cmd:,}{it:n-N+K}{cmd:)} to 
{cmd:min(}{it:K}{cmd:,}{it:n}{cmd:)}{p_end}
{p2col: Range:}0 to 1 (right exclusive){p_end}
{p2col: Description:}returns the hypergeometric probability of {it:k} successes
	(where success is obtaining an element with the attribute of interest) 
	out of a sample of size {it:n}, from a population of size {it:N}
	containing {it:K} elements that have the attribute of interest.
{p2colreset}{...}
