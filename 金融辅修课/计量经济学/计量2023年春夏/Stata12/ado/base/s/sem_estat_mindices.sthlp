{smcl}
{* *! version 1.0.1  07jul2011}{...}
{viewerdialog estat "dialog sem_estat, message(-mindices-) name(sem_estat_mindices)"}{...}
{vieweralsosee "[SEM] estat mindices" "mansection SEM estatmindices"}{...}
{findalias assemmindices}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[SEM] estat ginvariant" "help sem_estat_ginvariant"}{...}
{vieweralsosee "[SEM] estat scoretests" "help sem_estat_scoretests"}{...}
{vieweralsosee "[SEM] sem" "help sem_command"}{...}
{vieweralsosee "[SEM] sem postestimation" "help sem_postestimation"}{...}
{viewerjumpto "Syntax" "sem_estat_mindices##syntax"}{...}
{viewerjumpto "Description" "sem_estat_mindices##description"}{...}
{viewerjumpto "Options" "sem_estat_mindices##options"}{...}
{viewerjumpto "Remarks" "sem_estat_mindices##remarks"}{...}
{viewerjumpto "Examples" "sem_estat_mindices##examples"}{...}
{viewerjumpto "Saved results" "sem_estat_mindices##saved_results"}{...}
{title:Title}

{p2colset 5 29 31 2}{...}
{p2col:{manlink SEM estat mindices} {hline 2}}Modification indices{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 14 2}
{cmd:estat} {cmdab:mi:ndices} [{cmd:,} {it:options}]

{synoptset 24}{...}
{synopthdr}
{synoptline}
{synopt:{opt showp:class(classname)}}restrict output to parameters in specified
   parameter classes{p_end}
{synopt:{opt min:chi2(#)}}display only tests with modification index
   {bind:(MI) {ul:>} {it:#}}{p_end}
{synoptline} 
{p2colreset}{...}

{marker classname}{...}
{synoptset 24}{...}
INCLUDE help sem_classnames
{p2colreset}{...}


{title:Menu}

{phang}
{bf:Statistics > Structural equation modeling (SEM) > Testing and CIs > Modification indices}


{marker description}{...}
{title:Description}

{pstd}
{cmd:estat mindices} reports modification indices for omitted paths in the
fitted model.  Modification indices are score tests (Lagrange multiplier
tests) for the statistical significance of the omitted paths.  See
{help sem_references##Sorbom1989:S{c o:}rbom (1989)} and
{help sem_references##Wooldridge2010:Wooldridge (2010}, 421-428).


{marker options}{...}
{title:Options}

{phang}{opth showpclass:(sem_estat_mindices##classname:classname)}
specifies that results be limited to parameters that belong to the
specified parameter classes.  The default is {cmd:showpclass(all)}.

{phang}{opt minchi2(#)}
suppresses listing paths with modification indices (MIs) less than {it:#}.
By default, {cmd:estat mindices} lists values significant at the 0.05 level,
corresponding to chi-squared value {cmd:minchi2(3.8414588)}.  Specify 
{cmd:minchi2(0)} if you wish to see all tests. 


{marker remarks}{...}
{title:Remarks}

{pstd}
See {findalias semmindices}.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse sem_2fmm}{p_end}
{phang2}{cmd:. sem (Affective -> a1 a2 a3 a4 a5) (Cognitive -> c1 c2 c3 c4 c5),}{break}
	{cmd: cov(Affective*Cognitive@0)}{p_end}

{pstd}Compute modification indices{p_end}
{phang2}{cmd:. estat mindices}{p_end}

{pstd}Show all modification indices{p_end}
{phang2}{cmd:. estat mindices, minchi2(0)}{p_end}

{pstd}Only show modification indices for covariances of measurement errors{p_end}
{phang2}{cmd:. estat mindices, showpclass(scoef)}{p_end}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:estat mindices} saves the following in {cmd:r()}:

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Scalars}{p_end}
{synopt:{cmd:r(N_groups)}}number of groups{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Matrices}{p_end}
{synopt:{cmd:r(nobs)}}sample size for each group{p_end}
{synopt:{cmd:r(mindices_pclass)}}parameter class of modification indices{p_end}
{synopt:{cmd:r(mindices)}}matrix containing the displayed table values{p_end}
{p2colreset}{...}

