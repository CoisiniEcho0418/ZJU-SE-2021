{smcl}
{* *! version 1.1.4  10jun2011}{...}
{viewerdialog ameans "dialog ameans"}{...}
{vieweralsosee "[R] ameans" "mansection R ameans"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] ci" "help ci"}{...}
{vieweralsosee "[R] mean" "help mean"}{...}
{vieweralsosee "[R] summarize" "help summarize"}{...}
{vieweralsosee "[SVY] svy estimation" "help svy_estimation"}{...}
{viewerjumpto "Syntax" "ameans##syntax"}{...}
{viewerjumpto "Description" "ameans##description"}{...}
{viewerjumpto "Options" "ameans##options"}{...}
{viewerjumpto "Examples" "ameans##examples"}{...}
{viewerjumpto "Saved results" "ameans##saved_results"}{...}
{title:Title}

{p2colset 5 19 21 2}{...}
{p2col :{manlink R ameans} {hline 2}}Arithmetic, geometric, and harmonic means{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 14 2}
{cmd:ameans} [{varlist}]
{ifin} {weight}
[{cmd:,} {it:options}]

{synoptset 16 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:Main}
{synopt:{opt a:dd(#)}}add {it:#} to each variable in {varlist}{p_end}
{synopt:{opt o:nly}}add {it:#} only to variables with nonpositive values{p_end}
{synopt:{opt l:evel(#)}}set confidence level; default is {cmd:level(95)}{p_end}
{synoptline}
{p2colreset}{...}
{p 4 6 2}
{cmd:by} is allowed; see {manhelp by D}.{p_end}
{p 4 6 2}
{cmd:aweight}s and {cmd:fweight}s are allowed; see {help weight}.


{title:Menu}

{phang}
{bf:Statistics > Summaries, tables, and tests >}
       {bf:Summary and descriptive statistics > Arith./geometric/harmonic means}


{marker description}{...}
{title:Description}

{pstd}
{cmd:ameans} computes the arithmetic, geometric, and harmonic means, 
with their corresponding confidence intervals, for each variable in {varlist}
or for all the variables in the data if {it:varlist} is not specified.
{cmd:gmeans} and {cmd:hmeans} are synonyms for {cmd:ameans}.

{pstd}
If you simply want arithmetic means and corresponding confidence intervals,
see {manhelp ci R}.


{marker options}{...}
{title:Options}

{dlgtab:Main}

{phang}
{opt add(#)} adds the value {it:#} to each variable in
{varlist} before computing the means and confidence intervals.  This option is
useful when analyzing variables with nonpositive values.

{phang}
{opt only} modifies the action of the {opt add(#)} option so that it 
adds {it:#} only to variables with at least one nonpositive value.

{phang}
{opt level(#)} specifies the confidence level, as a percentage,
for confidence intervals. The default is {cmd:level(95)} or as set by 
{helpb set level}.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse systolic}{p_end}

{pstd}Compute arithmetic, geometric, and harmonic means{p_end}
{phang2}{cmd:. ameans systolic}{p_end}

{pstd}Same as above, but add 7 to {cmd:systolic} before computing means{p_end}
{phang2}{cmd:. ameans systolic, add(7)}{p_end}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:ameans} saves the following in {cmd:r()}:

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Scalars}{p_end}
{synopt:{cmd:r(N)}}number of nonmissing observations; used for arithmetic
mean{p_end}
{synopt:{cmd:r(N_pos)}}number of nonmissing positive observations; used for
geometric and harmonic means{p_end}
{synopt:{cmd:r(mean)}}arithmetic mean{p_end}
{synopt:{cmd:r(lb)}}lower bound of confidence interval for arithmetic mean{p_end}
{synopt:{cmd:r(ub)}}upper bound of confidence interval for arithmetic mean{p_end}
{synopt:{cmd:r(Var)}}variance of untransformed data{p_end}
{synopt:{cmd:r(mean_g)}}geometric mean{p_end}
{synopt:{cmd:r(lb_g)}}lower bound of confidence interval for geometric mean{p_end}
{synopt:{cmd:r(ub_g)}}upper bound of confidence interval for geometric mean{p_end}
{synopt:{cmd:r(Var_g)}}variance of ln x_i{p_end}
{synopt:{cmd:r(mean_h)}}harmonic mean{p_end}
{synopt:{cmd:r(lb_h)}}lower bound of confidence interval for harmonic mean{p_end}
{synopt:{cmd:r(ub_h)}}upper bound of confidence interval for harmonic mean{p_end}
{synopt:{cmd:r(Var_h)}}variance of 1/x_i{p_end}
{p2colreset}{...}
