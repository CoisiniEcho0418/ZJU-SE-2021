{smcl}
{* *! version 1.1.11  21apr2011}{...}
{viewerdialog predict "dialog mds_p"}{...}
{viewerdialog estat "dialog mds_estat"}{...}
{viewerdialog mdsconfig "dialog mdsconfig"}{...}
{viewerdialog mdsshepard "dialog mdsshepard"}{...}
{viewerdialog screeplot "dialog screeplot"}{...}
{vieweralsosee "[MV] mds postestimation" "mansection MV mdspostestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[MV] mds" "help mds"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[MV] mdslong" "help mdslong"}{...}
{vieweralsosee "[MV] mdsmat" "help mdsmat"}{...}
{vieweralsosee "[MV] screeplot" "help screeplot"}{...}
{viewerjumpto "Description" "mds postestimation##description"}{...}
{viewerjumpto "Special-interest postestimation commands" "mds postestimation##special"}{...}
{viewerjumpto "" "--"}{...}
{viewerjumpto "Syntax for predict" "mds postestimation##syntax_predict"}{...}
{viewerjumpto "Options for predict" "mds postestimation##options_predict"}{...}
{viewerjumpto "" "--"}{...}
{viewerjumpto "Syntax for estat" "mds postestimation##syntax_estat"}{...}
{viewerjumpto "Options for estat" "mds postestimation##options_estat"}{...}
{viewerjumpto "" "--"}{...}
{viewerjumpto "Syntax for mdsconfig" "mds postestimation##syntax_mdsconfig"}{...}
{viewerjumpto "Options for mdsconfig" "mds postestimation##options_mdsconfig"}{...}
{viewerjumpto "" "--"}{...}
{viewerjumpto "Syntax for mdsshepard" "mds postestimation##syntax_mdsshepard"}{...}
{viewerjumpto "Options for mdsshepard" "mds postestimation##options_mdsshepard"}{...}
{viewerjumpto "" "--"}{...}
{viewerjumpto "Examples" "mds postestimation##examples"}{...}
{viewerjumpto "Saved results" "mds postestimation##saved_results"}{...}
{title:Title}

{p 4 33 2}
{manlink MV mds postestimation} {hline 2}
Postestimation tools for mds, mdsmat, and mdslong


{marker description}{...}
{title:Description}

{pstd}
The following postestimation commands are of special interest after {cmd:mds},
{cmd:mdsmat}, and {cmd:mdslong}:

{synoptset 22 tabbed}{...}
{p2coldent:Command}Description{p_end}
{synoptline}
{synopt:{helpb mds postestimation##estat:estat config}}coordinates of the
	approximating configuration{p_end}
{synopt:{helpb mds postestimation##estat:estat correlations}}correlations
	between dissimilarities and approximating distances{p_end}
{synopt:{helpb mds postestimation##estat:estat pairwise}}pairwise
	dissimilarities, approximating distances, and raw residuals{p_end}
{synopt:{helpb mds postestimation##estat:estat quantiles}}quantiles of the
	residuals per object{p_end}
{synopt:{helpb mds postestimation##estat:estat stress}}Kruskal stress
        (loss) measure (only after classical MDS){p_end}
{p2coldent:+ {helpb mds postestimation##estat:estat summarize}}estimation
	sample summary{p_end}
{synopt:{helpb mds postestimation##mdsconfig:mdsconfig}}plot of approximating
	configuration{p_end}
{synopt:{helpb mds postestimation##mdsshepard:mdsshepard}}Shepard diagram{p_end}
{synopt:{helpb screeplot}}plot eigenvalues (only after classical MDS){p_end}
{synoptline}
{p 4 6 2}
+ {cmd:estat summarize} is not available after {cmd:mdsmat}.

{pstd}
The following standard postestimation commands are also available:

{p2coldent:Command}Description{p_end}
{synoptline}
{p2coldent:* {helpb estimates}}cataloging estimation results{p_end}
{synopt:{helpb mds postestimation##predict:predict}}approximating
	configuration, disparities, dissimilarities, distances, and
	residuals{p_end}
{synoptline}
{p2colreset}{...}
{p 4 6 2}
* All {cmd:estimates} subcommands except {opt table} and {opt stats} are
available.
{p_end}


{marker special}{...}
{title:Special-interest postestimation commands}

{pstd}{cmd:estat config}
lists the coordinates of the approximating configuration.

{pstd}{cmd:estat correlations}
lists the Pearson and Spearman correlations between the disparities or
dissimilarities and the Euclidean distances for each object.

{pstd}{cmd:estat pairwise}
lists the pairwise statistics: the disparities, the
distances, and the residuals.

{pstd}{cmd:estat quantiles}
lists the quantiles of the residuals per object.

{pstd}{cmd:estat stress}
displays the Kruskal stress (loss) measure between the (transformed)
dissimilarities and fitted distances per object (only after classical MDS).

{pstd}{cmd:estat summarize}
summarizes the variables in the MDS over the estimation sample.  After
{cmd:mds}, {cmd:estat summarize} also reports whether and how variables were
transformed before computing similarities or dissimilarities.

{pstd}{cmd:mdsconfig}
produces a plot of the approximating Euclidean configuration.  By default,
dimensions 1 and 2 are plotted.

{pstd}{cmd:mdsshepard}
produces a Shepard diagram of the disparities against
the Euclidean distances.  Ideally, the points in the plot should be close
to the y=x line.  Optionally, separate plots are generated for each "row"
(value of {cmd:id()}).


{marker syntax_predict}{...}
{marker predict}{...}
{title:Syntax for predict}

{p 8 16 2}
{cmd:predict} {dtype} {{it:stub*}|{it:{help varlist:newvarlist}}} {ifin}
[{cmd:,} {it:statistic} {it:options}]

{synoptset 30 tabbed}{...}
{synopthdr:statistic}
{synoptline}
{syntab:Main}
{synopt:{opt con:fig}}approximating configuration; specify {cmd:dimension()} or
        fewer variables{p_end}
{synopt:{opt pair:wise(pstats)}}selected pairwise statistics; specify same
        number of variables{p_end}
{synoptline}

{p2coldent:{it:pstats}}Description{p_end}
{synoptline}
{synopt:{opt disp:arities}}disparities = transformed(dissimilarities){p_end}
{synopt:{opt diss:imilarities}}dissimilarities{p_end}
{synopt:{opt dist:ances}}Euclidean distances between configuration points{p_end}
{synopt:{opt rr:esiduals}}raw residual = dissimilarity - distance{p_end}
{synopt:{opt tr:esiduals}}transformed residual = disparity - distance{p_end}
{synopt:{opt we:ights}}weights{p_end}
{synoptline}

{synopthdr}
{synoptline}
{syntab:Main}
{p2coldent:* {cmdab:sav:ing(}{it:{help filename}}[{cmd:, replace}]{cmd:)}}save results to {it:filename}; use {cmd:replace} to overwrite existing {it:filename}{p_end}
{synopt:{opt full}}create predictions for all pairs of object; {opt pairwise()} only{p_end}
{synoptline}
{p2colreset}{...}
{p 4 6 2}
* {opt saving()} is required after {cmd:mdsmat}, after {cmd:mds} if
{opt pairwise} is selected, and after {cmd:mdslong} if {opt config} is
selected.
{p_end}


INCLUDE help menu_predict


{marker options_predict}{...}
{title:Options for predict}

{dlgtab:Main}

{phang}{cmd:config}
generates variables containing the approximating configuration in Euclidean
space.  Specify as many new variables as approximating dimensions (as
determined by the {cmd:dimension()} option of {cmd:mds}, {cmd:mdsmat}, or
{cmd:mdslong}), though you may specify fewer.
{cmd:estat config} displays the same information but does not store the
information in variables.  After {cmd:mdsmat} and {cmd:mdslong}, you must also
specify the {cmd:saving()} option.

{phang}{opt pairwise(pstats)}
generates new variables containing pairwise statistics.  The number of new
variables should be the same as the number of specified statistics.  The
following statistics are allowed

{phang3}{cmd:disparities}
generates the disparities, that is, the transformed dissimilarities.  If no
transformation is applied (modern MDS with
{cmd:transform(identity)}), disparities are the same as dissimilarities.

{phang3}{cmd:dissimilarities}
generates the dissimilarities used in MDS.  If {cmd:mds}, {cmd:mdslong}, or
{cmd:mdsmat} was invoked on similarity data, the associated dissimilarities
are returned.

{phang3}{cmd:distances}
generates the (unsquared) Euclidean distances between the fitted configuration
points.

{phang3}{cmd:rresiduals}
generates the raw residuals: dissimilarities - distances.

{phang3}{cmd:tresiduals}
generates the transformed residuals: disparities - distances.

{phang3}{cmd:weights}
generates the weights.  Missing proximities are represented by zero weights.

{pmore}
{cmd:estat pairwise} displays some of the same information
but does not store the information in variables.

{pmore}
After {cmd:mds} and {cmd:mdsmat}, you must also specify the {cmd:saving()}
option.  With n objects, the pairwise dataset has n(n-1)/2 observations.
In addition to the three requested variables, {cmd:predict} produces
variables {it:id}{cmd:1} and {it:id}{cmd:2}, which identify pairs of objects.
With {cmd:mds}, {it:id} is the name of the identification variable ({cmd:id()}
option) and with {cmd:mdsmat} it is "{cmd:Category}".

{phang}{cmd:saving(}{it:{help filename}}[{cmd:, replace}]{cmd:)}
is required after {cmd:mdsmat}, after {cmd:mds} if {opt pairwise()} is selected,
and after {cmd:mdslong} if {opt config} is selected.  {opt saving()} indicates
that the generated variables are to be created in a new Stata dataset and
saved in the file named {it:filename}.  Unless {opt saving()} is specified,
the variables are generated in the current dataset.

{pmore}{opt replace}
indicates that {it:filename} specified in {cmd:saving()} may be overwritten.

{phang}{opt full}
creates predictions for all pairs of objects (j1,j2).  The default is to
generate predictions only for pairs (j1,j2) where j1>j2.  {opt full} may
be specified only with {opt pairwise()}.


{marker syntax_estat}{...}
{marker estat}{...}
{title:Syntax for estat}

{pstd}
List the coordinates of the approximating configuration

{p 8 14 2}
{cmd:estat} {cmdab:con:fig} [{cmd:,}
{opt max:length(#)} {opth for:mat(%fmt)}]


{pstd}
List the Pearson and Spearman correlations

{p 8 14 2}
{cmd:estat} {cmdab:cor:relations} [{cmd:,}
{opt max:length(#)} {opth for:mat(%fmt)} {opt notrans:form} {opt notot:al}]


{pstd}
List the pairwise statistics: disparities, distances, and residuals

{p 8 14 2}
{cmd:estat} {cmdab:pair:wise} [{cmd:,}
{opt max:length(#)} {opt notrans:form} {opt f:ull} {opt s:eparator}]


{pstd}
List the quantiles of the residuals

{p 8 14 2}
{cmd:estat} {cmdab:qua:ntiles} [{cmd:,}
{opt max:length(#)} {opth for:mat(%fmt)} {opt notot:al} {opt notrans:form}]


{pstd}
Display the Kruskal stress (loss) measure per point (only after classical MDS)

{p 8 14 2}
{cmd:estat} {cmdab:str:ess} [,
{opt max:length(#)} {opth for:mat(%fmt)} {opt notot:al} {opt notrans:form}]


{pstd}
Summarize the variables in MDS

{p 8 14 2}
{cmd:estat} {cmdab:su:mmarize} [{cmd:,} {opt lab:els}]


{synoptset 16 tabbed}{...}
{synopthdr}
{synoptline}
{synopt:{opt max:length(#)}}maximum number of characters for displaying object
	names; default is {cmd:12}{p_end}
{synopt:{opth for:mat(%fmt)}}display format{p_end}
{synopt:{opt notot:al}}suppress display of overall summary statistics{p_end}
{synopt:{opt notrans:form}}use dissimilarities instead of disparities{p_end}
{synopt:{opt f:ull}}display all pairs (j1,j2); default is (j1>j2) only{p_end}
{synopt:{opt s:eparator}}draw separating lines{p_end}
{synopt:{opt lab:els}}display variable labels{p_end}
{synoptline}
{p2colreset}{...}


INCLUDE help menu_estat


{marker options_estat}{...}
{title:Options for estat}


{phang}{opt maxlength(#)},
an option used with all but {cmd:estat summarize},
specifies the maximum number of characters of the object names to be
displayed; the default is {cmd:maxlength(12)}.

{phang}{opth format(%fmt)},
an option used with {cmd:estat config}, {cmd:estat correlations},
{cmd:estat quantiles}, and {cmd:estat stress}, specifies the display format;
the default differs between the subcommands.

{phang}{opt nototal},
an option used with {cmd:estat correlations}, {cmd:estat quantiles},
and {cmd:estat stress}, suppresses the overall summary statistics.

{phang}{opt notransform},
an option used with {cmd:estat correlations}, {cmd:estat pairwise},
{cmd:estat quantiles}, and {cmd:estat stress}, specifies that the
untransformed dissimilarities be used instead of the transformed
dissimilarities (disparities).

{phang}{opt full},
an option used with {cmd:estat pairwise},
displays a row for all pairs (j1,j2).  The default is to display rows only for
pairs where j1>j2.

{phang}{opt separator},
an option used with {cmd:estat pairwise},
draws separating lines between blocks of rows corresponding to changes in the
first of the pair of objects.

{phang}{opt labels},
an option used with {cmd:estat summarize},
displays variable labels.


{marker syntax_mdsconfig}{...}
{marker mdsconfig}{...}
{title:Syntax for mdsconfig}

{p 8 18 2}
{cmd:mdsconfig} [{cmd:,} {it:options}]

{synoptset 23 tabbed}{...}
{synopthdr:options}
{synoptline}
{syntab:Main}
{synopt:{opt dim:ensions(# #)}}two dimensions to be displayed; 
	{bind:default is {cmd:dimensions(2 1)}}{p_end}
{synopt:{opt xneg:ate}}negate data relative to the {it:x} axis{p_end}
{synopt:{opt yneg:ate}}negate data relative to the {it:y} axis{p_end}
{synopt:{opt auto:aspect}}adjust aspect ratio on the basis of the data;
	default aspect ratio is 1{p_end}
{synopt:{opt max:length(#)}}maximum number of characters used in marker
	labels{p_end}
{synopt:{it:{help cline_options}}}affect rendition of the lines
	connecting points{p_end}
{synopt:{it:{help marker_options}}}change look of markers (color, 
	size, etc.){p_end}
{synopt:{it:{help marker_label_options}}}change look or position 
	of marker labels{p_end}

{syntab:Y axis, X axis, Titles, Legend, Overall}
{synopt:{it:twoway_options}}any options other than {opt by()}
        documented in {manhelpi twoway_options G-3}{p_end}
{synoptline}
{p2colreset}{...}


{title:Menu}

{phang}
{bf:Statistics > Multivariate analysis > Multidimensional scaling (MDS) >}
       {bf:Postestimation > Approximating configuration plot}


{marker options_mdsconfig}{...}
{title:Options for mdsconfig}

{dlgtab:Main}

{phang}{opt dimensions(# #)}
identifies the dimensions to be displayed.  For instance,
{bind:{cmd:dimensions(3 2)}} plots
the third dimension (vertically) versus the second dimension (horizontally).
The dimension number cannot exceed the number of extracted dimensions.  The
default is {cmd:dimensions(2 1)}.

{phang}{opt xnegate}
specifies that the data be negated relative to the {it:x} axis.

{phang}{opt ynegate}
specifies that the data be negated relative to the {it:y} axis.

{marker autoaspect}{...}
{phang}{opt autoaspect}
specifies that the aspect ratio be automatically adjusted based on the
range of the data to be plotted.  This option can make some plots more
readable.  By default, {cmd:mdsconfig} uses an aspect ratio of one, producing
a square plot.  Some plots will have little variation in the {it:y}-axis
direction, and use of the {opt autoaspect} option will better fill the
available graph space while preserving the equivalence of distance in the
{it:x} and {it:y} axes.

{pmore}
As an alternative to {opt autoaspect}, the {it:twoway_option}
{helpb aspect_option:aspectratio()} can be used to override the default
aspect ratio. {cmd:mdsconfig} accepts the {cmd:aspectratio()} option as
a suggestion only and will override it when necessary to produce plots
with balanced axes; that is, distance on the {it:x} axis equals distance
on the {it:y} axis.

{pmore}
{it:{help twoway_options:twoway_options}}, such as {cmd:xlabel()},
{cmd:xscale()}, {cmd:ylabel()}, and {cmd:yscale()}, should be used with
caution.  These {it:{help axis_options}} are accepted but may have unintended
side effects on the aspect ratio.

{phang}{opt maxlength(#)}
specifies the maximum number of characters for object names used to mark the
points; the default is {cmd:maxlength(12)}.

{phang}
{it:cline_options}
affect the rendition of the lines connecting the plotted points; see
{manhelpi cline_options G-3}.  If you are drawing connected lines, 
the appearance of the plot depends on the sort order of the data.

{phang}
{it:marker_options}
affect the rendition of the markers drawn at the plotted points, including
their shape, size, color, and outline; see {manhelpi marker_options G-3}.

{phang}
{it:marker_label_options}
specify if and how the markers are to be labeled; see
{manhelpi marker_label_options G-3}.

{dlgtab:Y axis, X axis, Titles, Legend, Overall}

{phang}{it:twoway_options}
are any of the options documented in {manhelpi twoway_options G-3}, excluding
{cmd:by()}.  These include options for titling the graph (see
{manhelpi title_options G-3}) and for saving the graph to disk (see
{manhelpi saving_option G-3}).
See {helpb mds postestimation##autoaspect:autoaspect} above for a warning
against using options such as {cmd:xlabel()}, {cmd:xscale()},
{cmd:ylabel()}, and {cmd:yscale()}.


{marker syntax_mdsshepard}{...}
{marker mdsshepard}{...}
{title:Syntax for mdsshepard}

{p 8 19 2}
{cmd:mdsshepard} [{cmd:,} {it:options}]

{synoptset 21 tabbed}{...}
{synopthdr:options}
{synoptline}
{syntab:Main}
{synopt:{opt notrans:form}}use dissimilarities instead of disparities{p_end}
{synopt:{opt auto:aspect}}adjust aspect ratio on the basis of the data;
	default aspect ratio is 1{p_end}
{synopt:{opt sep:arate}}draw separate Shepard diagrams for each object{p_end}
{synopt:{it:{help marker_options}}}change look of markers (color, 
	size, etc.){p_end}

{syntab:Y axis, X axis, Titles, Legend, Overall}
{synopt:{it:twoway_options}}any options other than {opt by()}
        documented in {manhelpi twoway_options G-3}{p_end}
{synopt:{opth byo:pts(by_option)}}affect the
        rendition of combined graphs; {opt separate} only{p_end}
{synoptline}
{p2colreset}{...}


{title:Menu}

{phang}
{bf:Statistics > Multivariate analysis > Multidimensional scaling (MDS) >}
    {bf:Postestimation > Shepard diagram}


{marker options_mdsshepard}{...}
{title:Options for mdsshepard}

{dlgtab:Main}

{phang}{opt notransform}
uses dissimilarities instead of disparities, that is, suppresses the
transformation of the dissimilarities.

{phang}{opt autoaspect}
specifies that the aspect ratio is to be automatically adjusted based on the
range of the data to be plotted.  By default, {cmd:mdsshepard} uses an aspect
ratio of one, producing a square plot.

{pmore}
See the description of the 
{helpb mds postestimation##autoaspect:autoaspect} option of {cmd:mdsconfig} for
more details.

{phang}{opt separate}
displays separate plots of each value of the id variable.  This may
be time consuming if the number of distinct id values is not small.

{phang}
{it:marker_options}
affect the rendition of the markers drawn at the plotted points, including
their shape, size, color, and outline; see {manhelpi marker_options G-3}.

{dlgtab:Y axis, X axis, Titles, Legend, Overall}

{phang}{it:twoway_options}
are any of the options documented in {manhelpi twoway_options G-3}, excluding
{cmd:by()}. These include options for titling the graph (see
{manhelpi title_options G-3}) and for saving the graph to disk (see
{manhelpi saving_option G-3}).
See the {helpb mds postestimation##autoaspect:autoaspect} option of
{cmd:mdsconfig} for a warning against using options such as {cmd:xlabel()},
{cmd:xscale()}, {cmd:ylabel()}, and {cmd:yscale()}.

{phang}
{opt byopts(by_option)}
is documented in {manhelpi by_option G-3}.  This option affect the appearance
of the combined graph and only allowed with the {opt separate} option.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. sysuse auto}

{pstd}Perform classical multidimensional scaling, standardizing variables
{p_end}
{phang2}{cmd:. mds price-gear, id(make) dim(2) std}

{pstd}List coordinates of the approximating configuration{p_end}
{phang2}{cmd:. estat config}

{pstd}List correlations between disparities and Euclidean distances{p_end}
{phang2}{cmd:. estat correlations}

{pstd}List quantiles of transformed residuals{p_end}
{phang2}{cmd:. estat quantiles}

{pstd}List pairwise disparities, distances, and residuals{p_end}
{phang2}{cmd:. estat pairwise}

{pstd}Display Kruskal stress measure for each object{p_end}
{phang2}{cmd:. estat stress}

{pstd}Display summary of variables{p_end}
{phang2}{cmd:. estat summarize}

{pstd}Plot the approximating configuration{p_end}
{phang2}{cmd:. mdsconfig}

{pstd}Plot Shepard diagram{p_end}
{phang2}{cmd:. mdsshepard}
 
{pstd}Generate variables containing the approximating configuration{p_end}
{phang2}{cmd:. predict d1 d2, config}

{pstd}Save to another dataset variables containing pairwise disparities,
dissimilarities, and distances{p_end}
{phang2}{cmd:. predict disp diss dist, pairwise(disp diss dist) saving(gd3)}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:estat correlations} saves the following in {cmd:r()}:

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Matrices}{p_end}
{synopt:{cmd:r(R)}}statistics per object; columns with # of obs., Pearson corr., and Spearman corr.{p_end}
{synopt:{cmd:r(T)}}overall statistics; # of obs., Pearson corr., and Spearman corr.{p_end}

{pstd}
{cmd:estat quantiles} saves the following in {cmd:r()}:

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Macros}{p_end}
{synopt:{cmd:r(dtype)}}{cmd:adjusted} or {cmd:raw}; dissimilarity
transformation{p_end}

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Matrices}{p_end}
{synopt:{cmd:r(Q)}}statistics per object; columns with # of obs., min., p25,
p50, p75, and max.{p_end}
{synopt:{cmd:r(T)}}overall statistics; # of obs., min., p25, p50, p75, and
max.{p_end}

{pstd}
{cmd:estat stress} saves the following in {cmd:r()}:

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Macros}{p_end}
{synopt:{cmd:r(dtype)}}{cmd:adjusted} or {cmd:raw}; dissimilarity
transformation{p_end}

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Matrices}{p_end}
{synopt:{cmd:r(S)}}Kruskal's stress/loss measure per object{p_end}
{synopt:{cmd:r(T)}}1 x 1 matrix with the overall Kruskal stress/loss measure
{p_end}
{p2colreset}{...}
