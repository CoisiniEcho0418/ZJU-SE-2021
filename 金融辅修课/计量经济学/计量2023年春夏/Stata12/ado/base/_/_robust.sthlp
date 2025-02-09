{smcl}
{* *! version 1.1.8  03may2011}{...}
{vieweralsosee "[P] _robust" "mansection P _robust"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[P] ereturn" "help ereturn"}{...}
{vieweralsosee "[R] ml" "help ml"}{...}
{vieweralsosee "[R] regress" "help regress"}{...}
{vieweralsosee "[SVY] svy" "help svy"}{...}
{vieweralsosee "[U] 20 Estimation and postestimation commands (estimation)" "help estcom"}{...}
{viewerjumpto "Syntax" "_robust##syntax"}{...}
{viewerjumpto "Description" "_robust##description"}{...}
{viewerjumpto "Options" "_robust##options"}{...}
{viewerjumpto "Examples" "_robust##examples"}{...}
{viewerjumpto "Saved results" "_robust##saved_results"}{...}
{title:Title}

{p2colset 5 20 22 2}{...}
{p2col :{manlink P _robust} {hline 2}}Robust variance estimates{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 16 2}{cmd:_robust} {varlist} {ifin} {weight}
	[{cmd:,} {cmdab:v:ariance:(}{it:matname}{cmd:)}
	{cmd:minus(}{it:#}{cmd:)}
	{opth str:ata(varname)}
	{opth psu(varname)}
	{opth cl:uster(varname)}
	{opth fpc(varname)}
	{opth sub:pop(varname)}
	{cmd:vsrs(}{it:matname}{cmd:)}
	{cmdab:srs:subpop}
	{cmdab:zero:weight}]

{phang}
{cmd:_robust} works with models that have all types of varlists, including
those with factor variables and times-series operators; see
{help fvvarlist} and {help tsvarlist}.{p_end}
{phang}
{cmd:pweight}s, {cmd:aweight}s, {cmd:fweight}s, and {cmd:iweight}s are
allowed; see {help weight}.


{marker description}{...}
{title:Description}

{pstd}
{cmd:_robust} is a programmer's command that computes a robust variance
estimator based on a {varlist} of equation-level scores and a covariance
matrix.  It produces estimators for ordinary data (each observation
independent), clustered data (data not independent within groups, but
independent across groups), and complex survey data from one stage of
stratified cluster sampling.

{pstd}
See {manlink P _robust} for a full description of this command.


{marker options}{...}
{title:Options}

{phang}{cmd:variance(}{it:matname}{cmd:)} specifies a matrix containing the
unadjusted "covariance" matrix, that is, the D in V=DMD.  The matrix must have
its rows and columns labeled with the appropriate corresponding variable
names, that is, the names of the {it:x}s in xb.  If there are multiple
equations, the matrix must have equation names; see
{manhelp matrix_rownames P:matrix rownames}.  The D is
overwritten with the robust covariance matrix V.  If {cmd:variance()} is not
specified, Stata assumes that D has been posted using {cmd:ereturn post};
{cmd:_robust} will then automatically post the robust covariance matrix V and
replace D.

{phang}{cmd:minus(}{it:#}{cmd:)} specifies k={it:#} for the multiplier n/(n-k)
of the robust variance estimators.  Stata's maximum likelihood commands use
k=1, and so does the {cmd:svy} prefix.  {cmd:regress, vce(robust)} uses, by
default, this multiplier with k equal to the number of explanatory variables
in the model, including the constant.  The default is {cmd:minus(1)}.
See {mansection P _robustMethodsandformulas:{it:Methods and formulas}}
for details.

{phang}{opth strata(varname)} specifies the name of a variable
(numeric or string) that contains stratum identifiers.

{phang}{opth psu(varname)} specifies the name of a variable (numeric
or string) that contains identifiers for the primary sampling unit (PSU).
{cmd:psu()} and {cmd:cluster()} are synonyms; they both specify the same
thing.

{phang}{opth cluster(varname)} is a synonym for {cmd:psu()}.

{phang}{opth fpc(varname)} requests a finite population correction
for the variance estimates.  If the variable specified has values <= 1, it is
interpreted as a stratum sampling rate f_h = n_h/N_h, where n_h = number of
PSUs sampled from stratum h and N_h = total number of PSUs in the population
belonging to stratum h.  If the variable specified has values greater than 1,
it is interpreted as containing N_h.

{phang}{opth subpop(varname)} specifies that estimates be computed
for the single subpopulation defined by observations for which {it:varname}!=0
(and is not missing).  This option would typically be used only with survey
data; see {manlink SVY subpopulation estimation}.

{phang}{cmd:vsrs(}{it:matname}{cmd:)} creates a matrix containing V_srswor, an
estimate of the variance that would have been observed had the data been
collected using simple random sampling without replacement.  This is used to compute design effects for survey data; see {manhelp estat_svy SVY:estat}.

{phang}{cmd:srssubpop} can only be specified if {cmd:vsrs()} and
{cmd:subpop()} are specified. {cmd:srssubpop} requests that the estimate of
simple-random-sampling variance, {cmd:vsrs()}, be computed assuming sampling
within a subpopulation.  If {cmd:srssubpop} is not specified, it is computed
assuming sampling from the entire population.

{phang}{cmd:zeroweight} specifies whether observations with weights equal to
zero should be omitted from the computation.  This option does not apply to
{cmd:fweight}s; observations with 0 {cmd:fweight}s are always omitted.  If
{cmd:zeroweight} is specified, observations with zero weights are included in
the computation.  If {cmd:zeroweight} is not specified (the default),
observations with zero weights are omitted.  Including the observations with
zero weights affects the computation in that it may change the counts of PSUs
(clusters) per stratum.  Stata's {cmd:svy} prefix command includes
observations with zero weights; all other commands exclude them.  This option
is typically used only with survey data.


{marker examples}{...}
{title:Examples}

{phang2}{cmd:. webuse _robust}{p_end}
{phang2}{cmd:. regress mpg weight gear_ratio foreign, mse1}{p_end}
{phang2}{cmd:. matrix D = e(V)}{p_end}
{phang2}{cmd:. predict double e, residual}{p_end}
{phang2}{cmd:. _robust e, v(D) minus(4)}{p_end}
{phang2}{cmd:. matrix list D}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:_robust} saves the following in {cmd:r()}:

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Scalars}{p_end}
{synopt:{cmd:r(N)}}number of observation{p_end}
{synopt:{cmd:r(N_sub)}}subpopulation observations{p_end}
{synopt:{cmd:r(N_strata)}}number of strata{p_end}
{synopt:{cmd:r(N_clust)}}number of clusters (PSUs){p_end}
{synopt:{cmd:r(singleton)}}{cmd:1} if singleton strata, {cmd:0} otherwise{p_end}
{synopt:{cmd:r(census)}}{cmd:1} if census data, {cmd:0} otherwise{p_end}
{synopt:{cmd:r(df_r)}}variance degrees of freedom{p_end}
{synopt:{cmd:r(sum_w)}}sum of weights{p_end}
{synopt:{cmd:r(N_subpop)}}number of observations for subpopulation
({cmd:subpop()} only){p_end}
{synopt:{cmd:r(sum_wsub)}}sum of weights for subpopulation ({cmd:subpop()}
only){p_end}

{synoptset 22 tabbed}{...}
{p2col 5 22 24 2: Macros}{p_end}
{synopt:{cmd:r(subpop)}}{it:subpop} from {cmd:subpop()}{p_end}

{pstd}
{cmd:r(N_strata)} and {cmd:r(N_clust)} are alway set. If the
{cmd:strata()} option is not specified, then {cmd:r(N_strata)} = 1 (there truly
is one stratum). If neither the {cmd:cluster()} nor the {cmd:psu()} option is
specified, then {cmd:r(N_clust)} equals the number of observations (each
observation is a PSU).

{pstd}
When {cmd:_robust} alters the post of {cmd:ereturn post}, it also saves the
following in {cmd:e()}:

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Macros}{p_end}
{synopt:{cmd:e(vcetype)}}{cmd:Robust}{p_end}
{synopt:{cmd:e(clustvar)}}name of cluster (PSU) variable{p_end}
{p2colreset}{...}
