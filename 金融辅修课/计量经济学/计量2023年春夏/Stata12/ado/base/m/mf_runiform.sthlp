{smcl}
{* *! version 1.3.3  11feb2011}{...}
{vieweralsosee "[M-5] runiform()" "mansection M-5 runiform()"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-4] standard" "help m4_standard"}{...}
{vieweralsosee "[M-4] statistical" "help m4_statistical"}{...}
{viewerjumpto "Syntax" "mf_runiform##syntax"}{...}
{viewerjumpto "Description" "mf_runiform##description"}{...}
{viewerjumpto "Remarks" "mf_runiform##remarks"}{...}
{viewerjumpto "Conformability" "mf_runiform##conformability"}{...}
{viewerjumpto "Diagnostics" "mf_runiform##diagnostics"}{...}
{viewerjumpto "Source code" "mf_runiform##source"}{...}
{viewerjumpto "Reference" "mf_runiform##reference"}{...}
{title:Title}

{p 4 8 2}
{manlink M-5 runiform()} {hline 2} Uniform and nonuniform pseudorandom variates


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:real matrix}{bind:  }
{cmd:runiform(}{it:real scalar r}{cmd:,} {it:real scalar c}{cmd:)}



{p 8 12 2}
{it:string scalar}
{cmd:rseed()}

{p 8 12 2}
{it:void}{bind:         }
{cmd:rseed(}{it:string scalar newseed}{cmd:)}

{p 8 12 2}
{it:void}{bind:         }
{cmd:rseed(}{it:real scalar newseed}{cmd:)}



{p 8 28 2}
{it:real matrix}{bind:  }
{cmd:rbeta(}{it:real scalar r}{cmd:,} {it:real scalar c}{cmd:,}{break}
{it:real matrix a}{cmd:,} {it:real matrix b}{cmd:)}



{p 8 32 2}
{it:real matrix}{bind:  }
{cmd:rbinomial(}{it:real scalar r}{cmd:,} {it:real scalar c}{cmd:,}{break}
{it:real matrix n}{cmd:,} {it:real matrix p}{cmd:)}



{p 8 29 2}
{it:real matrix}{bind:  }
{cmd:rchi2(}{it:real scalar r}{cmd:,} {it:real scalar c}{cmd:,}
{it:real matrix df}{cmd:)}



{p 8 32 2}
{it:real matrix}{bind:  }
{cmd:rdiscrete(}{it:real scalar r}{cmd:,} {it:real scalar c}{cmd:,}
{it:real colvector p}{cmd:)}



{p 8 29 2}
{it:real matrix}{bind:  }
{cmd:rgamma(}{it:real scalar r}{cmd:,} {it:real scalar c}{cmd:,}
{it:real matrix a}{cmd:,} {it:real matrix b}{cmd:)}



{p 8 38 2}
{it:real matrix}{bind:  }
{cmd:rhypergeometric(}{it:real scalar r}{cmd:,} {it:real scalar c}{cmd:,}{break}
{it:real matrix N}{cmd:,} {it: real matrix K}{cmd:,}{break}
{it:real matrix n}{cmd:)}



{p 8 33 2}
{it:real matrix}{bind:  }
{cmd:rnbinomial(}{it:real scalar r}{cmd:,} {it:real scalar c}{cmd:,}{break}
{it:real matrix n}{cmd:,} {it:real matrix p}{cmd:)}



{p 8 30 2}
{it:real matrix}{bind:  }
{cmd:rnormal(}{it:real scalar r}{cmd:,} {it:real scalar c}{cmd:,}{break}
{it:real matrix m}{cmd:,} {it:real matrix s}{cmd:)}



{p 8 31 2}
{it:real matrix}{bind:  }
{cmd:rpoisson(}{it:real scalar r}{cmd:,} {it:real scalar c}{cmd:,}{break}
{it:real matrix m}{cmd:)}



