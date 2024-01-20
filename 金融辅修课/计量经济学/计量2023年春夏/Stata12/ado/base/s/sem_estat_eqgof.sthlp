{smcl}
{* *! version 1.0.3  07jul2011}{...}
{viewerdialog estat "dialog sem_estat, message(-eqgof-) name(sem_estat_eqgof)"}{...}
{vieweralsosee "[SEM] estat eqgof" "mansection SEM estateqgof"}{...}
{findalias assemtfmm}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[SEM] estat ggof" "help sem_estat_ggof"}{...}
{vieweralsosee "[SEM] estat gof" "help sem_estat_gof"}{...}
{vieweralsosee "[SEM] sem" "help sem_command"}{...}
{vieweralsosee "[SEM] sem postestimation" "help sem_postestimation"}{...}
{viewerjumpto "Syntax" "sem_estat_eqgof##syntax"}{...}
{viewerjumpto "Description" "sem_estat_eqgof##description"}{...}
{viewerjumpto "Option" "sem_estat_eqgof##option"}{...}
{viewerjumpto "Remarks" "sem_estat_eqgof##remarks"}{...}
{viewerjumpto "Examples" "sem_estat_eqgof##examples"}{...}
{viewerjumpto "Saved results" "sem_estat_eqgof##saved_results"}{...}
{title:Title}

{p2colset 5 26 24 2}{...}
{p2col:{manlink SEM estat eqgof} {hline 2}}Equation-level
	goodness-of-fit statistics{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 14 2}
{cmd:estat} {cmdab:eqg:of} [{cmd:,} {opth for:mat(%fmt)}]


{title:Menu}

{phang}
{bf:Statistics > Structural equation modeling (SEM) > Goodness of fit > Equation-level goodness of fit}


{marker description}{...}
{title:Description}

{pstd}
{cmd: estat eqgof} displays equation-by-equation goodness-of-fit statistics.
Displayed are R-squared and the Bentler-Raykov squared multiple-correlation
coefficient ({help sem_references##Bentler2000:Bentler and Raykov 2000}).

{pstd}
These two concepts of fit are equivalent for recursive structural equation
models and univariate linear regression.  For nonrecursive structural equation
models, these measures are distinct.

{pstd}
Equation-level variance decomposition is also reported, along with the overall
model coefficient of determination.


{marker option}{...}
{title:Option}

{phang}{opth format(%fmt)} specifies the display format.  The default is
{cmd:format(%9.0g)}.


{marker remarks}{...}
{title:Remarks}

{pstd}
See {findalias semtfmm}.

{pstd}
In rare circumstances, these equation-level goodness-of-fit measures in
nonrecursive structural equations have unexpected values.  It is possible to
obtain negative R-squared and multiple-correlation values.

{pstd}
It is recommended to use the Bentler-Raykov squared multiple correlations as a
measure of explained variance for nonrecursive systems that involve endogenous
variables with reciprocal causations.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse sem_2fmm}{p_end}
{phang2}{cmd:. sem (Affective -> a1 a2 a3 a4 a5) (Cognitive -> c1 c2 c3 c4 c5)}{p_end}

{pstd}Display equation-level goodness-of-fit statistics{p_end}
{phang2}{cmd:. estat eqgof}{p_end}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:estat eqgof} saves the following in {cmd:r()}:

{synoptset 18 tabbed}{...}
{p2col 5 18 22 2: Scalars}{p_end}
{synopt:{cmd:r(N_groups)}}number of groups{p_end}
{synopt:{cmd:r(CD}[{cmd:_}{it:#}]{cmd:)}}overall coefficient of determination
	(for group {it:#}){p_end}

{synoptset 18 tabbed}{...}
{p2col 5 18 22 2: Matrices}{p_end}
{synopt:{cmd:r(nobs)}}sample size for each group{p_end}
{synopt:{cmd:r(eqfit}[{cmd:_}{it:#}]{cmd:)}}fit statistics (for group
{it:#}){p_end}
{p2colreset}{...}
