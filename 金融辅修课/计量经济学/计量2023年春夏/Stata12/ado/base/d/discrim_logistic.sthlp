{smcl}
{* *! version 1.1.6  05may2011}{...}
{viewerdialog discrim "dialog discrim, message(-logistic-) name(discrim_logistic)"}{...}
{vieweralsosee "[MV] discrim logistic" "mansection MV discrimlogistic"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[MV] discrim logistic postestimation" "help discrim logistic postestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[MV] discrim" "help discrim"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] logistic" "help logistic"}{...}
{vieweralsosee "[R] mlogit" "help mlogit"}{...}
{viewerjumpto "Syntax" "discrim logistic##syntax"}{...}
{viewerjumpto "Description" "discrim logistic##description"}{...}
{viewerjumpto "Options" "discrim logistic##options"}{...}
{viewerjumpto "Examples" "discrim logistic##examples"}{...}
{viewerjumpto "Saved results" "discrim logistic##saved_results"}{...}
{title:Title}

{p2colset 5 30 32 2}{...}
{p2col:{manlink MV discrim logistic} {hline 2}}Logistic discriminant
	analysis{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 25 2}
{cmd:discrim} {cmdab:logi:stic} {varlist} {ifin} {weight}{cmd:,}
	{opth g:roup(varlist:groupvar)}
	[{it:options}]

{synoptset 19 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:Model}
{p2coldent:* {opth g:roup(varlist:groupvar)}}variable specifying the groups{p_end}
{synopt:{opth pri:ors(discrim_logistic##priors:priors)}}group prior probabilities{p_end}
{synopt:{opth tie:s(discrim_logistic##ties:ties)}}how ties in classification
        are to be handled{p_end}

{syntab:Reporting}
{synopt:{opt not:able}}suppress resubstitution classification table{p_end}
{synopt:{opt nolo:g}}suppress the {cmd:mlogit} log-likelihood iteration
	log{p_end}
{synoptline}
{p2colreset}{...}

INCLUDE help discrim_opts

{p 4 6 2}
*{cmd:group()} is required.{p_end}
{p 4 6 2}
{opt statsby} and {cmd:xi} are allowed; see {help prefix}.
{p_end}
{p 4 6 2}
{opt fweight}s are allowed; see {help weight}.
{p_end}
{p 4 6 2}
See
{manhelp discrim_logistic_postestimation MV:discrim logistic postestimation}
for features available after estimation.
{p_end}


{title:Menu}

{phang}
{bf:Statistics > Multivariate analysis > Discriminant analysis > Logistic}


{marker description}{...}
{title:Description}

{pstd}
{cmd:discrim logistic} performs logistic discriminant analysis.
See {manhelp discrim MV} for other discrimination commands.


{marker options}{...}
{title:Options}

{dlgtab:Main}

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
{opt nolog}
suppress the {cmd:mlogit} log-likelihood iteration log.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse rootstock}{p_end}

{pstd}Fit a logistic discriminant analysis model with equal prior probabilities
for the six rootstock groups and display classification matrix{p_end}
{phang2}{cmd:. discrim logistic y1 y2 y3 y4, group(rootstock)}{p_end}

{pstd}Fit the same model, but use prior probabilities of 0.2 for the first
four rootstocks and 0.1 for the last two rootstocks{p_end}
{phang2}
{cmd:. discrim logistic y*, group(rootstock) priors(.2,.2,.2,.2,.1,.1)}
{p_end}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:discrim logistic} saves the following in {cmd:e()}:

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Scalars}{p_end}
{synopt:{cmd:e(N)}}number of observations{p_end}
{synopt:{cmd:e(N_groups)}}number of groups{p_end}
{synopt:{cmd:e(k)}}number of discriminating variables{p_end}
{synopt:{cmd:e(ibaseout)}}base outcome number{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Macros}{p_end}
{synopt:{cmd:e(cmd)}}{cmd:discrim}{p_end}
{synopt:{cmd:e(subcmd)}}{cmd:logistic}{p_end}
{synopt:{cmd:e(cmdline)}}command as typed{p_end}
{synopt:{cmd:e(groupvar)}}name of group variable{p_end}
{synopt:{cmd:e(grouplabels)}}labels for the groups{p_end}
{synopt:{cmd:e(varlist)}}discriminating variables{p_end}
{synopt:{cmd:e(dropped)}}variables dropped because of collinearity{p_end}
{synopt:{cmd:e(wtype)}}weight type{p_end}
{synopt:{cmd:e(wexp)}}weight expression{p_end}
{synopt:{cmd:e(title)}}title in estimation output{p_end}
{synopt:{cmd:e(ties)}}how ties are to be handled{p_end}
{synopt:{cmd:e(properties)}}{cmd:b noV}{p_end}
{synopt:{cmd:e(estat_cmd)}}program used to implement {cmd:estat}{p_end}
{synopt:{cmd:e(predict)}}program used to implement {cmd:predict}{p_end}
{synopt:{cmd:e(marginsnotok)}}predictions disallowed by {cmd:margins}{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Matrices}{p_end}
{synopt:{cmd:e(b)}}coefficient vector{p_end}
{synopt:{cmd:e(groupcounts)}}number of observations for each group{p_end}
{synopt:{cmd:e(grouppriors)}}prior probabilities for each group{p_end}
{synopt:{cmd:e(groupvalues)}}numeric value for each group{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Functions}{p_end}
{synopt:{cmd:e(sample)}}marks estimation sample{p_end}
{p2colreset}{...}
