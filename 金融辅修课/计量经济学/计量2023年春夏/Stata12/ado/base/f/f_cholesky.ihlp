{* *! version 1.0.1  28apr2011}{...}
    {cmd:cholesky(}{it:M}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain:}{it:n} x {it:n}, positive-definite, symmetric matrices{p_end}
{p2col: Range:}{it:n} x {it:n} lower-triangular matrices{p_end}
{p2col: Description:}returns the Cholesky decomposition of the matrix:{break}
             if {it:R} = {cmd:cholesky(}{it:S}{cmd:)}, then 
	     {it:RR}^T = {it:S}.{break}
	     {it:R}^T indicates the transpose of {it:R}.{break}
	     Row and column names are obtained from {it:M}.{p_end}
{p2colreset}{...}
