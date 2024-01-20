{smcl}
{* *! version 1.1.4  07apr2011}{...}
{viewerdialog "cluster single" "dialog cluster_singlelinkage"}{...}
{viewerdialog "cluster average" "dialog cluster_averagelinkage"}{...}
{viewerdialog "cluster complete" "dialog cluster_completelinkage"}{...}
{viewerdialog "cluster wards" "dialog cluster_wardslinkage"}{...}
{viewerdialog "cluster waverage" "dialog cluster_waveragelinkage"}{...}
{viewerdialog "cluster median" "dialog cluster_medianlinkage"}{...}
{viewerdialog "cluster centroid" "dialog cluster_centroidlinkage"}{...}
{viewerdialog "" "--"}{...}
{viewerdialog "clustermat single" "dialog clustermat_singlelinkage"}{...}
{viewerdialog "clustermat average" "dialog clustermat_averagelinkage"}{...}
{viewerdialog "clustermat complete" "dialog clustermat_completelinkage"}{...}
{viewerdialog "clustermat wards" "dialog clustermat_wardslinkage"}{...}
{viewerdialog "clustermat waverage" "dialog clustermat_waveragelinkage"}{...}
{viewerdialog "clustermat median" "dialog clustermat_medianlinkage"}{...}
{viewerdialog "clustermat centroid" "dialog clustermat_centroidlinkage"}{...}
{vieweralsosee "[MV] cluster linkage" "mansection MV clusterlinkage"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[MV] cluster" "help cluster"}{...}
{vieweralsosee "[MV] clustermat" "help clustermat"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[MV] cluster dendrogram" "help cluster_dendrogram"}{...}
{vieweralsosee "[MV] cluster generate" "help cluster_generate"}{...}
{vieweralsosee "[MV] cluster notes" "help cluster_notes"}{...}
{vieweralsosee "[MV] cluster stop" "help cluster_stop"}{...}
{vieweralsosee "[MV] cluster utility" "help cluster_utility"}{...}
{viewerjumpto "Syntax" "cluster linkage##syntax"}{...}
{viewerjumpto "Description" "cluster linkage##description"}{...}
{viewerjumpto "Options for cluster linkage commands" "cluster linkage##options_cluster"}{...}
{viewerjumpto "Options for clustermat linkage commands" "cluster linkage##options_clustermat"}{...}
{viewerjumpto "Examples" "cluster linkage##examples"}{...}
{title:Title}

{p2colset 5 29 31 2}{...}
{p2col :{manlink MV cluster linkage} {hline 2}}Hierarchical cluster analysis{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{pstd}
Cluster analysis of data

{p 8 33 2}
{cmd:cluster} {it:linkage} [{varlist}] {ifin}
[{cmd:,} {it:cluster_options}]


{pstd}
Cluster analysis of a dissimilarity matrix

{p 8 33 2}
{cmd:clustermat} {it:linkage}{space 2}{it:matname}{space 2}{ifin}
[{cmd:,} {it:clustermat_options}]


INCLUDE help clus_linkage

INCLUDE help cluster_hier_optstab

INCLUDE help clustermat_hier_optstab


{title:Menu}

    {title:cluster singlelinkage}

{phang2}
{bf:Statistics > Multivariate analysis > Cluster analysis > Cluster data >}
      {bf:Single linkage}

    {title:cluster averagelinkage}

{phang2}
{bf:Statistics > Multivariate analysis > Cluster analysis > Cluster data >}
       {bf:Average linkage}

    {title:cluster completelinkage}

{phang2}
{bf:Statistics > Multivariate analysis > Cluster analysis > Cluster data >}
       {bf:Complete linkage}

    {title:cluster waveragelinkage}

{phang2}
{bf:Statistics > Multivariate analysis > Cluster analysis > Cluster data >}
        {bf:Weighted-average linkage}

    {title:cluster medianlinkage}

{phang2}
{bf:Statistics > Multivariate analysis > Cluster analysis > Cluster data >}
        {bf:Median linkage}

    {title:cluster centroidlinkage}

{phang2}
{bf:Statistics > Multivariate analysis > Cluster analysis > Cluster data >}
       {bf:Centroid linkage}

    {title:cluster wardslinkage}

{phang2}
{bf:Statistics > Multivariate analysis > Cluster analysis > Cluster data >}
        {bf:Ward's linkage}


{marker description}{...}
{title:Description}

{pstd}
Stata's {cmd:cluster} and {cmd:clustermat} commands provide the following
hierarchical agglomerative linkage methods:
single,
complete,
average,
Ward's method,
centroid,
median,
and weighted average.
There are others mentioned in the literature, but these are the best-known
methods.

{pstd}
The {cmd:clustermat} linkage commands perform hierarchical agglomerative
linkage cluster analysis on the dissimilarity matrix {it:matname}.  See
{manhelp clustermat MV} for a general discussion of cluster analysis of
dissimilarity matrices and a description of the other {cmd:clustermat}
commands.

{pstd}
After a {cmd:cluster} {it:linkage} or {cmd:clustermat} {it:linkage} command,
the {cmd:cluster dendrogram} command
(see {manhelp cluster_dendrogram MV:cluster dendrogram}) displays the resulting
dendrogram, the {cmd:cluster stop} or {cmd:clustermat stop} command
(see {manhelp cluster_stop MV:cluster stop}) helps determine the number of
groups, and the {cmd:cluster generate} command (see
{manhelp cluster_generate MV:cluster generate}) produces grouping variables.


{marker options_cluster}{...}
{title:Options for cluster linkage commands}

{dlgtab:Main}

{phang}
{opt measure(measure)}
specifies the similarity or dissimilarity measure. 
The default for {cmd:averagelinkage}, {cmd:completelinkage},
{cmd:singlelinkage}, and {cmd:waveragelinkage} is {cmd:L2} (synonym
{opt Euc:lidean}).  The default for {cmd:centroidlinkage},
{cmd:medianlinkage}, and {cmd:wardslinkage} is {cmd:L2squared}.  This option
is not case sensitive.  See {manhelpi measure_option MV} for a discussion of
these measures.

{pmore}
Several authors advise using the {cmd:L2squared} {it:measure} exclusively with
centroid, median, and Ward's linkage. See
{it:{mansection MV clusterRemarksDissimilaritytransformationsandtheLanceandWilliamsformula:Dissimilarity transformations and the Lance-Williams formula}}
and
{it:{mansection MV clusterRemarksWarningconcerningsimilarityordissimilaritychoice:Warning concerning dissimilarity choice}}
in {bf:[MV] cluster} for details.

{phang}
{opt name(clname)}
specifies the name to attach to the resulting cluster analysis.  If
{cmd:name()} is not specified, Stata finds an available cluster name, displays
it for your reference, and then attaches the name to your cluster analysis.

{dlgtab:Advanced}

{phang}
{opt generate(stub)}
provides a prefix for the variable names created by {cmd:cluster}
{it:linkage}.  By default, the variable name prefix will be the name specified
in {cmd:name()}.  Three variables with the suffixes {hi:_id}, {hi:_ord}, and
{hi:_hgt} are created and attached to the cluster-analysis results.  Users
generally will not need to access these variables directly.

{pmore}
Centroid linkage and median linkage can produce reversals or crossovers;
see {manlink MV cluster} for details.  When reversals happen,
{cmd:cluster centroidlinkage} and {cmd:cluster medianlinkage} also create a
fourth variable with the suffix {hi:_pht}.  This is a pseudoheight variable
that is used by some postclustering commands to properly interpret the
{hi:_hgt} variable.


{marker options_clustermat}{...}
{title:Options for clustermat linkage commands}

INCLUDE help clustermat_hier_opts


{marker examples}{...}
{title:Examples}

    {hline}
{phang}{cmd:. webuse labtech}{p_end}
{phang}{cmd:. cluster singlelinkage x1 x2 x3 x4, name(L2slnk)}{p_end}
{phang}{cmd:. cluster dendrogram L2slnk, xlabel(, angle(90) labsize(*.75))}
{p_end}
    {hline}
{phang}{cmd:. webuse homework, clear}{p_end}
{phang}{cmd:. cluster averagelinkage a1-a60, measure(matching) name(alink)}
{p_end}
{phang}{cmd:. cluster wardslinkage a1-a60, measure(matching) name(wardlink)}
{p_end}
{phang}{cmd:. cluster medianlinkage a*, measure(L(1.5))}{p_end}
    {hline}
