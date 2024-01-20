{smcl}
{* *! version 1.0.1  07jul2011}{...}
{viewerdialog estat "dialog sem_estat, message(-ginvariant-) name(sem_estat_ginvariant)"}{...}
{vieweralsosee "[SEM] estat ginvariant " "mansection SEM estatginvariant"}{...}
{findalias assemginv}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[SEM] estat mindices" "help sem_estat_mindices"}{...}
{vieweralsosee "[SEM] estat scoretests" "help sem_estat_scoretests"}{...}
{vieweralsosee "[SEM] sem" "help sem_command"}{...}
{vieweralsosee "[SEM] sem postestimation" "help sem_postestimation"}{...}
{viewerjumpto "Syntax" "sem_estat_ginvariant##syntax"}{...}
{viewerjumpto "Description" "sem_estat_ginvariant##description"}{...}
{viewerjumpto "Options" "sem_estat_ginvariant##options"}{...}
{viewerjumpto "Remarks" "sem_estat_ginvariant##remarks"}{...}
{viewerjumpto "Examples" "sem_estat_ginvariant##examples"}{...}
{viewerjumpto "Saved results" "sem_estat_ginvariant##saved_results"}{...}
{title:Title}

{p2colset 5 31 33 2}{...}
{p2col:{manlink SEM estat ginvariant} {hline 2}}Test for invariance of
	parameters across groups{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 14 2}
{cmd:estat} {cmdab:gin:variant} [{cmd:,} {it:options}]

{synoptset 24}{...}
{synopthdr}
{synoptline}
{synopt:{opt showp:class(classname)}}restrict output to parameters in specified parameter classes{p_end}
{synopt:{opt cla:ss}}include joint tests for parameter classes{p_end}
{synopt:{opt leg:end}}include legend describing parameter classes{p_end}
{synoptline}
{p2colreset}{...}

{marker classname}{...}
{synoptset 24}{...}
INCLUDE help sem_classnames
{p2colreset}{...}


{title:Menu}

{phang}
{bf:Statistics > Structural equation modeling (SEM) > Group statistics > Test invariance of parameters across groups}


{marker description}{...}
{title:Description}

{pstd}
{cmd:estat ginvariant} is for use after estimation with {cmd:sem,}
{opt group()};
see {helpb sem_group_options:[SEM] sem group options}.

{pstd}
{cmd:estat ginvariant} performs score tests (Lagrange multiplier tests) and
Wald tests of (1) whether parameters constrained to be equal across groups
should be relaxed and (2) whether parameters allowed to vary across groups
could be constrained.

{pstd}
See {help sem_references##Sorbom1989:S{c o:}rbom (1989)} and
{help sem_references##Wooldridge2010:Wooldridge (2010}, 421-428).


{marker options}{...}
{title:Options}

{phang}
{opth showpclass:(sem_estat_ginvariant##classname:classname)} displays tests
for the classes specified.  {cmd:showpclass(all)} is the default.

{phang}
{opt class} displays a table with joint tests for group invariance for each
of the nine parameter classes.

{phang}
{opt legend} displays a legend describing the parameter classes.  This option
can only be used with the {opt class} option.


{marker remarks}{...}
{title:Remarks}

{pstd}
See {findalias semginv}.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse sem_2fmmby}{p_end}
{phang2}{cmd:. sem (Peer -> peerrel1 peerrel2 peerrel3 peerrel4)}{break}
	{cmd: (Par -> parrel1 parrel2 parrel3 parrel4), group(grade)}{p_end}

{pstd}Test for invariance of parameters across groups{p_end}
{phang2}{cmd:. estat ginvariant}{p_end}

{pstd}Include joint tests for parameter classes{p_end}
{phang2}{cmd:. estat ginvariant, class}{p_end}

{pstd}Only display measurement coefficients{p_end}
{phang2}{cmd:. estat ginvariant, showpclass(mcoef)}{p_end}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:estat ginvariant} saves the following in {cmd:r()}:

{synoptset 24 tabbed}{...}
{p2col 5 24 28 2: Scalars}{p_end}
{synopt:{cmd:r(N_groups)}}number of groups{p_end}

{synoptset 24 tabbed}{...}
{p2col 5 24 28 2: Matrices}{p_end}
{synopt:{cmd:r(nobs)}}sample size for each group{p_end}
{synopt:{cmd:r(test)}}Wald and score tests{p_end}
{synopt:{cmd:r(test_pclass)}}parameter classes corresponding to {cmd:r(test)}{p_end}
{synopt:{cmd:r(test_class)}}joint Wald and score tests for each class{p_end}
{p2colreset}{...}
