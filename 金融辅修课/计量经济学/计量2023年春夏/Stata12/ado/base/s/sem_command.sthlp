{smcl}
{* *! version 1.0.1  07jul2011}{...}
{viewerdialog "SEM Builder" "stata sembuilder"}{...}
{vieweralsosee "[SEM] sem" "mansection SEM sem"}{...}
{vieweralsosee "[SEM] intro 1" "mansection SEM intro1"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[SEM] sem estimation options" "help sem_estimation_options"}{...}
{vieweralsosee "[SEM] sem group options" "help sem_group_options"}{...}
{vieweralsosee "[SEM] sem model description options" "help sem_model_options"}{...}
{vieweralsosee "[SEM] sem path notation" "help sem_path_notation"}{...}
{vieweralsosee "[SEM] sem postestimation" "help sem_postestimation"}{...}
{vieweralsosee "[SEM] sem reporting options" "help sem_reporting_options"}{...}
{vieweralsosee "[SEM] sem ssd options" "help sem_ssd_options"}{...}
{vieweralsosee "[SEM] sem syntax options" "help sem_syntax_options"}{...}
{viewerjumpto "Syntax" "sem_command##syntax"}{...}
{viewerjumpto "Description" "sem_command##description"}{...}
{viewerjumpto "Options" "sem_command##options"}{...}
{viewerjumpto "Remarks" "sem_command##remarks"}{...}
{viewerjumpto "Examples" "sem_command##examples"}{...}
{viewerjumpto "Saved results" "sem_command##saved_results"}{...}
{title:Title}

{p2colset 5 18 20 2}{...}
{p2col:{manlink SEM sem} {hline 2}}Structural equation model estimation
command{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{cmd:sem} {it:paths} {ifin} {weight} [{cmd:,} {it:options}]

{pstd}
where
{it:paths} are the paths of the model in command-language path notation; see
{helpb sem_path_notation:[SEM] sem path notation}.{p_end}

{synoptset 30}{...}
{synopthdr:options}
{synoptline}
{synopt :{help sem_command##model_options:{it:model_description_options}}}fully
define, along with {it:paths}, the model to be fit{p_end}

{synopt :{help sem_command##group_options:{it:group_options}}}fit model for different groups{p_end}

{synopt :{help sem_command##ssd_options:{it:ssd_options}}}for use with summary
statistics data{p_end}

{synopt :{help sem_command##estimation_options:{it:estimation_options}}}method used to
obtain estimation results{p_end}

{synopt :{help sem_command##reporting_options:{it:reporting_options}}}reporting of
estimation results{p_end}

{synopt :{help sem_command##syntax_options:{it:syntax_options}}}controlling
interpretation of syntax{p_end}
{synoptline}


{synoptset 30 tabbed}{...}
{marker model_options}{...}
{synopthdr:model_description_options}
{synoptline}
{p2coldent :* {opt cov:ariance()}}path notation for treatment of
covariances{p_end}
{p2coldent :* {opt var:iance()}}path notation for treatment of
variances{p_end}
{p2coldent :* {opt mean:s()}}path notation for treatment of means{p_end}
{p2coldent :* {opt covstr:ucture()}}alternative method to place restrictions
on covariances{p_end}
{synopt :{opt nocon:stant}}do not fit intercepts{p_end}
{synopt :{opt nomean:s}}do not fit means or intercepts{p_end}
{synopt :{opt noanchor}}do not apply default anchoring{p_end}
{synopt :{opt forcenoanchor}}programmer's option{p_end}
{p2coldent :* {opt rel:iability()}}reliability of measurement variables{p_end}
{synopt :{opt const:raints()}}specify constraints{p_end}
{synopt :{opt from()}}specify starting values{p_end}
{synoptline}
{p 4 6 2}
(*) option may be specified more than once.  See {helpb sem_model_options:[SEM] sem model description options}.
{p_end}


{marker group_options}{...}
{synoptset 30}{...}
{synopthdr:group_options}
{synoptline}
{synopt :{opth group(varname)}}fit model for different groups{p_end}
{synopt :{opt gin:variant(classname)}}specify parameters that are equal across groups{p_end}
{synoptline}
{p 4 6 2}
See {helpb sem_group_options:[SEM] sem group options}.
{p_end}


{marker ssd_options}{...}
{synopthdr:ssd_options}
{synoptline}
{synopt :{opt sel:ect()}}alternative to {opt if} {it:exp} for SSD{p_end}
{synopt :{opt forcecor:relations}}allow groups and pooling of SSD correlations{p_end}
{synoptline}
{p 4 6 2}
See {helpb sem_ssd_options:[SEM] sem ssd options}.
{p_end}


{marker estimation_options}{...}
{synopthdr:estimation_options}
{synoptline}
{synopt :{opt meth:od(method)}}estimation method; see {helpb sem_option_method:[SEM] sem option method()}{p_end}
{synopt :{opt vce(vcetype)}}VCE type; see {helpb sem_option_method:[SEM] sem option method()} {p_end}
{synopt :{opt nm1}}compute sample variance rather than ML variance {p_end}
{synopt :{opt noxcond:itional}}compute covariances etc of observed exogenous
{p_end}
{synopt :{opt allmiss:ing}}for use with {cmd:method(mlmv)} {p_end}
{synopt :{opt noivstart}}skip calculation of starting values {p_end}
{synopt :{it:{help sem_estimation_options##maximize_options:maximize_options}}}control the maximization process for specified model; seldom used{p_end}
{synopt :{opt satopt:s}{cmd:(}{it:{help sem_estimation_options##satopts:maximize_options}{cmd:)}}}control the maximization process for saturated model; seldom used{p_end}
{synopt :{opt baseopt:s}{cmd:(}{it:{help sem_estimation_options##baseopts:maximize_options}{cmd:)}}}control the maximization process for baseline model; seldom used{p_end}
{synoptline}
{p 4 6 2}
See {helpb sem_estimation_options:[SEM] sem estimation options}.
{p_end}


{marker reporting_options}{...}
{synopthdr:reporting_options}
{synoptline}
{synopt :{opt l:evel(#)}}set confidence level; default is {cmd:level(95)}{p_end}
{synopt :{opt stand:ardized}}display standardized coefficients and values{p_end}
{synopt :{opt coefl:egend}}display coefficient legend{p_end}
{synopt :{opt nocnsr:eport}}do not display constraints{p_end}
{synopt :{opt nodes:cribe}}do not display variable classification table{p_end}
{synopt :{opt nohead:er}}do not display header above parameter table{p_end}
{synopt :{opt nofoot:note}}do not display footnotes below parameter table{p_end}
{synopt :{opt notable}}do not display parameter tables{p_end}
{synopt :{opt nolab:el}}display group values rather than value labels{p_end}
{synopt :{opt wrap(#)}}allow long group label to wrap the first {it:#} lines
{p_end}
{synopt :{opt showg:invariant}}report all estimated parameters{p_end}
{synoptline}
{p 4 6 2}
See {helpb sem_reporting_options:[SEM] sem reporting options}.
{p_end}


{marker syntax_options}{...}
{synopthdr:syntax_options}
{synoptline}
{synopt :{opt lat:ent}{cmd:(}{it:names}{cmd:)}}explicitly specify latent variable names{p_end}
{synopt :{opt nocaps:latent}}do not treat capitalized Names as latent{p_end}
{synoptline}
{p 4 6 2}
See {helpb sem_syntax_options:[SEM] sem syntax options}.
{p_end}

{p 4 6 2}
{cmd:bootstrap}, {cmd:by}, {cmd:jackknife}, {opt permute}, {cmd:statsby}, and {cmd:svy} are allowed; see {help prefix}.{p_end}
{p 4 6 2}
{cmd:fweight}s, {cmd:iweight}s, and {cmd:pweight}s are allowed; 
see {help weight}.{p_end}
{p 4 6 2}
See {helpb sem_postestimation:[SEM] sem postestimation} for features available
after estimation.
{p_end}


{title:Menu}

{phang}
{bf:Statistics > Structural equation modeling (SEM) > Model building and estimation}


{marker description}{...}
{title:Description}

{pstd}
{cmd:sem} fits structural equation models.  Even when you use the GUI, you are
using the {cmd:sem} command. 


{marker options}{...}
{title:Options}

{phang}
{it:model_description_options}
describe the model to be fit.  The model to be fit is fully specified by
{it:paths} -- which appear immediately after {cmd:sem} -- and the options 
{opt covariance()}, {opt variance()}, and {opt means()}.  See
{helpb sem_model_options:[SEM] sem model description options} and 
{helpb sem_path_notation:[SEM] sem path notation}.

{phang}
{it:group_options}
allow the specified model to be fit for different subgroups of the data,
with some parameters free to vary across groups and other parameters
constrained to be equal across groups.  See 
{helpb sem_group_options:[SEM] sem group options}.

{phang}
{it:ssd_options}
allow models to be fit using summary statistics data (SSD),
meaning data on means, variances (standard deviations), and covariances
(correlations).  See {helpb sem_ssd_options:[SEM] sem ssd options}.

{phang}
{it:estimation_options}
control how the estimation results are obtained.  These options control how
the standard errors (VCE) are obtained and control technical issues
such as choice of estimation method.  See 
{helpb sem_estimation_options:[SEM] sem estimation options}.

{phang}
{it:reporting_options}
control how the results of estimation are displayed.  See 
{helpb sem_reporting_options:[SEM] sem reporting options}.

{phang}
{it:syntax_options}
control how the syntax that you type is interpreted.  See 
{helpb sem_syntax_options:[SEM] sem syntax options}.


{marker remarks}{...}
{title:Remarks}

{pstd}
For a readable explanation of what {cmd:sem} can do and how to use it, see any
of the intro sections in {manlink SEM sem}.  You might start with 
{manlink SEM intro 1}.

{pstd}
For examples of {cmd:sem} in action, see any of the example sections in
{manlink SEM sem}.  You might start with {findalias semsfmm}.

{pstd}
For detailed syntax and descriptions, also see the references below.

{pstd}
See the following advanced topics in {manlink SEM sem}:

{phang2}
{mansection SEM semRemarksDefaultnormalizationconstraints:Default normalization constraints}{p_end}
{phang2}
{mansection SEM semRemarksDefaultcovarianceassumptions:Default covariance assumptions}{p_end}
{phang2}
{mansection SEM semRemarksHowtosolveconvergenceproblems:How to solve convergence problems}{p_end}


{marker examples}{...}
{title:Examples}

{pstd}
These examples are intended for quick reference.  For detailed examples, see
{helpb sem examples:[SEM] examples}.


{title:Examples: Correlations}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse census13}{p_end}

{pstd}Use {cmd:correlate} command {p_end}
{phang2}{cmd:. correlate mrgrate dvcrate medage}{p_end}

{pstd}Replicate with {cmd:sem}{p_end}
{phang2}{cmd:. sem ( <- mrgrate dvcrate medage), standardized}{p_end}


{title:Examples: Linear regression}

{pstd}Setup{p_end}
{phang2}{cmd:. sysuse auto}{p_end}
{phang2}{cmd:. generate weight2 = weight^2}{p_end}

{pstd}Use {cmd:regress} command{p_end}
{phang2}{cmd:. regress mpg weight weight2 foreign}{p_end}

{pstd}Replicate model with {cmd:sem}{p_end}
{phang2}{cmd:. sem (mpg <- weight weight2 foreign)}{p_end}


{title:Examples: Single-factor measurement model}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse sem_1fmm}{p_end}

{pstd}CFA model with a single latent variable {cmd:X}{p_end}
{phang2}{cmd:. sem (x1 x2 x3 x4 <- X)}{p_end}

{pstd}Display standardized results{p_end}
{phang2}{cmd:. sem, standardized}{p_end}


{title:Examples: Two-factor measurement model}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse sem_2fmm}{p_end}

{pstd}CFA model with two latent variables: {cmd:Affective} and {cmd:Cognitive}{p_end}
{phang2}{cmd:. sem (Affective -> a1 a2 a3 a4 a5)}{break}
	{cmd:(Cognitive -> c1 c2 c3 c4 c5)}{p_end}


{title:Examples: Nonrecursive structural model}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse sem_sm1}{p_end}

{pstd}Model with a feedback loop{p_end}
{phang2}{cmd:. sem (r_occasp <- f_occasp r_intel r_ses f_ses)}{break}
	{cmd:(f_occasp <- r_occasp f_intel f_ses r_ses),}{break}
	{cmd:cov(e.r_occasp*e.f_occasp)}{p_end}


{title:Examples: MIMIC model}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse sem_mimic1}{p_end}

{pstd}MIMIC model{p_end}
{phang2}{cmd:. sem (SubjSES -> s_income s_occpres s_socstat)}{break}
	{cmd:(SubjSES <- income occpres)}{p_end}


{title:Examples: Latent growth model}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse sem_lcm}{p_end}

{pstd}Fit latent growth model{p_end}
{phang2}{cmd:. sem (lncrime0 <- Intercept@1 Slope@0) } {break}
	{cmd:(lncrime1 <- Intercept@1 Slope@1)}{break}
	{cmd:(lncrime2 <- Intercept@1 Slope@2)}{break}
	{cmd:(lncrime3 <- Intercept@1 Slope@3),}{break}
	{cmd:latent(Intercept Slope) means(Intercept Slope) noconstant}{p_end}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:sem} saves the following in {cmd:e()}:

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Scalars}{p_end}
{synopt:{cmd:e(N)}}number of observations{p_end}
{synopt:{cmd:e(N_clust)}}number of clusters{p_end}
{synopt:{cmd:e(N_groups)}}number of groups{p_end}
{synopt:{cmd:e(N_missing)}}number of missing values in the sample for
{cmd:method(mlmv)}{p_end}
{synopt:{cmd:e(ll)}}log likelihood of model{p_end}
{synopt:{cmd:e(df_m)}}model degrees of freedom{p_end}
{synopt:{cmd:e(df_b)}}baseline model degrees of freedom{p_end}
{synopt:{cmd:e(df_s)}}saturated model degrees of freedom{p_end}
{synopt:{cmd:e(chi2_ms)}}test of target model against saturated model{p_end}
{synopt:{cmd:e(df_ms)}}degrees of freedom for {cmd:e(chi2_ms)}{p_end}
{synopt:{cmd:e(p_ms)}}p-value for {cmd:e(chi2_ms)}{p_end}
{synopt:{cmd:e(chi2_bs)}}test of baseline model against saturated model{p_end}
{synopt:{cmd:e(df_bs)}}degrees of freedom for {cmd:e(chi2_bs)}{p_end}
{synopt:{cmd:e(p_bs)}}p-value for {cmd:e(chi2_bs)}{p_end}
{synopt:{cmd:e(rank)}}rank of {cmd:e(V)}{p_end}
{synopt:{cmd:e(ic)}}number of iterations{p_end}
{synopt:{cmd:e(rc)}}return code{p_end}
{synopt:{cmd:e(converged)}}{cmd:1} if target model converged, {cmd:0}
	otherwise{p_end}
{synopt:{cmd:e(critvalue)}}log likelihood or discrepancy of fitted
model{p_end}
{synopt:{cmd:e(critvalue_b)}}log likelihood or discrepancy of baseline
model{p_end}
{synopt:{cmd:e(critvalue_s)}}log likelihood or discrepancy of saturated
model{p_end}
{synopt:{cmd:e(modelmeans)}}{cmd:1} if fitting means and intercepts, {cmd:0}
otherwise{p_end}

{p2col 5 20 24 2: Macros}{p_end}
{synopt:{cmd:e(cmd)}}{cmd:sem}{p_end}
{synopt:{cmd:e(cmdline)}}command as typed{p_end}
{synopt:{cmd:e(data)}}{cmd:raw} or {cmd:ssd} if SSD data was used{p_end}
{synopt:{cmd:e(wtype)}}weight type{p_end}
{synopt:{cmd:e(wexp)}}weight expression{p_end}
{synopt:{cmd:e(title)}}title in estimation output{p_end}
{synopt:{cmd:e(clustvar)}}name of cluster variable{p_end}
{synopt:{cmd:e(vce)}}vcetype specified in {cmd:vce()}{p_end}
{synopt:{cmd:e(vcetype)}}title used to label Std. Err.{p_end}
{synopt:{cmd:e(method)}}estimation method: {cmd:ml}, {cmd:mlmv},
	or {cmd:adf}{p_end}
{synopt:{cmd:e(technique)}}maximization technique{p_end}
{synopt:{cmd:e(properties)}}{cmd:b V}{p_end}
{synopt:{cmd:e(estat_cmd)}}program used to implement {cmd:estat}{p_end}
{synopt:{cmd:e(predict)}}program used to implement {cmd:predict}{p_end}
{synopt:{cmd:e(lyvars)}}names of latent   y variables{p_end}
{synopt:{cmd:e(oyvars)}}names of observed y variables{p_end}
{synopt:{cmd:e(lxvars)}}names of latent   x variables{p_end}
{synopt:{cmd:e(oxvars)}}names of observed x variables{p_end}
{synopt:{cmd:e(groupvar)}}name of group variable{p_end}
{synopt:{cmd:e(xconditional)}}empty if {cmd:noxconditional} specified,
	{cmd:xconditional} otherwise{p_end}

{p2col 5 20 24 2: Matrices}{p_end}
{synopt:{cmd:e(b)}}parameter vector{p_end}
{synopt:{cmd:e(b_std)}}standardized parameter vector{p_end}
{synopt:{cmd:e(b_pclass)}}parameter class{p_end}
{synopt:{cmd:e(V)}}covariance matrix of the estimators{p_end}
{synopt:{cmd:e(V_std)}}standardized covariance matrix of the estimators{p_end}
{synopt:{cmd:e(V_modelbased)}}model-based variance{p_end}
{synopt:{cmd:e(admissible)}}admissibility of Sigma, Psi, Phi{p_end}
{synopt:{cmd:e(ilog)}}iteration log (up to 20 iterations){p_end}
{synopt:{cmd:e(gradient)}}gradient vector{p_end}
{synopt:{cmd:e(nobs)}}vector with number of observations per group{p_end}
{synopt:{cmd:e(groupvalue)}}vector of group values of {cmd:e(groupvar)}{p_end}
{synopt:{cmd:e(S}[{cmd:_}{it:#}]{cmd:)}}sample covariance matrix of observed
variables (for group {it:#}){p_end}
{synopt:{cmd:e(means}[{cmd:_}{it:#}]{cmd:)}}sample means of observed
variables (for group {it:#}){p_end}
{synopt:{cmd:e(W)}}weight matrix for {cmd:method(adf)}{p_end}

{p2col 5 20 24 2: Functions}{p_end}
{synopt:{cmd:e(sample)}}marks
	estimation sample (not with summary statistics data){p_end}
{p2colreset}{...}
