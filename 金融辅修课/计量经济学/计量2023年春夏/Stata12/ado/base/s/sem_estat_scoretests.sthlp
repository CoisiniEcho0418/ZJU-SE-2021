{smcl}
{* *! version 1.0.2  07jul2011}{...}
{viewerdialog estat "dialog sem_estat, message(-scoretests-) name(sem_estat_scoretests)"}{...}
{vieweralsosee "[SEM] estat scoretests " "mansection SEM estatscoretests"}{...}
{findalias assembequal}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[SEM] estat ginvariant" "help sem_estat_ginvariant"}{...}
{vieweralsosee "[SEM] estat mindices" "help sem_estat_mindices"}{...}
{vieweralsosee "[SEM] sem" "help sem_command"}{...}
{vieweralsosee "[SEM] sem postestimation" "help sem_postestimation"}{...}
{viewerjumpto "Syntax" "sem_estat_scoretests##syntax"}{...}
{viewerjumpto "Description" "sem_estat_scoretests##description"}{...}
{viewerjumpto "Option" "sem_estat_scoretests##option"}{...}
{viewerjumpto "Remarks" "sem_estat_scoretests##remarks"}{...}
{viewerjumpto "Examples" "sem_estat_scoretests##examples"}{...}
{viewerjumpto "Saved results" "sem_estat_scoretests##saved_results"}{...}
{title:Title}

{p2colset 5 31 33 2}{...}
{p2col:{manlink SEM estat scoretests} {hline 2}}Score tests{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 14 2}
{cmd:estat} {cmdab:score:tests} [{cmd:,} {opt min:chi2(#)}]


{title:Menu}

{phang}
{bf:Statistics > Structural equation modeling (SEM) > Testing and CIs > Score tests of linear constraints}


{marker description}{...}
{title:Description}

{pstd}
{cmd:estat scoretests} displays score tests  (Lagrangian multiplier tests) for
each of the user-specified linear constraints imposed on the model when it was
fit.  See {help sem_references##Sorbom1989:S{c o:}rbom (1989)} and
{help sem_references##Wooldridge2010:Wooldridge (2010}, 421-428).


{marker option}{...}
{title:Option}

{phang}{opt minchi2(#)}
suppresses output of tests with chi2(1) < {it:#}.
By default, {cmd:estat mindices} lists values significant at the 0.05 level,
corresponding to chi-squared value {cmd:minchi2(3.8414588)}.  Specify 
{cmd:minchi2(0)} if you wish to see all tests. 


{marker remarks}{...}
{title:Remarks}

{pstd}
See {findalias sembequal}.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse sem_sm1}{p_end}
{phang2}{cmd:. sem (r_occasp <- f_occasp@b1 r_intel@b2 r_ses@b3 f_ses@b4)}{break}
	{cmd: (f_occasp <- r_occasp@b1 f_intel@b2 f_ses@b3 r_ses@b4),}{break}
	{cmd: cov(e.r_occasp*e.f_occasp)}{p_end}

{pstd}Compute score tests{p_end}
{phang2}{cmd:. estat scoretests}{p_end}

{pstd}Display all score tests{p_end}
{phang2}{cmd:. estat scoretests, minchi2(0)}{p_end}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:estat scoretests} saves the following in {cmd:r()}:

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Scalars}{p_end}
{synopt:{cmd:r(N_groups)}}number of groups{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Matrices}{p_end}
{synopt:{cmd:r(nobs)}}sample size for each group{p_end}
{synopt:{cmd:r(Cns_sctest)}}matrix containing the displayed table values{p_end}
{p2colreset}{...}