{p 8 31 2}
{it:real matrix}{bind:  }
{cmd:rt(}{it:real scalar r}{cmd:,} {it:real scalar c}{cmd:,} 
{it:real matrix df}{cmd:)}


{marker description}{...}
{title:Description}

{marker runiform}{...}
{p 4 4 2}
{cmd:runiform(}{it:r}{cmd:,} {it:c}{cmd:)} returns an {it:r x c} real matrix
containing uniformly distributed random variates on [0,1).
{cmd:runiform()} is the same function as Stata's {helpb runiform()} function.
{p_end}

{marker seed}{...}
{p 4 4 2}
{cmd:rseed()} returns the current random-variate seed in an encrypted
string form.  {cmd:rseed()} returns the same thing as Stata's
{cmd:c(seed)}; see {bf:{help set_seed:[R] set seed}} and 
{bf:{help creturn:[P] creturn}}.

{p 4 4 2}
{cmd:rseed(}{it:newseed}{cmd:)} sets the seed:  a string previously
obtained from {cmd:rseed()} can be specified for the argument or 
an integer can be specified.  {cmd:rseed()} has the 
same effect as Stata's {cmd:set} {cmd:seed} command; see 
{bf:{help set_seed:[R] set seed}}.{p_end}

{marker rbeta}{...}
{p 4 4 2}
{cmd:rbeta(}{it:r}{cmd:,} {it:c}{cmd:,} {it:a}{cmd:,} {it:b}{cmd:)} 
returns an i{it:r x} j{it:c} real matrix 
containing beta random variates.  The real-valued matrices 
{it:a} and {it:b} contain the beta shape parameters.  The matrices {it:a} 
and {it:b} must be {help m6_glossary##r-conformability:r-conformable}, where 
i = {cmd:max(rows(}{it:a}{cmd:),rows(}{it:b}{cmd:))} and
j = {cmd:max(cols(}{it:a}{cmd:),cols(}{it:b}{cmd:))}.{p_end}

{marker rbinomial}{...}
{p 4 4 2}
{cmd:rbinomial(}{it:r}{cmd:,} {it:c}{cmd:,} {it:n}{cmd:,} {it:p}{cmd:)} 
returns an i{it:r x} j{it:c} real matrix
containing binomial random variates.  The real-valued matrices 
{it:n} and {it:p} contain the number of trials and the probability parameters.
The matrices {it:n} and {it:p} must be
{help m6_glossary##r-conformability:r-conformable},
where i = {cmd:max(rows(}{it:n}{cmd:),rows(}{it:p}{cmd:))} and
j = {cmd:max(cols(}{it:n}{cmd:),cols(}{it:p}{cmd:))}.{p_end}

{marker rchi2}{...}
{p 4 4 2}
{cmd:rchi2(}{it:r}{cmd:,} {it:c}{cmd:,} {it:df}{cmd:)} 
returns an i{it:r x} j{it:c} real matrix containing chi-squared
random variates.  The real-valued matrix {it:df} contains the 
degrees of freedom parameters, where i = {cmd:rows(}{it:df}{cmd:)} and
j = {cmd:cols(}{it:df}{cmd:)}.{p_end}

{marker rdiscrete}{...}
{p 4 4 2}
{cmd:rdiscrete(}{it:r}{cmd:,} {it:c}{cmd:,} {it:p}{cmd:)}
returns an {it:r x c} real matrix containing random
variates from the discrete distribution specified by the probabilities in
the vector {it:p} of length {it:k}.  The range of the discrete variates
is 1, 2, ..., {it:k}.  The alias method of 
{help mf_runiform##W1977:Walker (1977)} is used to 
sample from the discrete distribution.

{marker rgamma}{...}
{p 4 4 2}
{cmd:rgamma(}{it:r}{cmd:,} {it:c}{cmd:,} {it:a}{cmd:,} {it:b}{cmd:)} 
returns an i{it:r x} j{it:c} real matrix containing gamma
random variates.  The real-valued matrices {it:a} and {it:b} 
contain the gamma shape and scale parameters, respectively.
The matrices {it:a} and {it:b} must be
{help m6_glossary##r-conformability:r-conformable},
where i = {cmd:max(rows(}{it:a}{cmd:),rows(}{it:b}{cmd:))} and
j = {cmd:max(cols(}{it:a}{cmd:),cols(}{it:b}{cmd:))}.{p_end}

{marker rhypergeometric}{...}
{p 4 4 2}
{cmd:rhypergeometric(}{it:r}{cmd:,} {it:c}{cmd:,} {it:N}{cmd:,} 
{it:K}{cmd:,} {it:n}{cmd:)} returns an i{it:r x} j{it:c} real matrix containing
hypergeometric random variates.  The integer-valued matrix {it:N}
contains the population sizes, the integer-valued matrix {it:K} 
contains the number of elements in each population that have the attribute of
interest, and the integer-valued matrix {it:n} contains the sample 
size.  The matrices {it:N}, {it:K}, and {it:n} must be 
{help m6_glossary##r-conformability:r-conformable}, where 
i = {cmd:max(rows(}{it:N}{cmd:),rows(}{it:K}{cmd:),rows(}{it:n}{cmd:))} 
and
j = {cmd:max(cols(}{it:N}{cmd:),cols(}{it:K}{cmd:),cols(}{it:n}{cmd:))}.
{p_end}

{marker rnbinomial}{...}
{p 4 4 2}
{cmd:rnbinomial(}{it:r}{cmd:,} {it:c}{cmd:,} {it:n}{cmd:,} {it:p}{cmd:)}
returns an i{it:r x} j{it:c} real matrix containing negative binomial
random variates.  When the elements of the matrix {it:n} are 
integer-valued, {cmd:rnbinomial()} returns the number of failures 
before the {it:n}th success, where the probability
of success on a single draw is contained in the real-valued matrix 
{it:p}.  The elements of {it:n} can also be nonintegral but must be positive.
The matrices {it:n} and {it:p} must be
{help m6_glossary##r-conformability:r-conformable},
where i = {cmd:max(rows(}{it:n}{cmd:),rows(}{it:p}{cmd:))} and
j = {cmd:max(cols(}{it:n}{cmd:),cols(}{it:p}{cmd:))}.{p_end}

{marker rnormal}{...}
{p 4 4 2}
{cmd:rnormal(}{it:r}{cmd:,} {it:c}{cmd:,} {it:m}{cmd:,} {it:s}{cmd:)} 
returns an i{it:r x} j{it:c} real matrix containing normal (Gaussian)
random variates.  The real-valued matrices {it:m} and {it:s} contain
the mean and standard deviation parameters, respectively.
The matrices {it:m} and {it:s} must be
{help m6_glossary##r-conformability:r-conformable},
where i = {cmd:max(rows(}{it:m}{cmd:),rows(}{it:s}{cmd:))} and
j = {cmd:max(cols(}{it:m}{cmd:),cols(}{it:s}{cmd:))}.{p_end}

{marker rpoisson}{...}
{p 4 4 2}
{cmd:rpoisson(}{it:r}{cmd:,} {it:c}{cmd:,} {it:m}{cmd:)} returns an 
i{it:r x} j{it:c} real matrix containing Poisson random variates.  The 
real-valued matrix {it:m} contains the Poisson mean parameters,
where i = {cmd:rows(}{it:m}{cmd:)} and j = {cmd:cols(}{it:m}{cmd:)}.
{p_end}

{marker rt}{...}
{p 4 4 2}
{cmd:rt(}{it:r}{cmd:,} {it:c}{cmd:,} {it:df}{cmd:)} returns an 
i{it:r x} j{it:c} real matrix containing Student's t random
variates.  The real-valued matrix {it:df} contains the 
degrees-of-freedom parameters, where i = {cmd:rows(}{it:df}{cmd:)} and
j = {cmd:cols(}{it:df}{cmd:)}.{p_end}


{marker remarks}{...}
{title:Remarks}

{p 4 4 2}
The functions described here generate random variates.  The parameter
limits for each generator are the same as those documented for Stata's
{help random-number functions}, except for {cmd:rdiscrete()}, which
has no Stata equivalent.

{p 4 4 2}
In the example below, we generate and summarize 1,000 random normal
deviates with a mean of 3 and standard deviation of 1.

	: {cmd:rseed(13579)}
	: {cmd:x = rnormal(1000, 1, 3, 1)}
	: {cmd:meanvariance(x)}
	{res}      {txt}           1
            {c TLC}{hline 15}{c TRC}
	  1 {c |}  {res}3.002713574{txt}  {c |}
	  2 {c |}  {res}.9843730019{txt}  {c |}
	    {c BLC}{hline 15}{c BRC}{txt}

{p 4 4 2}
The next example uses a 1 {it:x} 3 vector of gamma shape parameters to
generate a 1000 {it:x} 3 matrix of gamma random variates, {cmd:X}.

	: {cmd:a = (0.5,1.5,2.5)}
	: {cmd:rseed(13579)}
	: {cmd:X = rgamma(1000,1,a,1)}
	: {cmd:mean(X)}
	{res}       {txt}          1             2             3
            {c TLC}{hline 43}{c TRC}
	  1 {c |}  {res}.5339343609   1.510028772   2.451447187{txt}  {c |}
            {c BLC}{hline 43}{c BRC}{txt}

	: {cmd:diagonal(variance(X))'}
        {res}    {txt}    1             2             3
            {c TLC}{hline 43}{c TRC}
	  1 {c |}  {res}.6129729256   1.669457192   2.284915684{txt}  {c |}
            {c BLC}{hline 43}{c BRC}{txt}

{p 4 4 2}
The first column of {cmd:X} contains gamma variates with shape parameter 0.5,
the second column contains gamma variates with shape parameter 1.5, and the
third column contains gamma variates with shape parameter 2.5.

{p 4 4 2}
Below we generate a 4 {it:x} 3 matrix of beta variates where we demonstrate
the use of two r-conformable parameter matrices, {cmd:a} and {cmd:b}.

	: {cmd:a = (0.5,1.5,2.5)}
	: {cmd:b = (0.5,0.75,1.0\1.25,1.5,1.75)}
	: {cmd:rseed(13579)}
	: {cmd:rbeta(2,1,a,b)}
	{res}      {txt}           1             2             3
            {c TLC}{hline 43}{c TRC}
	  1 {c |}   .668359305   .3238859912   .7785175363  {c |}
	  2 {c |}   .266459731   .7665943496    .634730294  {c |}
	  3 {c |}  .0373430126   .9246702534    .851879254  {c |}
	  4 {c |}  .1903514438   .5012842811   .8759050005  {c |}
            {c BLC}{hline 43}{c BRC}{txt}

{p 4 4 2}
The 4 {it:x} 3 shape-parameter matrices used to generate these beta 
variates are given below:

	: {cmd:J(2,1,J(rows(b),1,a))}
	{res}   {txt}      1     2     3
            {c TLC}{hline 19}{c TRC}
	  1 {c |}   .5   1.5   2.5  {c |}
	  2 {c |}   .5   1.5   2.5  {c |}
	  3 {c |}   .5   1.5   2.5  {c |}
	  4 {c |}   .5   1.5   2.5  {c |}
            {c BLC}{hline 19}{c BRC}{txt}

	: {cmd:J(2,1,b)}
	{res}    {txt}      1      2      3
            {c TLC}{hline 22}{c TRC}
	  1 {c |}    .5    .75      1  {c |}
	  2 {c |}  1.25    1.5   1.75  {c |}
	  3 {c |}    .5    .75      1  {c |}
	  4 {c |}  1.25    1.5   1.75  {c |}
            {c BLC}{hline 22}{c BRC}{txt}


{marker conformability}{...}
{title:Conformability}

    {cmd:runiform(}{it:r}{cmd:,} {it:c}{cmd:)}:
		{it:r}:  1 {it:x} 1
		{it:c}:  1 {it:x} 1
	   {it:result}:  {it:r x c}

    {cmd:rseed()}:
	   {it:result}:  1 {it:x} 1

    {cmd:rseed(}{it:newseed}{cmd:)}:
	  {it:newseed}:  1 {it:x} 1
	   {it:result}:  {it:void}

    {cmd:rbeta(}{it:r}{cmd:,} {it:c}{cmd:,} {it:a}{cmd:,} {it:b}{cmd:)}:
		{it:r}:  1 {it:x} 1
		{it:c}:  1 {it:x} 1
		{it:a}:  1 {it:x} 1 or i {it:x} 1 or 1 {it:x} j or i {it:x} j
		{it:b}:  1 {it:x} 1 or i {it:x} 1 or 1 {it:x} j or i {it:x} j
	   {it:result}:  {it:r x c} or i{it:r} {it:x} {it:c} or {it:r} {it:x} j{it:c} or i{it:r} {it:x} j{it:c}

    {cmd:rbinomial(}{it:r}{cmd:,} {it:c}{cmd:,} {it:n}{cmd:,} {it:p}{cmd:,}{cmd:)}:
		{it:r}:  1 {it:x} 1
		{it:c}:  1 {it:x} 1
		{it:n}:  1 {it:x} 1 or i {it:x} 1 or 1 {it:x} j or i {it:x} j 
		{it:p}:  1 {it:x} 1 or i {it:x} 1 or 1 {it:x} j or i {it:x} j 
	   {it:result}:  {it:r x c} or i{it:r} {it:x} {it:c} or {it:r} {it:x} j{it:c} or i{it:r} {it:x} j{it:c}

    {cmd:rchi2(}{it:r}{cmd:,} {it:c}{cmd:,} {it:df}{cmd:)}:
		{it:r}:  1 {it:x} 1
		{it:c}:  1 {it:x} 1
	       {it:df}:  i {it:x} j
	   {it:result}:  i{it:r x} j{it:c}

    {cmd:rdiscrete(}{it:r}{cmd:, }{it:c}{cmd:, }{it:p}{cmd:)}:
		{it:r}:  1 {it:x} 1
		{it:c}:  1 {it:x} 1
		{it:p}:  {it:k x} 1 
	   {it:result}:  {it:r x c}

    {cmd:rgamma(}{it:r}{cmd:,} {it:c}{cmd:,} {it:a}{cmd:,} {it:b}{cmd:)}:
		{it:r}:  1 {it:x} 1
		{it:c}:  1 {it:x} 1
		{it:a}:  1 {it:x} 1 or i {it:x} 1 or 1 {it:x} j or i {it:x} j
		{it:b}:  1 {it:x} 1 or i {it:x} 1 or 1 {it:x} j or i {it:x} j
	   {it:result}:  {it:r x c} or i{it:r} {it:x} {it:c} or {it:r} {it:x} j{it:c} or i{it:r} {it:x} j{it:c}

    {cmd:rhypergeometric(}{it:r}{cmd:,} {it:c}{cmd:,} {it:N}{cmd:,} {it:K}{cmd:,} {it:n}{cmd:)}:
		{it:r}:  1 {it:x} 1
		{it:c}:  1 {it:x} 1
		{it:N}:  1 {it:x} 1 
		{it:K}:  1 {it:x} 1 or i {it:x} 1 or 1 {it:x} j or i {it:x} j 
		{it:n}:  1 {it:x} 1 or i {it:x} 1 or 1 {it:x} j or i {it:x} j 
	   {it:result}:  {it:r x c} or i{it:r} {it:x} {it:c} or {it:r} {it:x} j{it:c} or i{it:r} {it:x} j{it:c}

    {cmd:rnbinomial(}{it:r}{cmd:,} {it:c}{cmd:,} {it:n}{cmd:,} {it:p}{cmd:)}:
		{it:r}:  1 {it:x} 1
		{it:c}:  1 {it:x} 1
		{it:n}:  1 {it:x} 1 or i {it:x} 1 or 1 {it:x} j or i {it:x} j 
		{it:p}:  1 {it:x} 1 or i {it:x} 1 or 1 {it:x} j or i {it:x} j 
	   {it:result}:  {it:r x c} or i{it:r} {it:x} {it:c} or {it:r} {it:x} j{it:c} or i{it:r} {it:x} j{it:c}

    {cmd:rnormal(}{it:r}{cmd:,} {it:c}{cmd:,} {it:m}{cmd:,} {it:s}{cmd:)}:
		{it:r}:  1 {it:x} 1
		{it:c}:  1 {it:x} 1
		{it:m}:  1 {it:x} 1 or i {it:x} 1 or 1 {it:x} j or i {it:x} j 
		{it:s}:  1 {it:x} 1 or i {it:x} 1 or 1 {it:x} j or i {it:x} j 
	   {it:result}:  {it:r x c} or i{it:r} {it:x} {it:c} or {it:r} {it:x} j{it:c} or i{it:r} {it:x} j{it:c}

    {cmd:rpoisson(}{it:r}{cmd:,} {it:c}{cmd:,} {it:m}{cmd:)}:
		{it:r}:  1 {it:x} 1
		{it:c}:  1 {it:x} 1
		{it:m}:  i {it:x} j
	   {it:result}:  i{it:r x} j{it:c}

    {cmd:rt(}{it:r}{cmd:,} {it:c}{cmd:,} {it:df}{cmd:)}:
		{it:r}:  1 {it:x} 1
		{it:c}:  1 {it:x} 1
	       {it:df}:  1 {it:x} 1 or i {it:x} 1 or 1 {it:x} j or i {it:x} j
	   {it:result}:  {it:r x c} or i{it:r} {it:x} {it:c} or {it:r} {it:x} j{it:c} or i{it:r} {it:x} j{it:c}


{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
All random-variate generators abort with error if {it:r<0} or {it:c<0}.

{p 4 4 2}
{cmd:rseed(}{it:seed}{cmd:)} aborts with error if a string seed is
specified and it is malformed (was not obtained from {cmd:rseed()}).

{p 4 4 2} 
{cmd:rnormal(}{it:r}{cmd:,} {it:c}{cmd:,} {it:m}{cmd:,} {it:s}{cmd:)}, 
{cmd:rbeta(}{it:r}{cmd:,} {it:c}{cmd:,} {it:a}{cmd:,} {it:b}{cmd:)}, 
{cmd:rbinomial(}{it:r}{cmd:,} {it:c}{cmd:,} {it:n}{cmd:,} {it:p}{cmd:)}, 
{cmd:rhypergeometric(}{it:r}{cmd:,} {it:c}{cmd:,} {it:N}{cmd:,} {it:K}{cmd:,}
{it:n}{cmd:)},
and {cmd:rnbinomial(}{it:r}{cmd:,} {it:c}{cmd:,} {it:k}{cmd:,} {it:p}{cmd:)} 
abort with an error if the parameter matrices do not conform.  See 
{it:{help m6_glossary##r-conformability:r-conformability}}
in {helpb m6_glossary:[M-6] Glossary} for rules on matrix conformability.

{p 4 4 2} 
{cmd:rdiscrete()} aborts with error if the probabilities in {it:p} 
are not in [0,1] or do not sum to 1.


{marker source}{...}
{title:Source code}

{p 4 4 2}
Functions are built in.


{marker reference}{...}
{title:Reference}

{marker W1977}{...}
{phang}
Walker, A. J.  1977.  An efficient method for generating discrete random
variables with general distributions.
{it:ACM Transactions on Mathematical Software} 3: 253-256.
{p_end}
