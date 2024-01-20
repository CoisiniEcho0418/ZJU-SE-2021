{smcl}
{* *! version 2.1.3  11feb2011}{...}
{viewerdialog "estimates stats" "dialog estimates_stats"}{...}
{vieweralsosee "[R] estimates stats" "mansection R estimatesstats"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] estimates" "help estimates"}{...}
{viewerjumpto "Syntax" "estimates_stats##syntax"}{...}
{viewerjumpto "Description" "estimates_stats##description"}{...}
{viewerjumpto "Option" "estimates_stats##option"}{...}
{viewerjumpto "Examples" "estimates_stats##examples"}{...}
{viewerjumpto "Saved results" "estimates_stats##saved_results"}{...}
{title:Title}

{p2colset 5 28 30 2}{...}
{p2col :{manlink R estimates stats} {hline 2}}Model statistics{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{opt est:imates} {opt stat:s} 
[{it:namelist}]
[{cmd:,}
{cmd:n(}{it:#}{cmd:)}]


{phang}
where {it:namelist} is a name, a list of names, {cmd:_all}, or 
{cmd:*}.{break}
A name may be {cmd:.}, meaning the current (active) estimates.{break}
{cmd:_all} and {cmd:*} mean the same thing.


{title:Menu}

{phang}
{bf:Statistics > Postestimation > Manage estimation results >}
    {bf:Table of fit statistics}


{marker description}{...}
{title:Description}

{pstd}
{cmd:estimates} {cmd:stats} reports model-selection statistics, including the
Akaike information criterion (AIC) and the Bayesian information criterion
(BIC).  These measures are appropriate for maximum likelihood models.

{pstd}
If {cmd:estimates} {cmd:stats} is used for a non-likelihood-based model,
such as {cmd:qreg}, missing values are reported.


{marker option}{...}
{title:Option}

{phang}
{cmd:n(}{it:#}{cmd:)} specifies the {it:N} to be used in calculating 
    BIC; see {bf:{help bic_note:[R] BIC note}}.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. sysuse auto}{p_end}
{phang2}{cmd:. logistic foreign mpg weight displ}

{pstd}Create a table for the most recent estimation results{p_end}
{phang2}{cmd:. estimates stats}

{pstd}Compare two models{p_end}
{phang2}{cmd:. logistic foreign mpg weight displ}{p_end}
{phang2}{cmd:. estimates store full}{p_end}
{phang2}{cmd:. logistic foreign mpg weight}{p_end}
{phang2}{cmd:. estimates store sub}{p_end}
{phang2}{cmd:. estimates stats full sub}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:estimates} {cmd:stats} saves the following in {cmd:r()}:

	Matrices
{p2col 12 23 25 2:  {cmd:r(S)}}matrix with 6 columns, N, ll0, ll, df, AIC, and
                            BIC rows, corresponding to models in table
{p_end}
