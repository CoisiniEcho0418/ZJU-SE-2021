{smcl}
{* *! version 1.1.3  11feb2011}{...}
{viewerdialog "cluster notes" "dialog cluster_note"}{...}
{vieweralsosee "[MV] cluster notes" "mansection MV clusternotes"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[MV] cluster" "help cluster"}{...}
{vieweralsosee "[MV] clustermat" "help clustermat"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[MV] cluster programming utilities" "help cluster_programming"}{...}
{vieweralsosee "[MV] cluster utility" "help cluster_utility"}{...}
{vieweralsosee "[D] notes" "help notes"}{...}
{vieweralsosee "[D] save" "help save"}{...}
{viewerjumpto "Syntax" "cluster notes##syntax"}{...}
{viewerjumpto "Description" "cluster notes##description"}{...}
{viewerjumpto "Examples" "cluster notes##examples"}{...}
{title:Title}

{p2colset 5 27 29 2}{...}
{p2col :{manlink MV cluster notes} {hline 2}}Place notes in cluster analysis{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

INCLUDE help cluster_notes_syntax


{title:Menu}

{phang}
{bf:Statistics > Multivariate analysis > Cluster analysis > Postclustering >}
      {bf:Cluster analysis notes}


{marker description}{...}
{title:Description}

{pstd}
The {cmd:cluster notes} command attaches notes to a previously run cluster
analysis.  The notes become part of the data and are saved when the data are
saved and retrieved when the data are used; see {manhelp save D}.

{pstd}
To add a note to a cluster analysis, type {cmd:cluster notes}, the
cluster-analysis name, a colon, and the text.

{pstd}
Typing {cmd:cluster notes} by itself lists all cluster notes associated
with all defined cluster analyses.  {cmd:cluster notes} followed by one or more
cluster names lists the notes for those cluster analyses.

{pstd}
{cmd:cluster notes drop} allows you to drop cluster notes.  If
{cmd:in} {it:{help numlist}} is omitted, all notes for {it:clname} are dropped.

{pstd}
See {manhelp cluster MV} for information on the available cluster analysis
commands.


{marker examples}{...}
{title:Examples}

{phang}{cmd:. cluster notes myclus: Group 9 looks strange.  Examine it closer.}{p_end}
{phang}{cmd:. cluster notes ageclus: Consider removing the singleton groups.}{p_end}
{phang}{cmd:. cluster notes}{p_end}
{phang}{cmd:. cluster notes myclus}{p_end}
{phang}{cmd:. cluster notes drop clusxyz in 3 6/8}{p_end}
{phang}{cmd:. cluster notes drop ageclus}{p_end}
{phang}{cmd:. cluster notes}{p_end}
