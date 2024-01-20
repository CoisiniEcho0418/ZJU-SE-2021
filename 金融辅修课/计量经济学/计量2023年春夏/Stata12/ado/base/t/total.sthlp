{smcl}
{* *! version 1.1.16  10may2011}{...}
{viewerdialog total "dialog total"}{...}
{viewerdialog "svy: total" "dialog total, message(-svy-) name(svy_total)"}{...}
{vieweralsosee "[R] total" "mansection R total"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] total postestimation" "help total postestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] mean" "help mean"}{...}
{vieweralsosee "[R] proportion" "help proportion"}{...}
{vieweralsosee "[R] ratio" "help ratio"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[MI] estimation" "help mi_estimation"}{...}
{vieweralsosee "[SVY] svy estimation" "help svy_estimation"}{...}
{viewerjumpto "Syntax" "total##syntax"}{...}
{viewerjumpto "Description" "total##description"}{...}
{viewerjumpto "Options" "total##options"}{...}
{viewerjumpto "Example" "total##example"}{...}
{viewerjumpto "Saved results" "total##saved_results"}{...}
{title:Title}

{p2colset 5 18 20 2}{...}
{p2col:{manlink R total} {hline 2}}Estimate totals{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 14 2}
{cmd:total} {varlist} {ifin} {weight} [{cmd:,} {it:options}]


{synoptset 26 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:if/in/over}
{synopt :{cmd:over(}{varlist}[{cmd:,} {opt nolab:el}]{cmd:)}}group over
subpopulations defined by {it:varlist}; optionally, suppress group
labels{p_end}

{syntab:SE/Cluster}
{synopt :{opth vce(vcetype)}}{it:vcetype}
	may be {opt analytic}, {opt cl:uster} {it:clustvar}, {opt boot:strap},
	or {opt jack:knife}{p_end}

{syntab:Reporting}
{synopt :{opt l:evel(#)}}set confidence level; default is {cmd:level(95)}{p_end}
{synopt :{opt noh:eader}}suppress table header{p_end}
{synopt :{opt nol:egend}}suppress table legend{p_end}
{synopt :{it:{help total##display_options:display_options}}}control
column formats and line width{p_end}

INCLUDE help shortdes-coeflegend
{synoptline}
{p2colreset}{...}
{p 4 6 2}
{cmd:bootstrap}, {cmd:jackknife}, {cmd:mi estimate}, {cmd:rolling}, {cmd:statsby},
and {cmd:svy} are allowed; see {help prefix}.{p_end}
INCLUDE help vce_mi
{p 4 6 2}Weights are not allowed with the {helpb bootstrap} prefix.{p_end}
{p 4 6 2}
{opt vce()} and weights are not allowed with the {helpb svy} prefix.
{p_end}
{p 4 6 2}
{opt fweight}s, {opt pweight}s, and {opt iweight}s are allowed; see {help weight}.{p_end}
{p 4 6 2}
{opt coeflegend} does not appear in the dialog box.{p_end}
{p 4 6 2}See {manhelp total_postestimation R:total postestimation} for
features available after estimation.{p_end}


{title:Menu}

{phang}
{bf:Statistics > Summaries, tables, and tests >}
      {bf:Summary and descriptive statistics > Totals}


{marker description}{...}
{title:Description}

{pstd}
{opt total} produces estimates of totals, along with standard errors.


{marker options}{...}
{title:Options}

{dlgtab:if/in/over}

{phang}
{opt over}{cmd:(}{varlist} [{cmd:,} {opt nolabel}]{cmd:)}
specifies that estimates be computed for multiple subpopulations,
which are identified by the different values of the variables in 
{it:varlist}.

{pmore}
When this option is supplied with one variable name, such as
{opth over(varname)}, the value labels of {it:varname} are used to identify
the subpopulations.  If {it:varname} does not have labeled values (or there
are unlabeled values), the values themselves are used, provided that they are
nonnegative integers.  Noninteger values, negative values, and labels that
are not valid Stata names are substituted with a default identifier.

{pmore}
When {cmd:over()} is supplied with multiple variable names, each subpopulation
is assigned a unique default identifier.

{phang2}
{opt nolabel} specifies that value labels attached to the variables
identifying the subpopulations be ignored.

{dlgtab:SE/Cluster}

{phang}
{opt vce(vcetype)} specifies the type of standard error reported, which 
includes types that are derived from asymptotic theory,
that allow for intragroup correlation, and that use bootstrap or
jackknife methods; see {manhelpi vce_option R}.{p_end}

{pmore}
{cmd:vce(analytic)}, the default, uses the analytically derived variance
estimator associated with the sample total.

{dlgtab:Reporting}

{phang}
{opt level(#)}; see {helpb estimation options##level():[R] estimation options}.

{phang}
{opt noheader} prevents the table header from being displayed. This option
implies {opt nolegend}.

{phang}
{opt nolegend} prevents the table legend identifying the subpopulations from
being displayed.
{p_end}

{marker display_options}{...}
{phang}
{it:display_options}:
{opth cformat(%fmt)} and {opt nolstretch};
    see {helpb estimation options##display_options:[R] estimation options}.

{pstd}
The following option is available with {opt total} but is not shown in the
dialog box:

{phang}
{opt coeflegend}; see
     {helpb estimation options##coeflegend:[R] estimation options}.


{marker example}{...}
{title:Example}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse total}{p_end}

{pstd}Estimate totals over values of {cmd:sex}, using {cmd:swgt} as
{cmd:pweight}s{p_end}
{phang2}{cmd:. total heartatk [pw=swgt], over(sex)}{p_end}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:total} saves the following in {cmd:e()}:

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Scalars}{p_end}
{synopt:{cmd:e(N)}}number of observations{p_end}
{synopt:{cmd:e(N_over)}}number of subpopulations{p_end}
{synopt:{cmd:e(N_clust)}}number of clusters{p_end}
{synopt:{cmd:e(k_eq)}}number of equations in {cmd:e(b)}{p_end}
{synopt:{cmd:e(df_r)}}sample degrees of freedom{p_end}
{synopt:{cmd:e(rank)}}rank of {cmd:e(V)}{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Macros}{p_end}
{synopt:{cmd:e(cmd)}}{cmd:total}{p_end}
{synopt:{cmd:e(cmdline)}}command as typed{p_end}
{synopt:{cmd:e(varlist)}}{it:varlist}{p_end}
{synopt:{cmd:e(wtype)}}weight type{p_end}
{synopt:{cmd:e(wexp)}}weight expression{p_end}
{synopt:{cmd:e(title)}}title in estimation output{p_end}
{synopt:{cmd:e(cluster)}}name of cluster variable{p_end}
{synopt:{cmd:e(over)}}{it:varlist} from {cmd:over()}{p_end}
{synopt:{cmd:e(over_labels)}}labels from {cmd:over()} variables{p_end}
{synopt:{cmd:e(over_namelist)}}names from {cmd:e(over_labels)}{p_end}
{synopt:{cmd:e(vce)}}{it:vcetype} specified in {cmd:vce()}{p_end}
{synopt:{cmd:e(vcetype)}}title used to label Std. Err.{p_end}
{synopt:{cmd:e(properties)}}{cmd:b V}{p_end}
{synopt:{cmd:e(estat_cmd)}}program used to implement {cmd:estat}{p_end}
{synopt:{cmd:e(marginsnotok)}}predictions disallowed by {cmd:margins}{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Matrices}{p_end}
{synopt:{cmd:e(b)}}vector of total estimates{p_end}
{synopt:{cmd:e(V)}}(co)variance estimates{p_end}
{synopt:{cmd:e(_N)}}vector of numbers of nonmissing observations{p_end}
{synopt:{cmd:e(error)}}error code corresponding to {cmd:e(b)}{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Functions}{p_end}
{synopt:{cmd:e(sample)}}marks estimation sample{p_end}
{p2colreset}{...}
