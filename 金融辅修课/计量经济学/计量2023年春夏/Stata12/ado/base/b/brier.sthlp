{smcl}
{* *! version 1.1.3  24mar2011}{...}
{viewerdialog brier "dialog brier"}{...}
{vieweralsosee "[R] brier" "mansection R brier"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] logistic" "help logistic"}{...}
{vieweralsosee "[R] logit" "help logit"}{...}
{vieweralsosee "[R] probit" "help probit"}{...}
{viewerjumpto "Syntax" "brier##syntax"}{...}
{viewerjumpto "Description" "brier##description"}{...}
{viewerjumpto "Option" "brier##option"}{...}
{viewerjumpto "Example" "brier##example"}{...}
{viewerjumpto "Saved results" "brier##saved_results"}{...}
{title:Title}

{p2colset 5 18 20 2}{...}
{p2col :{manlink R brier} {hline 2}}Brier score decomposition{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 14 2}
{cmd:brier} {it:outcomevar} {it:forecastvar} {ifin} 
[{cmd:,} {opt g:roup(#)}]

{phang}
{cmd:by} is allowed; see {manhelp by D}.


{title:Menu}

{phang}
{bf:Statistics > Epidemiology and related > Other > Brier score decomposition}


{marker description}{...}
{title:Description}

{pstd}
{cmd:brier} computes the Yates, Sanders, and Murphy decompositions of the
Brier Mean Probability Score.  {it:outcomevar} contains 0/1 values reflecting
the actual outcome of the experiment, and {it:forecastvar} contains the
corresponding probabilities as predicted by, say, logit, probit, or a human
forecaster.


{marker option}{...}
{title:Option}

{dlgtab:Main}

{pstd}
{opt group(#)} specifies the number of groups that will be used to compute the
decomposition.  {cmd:group(10)} is the default.


{marker example}{...}
{title:Example}

{phang}{cmd:. webuse bball}{p_end}
{phang}{cmd:. brier win for, group(5)}{p_end}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:brier} saves the following in {cmd:r()}:

{synoptset 16 tabbed}{...}
{p2col 5 16 20 2: Scalars}{p_end}
{synopt:{cmd:r(p_roc)}}significance of ROC area{p_end}
{synopt:{cmd:r(roc_area)}}ROC area{p_end}
{synopt:{cmd:r(z)}}Spiegelhalter's z statistic{p_end}
{synopt:{cmd:r(p)}}significance of z statistic{p_end}
{synopt:{cmd:r(brier)}}Brier score{p_end}
{synopt:{cmd:r(brier_s)}}Sanders-modified Brier score{p_end}
{synopt:{cmd:r(sanders)}}Sanders resolution{p_end}
{synopt:{cmd:r(oiv)}}outcome index variance{p_end}
{synopt:{cmd:r(murphy)}}Murphy resolution{p_end}
{synopt:{cmd:r(relinsm)}}reliability-in-the-small{p_end}
{synopt:{cmd:r(Var_f)}}forecast variance{p_end}
{synopt:{cmd:r(Var_fex)}}excess forecast variance{p_end}
{synopt:{cmd:r(Var_fmin)}}minimum forecast variance{p_end}
{synopt:{cmd:r(relinla)}}reliability-in-the-large{p_end}
{synopt:{cmd:r(cov_2f)}}2*forecast-outcome-covariance{p_end}
{p2colreset}{...}
