{smcl}
{* *! version 1.1.4  05may2011}{...}
{viewerdialog candisc "dialog candisc"}{...}
{vieweralsosee "[MV] candisc" "mansection MV candisc"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[MV] discrim lda" "help discrim lda"}{...}
{vieweralsosee "[MV] discrim lda postestimation" "help discrim_lda_postestimation"}{...}
{viewerjumpto "Syntax" "candisc##syntax"}{...}
{viewerjumpto "Description" "candisc##description"}{...}
{viewerjumpto "Options" "candisc##options"}{...}
{viewerjumpto "Examples" "candisc##examples"}{...}
{viewerjumpto "Saved results" "candisc##saved_results"}{...}
{title:Title}

{p2colset 5 21 23 2}{...}
{p2col:{manlink MV candisc} {hline 2}}Canonical linear discriminant analysis
{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 16 2}
{cmd:candisc} {varlist} {ifin} {weight}{cmd:,}
	{opth g:roup(varlist:groupvar)}
	[{it:options}]

{synoptset 19 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:Model}
{p2coldent:* {opth g:roup(varlist:groupvar)}}variable specifying the groups{p_end}
{synopt:{opth pri:ors(candisc##priors:priors)}}group prior probabilities{p_end}
{synopt:{opth tie:s(candisc##ties:ties)}}how ties in classification are to be
	handled{p_end}

{syntab:Reporting}
{synopt:{opt not:able}}suppress resubstitution classification table{p_end}
{synopt:{opt loo:table}}display leave-one-out classification table{p_end}
{synopt:{opt nost:ats}}suppress display of canonical statistics{p_end}
{synopt:{opt noco:ef}}suppress display of standardized canonical
	discriminant function coefficients{p_end}
{synopt:{opt nostr:uct}}suppress display of canonical structure matrix{p_end}
{synopt:{opt nom:eans}}suppress display of group means on canonical
	variables{p_end}
{synoptline}
{p2colreset}{...}

INCLUDE help discrim_opts

{p 4 6 2}
*{opt group()} is required.{p_end}
{p 4 6 2}
{opt statsby} and {cmd:xi} are allowed; see {help prefix}.
{p_end}
{p 4 6 2}
{opt fweight}s are allowed; see {help weight}.
{p_end}
{p 4 6 2}
{* -candisc- and -discrim lda- share the same postestimation commands / help}
See {manhelp discrim_lda_postestimation MV:discrim lda postestimation} for
features available after estimation.
{p_end}


{title:Menu}

{phang}
{bf:Statistics > Multivariate analysis > Discriminant analysis >}
        {bf:Canonical linear discriminant analysis}


{marker description}{...}
{title:Description}

{pstd}
{cmd:candisc} performs canonical linear discriminant analysis (LDA).  What is
computed is the same as with {manhelp discrim_lda MV:discrim lda}.  The
difference is in what is presented.  See {manhelp discrim MV} for other
discrimination commands.


{marker options}{...}
{title:Options}

{dlgtab:Model}

{phang}
{opth group:(varlist:groupvar)}
is required and specifies the name of the grouping variable.  {it:groupvar}
must be a numeric variable.

INCLUDE help discrim_priors

{dlgtab:Reporting}

{phang}
{opt notable}
suppresses the computation and display of the resubstitution classification
table.

{phang}
{opt lootable}
displays the leave-one-out classification table.

{phang}
{opt nostats}
suppresses the display of the table of canonical statistics.

{phang}
{opt nocoef}
suppresses the display of the standardized canonical discriminant function
coefficients.

{phang}
{opt nostruct}
suppresses the display of the canonical structure matrix.

{phang}
{opt nomeans}
suppresses the display of group means on canonical variables.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse rootstock}{p_end}

{pstd}Fit linear discriminant analysis (LDA) model with equal prior
probabilities for the six rootstock groups and display the canonical
results{p_end}
{phang2}{cmd:. candisc y1 y2 y3 y4, group(rootstock)}{p_end}

{pstd}Fit the same model, but use prior probabilities of 0.2 for the first
four rootstocks and 0.1 for the last two rootstocks and display only the
canonical discriminant test statistics and the leave-one-out classification
table{p_end}
{phang2}
{cmd:. candisc y*, group(rootstock) priors(.2,.2,.2,.2,.1,.1) lootable}
	{cmd:notable nocoef nostruct nomeans}
{p_end}

{pstd}Replay results allowing the default display{p_end}
{phang2}{cmd:. candisc}{p_end}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:candisc} saves the same items in {cmd:e()} as
{manhelp discrim_lda MV:discrim lda} with the exception that {cmd:e(subcmd)}
is not set and the following {cmd:e()} results are different:

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Macros}{p_end}
{synopt:{cmd:e(cmd)}}{cmd:candisc}{p_end}
{synopt:{cmd:e(title)}}{cmd:Canonical linear discriminant analysis}{p_end}
