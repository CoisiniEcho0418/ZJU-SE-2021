{* *! version 1.1.6  16jul2008}{...}
    {cmd:ibeta(}{it:a}{cmd:,}{it:b}{cmd:,}{it:x}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain {it:a}:}1e-10 to 1e+17{p_end}
{p2col: Domain {it:b}:}1e-10 to 1e+17{p_end}
{p2col: Domain {it:x}:}-8e+307 to 8e+307{p_end}
{p2col:}Interesting domain is 0 {ul:<} {it:x} {ul:<} 1{p_end}
{p2col: Range:}0 to 1{p_end}
{p2col: Description:}returns the
	cumulative beta distribution with shape parameters {it:a} and {it:b}
	{p_end}
{p2col: }returns {cmd:0} if {it:x} < 0.{p_end}
{p2col: }returns {cmd:1} if {it:x} > 1.{p_end}

{p2col 8 22 22 2:}{cmd:ibeta()} returns the regularized incomplete
beta function, also known as the incomplete beta function ratio.
The incomplete beta function without regularization is given by
{break}
{cmd:(gamma(}{it:a}{cmd:)*gamma(}{it:b}{cmd:)/gamma(}{it:a}{cmd:+}{it:b}{cmd:))*ibeta(}{it:a}{cmd:,}{it:b}{cmd:,}{it:x}{cmd:)}
{break}
or, better when {it:a} or {it:b} might be large,
{break} 
{cmd:exp(lngamma(}{it:a}{cmd:)+lngamma(}{it:b}{cmd:)-lngamma(}{it:a}{cmd:+}{it:b}{cmd:))*ibeta(}{it:a}{cmd:,}{it:b}{cmd:,}{it:x}{cmd:)}.

{p2col 8 22 22 2:}Here is an example of the use of the regularized
incomplete beta function.  Although Stata has a cumulative binomial function
(see {helpb f_binomiallc:binomial()}), the probability that an event occurs {it:k} or
fewer times in {it:n} trials, when the probability of one event is {it:p}, can
be evaluated as
{cmd:cond(}{it:k}{cmd:==}{it:n}{cmd:,1,1-ibeta(}{it:k}{cmd:+1,}{it:n}{cmd:-}{it:k}{cmd:,}{it:p}{cmd:))}.
The reverse cumulative binomial (the probability that an event occurs {it:k}
or more times) can be evaluated as
{cmd:cond(}{it:k}{cmd:==0,1,ibeta(}{it:k}{cmd:,}{it:n}{cmd:-}{it:k}{cmd:+1,}{it:p}{cmd:))}.{p_end}
{p2colreset}{...}
