{smcl}
{* *! version 1.0.2  07jul2011}{...}
{viewerdialog estat "dialog sem_estat, message(-stable-) name(sem_estat_stable)"}{...}
{vieweralsosee "[SEM] estat stable" "mansection SEM estatstable"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[SEM] estat teffects" "help sem_estat_teffects"}{...}
{vieweralsosee "[SEM] sem" "help sem_command"}{...}
{vieweralsosee "[SEM] sem postestimation" "help sem_postestimation"}{...}
{viewerjumpto "Syntax" "sem_estat_stable##syntax"}{...}
{viewerjumpto "Description" "sem_estat_stable##description"}{...}
{viewerjumpto "Option" "sem_estat_stable##option"}{...}
{viewerjumpto "Remarks" "sem_estat_stable##remarks"}{...}
{viewerjumpto "Examples" "sem_estat_stable##examples"}{...}
{viewerjumpto "Saved results" "sem_estat_stable##saved_results"}{...}
{title:Title}

{p2colset 5 27 29 2}{...}
{p2col:{manlink SEM estat stable} {hline 2}}Check stability of nonrecursive system{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 14 2}
{cmd:estat} {cmdab:sta:ble} [{cmd:,}
{cmdab:d:etail}]


{title:Menu}

{phang}
{bf:Statistics > Structural equation modeling (SEM) > Other > Assess stability of nonrecursive systems}


{marker description}{...}
{title:Description}

{pstd}
{cmd:estat stable} reports the eigenvalue stability index for nonrecursive
models after estimation by {cmd:sem}.  The stability index is computed as the
maximum modulus of the eigenvalues for the matrix of coefficients on
endogenous variables predicting other endogenous variables.  When the model
was fit by {cmd:sem} with the {cmd:group()} option, {cmd:estat stable}
reports the index for each group separately. 

{pstd}
There are two formulas commonly used to calculate the index.  
{cmd:estat stable} uses the formulation of
{help sem_references##Bentler1983:Bentler and Freeman (1983)}. 


{marker option}{...}
{title:Option}

{phang}{opt detail}
displays the matrix of coefficients on endogenous variables predicting other
endogenous variables, also known as the Beta matrix.  


{marker remarks}{...}
{title:Remarks}

{pstd} 
See {help sem_glossary##nonrecursive_models:nonrecursive model} in
{helpb sem glossary:[SEM] Glossary}.  The issue of stability is described
there.   Also see {it:{mansection SEM estatteffectsRemarks:Remarks}} of
{manlink SEM estat teffects}.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse sem_sm1}{p_end}
{phang2}{cmd:. sem (r_occasp <- f_occasp r_intel r_ses f_ses)}{break}
	{cmd: (f_occasp <- r_occasp f_intel f_ses r_ses),}{break}
	{cmd:  cov(e.r_occasp*e.f_occasp)}{p_end}

{pstd}Check stability condition{p_end}
{phang2}{cmd:. estat stable}{p_end}

{pstd}Also display Beta matrix{p_end}
{phang2}{cmd:. estat stable, detail}{p_end}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:estat stable} saves the following in {cmd:r()}:

{synoptset 18 tabbed}{...}
{p2col 5 18 22 2: Scalars}{p_end}
{synopt:{cmd:r(N_groups)}}number of groups{p_end}
{synopt:{cmd:r(stindex}[{cmd:_}{it:#}]{cmd:)}}stability index (for group
{it:#}){p_end}

{synoptset 18 tabbed}{...}
{p2col 5 18 22 2: Matrices}{p_end}
{synopt:{cmd:r(nobs)}}sample size for each group{p_end}
{synopt:{cmd:r(Beta}[{cmd:_}{it:#}]{cmd:)}}coefficients of endogenous
variables on endogenous variables (for group {it:#}){p_end}
{synopt:{cmd:r(Re}[{cmd:_}{it:#}]{cmd:)}}real parts of the eigenvalues of A (for group {it:#}){p_end}
{synopt:{cmd:r(Im}[{cmd:_}{it:#}]{cmd:)}}imaginary parts of the eigenvalues of
A (for group {it:#}){p_end}
{synopt:{cmd:r(Modulus}[{cmd:_}{it:#}]{cmd:)}}modulus of the eigenvalues of A (for group {it:#}){p_end}
{p2colreset}{...}
