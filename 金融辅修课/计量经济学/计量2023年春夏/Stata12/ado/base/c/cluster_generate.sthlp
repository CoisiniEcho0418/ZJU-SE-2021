{smcl}
{* *! version 1.1.5  11feb2011}{...}
{viewerdialog "cluster generate" "dialog cluster_generate"}{...}
{vieweralsosee "[MV] cluster generate" "mansection MV clustergenerate"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[MV] cluster" "help cluster"}{...}
{vieweralsosee "[MV] clustermat" "help clustermat"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[D] egen" "help egen"}{...}
{vieweralsosee "[D] generate" "help generate"}{...}
{viewerjumpto "Syntax" "cluster generate##syntax"}{...}
{viewerjumpto "Description" "cluster generate##description"}{...}
{viewerjumpto "Options" "cluster generate##options"}{...}
{viewerjumpto "Examples" "cluster generate##examples"}{...}
{title:Title}

{p2colset 5 30 32 2}{...}
{p2col :{manlink MV cluster generate} {hline 2}}Generate summary or grouping variables from a cluster analysis{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

INCLUDE help cluster_generate_optstab


{title:Menu}

{phang}
{bf:Statistics > Multivariate analysis > Cluster analysis > Postclustering >}
      {bf:Summary variables from cluster analysis}


{marker description}{...}
{title:Description}

{pstd}
The {cmd:cluster generate} command generates summary or grouping variables
from a hierarchical cluster analysis.  The result depends on the function.  See
{manhelp cluster MV} for information on available cluster analysis commands.

{pstd}
The {opth groups(numlist)} function generates grouping variables,
giving the grouping for the specified numbers of clusters from a
hierarchical cluster analysis.  If one number is given,
{newvar} is produced with group numbers going from 1 to the number of
clusters requested.  If more than one number is specified, a new variable is
generated for each number by using the provided {it:stub} name appended with the
number.  For instance,

{center:{cmd:cluster gen xyz = groups(5/7), name(myclus)}}

{pstd}
creates variables {hi:xyz5}, {hi:xyz6}, and {hi:xyz7}, giving groups 5, 6,
and 7 obtained from the cluster analysis named {hi:myclus}.

{pstd}
The {cmd:cut(}{it:#}{cmd:)} function generates a grouping variable
corresponding to cutting the dendrogram (see
{manhelp cluster_dendrogram MV:cluster dendrogram})
of a hierarchical cluster analysis at the specified (dis)similarity value.

{pstd}
More {cmd:cluster generate} functions may be added; see
{manhelp cluster_programming MV:cluster programming utilities}.


{marker options}{...}
{title:Options}

{phang}
{cmd:name(}{it:clname}{cmd:)} specifies the name of the cluster
analysis to use in producing the new variables.  The default is the 
name of the cluster analysis last performed, which can be reset using the
{cmd:cluster use} command; see {manhelp cluster_utility MV:cluster utility}.

{phang}
{cmd:ties(}{cmd:error} | {cmd:skip} | {cmd:fewer} | {cmd:more}{cmd:)}
indicates what to do with the {cmd:groups()} function for ties.  A
hierarchical cluster analysis has ties when multiple groups are generated at a
particular (dis)similarity value.  For example, you might have the case where
you can uniquely create two, three, and four groups, but the next possible
grouping produces eight groups because of ties.

{pmore}
{cmd:ties(error)}, the default, produces an error message and does not
  generate the requested variables.

{pmore}
{cmd:ties(skip)} specifies that the offending requests are to be
  ignored.  No error message is produced, and only the requests that produce
  unique groupings will be honored.  With multiple values specified in the
  {cmd:groups()} function, {cmd:ties(skip)} allows the processing of those
  that produce unique groupings and ignores the rest.

{pmore}
{cmd:ties(fewer)} produces the results for the largest number of groups
  less than or equal to your request.  In the example above with
  {cmd:groups(6)} and using {cmd:ties(fewer)}, you would get the same result
  that you would by using {cmd:groups(4)}.

{pmore}
{cmd:ties(more)} produces the results for the smallest number of groups
  greater than or equal to your request.  In the example above with
  {cmd:groups(6)} and using {cmd:ties(more)}, you would get the same result
  that you would by using {cmd:groups(8)}.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse labtech}{p_end}
{phang2}{cmd:. cluster completelinkage x1 x2 x3 x4, name(L2clnk)}

{pstd}Generate grouping variable for two groups{p_end}
{phang2}{cmd:. cluster generate g2 = groups(2), name(L2clnk)}{p_end}

{pstd}Generate grouping variable by cutting dendrogram at dissimilarity
measure of 227.3{p_end}
{phang2}{cmd:. cluster gen g2cut = cut(227.3)}{p_end}

{pstd}Generate set of grouping variables for three to 12 groups{p_end}
{phang2}{cmd:. cluster gen gp = gr(3/12), name(L2clnk)}{p_end}

{pstd}If there are ties, create more than the requested four groups{p_end}
{phang2}{cmd:. cluster gen more4 = gr(4), ties(more)}{p_end}

{pstd}If there are ties, create fewer than the requested four groups{p_end}
{phang2}{cmd:. cluster gen less4 = gr(4), ties(fewer)}{p_end}
