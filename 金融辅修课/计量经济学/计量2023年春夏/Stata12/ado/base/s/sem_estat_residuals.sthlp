{smcl}
{* *! version 1.0.2  07jul2011}{...}
{viewerdialog estat "dialog sem_estat, message(-residuals-) name(sem_estat_residuals)"}{...}
{vieweralsosee "[SEM] estat residuals " "mansection SEM estatresiduals"}{...}
{findalias assemmimic}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[SEM] estat eqgof" "help sem_estat_eqgof"}{...}
{vieweralsosee "[SEM] estat ggof" "help sem_estat_ggof"}{...}
{vieweralsosee "[SEM] estat gof" "help sem_estat_gof"}{...}
{vieweralsosee "[SEM] sem" "help sem_command"}{...}
{vieweralsosee "[SEM] sem postestimation" "help sem_postestimation"}{...}
{viewerjumpto "Syntax" "sem_estat_residuals##syntax"}{...}
{viewerjumpto "Description" "sem_estat_residuals##description"}{...}
{viewerjumpto "Options" "sem_estat_residuals##options"}{...}
{viewerjumpto "Remarks" "sem_estat_residuals##remarks"}{...}
{viewerjumpto "Examples" "sem_estat_residuals##examples"}{...}
{viewerjumpto "Saved results" "sem_estat_residuals##saved_results"}{...}
{title:Title}

{p2colset 5 30 28 2}{...}
{p2col :{manlink SEM estat residuals} {hline 2}}Display mean and covariance residuals{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 14 2}
{cmd:estat} {cmdab:res:iduals} [{cmd:,} {it:options}]

{synoptset 22}{...}
{synopthdr}
{synoptline}
{synopt:{opt norm:alized}}report normalized residuals{p_end}
{synopt:{opt stand:ardized}}report standardized residuals{p_end}
{synopt:{opt sam:ple}}use sample covariances in residual variance computations{p_end}
{synopt :{opt nm1}}use adjustment {it:N}-1 in residual variance computations{p_end}
{synopt:{opt zero:tolerance(tol)}}apply tolerance to treat residuals
as zero{p_end}
{synopt:{opth for:mat(%fmt)}}display format{p_end}
{synoptline}
{p2colreset}{...}


{title:Menu}

{phang}
{bf:Statistics > Structural equation modeling (SEM) > Goodness of fit > Matrices of residuals}


{marker description}{...}
{title:Description}

{pstd}
{cmd:estat residuals} displays the mean and covariance residuals after
estimation by {cmd:sem}.  Normalized and standardized residuals are available.

{pstd}
Both mean and covariance residuals are reported unless {cmd:sem}'s option 
{opt nomeans} was specified or implied at the time the model was fit, in
which case mean residuals are not reported. 

{pstd}
{cmd:estat residuals} usually does not work following {cmd:sem} models fit
using {cmd:method(mlmv)}.  It also does not work if there are any missing
values, which after all, is the whole point of using {cmd:method(mlmv)}.


{marker options}{...}
{title:Options}

{phang}
{opt normalized} and {opt standardized} are alternatives.  If neither is
specified, raw residuals are reported.

{p 8 8 2}
Normalized residuals and standardized residuals attempt to adjust the
residuals in the same way but go about it differently.  The normalized
residuals are always valid, but they do not follow a standard normal
distribution.  The standardized residuals do follow a standard normal
distribution, but only if they can be calculated; otherwise, they will equal
missing values.  When both can be calculated (equivalent to both being
appropriate), the normalized residuals will be a little smaller than the
standardized residuals.  See
{help sem_references##Joreskog1986:J{c o:}reskog and S{c o:}rbom (1986)}.

{phang}
{opt sample} specifies that the sample variance and covariances be used in
variance formulas to compute normalized and standardized residuals.  The
default uses fitted variance and covariance values as described by
{help sem_references##Bollen1989:Bollen (1989)}.

{phang}
{opt nm1} specifies that the variances be computed using N-1 in the
denominator rather than using sample size N.

{phang}
{opt zerotolerance(tol)} treats residuals within {it:tol} of
zero as if they were zero.  {it:tol} must be a numeric value less than one.
The default is {cmd:zerotolerance(0)}, meaning that no tolerance is applied.
When standardized residuals cannot be calculated, it is because a
variance calculated by the
{help sem references##Hausman1978:Hausman (1978)} theorem turns negative.
Applying a tolerance to the residuals turns some residuals into 0 and then
division by the negative variance becomes irrelevant, and that may be enough to
solve the calculation problem.

{phang}
{opth format(%fmt)} specifies the display format.  The default is
{cmd:format(%9.3f)}.


{marker remarks}{...}
{title:Remarks}

{pstd}
See {findalias semmimic}.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse sem_mimic1}{p_end}
{phang2}{cmd:. sem (SubjSES -> s_income s_occpres s_socstat)}{break}
	{cmd: (SubjSES <- income occpres)}{p_end}

{pstd}Display raw mean and covariance residuals{p_end}
{phang2}{cmd:. estat residuals}{p_end}

{pstd}Include normalized and standardized residuals{p_end}
{phang2}{cmd:. estat residuals, normalized standardized}{p_end}

{pstd}Use sample covariances and adjustment N-1 in computations{p_end}
{phang2}{cmd:. estat residuals, normalized standardized sample nm1}{p_end}

{pstd}Treat residuals less than 1e-6 as zero{p_end}
{phang2}{cmd:. estat residuals, normalized standardized zerotolerance(1e-6)}{p_end}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:estat residuals} saves the following in {cmd:r()}:

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Scalars}{p_end}
{synopt:{cmd:r(N_groups)}}number of groups{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Macros}{p_end}
{synopt:{cmd:r(sample)}}empty or {opt sample}, if {opt sample} was specified{p_end}
{synopt:{cmd:r(nm1)}}empty or {opt nm1}, if {opt nm1} was specified{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Matrices}{p_end}
{synopt:{cmd:r(nobs)}}sample size for each group{p_end}
{synopt:{cmd:r(res_mean}[{cmd:_}{it:#}]{cmd:)}}raw mean residuals (for group
{it:#}) (*){p_end}
{synopt:{cmd:r(res_cov}[{cmd:_}{it:#}]{cmd:)}}raw covariance residuals (for group {it:#}){p_end}
{synopt:{cmd:r(nres_mean}[{cmd:_}{it:#}]{cmd:)}}normalized mean residuals (for
group {it:#}) (*){p_end}
{synopt:{cmd:r(nres_cov}[{cmd:_}{it:#}]{cmd:)}}normalized covariance residuals (for group {it:#}){p_end}
{synopt:{cmd:r(sres_mean}[{cmd:_}{it:#}]{cmd:)}}standardized mean residuals
(for group {it:#}) (*){p_end}
{synopt:{cmd:r(sres_cov}[{cmd:_}{it:#}]{cmd:)}}standardized covariance residuals (for group {it:#}){p_end}
{p2colreset}{...}

{p 4 8 2}
(*) If there are no estimated means or intercepts in the {cmd:sem} model,
these matrices are not returned.  
{p_end}
