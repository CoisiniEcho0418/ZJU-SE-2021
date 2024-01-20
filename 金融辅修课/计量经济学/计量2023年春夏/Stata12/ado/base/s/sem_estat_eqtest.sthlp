{smcl}
{* *! version 1.0.1  07jul2011}{...}
{viewerdialog estat "dialog sem_estat, message(-eqtest-) name(sem_estat_eqtest)"}{...}
{vieweralsosee "[SEM] estat eqtest" "mansection SEM estateqtest"}{...}
{findalias assemeqtest}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[SEM] lrtest" "help sem_lrtest"}{...}
{vieweralsosee "[SEM] sem" "help sem_command"}{...}
{vieweralsosee "[SEM] sem postestimation" "help sem_postestimation"}{...}
{vieweralsosee "[SEM] test" "help sem_test"}{...}
{viewerjumpto "Syntax" "sem_estat_eqtest##syntax"}{...}
{viewerjumpto "Description" "sem_estat_eqtest##description"}{...}
{viewerjumpto "Option" "sem_estat_eqtest##option"}{...}
{viewerjumpto "Remarks" "sem_estat_eqtest##remarks"}{...}
{viewerjumpto "Examples" "sem_estat_eqtest##examples"}{...}
{viewerjumpto "Saved results" "sem_estat_eqtest##saved_results"}{...}
{title:Title}

{p2colset 5 27 29 2}{...}
{p2col:{manlink SEM estat eqtest} {hline 2}}Equation-level test that all
	coefficients are zero{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 16 2}
{cmd:estat} {cmdab:eqt:est} [{cmd:,} {opt tot:al} ]


{title:Menu}

{phang}
{bf:Statistics > Structural equation modeling (SEM) > Testing and CIs > Equation-level Wald tests}


{marker description}{...}
{title:Description}

{pstd}{cmd:estat eqtest} displays Wald tests that all coefficients excluding
the intercept are zero for each equation in the model.  


{marker option}{...}
{title:Option}

{phang}{opt total} is for use when estimation was with {cmd:sem, group()}.  It
specifies that the tests be aggregated across the groups. 


{marker remarks}{...}
{title:Remarks}

{pstd}
See {findalias semeqtest}.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. sysuse auto}{p_end}
{phang2}{cmd:. sem (price <- foreign mpg displacement) (weight <- foreign length),}{break}
	{cmd: cov(e.price*e.weight)}{p_end}

{pstd}Test that all coefficients are zero{p_end}
{phang2}{cmd:. estat eqtest}{p_end}

{pstd}Model with groups{p_end}
{phang2}{cmd:. sem (price <- turn mpg displacement), group(foreign)}{p_end}

{pstd}Test that all coefficients are zero{p_end}
{phang2}{cmd:. estat eqtest}{p_end}

{pstd}Aggregate tests across groups{p_end}
{phang2}{cmd:. estat eqtest, total}{p_end}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:estat eqtest} saves the following in {cmd:r()}:

{synoptset 18 tabbed}{...}
{p2col 5 18 22 2: Scalars}{p_end}
{synopt:{cmd:r(N_groups)}}number of groups{p_end}

{synoptset 18 tabbed}{...}
{p2col 5 18 22 2: Matrices}{p_end}
{synopt:{cmd:r(nobs)}}sample size for each group{p_end}
{synopt:{cmd:r(test}[{cmd:_}{it:#}]{cmd:)}}test statistics (for group {it:#}){p_end}
{synopt:{cmd:r(test_total)}}aggregated test statistics ({cmd:total} only){p_end}
{p2colreset}{...}
