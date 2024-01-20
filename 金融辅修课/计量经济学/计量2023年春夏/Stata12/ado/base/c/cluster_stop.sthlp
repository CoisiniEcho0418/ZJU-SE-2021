{smcl}
{* *! version 1.1.9  11feb2011}{...}
{viewerdialog "cluster stop" "dialog cluster_stop"}{...}
{viewerdialog "clustermat stop" "dialog clustermat_stop"}{...}
{vieweralsosee "[MV] cluster stop" "mansection MV clusterstop"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[MV] cluster" "help cluster"}{...}
{vieweralsosee "[MV] clustermat" "help clustermat"}{...}
{viewerjumpto "Syntax" "cluster stop##syntax"}{...}
{viewerjumpto "Description" "cluster stop##description"}{...}
{viewerjumpto "Options" "cluster stop##options"}{...}
{viewerjumpto "Examples" "cluster stop##examples"}{...}
{viewerjumpto "Saved results" "cluster stop##saved_results"}{...}
{viewerjumpto "References" "cluster stop##references"}{...}
{title:Title}

{p2colset 5 26 28 2}{...}
{p2col :{manlink MV cluster stop} {hline 2}}Cluster-analysis stopping rules{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

INCLUDE help cluster_stop_syntax


{title:Menu}

{phang}
{bf:Statistics > Multivariate analysis > Cluster analysis > Postclustering >}
        {bf:Cluster analysis stopping rules}


{marker description}{...}
{title:Description}

{pstd}
Cluster-analysis stopping rules are used to determine the number
of clusters.  A stopping-rule value (also called an index) is computed
for each cluster solution (for example, at each level of the hierarchy in
a hierarchical cluster analysis).  Larger values (or smaller, depending
on the particular stopping rule) indicate more distinct clustering.
See {manhelp cluster MV} for background information on cluster analysis and
on the {cmd:cluster} and {cmd:clustermat} commands.

{pstd}
The {cmd:cluster stop} and {cmd:clustermat stop} commands currently provide
two  stopping rules, the 
{help cluster stop##CH1974:Calinski and Harabasz (1974)} pseudo-F index and the
{help cluster stop##DH2001:Duda-Hart (2001, sec. 10.10)} Je(2)/Je(1) index.
For both rules, larger values indicate more distinct clustering.  Presented
with the Duda-Hart Je(2)/Je(1) values are pseudo-T-squared values.  Smaller
pseudo-T-squared values indicate more distinct clustering.

{pstd}
{it:clname} specifies the name of the cluster analysis.  The default
is the most recently performed cluster analysis, which can be reset using the
{cmd:cluster use} command; see {manhelp cluster_utility MV:cluster utility}.

{pstd}
More {cmd:stop} rules may be added; see
{manhelp cluster_subroutines MV:cluster programming subroutines}, which
illustrates this ability by showing a program that adds the step-size stopping
rule.


{marker options}{...}
{title:Options}

{marker rule()}{...}
{phang}
{cmd:rule(calinski} | {cmd:duda} | {it:rule_name}{cmd:)} indicates the
stopping rule.  {cmd:rule(calinski)}, the default, specifies the
Calinski-Harabasz pseudo-F index.  {cmd:rule(duda)} specifies the Duda-Hart 
Je(2)/Je(1) index.

{pmore}
{cmd:rule(calinski)} is allowed for both hierarchical and nonhierarchical
cluster analyses.  {cmd:rule(duda)} is allowed only for hierarchical cluster
analyses.

{pmore}
You can add stopping rules to the {cmd:cluster} {cmd:stop} command (see
{manhelp cluster_subroutines MV:cluster programming subroutines}) by using the
{opt rule(rule_name)} option.  
{manhelp cluster_subroutines MV:cluster programming subroutines}
illustrates how to add stopping rules by showing a program that adds a
{cmd:rule(stepsize)} option, which implements the simple step-size stopping
rule mentioned in 
{help cluster stop##MC1985:Milligan and Cooper (1985)}.

{phang}
{opth groups(numlist)} specifies the cluster groupings for which the
stopping rule is to be computed.  {cmd:groups(3/20)} specifies that the
measure be computed for the three-group solution, the four-group
solution, ..., and the 20-group solution.

{pmore}
With {cmd:rule(duda)}, the default is {cmd:groups(1/15)}.  With
{cmd:rule(calinski)} for a hierarchical cluster analysis, the default is
{cmd:groups(2/15)}.  {cmd:groups(1)} is not allowed with
{cmd:rule(calinski)} because the measure is not defined for the degenerate
one-group cluster solution.  The {cmd:groups()} option is unnecessary
(and not allowed) for a nonhierarchical cluster analysis.

{pmore}
If there are ties in the hierarchical cluster-analysis structure, some (or
possibly all) of the requested stopping-rule solutions may not be computable.
{bind:{cmd:cluster stop}} passes over, without comment, the {cmd:groups()} for
which ties in the hierarchy cause the stopping rule to be undefined.

{phang}
{opt matrix(matname)} saves the results in a matrix named {it:matname}.

{pmore}
With {cmd:rule(calinski)}, the matrix has two columns, the first
giving the number of clusters and the second giving the corresponding
Calinski-Harabasz pseudo-F stopping-rule index.

{pmore}
With {cmd:rule(duda)}, the matrix has three columns: the first column gives
the number of clusters, the second column gives the corresponding
Duda-Hart Je(2)/Je(1) stopping-rule index, and the third column provides
the corresponding pseudo-T-squared values.

{phang}
{opth variables(varlist)} specifies the variables to be used in the computation
of the stopping rule.  By default, the variables used for the cluster analysis
are used.  {cmd:variables()} is required for cluster solutions produced by
{cmd:clustermat}.


{marker examples}{...}
{title:Examples}

{phang}{cmd:. cluster stop}{p_end}
{phang}{cmd:. cluster stop myclus, rule(duda)}{p_end}
{phang}{cmd:. cluster stop, rule(calinski) groups(2/20) matrix(z)}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:cluster stop} and {cmd:clustermat stop} with {cmd:rule(calinski)}
saves the following in {cmd:r()}:

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Scalars}{p_end}
{synopt:{cmd:r(calinski_#)}}Calinski-Harabasz pseudo-F for # groups{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Macros}{p_end}
{synopt:{cmd:r(rule)}}{cmd:calinski}{p_end}
{synopt:{cmd:r(label)}}{cmd:C-H pseudo-F}{p_end}
{synopt:{cmd:r(longlabel)}}{cmd:Calinski & Harabasz pseudo-F}{p_end}

{pstd}
{cmd:cluster stop} and {cmd:clustermat stop} with {cmd:rule(duda)}
saves the following in {cmd:r()}:

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Scalars}{p_end}
{synopt:{cmd:r(duda_#)}}Duda-Hart Je(2)/Je(1) value for # groups{p_end}
{synopt:{cmd:r(dudat2_#)}}Duda-Hart pseudo-T-squared value for # groups{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Macros}{p_end}
{synopt:{cmd:r(rule)}}{cmd:duda}{p_end}
{synopt:{cmd:r(label)}}{cmd:D-H Je(2)/Je(1)}{p_end}
{synopt:{cmd:r(longlabel)}}{cmd:Duda & Hart Je(2)/Je(1)}{p_end}
{synopt:{cmd:r(label2)}}{cmd:D-H pseudo-T-squared}{p_end}
{synopt:{cmd:r(longlabel2)}}{cmd:Duda & Hart pseudo-T-squared}{p_end}
{p2colreset}{...}


{marker references}{...}
{title:References}

{marker CH1974}{...}
{phang}
Calinski, T., and J. Harabasz. 1974. A dendrite method for cluster analysis.
{it:Communications in Statistics} 3: 1-27.

{marker DH2001}{...}
{phang}
Duda, R. O., P. E. Hart, and D. B. Stork. 2001.
{it:Pattern Classification and Scene Analysis}, 2nd ed. New York: Wiley.

{marker MC1985}{...}
{phang}
Milligan, G. W., and M. C. Cooper. 1985.
An examination of procedures for determining the number of clusters in a
dataset. {it:Psychometrika} 50: 159-179.
{p_end}
