{smcl}
{* *! version 2.2.6  11feb2011}{...}
{vieweralsosee "[D] functions" "mansection D functions"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[D] drawnorm" "help drawnorm"}{...}
{vieweralsosee "[D] egen" "help egen"}{...}
{viewerjumpto "Description" "random_number_functions##description"}{...}
{viewerjumpto "Random-number functions" "random_number_functions##functions"}{...}
{viewerjumpto "References" "random_number_functions##references"}{...}
{title:Title}

{p2colset 5 22 24 2}{...}
{p2col :{manlink D functions} {hline 2}}Functions{p_end}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}This is a quick reference on functions for generating pseudorandom 
variates.  For help on all functions, see {manhelp functions D}.  See
{manhelp set_seed R:set seed} for setting the random-number seed.


{marker functions}{...}
{title:Random-number functions}

    {cmd:runiform()}
{p2colset 8 22 26 2}{...}
{p2col: Range:}0 to nearly 1 (0 to 1 - 2^(-32)){p_end}
{p2col: Description:}returns uniform random variates.{p_end}

{p2col 8 22 22 2:}{cmd:runiform()} returns uniformly distributed random
variates on the interval [0,1).  {cmd:runiform()} takes no arguments, but the
parentheses must be typed.  {cmd:runiform()} can be seeded with the 
{cmd:set seed} command. (See {help matrix functions} for the related
{cmd:matuniform()} matrix function.){p_end}

{p2col 8 22 22 2:}To generate random variates over the interval
[{it:a},{it:b}), use {it:a}{cmd:+(}{it:b}{cmd:-}{it:a}{cmd:)*runiform()}.{p_end}

{p2col 8 22 22 2:}To generate random integers over [{it:a},{it:b}],
use {it:a}{cmd:+int((}{it:b}{cmd:-}{it:a}{cmd:+1)*runiform())}.{p_end}
{p2colreset}{...}

    {cmd:rbeta(}{it:a}{cmd:,}{it: b}{cmd:)}
{p2colset 8 22 22 2}{...}
{p2col: Domain {it:a}:}0.05 to 1e+5{p_end}
{p2col: Domain {it:b}:}0.15 to 1e+5{p_end}
{p2col: Range:}0 to 1 (exclusive){p_end}
{p2col: Description:}returns beta({it:a},{it:b}) random variates, where
	{it:a} and {it:b} are the beta distribution shape parameters. 

