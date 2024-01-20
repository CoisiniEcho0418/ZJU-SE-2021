{smcl}
{* *! version 1.0.12  15aug2011}{...}
{viewerdialog mi "dialog mi"}{...}
{vieweralsosee "[MI] mi impute regress" "mansection MI miimputeregress"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[MI] intro" "help mi"}{...}
{vieweralsosee "[MI] intro substantive" "help mi intro substantive"}{...}
{vieweralsosee "[MI] mi impute" "help mi_impute"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[MI] mi impute intreg" "help mi_impute_intreg"}{...}
{vieweralsosee "[MI] mi impute pmm" "help mi_impute_pmm"}{...}
{vieweralsosee "[MI] mi impute truncreg" "help mi_impute_truncreg"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[MI] mi estimate" "help mi_estimate"}{...}
{viewerjumpto "Syntax" "mi_impute_regress##syntax"}{...}
{viewerjumpto "Description" "mi_impute_regress##description"}{...}
{viewerjumpto "Options" "mi_impute_regress##options"}{...}
{viewerjumpto "Examples" "mi_impute_regress##examples"}{...}
{viewerjumpto "Saved results" "mi_impute_regress##saved_results"}{...}
{title:Title}

{p2colset 5 31 33 2}{...}
{p2col :{manlink MI mi impute regress} {hline 2}}Impute using linear regression{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 19 2}{cmd:mi} {cmdab:imp:ute} {cmdab:reg:ress} 
{it:ivar} [{it:{help indepvars}}] [{it:{help if}}] {weight}
[{cmd:,} {it:{help mi_impute##impopts:impute_options}} {it:options}] 

{synoptset 22 tabbed}{...}
{synopthdr:options}
{synoptline}
{syntab:Main}
{synopt: {opt nocons:tant}}suppress constant term{p_end}
{synopt: {opth cond:itional(if)}}perform conditional imputation{p_end}
{synopt: {opt boot:strap}}estimate model parameters using sampling with replacement{p_end}
{synoptline}
{p 4 6 2}
You must {cmd:mi set} your data before using {cmd:mi} {cmd:impute}
{cmd:regress}; see {manhelp mi_set MI:mi set}.{p_end}
{p 4 6 2}
You must {cmd:mi register} {it:ivar} as imputed before using {cmd:mi}
{cmd:impute} {cmd:regress}; see {manhelp mi_set MI:mi set}.{p_end}
INCLUDE help fvvarlist
{p 4 6 2}
{cmd:aweight}s, {cmd:fweight}s, {cmd:iweight}s, and {cmd:pweight}s are
allowed; see {help weight}.{p_end}


{title:Menu}

{phang}
{bf:Statistics > Multiple imputation}


{marker description}{...}
{title:Description}

{pstd}
{cmd:mi} {cmd:impute} {cmd:regress} fills in missing values of a continuous
variable using the Gaussian normal regression imputation method.  You can
perform separate imputations on different subsets of the data by specifying
the {cmd:by()} option.  You can also account for analytic, frequency,
importance, and sampling weights.


{marker options}{...}
{title:Options}

{dlgtab:Main}

{phang}
{opt noconstant}; see {manhelp estimation_options R: estimation options}.

{phang}
{cmd:add()}, {cmd:replace}, {cmd:rseed()}, {cmd:double}, {cmd:by()}; see
{manhelp mi_impute MI:mi impute}.

{phang}
INCLUDE help mi_impute_uvopt_conditional.ihlp

{phang}
INCLUDE help mi_impute_uvopt_bootstrap.ihlp

{dlgtab:Reporting}

{phang}
{cmd:dots}, {cmd:noisily}, {cmd:nolegend}; see {manhelp mi_impute MI:mi impute}.
{cmd:noisily} specifies that the output from a linear regression fit to the
observed data be displayed.
INCLUDE help mi_impute_uvopt_nolegend.ihlp

{dlgtab:Advanced}

{phang}
{cmd:force}; see {manhelp mi_impute MI:mi impute}.

{pstd}
The following option is available with {opt mi impute} but is not shown in the
dialog box:

{phang}
{cmd:noupdate}; see {manhelp noupdate_option MI:noupdate option}.


{marker examples}{...}
{title:Examples}

{pstd}
Setup
{p_end}
{phang2}
{cmd:. webuse mheart1s0}
{p_end}

{pstd}Describe {cmd:mi} data{p_end}
{phang2}
{cmd:. mi describe}
{p_end}

{pstd}
Impute {cmd:bmi} using linear regression
{p_end}
{phang2}
{cmd:. mi impute regress bmi attack smokes age female hsgrad, add(20)}
{p_end}

{pstd}
Impute {cmd:bmi} separately for males and females
{p_end}
{phang2}
{cmd:. mi impute regress bmi age attack smokes age hsgrad, replace by(female)}
{p_end}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:mi impute regress} saves the following in {cmd:r()}:

{synoptset 25 tabbed}{...}
{p2col 5 25 29 2: Scalars}{p_end}
{synopt:{cmd:r(M)}}total number of imputations{p_end}
{synopt:{cmd:r(M_add)}}number of added imputations{p_end}
{synopt:{cmd:r(M_update)}}number of updated imputations{p_end}
{synopt:{cmd:r(k_ivars)}}number of imputed variables (always {cmd:1}){p_end}
{synopt:{cmd:r(N_g)}}number of imputed groups ({cmd:1} if {cmd:by()} is not specified){p_end}

{synoptset 25 tabbed}{...}
{p2col 5 25 29 2: Macros}{p_end}
{synopt:{cmd:r(method)}}name of imputation method ({cmd:regress}){p_end}
{synopt:{cmd:r(ivars)}}names of imputation variables{p_end}
{synopt:{cmd:r(rseed)}}random-number seed used{p_end}
{synopt:{cmd:r(by)}}names of variables specified within {cmd:by()}{p_end}

{synoptset 25 tabbed}{...}
{p2col 5 25 29 2: Matrices}{p_end}
{synopt:{cmd:r(N)}}number of observations in imputation sample in each group{p_end}
{synopt:{cmd:r(N_complete)}}number of complete observations in imputation sample in each group{p_end}
{synopt:{cmd:r(N_incomplete)}}number of incomplete observations in imputation sample in each group{p_end}
{synopt:{cmd:r(N_imputed)}}minimum across {it:m} of the number of imputed observations in imputation sample in each group{p_end}
