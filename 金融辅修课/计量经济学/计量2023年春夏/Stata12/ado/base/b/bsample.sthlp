{smcl}
{* *! version 1.1.5  21mar2011}{...}
{viewerdialog bsample "dialog bsample"}{...}
{vieweralsosee "[R] bsample" "mansection R bsample"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] bootstrap" "help bootstrap"}{...}
{vieweralsosee "[R] bstat" "help bstat"}{...}
{vieweralsosee "[D] sample" "help sample"}{...}
{vieweralsosee "[R] simulate" "help simulate"}{...}
{viewerjumpto "Syntax" "bsample##syntax"}{...}
{viewerjumpto "Description" "bsample##description"}{...}
{viewerjumpto "Options" "bsample##options"}{...}
{viewerjumpto "Examples" "bsample##examples"}{...}
{title:Title}

{p2colset 5 20 22 2}{...}
{p2col :{manlink R bsample} {hline 2}}Sampling with replacement{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 16 2}
{cmd:bsample}
	[{it:exp}]
	{ifin}
	[{cmd:,} {it:options}]

{phang}
where {it:exp} is a standard Stata expression; see {help exp}.

{synoptset 21}{...}
{synopthdr}
{synoptline}
{synopt :{opth str:ata(varlist)}}variables identifying strata{p_end}
{synopt :{opth cl:uster(varlist)}}variables identifying resampling clusters{p_end}
{synopt :{opth id:cluster(newvar)}}create new cluster ID variable{p_end}
{synopt :{opth w:eight(varname)}}replace {it:varname} with frequency weights{p_end}
{synoptline}
{p2colreset}{...}


{title:Menu}

{phang}
{bf:Statistics > Resampling > Draw bootstrap sample}


{marker description}{...}
{title:Description}

{pstd}
{cmd:bsample} draws bootstrap samples (random samples with replacement) from
the data in memory.

{pstd}
{it:{help exp}} specifies the size of the sample, which must be less than or
equal to the number of sampling units in the data.  The observed number of
units is the default when {it:exp} is not specified.

{phang2}
For bootstrap sampling of the observations, {it:exp} must be less
than or equal to {cmd:_N} (the number of observations in the data; see 
{help _N}).

{phang2}
For stratified bootstrap sampling, {it:exp} must be less than or equal to
{cmd:_N} within the strata identified by the {opt strata()} option.

{phang2}
For clustered bootstrap sampling, {it:exp} must be less than or equal to
{it:N_c} (the number of clusters identified by the {opt cluster()}
option).

{phang2}
For stratified bootstrap sampling of clusters, {it:exp} must be less than or
equal to {it:N_c} within the strata identified by the {opt strata()} option.

{pstd}
Observations that do not meet the optional {helpb if} and {helpb in}
criteria are dropped (not sampled).


{marker options}{...}
{title:Options}

{phang}
{opth strata(varlist)} specifies the variables identifying strata.  If
{opt strata()} is specified, bootstrap samples are selected within each stratum.

{phang}
{opth cluster(varlist)} specifies the variables identifying resampling
clusters.  If {opt cluster()} is specified, the sample drawn during each
replication is a bootstrap sample of clusters.

{phang}
{opth idcluster(newvar)} creates a new variable containing a unique
identifier for each resampled cluster.

{phang}
{opth weight(varname)} specifies a variable in which the sampling frequencies
will be placed.  {it:varname} must be an existing variable, which will be
replaced.  After {cmd:bsample}, {it:varname} can be used as an {opt fweight}
in any Stata command that accepts {opt fweight}s, which can speed up
resampling for commands like {cmd:regress} and {cmd:summarize}.  This option
cannot be combined with {opt idcluster()}.

{pmore}
By default, {cmd:bsample} replaces the data in memory with the sampled
observations; however, specifying the {opt weight()} option causes only the
specified {it:varname} to be changed.


{marker examples}{...}
{title:Examples}

    {hline}
{pstd}Setup{p_end}
{phang2}{cmd:. webuse bsample1}{p_end}

{pstd}Take bootstrap sample of size 200{p_end}
{phang2}{cmd:. bsample 200}{p_end}

    {hline}
{pstd}Setup{p_end}
{phang2}{cmd:. webuse bsample1, clear}{p_end}

{pstd}Take bootstrap samples of size 200 separately for females and males{p_end}
{phang2}{cmd:. bsample 200, strata(female)}{p_end}

    {hline}
{pstd}Setup{p_end}
{phang2}{cmd:. webuse bsample1, clear}{p_end}

{pstd}Take bootstrap sample of size 200 from females{p_end}
{phang2}{cmd:. bsample 200 if female}{p_end}

    {hline}