{p2col 8 22 22 2:}Besides the standard methodology for generating random 
	variates from a given distribution, {cmd:rbeta()} uses the 
	specialized algorithms of Johnk
        ({help random number functions##G2003:Gentle 2003}),
	Atkinson and Wittaker ({help random number functions##AW1970:1970},
                               {help random number functions##AW1976:1976}),
        {help random number functions##D1986:Devroye (1986)}, and 
	{help random number functions##SB1980:Schmeiser and Babu (1980)}.
{p2colreset}{...}

    {cmd:rbinomial(}{it:n}{cmd:,}{it: p}{cmd:)}
{p2colset 8 22 22 2}{...}
{p2col: Domain {it:n}:}1 to 1e+11{p_end}
{p2col: Domain {it:p}:}1e-8 to 1-1e-8{p_end}
{p2col: Range:}0 to {it:n}{p_end}
{p2col: Description:}returns binomial({it:n},{it:p}) random variates, where
	{it:n} is the number of trials and {it:p}
	is the success probability.  

{p2col 8 22 22 2:}Besides the standard methodology for generating random 
	variates from a given distribution, {cmd:rbinomial()} uses the 
	specialized algorithms of 
        {help random number functions##K1982:Kachitvichyanukul (1982)},
	{help random number functions##KS1988:Kachitvichyanukul and Schmeiser (1988)},
        and {help random number functions##K1986:Kemp (1986)}.
{p2colreset}{...}

    {cmd:rchi2(}{it:df}{cmd:)}
{p2colset 8 22 22 2}{...}
{p2col: Domain {it:df}:}2e-4 to 2e+8{p_end}
{p2col: Range:}0 to {cmd:c(maxdouble)}{p_end}
{p2col: Description:}returns chi-squared, with {it:df} degrees of 
	freedom, random variates.
{p2colreset}{...}

    {cmd:rgamma(}{it:a}{cmd:, }{it:b}{cmd:)}
{p2colset 8 22 22 2}{...}
{p2col: Domain {it:a}:}1e-4 to 1e+8{p_end}
{p2col: Domain {it:b}:}{cmd:c(smallestdouble)} to {cmd:c(maxdouble)}{p_end}
{p2col: Range:}0 to {cmd:c(maxdouble)}{p_end}
{p2col: Description:}returns gamma({it:a},{it:b}) random variates, where {it:a} 
	is the gamma shape parameter and {it:b} is the scale parameter.

{p2col 8 22 22 2:}Methods for generating gamma variates are taken from 
	{help random number functions##AD1974:Ahrens and Dieter (1974)},
        {help random number functions##B1983:Best (1983)}, and
        {help random number functions##SL1980:Schmeiser and Lal (1980)}.
{p2colreset}{...}

    {cmd:rhypergeometric(}{it:N}{cmd:,}{it: K}{cmd:,}{it: n}{cmd:)}
{p2colset 8 22 22 2}{...}
{p2col: Domain {it:N}:}2 to 1e+6{p_end}
{p2col: Domain {it:K}:}1 to {it:N-1}{p_end}
{p2col: Domain {it:n}:}1 to {it:N-1}{p_end}
{p2col: Range:}{cmd:max(}0{cmd:,}{it:n-N+K}{cmd:)} to 
{cmd:min(}{it:K,n}{cmd:)}{p_end}
{p2col: Description:}returns hypergeometric random variates.  The
	distribution parameters are integer valued, where 
	{it:N} is the population size, {it:K} is the 
	number of elements in the population that have the attribute of
	interest, and {it:n} is the sample size.  

{p2col 8 22 22 2:}Besides the standard methodology for generating random 
	variates from a given distribution, {cmd:rhypergeometric()} uses 
	the specialized algorithms of 
        {help random number functions##K1982:Kachitvichyanukul (1982)} and 
	{help random number functions##KS1985:Kachitvichyanukul and Schmeiser (1985)}.
{p2colreset}{...}

    {cmd:rnbinomial(}{it:n}{cmd:,}{it: p}{cmd:)}
{p2colset 8 22 22 2}{...}
{p2col: Domain {it:n}:}0.1 to 1e+5{p_end}
{p2col: Domain {it:p}:}1e-4 to 1-1e-4{p_end}
{p2col: Range:}0 to 2^53-1{p_end}
{p2col: Description:}returns negative binomial random variates.
	If {it:n} is integer valued, {cmd:rnbinomial()} returns the number 
	of failures before the {it:n}th success, 
	where the probability of success on a single trial is {it:p}. 
	{it:n} can also be nonintegral.  
{p2colreset}{...}

    {cmd:rnormal()}
{p2colset 8 22 22 2}{...}
{p2col: Range:}{cmd:c(mindouble)} to {cmd:c(maxdouble)}{p_end}
{p2col: Description:}returns standard normal (Gaussian) random variates,
	that is, variates from a normal distribution with a mean of 0 and a 
	standard deviation of 1.  

    {cmd:rnormal(}{it:m}{cmd:)}
{p2colset 8 22 22 2}{...}
{p2col: Domain {it:m}:}{cmd:c(mindouble)} to {cmd:c(maxdouble)}{p_end}
{p2col: Range:}{cmd:c(mindouble)} to {cmd:c(maxdouble)}{p_end}
{p2col: Description:}returns normal({it:m},1) (Gaussian) random variates,
	where {it:m} is the mean and the standard deviation is 1.
{p2colreset}{...}

    {cmd:rnormal(}{it:m}{cmd:,}{it: s}{cmd:)}
{p2colset 8 22 22 2}{...}
{p2col: Domain {it:m}:}{cmd:c(mindouble)} to {cmd:c(maxdouble)}{p_end}
{p2col: Domain {it:s}:}{cmd:c(smallestdouble)} to {cmd:c(maxdouble)}{p_end}
{p2col: Range:}{cmd:c(mindouble)} to {cmd:c(maxdouble)}{p_end}
{p2col: Description:}returns normal({it:m},{it:s}) (Gaussian) random variates,
	where {it:m} is the mean and {it:s} is the standard deviation.
{p2colreset}{...}

{p2col 8 22 22 2:}The methods for generating normal (Gaussian) random variates
are taken from {help random number functions##K1998:Knuth (1998, 122-128)};
{help random number functions##MMB1964:Marsaglia, MacLaren, and Bray (1964)};
and
{help random number functions##W1977:Walker (1977)}.
{p2colreset}{...}

    {cmd:rpoisson(}{it:m}{cmd:)}
{p2colset 8 22 22 2}{...}
{p2col: Domain {it:m}:}1e-6 to 1e+11{p_end}
{p2col: Range:}0 to 2^53-1{p_end}
{p2col: Description:}returns Poisson({it:m}) random variates, where {it:m} 
	is the distribution mean.  

{p2col 8 22 22 2:}Poisson variates are generated using the probability 
	integral transform methods of Kemp and Kemp
         ({help random number functions##KK1990:1990},
          {help random number functions##KK1991:1991}), as well as 
	the method of 
        {help random number functions##K1982:Kachitvichyanukul (1982)}.
{p2colreset}{...}

    {cmd:rt(}{it:df}{cmd:)}
{p2colset 8 22 22 2}{...}
{p2col: Domain {it:df}:}1 to 2^53-1{p_end}
{p2col: Range:}{cmd:c(mindouble)} to {cmd:c(maxdouble)}{p_end}
{p2col: Description:}returns Student's t random variates, where {it:df}
	is the degrees of freedom.  

{p2col 8 22 22 2:}Student's t variates are generated using the method 
	of Kinderman and Monahan
        ({help random number functions##KM1977:1977},
         {help random number functions##KM1980:1980}).
{p2colreset}{...}


{marker references}{...}
{title:References}

{marker AD1974}{...}
{phang}
Ahrens, J. H., and U. Dieter.  1974.  Computer methods for sampling from gamma,
beta, Poisson, and binomial distributions.  {it:Computing} 12: 223-246.

{marker AW1976}{...}
{phang}
Atkinson, A. C., and J. Whittaker.  1976.  A switching algorithm for the 
generation of beta random variables with at least one parameter less
than 1.  {it:Journal of the Royal Statistical Society, Series A}
139: 462-467.

{marker AW1970}{...}
{phang}
------. 1970. Algorithm AS 134: The generation of beta random
variables with one parameter greater than and one parameter less 
than 1.  {it:Applied Statistics} 28: 90-93.

{marker B1983}{...}
{phang}
Best, D. J.  1983.  A note on gamma variate generators with shape parameters
less than unity.  {it:Computing} 30: 185-188.

{marker D1986}{...}
{phang}
Devroye, L.  1986.  {it:Non-uniform Random Variate Generation}.
New York: Springer.

{marker G2003}{...}
{phang}
Gentle, J. E.  2003.  {it:Random Number Generation and Monte Carlo Methods}. 
2nd ed.  New York: Springer.

{marker K1982}{...}
{phang}
Kachitvichyanukul, V.  1982.
Computer Generation of Poisson, Binomial, and Hypergeometric Random Variables.
PhD thesis, Purdue University.

{marker KS1985}{...}
{phang}
Kachitvichyanukul, V., and B. Schmeiser.  1985.  Computer generation
of hypergeometric random variates.
{it:Journal of Statistical Computation and Simulation} 22: 127-145.

{marker KS1988}{...}
{phang}
------.  1988.  Binomial random variate generation.
{it:Communications of the Association for Computing Machinery} 31: 216-222.

{marker K1986}{...}
{phang} 
Kemp, C. D.  1986.  A modal method for generating binomial variates.  
{it:Communications in Statistics: Theory and Methods} 15: 805-813.

{marker KK1990}{...}
{phang} 
Kemp, A. W., and C. D. Kemp.  1990.  A composition-search algorithm for 
low-parameter Poisson generation.
{it:Journal of Statistical Computation and Simulation} 35: 239-244.

{marker KK1991}{...}
{phang} 
Kemp, C. D., and A. W. Kemp.  1991.  Poisson random variate generation. 
{it:Applied Statistics} 40: 143-158.

{marker KM1977}{...}
{phang}
Kinderman, A. J., and J. F. Monahan.  1977.  Computer generation of random
variables using the ratio of uniform deviates.
{it:Association for Computing Machinery Transactions on Mathematical Software}
3: 257-260.

{marker KM1980}{...}
{phang}
------.  1980.  New methods for generating
Student's t and gamma variables.  {it:Computing} 25: 369-377.

{marker K1998}{...}
{phang} 
Knuth, D.  1998.
{it:The Art of Computer Programming, Volume 2: Seminumerical Algorithms}.
3rd ed.  Reading, MA: Addison Wesley.

{marker MMB1964}{...}
{phang} 
Marsaglia, G., M. D. MacLaren, and T. A. Bray.  1964.  A fast procedure for
generating normal random variables.  {it:Communications of the ACM} 7: 4-10.

{marker SB1980}{...}
{phang}
Schmeiser, B. W., and A. J. G. Babu.  1980.  Beta variate generation via 
exponential majorizing functions.  {it:Operations Research} 28: 917-926.

{marker SL1980}{...}
{phang}
Schmeiser, B. W., and R. Lal. 1980.
Squeeze methods for generating gamma variates.
{it:Journal of the American Statistical Association} 75: 679-682.

{marker W1977}{...}
{phang}
Walker, A. J.  1977.  An efficient method for generating discrete random
variables with general distributions.
{it:ACM Transactions on Mathematical Software} 3: 253-256.
{p_end}
