{smcl}
{* *! version 1.3.11  10jun2011}{...}
{viewerdialog predict "dialog ca_p"}{...}
{viewerdialog estat "dialog ca_estat"}{...}
{viewerdialog cabiplot "dialog cabiplot"}{...}
{viewerdialog caprojection "dialog caprojection"}{...}
{viewerdialog screeplot "dialog screeplot"}{...}
{vieweralsosee "[MV] ca postestimation" "mansection MV capostestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[MV] ca" "help ca"}{...}
{vieweralsosee "[MV] screeplot" "help screeplot"}{...}
{viewerjumpto "Description" "ca postestimation##description"}{...}
{viewerjumpto "Special-interest postestimation commands" "ca postestimation##special"}{...}
{viewerjumpto "" "--"}{...}
{viewerjumpto "Syntax for predict" "ca postestimation##syntax_predict"}{...}
{viewerjumpto "Options for predict" "ca postestimation##options_predict"}{...}
{viewerjumpto "" "--"}{...}
{viewerjumpto "Syntax for estat" "ca postestimation##syntax_estat"}{...}
{viewerjumpto "Options for estat" "ca postestimation##options_estat"}{...}
{viewerjumpto "" "--"}{...}
{viewerjumpto "Syntax for cabiplot" "ca postestimation##syntax_cabiplot"}{...}
{viewerjumpto "Options for cabiplot" "ca postestimation##options_cabiplot"}{...}
{viewerjumpto "" "--"}{...}
{viewerjumpto "Syntax for caprojection" "ca postestimation##syntax_caprojection"}{...}
{viewerjumpto "Options for caprojection" "ca postestimation##options_caprojection"}{...}
{viewerjumpto "" "--"}{...}
{viewerjumpto "Examples" "ca postestimation##examples"}{...}
{viewerjumpto "Saved results" "ca postestimation##saved_results"}{...}
{title:Title}

{p2colset 5 31 33 2}{...}
{p2col:{manlink MV ca postestimation} {hline 2}}Postestimation tools for
{cmd:ca} and {cmd:camat}
{p_end}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
The following postestimation commands are of special interest after {cmd:ca}
and {cmd:camat}:

{synoptset 21 tabbed}{...}
{p2coldent:Command}Description{p_end}
{synoptline}
{synopt:{helpb ca postestimation##cabiplot:cabiplot}}biplot of row and column
	points{p_end}
{synopt:{helpb ca postestimation##caprojection:caprojection}}CA dimension
	projection plot{p_end}
{synopt:{helpb ca postestimation##estat:estat coordinates}}display row and
	column coordinates{p_end}
{synopt:{helpb ca postestimation##estat:estat distances}}display chi-squared
	distances between row and column profiles{p_end}
{synopt:{helpb ca postestimation##estat:estat inertia}}display inertia
	contributions of the individual cells{p_end}
{synopt:{helpb ca postestimation##estat:estat loadings}}display correlations 
        of profiles and axes{p_end}
{synopt:{helpb ca postestimation##estat:estat profiles}}display row and column
	profiles{p_end}
{p2coldent:+ {helpb ca postestimation##estat:estat summarize}}estimation sample
	summary{p_end}
{synopt:{helpb ca postestimation##estat:estat table}}display fitted
	correspondence table{p_end}
{synopt:{helpb screeplot}}plot singular values{p_end}
{synoptline}
{p 4 6 2}
+ {cmd:estat summarize} is not available after {cmd:camat}.

{pstd}
The following standard postestimation commands are also available:

{p2coldent:Command}Description{p_end}
{synoptline}
{p2coldent:* {helpb estimates}}cataloging estimation results{p_end}
{p2coldent:+ {helpb ca postestimation##predict:predict}}fitted values, row
	coordinates, or column coordinates{p_end}
{synoptline}
{p2colreset}{...}
{p 4 6 2}
* All {cmd:estimates} subcommands except {opt table} and {opt stats} are
available.
{p_end}
{p 4 6 2}
+ {cmd:predict} is not available after {cmd:camat}.


{marker special}{...}
{title:Special-interest postestimation commands}

{pstd}
{cmd:cabiplot}
produces a plot of the row points or column points, or a biplot of the row and
column points.  In this plot, the (Euclidean) distances between row (column)
points approximates the chi-squared distances between the associated row
(column) profiles if the CA is properly normalized.  Similarly, the
association between a row and column point is approximated by the inner
product of vectors from the origin to the respective points (see
{manhelp ca MV}).

{pstd}
{cmd:caprojection}
produces a line plot of the row and column coordinates.  The goal of this
graph is to show the ordering of row and column categories on each principal
dimension of the analysis.  Each principal dimension is represented by a
vertical line; markers are plotted on the lines where the row and column
categories project onto the dimensions.

{pstd}
{cmd:estat coordinates}
displays the row and column coordinates.

{pstd}
{cmd:estat distances}
displays the chi-squared distances between the row profiles and between the
column profiles.  Also, the chi-squared distances between the row and
column profiles to the respective centers (marginal distributions) are
displayed.  Optionally, the fitted profiles rather than the observed profiles
are used.

{pstd}
{cmd:estat inertia}
displays the inertia (chi2/N) contributions of the individual cells.

{pstd}
{cmd:estat loadings }
displays the correlations of the row and column profiles and the axes, 
comparable to the loadings of principal component analysis. 

{pstd}
{cmd:estat profiles}
displays the row and column profiles; the row (column) profile is the
conditional distribution of the row (column) given the column (row).  This is
equivalent to specifying the {cmd:row} and {cmd:column} options with the
{cmd:tabulate} command; see {manhelp tabulate_twoway R:tabulate twoway}.

{pstd}
{cmd:estat summarize}
displays summary information about the row and column variables over the
estimation sample.

{pstd}
{cmd:estat table}
displays the fitted correspondence table.  Optionally, the observed
"correspondence table" and the expected table under independence are
displayed.


{marker syntax_predict}{...}
{marker predict}{...}
{title:Syntax for predict}

{p 8 16 2}
{cmd:predict} {dtype} {newvar} {ifin} [{cmd:,} {it:statistic}]

{synoptset 15 tabbed}{...}
{synopthdr:statistic}
{synoptline}
{syntab:Main}
{synopt:{opt f:it}}fitted values; the default{p_end}
{synopt:{opt row:score(#)}}row score for dimension {it:#}{p_end}
{synopt:{opt col:score(#)}}column score for dimension {it:#}{p_end}
{synoptline}
{p2colreset}{...}
{p 4 6 2}
{cmd:predict} is not available after {cmd:camat}.


INCLUDE help menu_predict


{marker options_predict}{...}
{title:Options for predict}

{dlgtab:Main}

{phang}{opt fit}
specifies that fitted values for the correspondence analysis model be 
computed.  {opt fit} displays the fitted values p_{ij} according to the
correspondence analysis model.  {opt fit} is the default.

{phang}{opt rowscore(#)}
generates the row score for dimension {it:#}, that is, the appropriate elements
from the normalized row coordinates.

{phang}{opt colscore(#)}
generates the column score for dimension {it:#}, that is, the appropriate
elements from the normalized column coordinates.


{marker syntax_estat}{...}
{marker estat}{...}
{title:Syntax for estat}

{pstd}
Display row and column coordinates

{p 8 14 2}
{cmd:estat} {opt co:ordinates} [{cmd:,} {opt norow} {opt nocol:umn}
	{opth for:mat(%fmt)}]


{pstd}
Display chi-squared distances between row and column profiles

{p 8 14 2}
{cmd:estat} {opt di:stances} [{cmd:,} {opt norow} {opt nocol:umn}
	{opt ap:prox} {opth for:mat(%fmt)}]


{pstd}
Display inertia contributions of cells

{p 8 14 2}
{cmd:estat} {opt in:ertia} [{cmd:,} {opt to:tal} {opt nosc:ale}
	{opth for:mat(%fmt)}]


{pstd}
Display correlations of profiles and axes

{p 8 14 2}
{cmd:estat} {opt lo:adings} [{cmd:,} {opt norow} {opt nocol:umn}
	{opth for:mat(%fmt)}]


{pstd}
Display row and column profiles

{p 8 14 2}
{cmd:estat} {opt pr:ofiles} [{cmd:,} {opt norow} {opt nocol:umn}
	{opth for:mat(%fmt)}]


{pstd}
Display summary information

{p 8 14 2}
{cmd:estat} {opt su:mmarize} [{cmd:,} {opt lab:els} {opt nohea:der}
	{opt nowei:ghts}]


{pstd}
Display fitted correspondence table

{p 8 14 2}
{cmd:estat} {opt ta:ble} [{cmd:,}
	{opt fit} {opt obs} {opt in:dependence} {opt nosc:ale}
	{opth for:mat(%fmt)}]


{synoptset 16}{...}
{synopthdr}
{synoptline}
{synopt:{opt norow}}suppress display of row results{p_end}
{synopt:{opt nocol:umn}}suppress display of column results{p_end}
{synopt:{opth for:mat(%fmt)}}display format; default is
	{cmd:format(%9.4f)}{p_end}
{synopt:{opt ap:prox}}display distances between fitted (approximated)
	profiles{p_end}
{synopt:{opt to:tal}}add row and column margins{p_end}
{synopt:{opt nosc:ale}}display chi-squared
	contributions; default is inertias = chi2/N 
	(with {cmd:estat inertia}) {p_end}
{synopt:{opt lab:els}}display variable labels{p_end}
{synopt:{opt nohea:der}}suppress the header{p_end}
{synopt:{opt nowei:ghts}}ignore weights{p_end}
{synopt:{opt fit}}display fitted values from correspondence analysis model{p_end}
{synopt:{opt obs}}display correspondence table ("observed table"){p_end}
{synopt:{opt in:dependence}}display expected values under independence{p_end}
{synopt:{opt nosc:ale}}suppress scaling of entries
	to 1 (with {cmd:estat table}) {p_end}
{synoptline}
{p2colreset}{...}


INCLUDE help menu_estat


{marker options_estat}{...}
{title:Options for estat}

{phang}{opt norow},
an option used with {cmd:estat coordinates}, {cmd:estat distances}, and
{cmd:estat profiles}, suppresses the display of row results.

{phang}{opt nocolumn},
an option used with {cmd:estat coordinates}, {cmd:estat distances}, and
{cmd:estat profiles}, suppresses the display of column results.

{phang}{opth format(%fmt)},
an option used with many of the subcommands of {cmd:estat}, specifies the
display format for the matrix, for example, {cmd:format(%8.3f)}.  The default
is {cmd:format(%9.4f)}.

{phang}{opt approx},
an option used with {cmd:estat distances}, computes distances between the
fitted profiles.  The default is to compute distances between the observed
profiles.

{phang}{opt total},
an option used with {cmd:estat inertia}, adds row and column margins to the
table of inertia or chi-squared (chi-squared/N) contributions.

{phang}{opt noscale},
as an option used with {cmd:estat inertia}, displays chi-squared contributions
rather than inertia (= chi-squared/N) contributions.  (See below for the
description of {opt noscale} with {cmd:estat table}.)

{phang}{opt labels},
an option used with {cmd:estat summarize}, displays variable labels.

{phang}{opt noheader},
an option used with {cmd:estat summarize}, suppresses the header.

{phang}{opt noweights},
an option used with {cmd:estat summarize}, ignores the weights, if any.  The
default when weights are present is to perform a weighted {cmd:summarize} on
all variables except the weight variable itself.  An unweighted
{cmd:summarize} is performed on the weight variable.

{phang}{opt fit},
an option used with {cmd:estat table},
displays the fitted values for the correspondence analysis model.
{cmd:fit} is implied if {cmd:obs} and {cmd:independence} are not specified.

{phang}{opt obs},
an option used with {cmd:estat table}, displays the observed table with
nonnegative entries (the "correspondence table").

{phang}{opt independence},
an option used with {cmd:estat table}, displays the expected values p(ij)
assuming independence of the rows and columns, p(ij) = r(i) c(j), where r(i)
is the mass of row i and c(j) is the mass of column j.

{phang}{opt noscale},
as an option used with {cmd:estat table}, normalizes the displayed tables to
the sum of the original table entries.  The default is to scale the tables to
overall sum 1.  (See above for the description of {opt noscale} with
{cmd:estat inertia}.)


{marker syntax_cabiplot}{...}
{marker cabiplot}{...}
{title:Syntax for cabiplot}

{p 8 17 2}
{cmd:cabiplot} [{cmd:,} {it:options}]

{synoptset 26 tabbed}{...}
{synopthdr:options}
{synoptline}
{syntab:Main}
{synopt:{opt dim(# #)}}two dimensions to be displayed; 
	{bind:default {cmd:dim(2 1)}}{p_end}
{synopt:{opt norow}}suppress row coordinates{p_end}
{synopt:{opt nocol:umn}}suppress column coordinates{p_end}
{synopt:{opt xneg:ate}}negate the data relative to the {it:x} axis{p_end}
{synopt:{opt yneg:ate}}negate the data relative to the {it:y} axis{p_end}
{synopt:{opt max:length(#)}}maximum number of characters for labels;
	default is {cmd:maxlength(12)}{p_end}
{synopt:{opt or:igin}}display the origin on the plot{p_end}
{synopt:{opth or:iginlopts(line_options)}}affect rendition of origin
	axes{p_end}

{syntab:Rows}
{synopt:{opt row:opts(row_opts)}}affect rendition of rows{p_end}

{syntab:Columns}
{synopt:{opt col:opts(col_opts)}}affect rendition of columns{p_end}

{syntab:Y axis, X axis, Titles, Legend, Overall}
{synopt:{it:twoway_options}}any options other than {opt by()}
	documented in {manhelpi twoway_options G-3}{p_end}
{synoptline}
{p2colreset}{...}

{synoptset 26}{...}
{p2coldent:{it:row_opts} and {it:col_opts}}Descriptions{p_end}
{synoptline}
{synopt:{it:plot_options}}change look of markers
	(color, size, etc.) and look or position of marker labels{p_end}
{synopt:{opt sup:popts(plot_options)}}change look of supplementary markers
	and look or position of supplementary marker labels{p_end}
{synoptline}

{synopthdr:plot_options}
{synoptline}
{synopt:{it:{help marker_options}}}change look of markers
	(color, size, etc.){p_end}
{synopt:{it:{help marker_label_options}}}add marker labels; change
	look or position{p_end}
{synoptline}


{title:Menu}

{phang}
{bf:Statistics > Multivariate analysis > Correspondence analysis >}
     {bf:Postestimation after CA > Biplot of row and column points}


{marker options_cabiplot}{...}
{title:Options for cabiplot}

{dlgtab:Main}

{phang}{opt dim(# #)}
identifies the dimensions to be displayed.  For instance, {bind:{cmd:dim(3 2)}} plots
the third dimension (vertically) versus the second dimension (horizontally).
The dimension number cannot exceed the number of extracted dimensions.  The
default is {cmd:dim(2 1)}.

{phang}{opt norow} suppresses plotting of row points.

{phang}{opt nocolumn} suppresses plotting of column points.

{phang}{opt xnegate}
specifies that the {it:x}-axis values are to be negated (multiplied by -1).

{phang}{opt ynegate}
specifies that the {it:y}-axis values are to be negated (multiplied by -1).

{phang}{opt maxlength(#)}
specifies the maximum number of characters for row and column labels; 
the default is {cmd:maxlength(12)}.

{phang}{opt origin}
specifies that the origin be displayed on the plot.  This
is equivalent to adding the options 
{cmd:xline(0, lcolor(black) lwidth(vthin))}
{cmd:yline(0, lcolor(black) lwidth(vthin))} to the {cmd:cabiplot} command.

{phang}{opt originlopts(line_options)}
affects the rendition of the origin axes; see 
    {manhelpi line_options G-3}.

{dlgtab:Rows}

{phang}{opt rowopts(row_opts)}
affects the rendition of the rows.  The following {it:row_opts} are allowed:

{phang2}
{it:plot_options} affect the rendition of row markers, including their shape,
size, color, and outline (see {manhelpi marker_options G-3}) and specify if and
how the row markers are to be labeled (see
{manhelpi marker_label_options G-3}).

{phang2}
{opt suppopts(plot_options)}
affects supplementary markers and supplementary marker labels; see above for
description of {it:plot_options}.

{dlgtab:Columns}

{phang}{opt colopts(col_opts)}
affects the rendition of the columns.  The following {it:col_opts} are allowed:

{phang2}
{it:plot_options} affect the rendition of column markers, including their shape,
size, color, and outline (see {manhelpi marker_options G-3}) and specify if and
how the column markers are to be labeled (see 
{manhelpi marker_label_options G-3}).

{phang2}
{opt suppopts(plot_options)}
affects supplementary markers and supplementary marker labels; see above for
description of {it:plot_options}.

{dlgtab:Y axis, X axis, Titles, Legend, Overall}

{phang}{it:twoway_options}
are any of the options documented in {manhelpi twoway_options G-3} excluding
{cmd:by()}.  These include options for titling the graph (see
{manhelpi title_options G-3}) and saving the graph to disk (see
{manhelpi saving_option G-3}).

{pmore}
{cmd:cabiplot} automatically adjusts the aspect ratio on the basis of the
range of the data and ensures that the axes are balanced.  As an alternative,
the {it:twoway_option} {helpb aspect_option:aspectratio()} can be used to
override the default aspect ratio.  {cmd:cabiplot} accepts the
{cmd:aspectratio()} option as a suggestion only, and will override it when
necessary to produce plots with balanced axes; that is, distance on the {it:x}
axis equals distance on the {it:y} axis.

{pmore}
{it:{help twoway_options}} such as {cmd:xlabel()},
{cmd:xscale()}, {cmd:ylabel()}, and {cmd:yscale()} should be used with
caution.  These {it:{help axis_options}} are accepted but may have unintended
side effects on the aspect ratio.


{marker syntax_caprojection}{...}
{marker caprojection}{...}
{title:Syntax for caprojection}

{p 8 19 2}
{cmd:caprojection} [{cmd:,} {it:options}]

{synoptset 24 tabbed}{...}
{synopthdr:options}
{synoptline}
{syntab:Main}
{synopt:{opth dim(numlist)}}dimensions to be displayed; default is all{p_end}
{synopt:{opt norow}}suppress row coordinates{p_end}
{synopt:{opt nocol:umn}}suppress column coordinates{p_end}
{synopt:{opt alt:ernate}}alternate labels{p_end}
{synopt:{opt max:length(#)}}maximum number of characters displayed for labels;
	default is {cmd:maxlength(12)}{p_end}
{synopt:{it:{help graph_combine:combine_options}}}affect the rendition of
	the combined column and row graphs{p_end}	
{syntab:Rows}
{synopt:{opt row:opts(row_opts)}}affect rendition of rows{p_end}

{syntab:Columns}
{synopt:{opt col:opts(col_opts)}}affect rendition of columns{p_end}

{syntab:Y axis, X axis, Titles, Legend, Overall}
{synopt:{it:twoway_options}}any options other than {opt by()}
	documented in {manhelpi twoway_options G-3}{p_end}
{synoptline}
{p2colreset}{...}

{synoptset 24}{...}
{p2coldent:{it:row_opts} and {it:col_opts}}Descriptions{p_end}
{synoptline}
{synopt:{it:plot_options}}change look of markers
	(color, size, etc.) and look or position of marker labels{p_end}
{synopt:{opt sup:popts(plot_options)}}change look of supplementary markers
	and look or position of supplementary marker labels{p_end}
{synoptline}

{synopthdr:plot_options}
{synoptline}
{synopt:{it:{help marker_options}}}change look of markers
	(color, size, etc.){p_end}
{synopt:{it:{help marker_label_options}}}add marker labels; change
	look or position{p_end}
{synoptline}
{p2colreset}{...}


{title:Menu}

{phang}
{bf:Statistics > Multivariate analysis > Correspondence analysis >}
       {bf:Postestimation after CA > Dimension projection plot}


{marker options_caprojection}{...}
{title:Options for caprojection}

{dlgtab:Main}

{phang}{opth dim(numlist)}
identifies the dimensions to be displayed.  By default, all dimensions are
displayed.

{phang}{opt norow} suppresses plotting of rows.

{phang}{opt nocolumn} suppresses plotting of columns.

{phang}{opt alternate}
causes adjacent labels to alternate sides.

{phang}{opt maxlength(#)}
specifies the maximum number of characters for row and column labels; 
the default is {cmd:maxlength(12)}.

{phang}{it:combine_options}
affect the rendition of the combined plot; see
{manhelp graph_combine G-2: graph combine}.
{it:combine_options} may not be specified with either 
{cmd:norow} or {cmd:nocolumn}.

{dlgtab:Rows}

{phang}{opt rowopts(row_opts)}
affects the rendition of the rows.  The following {it:row_opts} are allowed:

{phang2}
{it:plot_options} affect the rendition of row markers, including their shape,
size, color, and outline (see {manhelp marker_options G-3}) and specify if and
how the row markers are to be labeled (see {manhelp marker_label_options G-3}).

{phang2}
{opt suppopts(plot_options)}
affects supplementary markers and supplementary marker labels; see above for
description of {it:plot_options}.

{dlgtab:Columns}

{phang}{opt colopts(col_opts)}
affects the rendition of the columns.  The following {it:col_opts} are allowed:

{phang2}
{it:plot_options} affect the rendition of column markers, including their shape,
size, color, and outline (see {manhelpi marker_options G-3}) and specify if and
how the column markers are to be labeled (see 
{manhelpi marker_label_options G-3}).

{phang2}
{opt suppopts(plot_options)}
affects supplementary markers and supplementary marker labels; see above for
description of {it:plot_options}.

{dlgtab:Y axis, X axis, Titles, Legend, Overall}

{phang}{it:twoway_options}
are any of the options documented in {manhelpi twoway_options G-3} excluding
{cmd:by()}.   These include options for titling the graph (see
{manhelpi title_options G-3}) and for saving the graph to disk (see
{manhelpi saving_option G-3}).


{marker examples}{...}
{title:Examples}

    Setup
        {cmd:. webuse ca_smoking}

    Estimate CA
        {cmd:. ca rank smoking}

    Postestimation statistics
        {cmd:. estat distances}
        {cmd:. estat distances, fit}
        {cmd:. estat inertia}
        {cmd:. estat inertia, total noscale}
        {cmd:. estat profiles, nocolumn}
        {cmd:. estat table, fit obs}

    Biplots
        {cmd:. cabiplot}
        {cmd:. cabiplot, nocolumn}

    Dimension projection plot
        {cmd:. caprojection, dim(1/2)}

    Predict variables
        {cmd:. predict fitted, fit}
        {cmd:. predict pers_score, rowscore(1)}
        {cmd:. predict smok_score, colscore(1)}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:estat distances} saves the following in {cmd:r()}:

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Matrices}{p_end}
{synopt:{cmd:r(Dcolumns)}}chi-squared distances between the columns and
	between the columns and the column center{p_end}
{synopt:{cmd:r(Drows)}}chi-squared distances between the rows and between the
rows and the row center{p_end}

{pstd}
{cmd:estat inertia} saves the following in {cmd:r()}:

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Matrices}{p_end}
{synopt:{cmd:r(Q)}}matrix of (squared) inertia (or chi-squared)
	contributions{p_end}

{pstd}
{cmd:estat loadings} saves the following in {cmd:r()}:

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Matrices}{p_end}
{synopt:{cmd:r(LC)}}column loadings{p_end}
{synopt:{cmd:r(LR)}}row loadings{p_end}

{pstd}
{cmd:estat profiles} saves the following in {cmd:r()}:

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Matrices}{p_end}
{synopt:{cmd:r(Pcolumns)}}column profiles (columns normalized to 1){p_end}
{synopt:{cmd:r(Prows)}}row profiles (rows normalized to 1){p_end}

{pstd}
{cmd:estat table} saves the following in {cmd:r()}:

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Matrices}{p_end}
{synopt:{cmd:r(Fit)}}fitted (reconstructed) values{p_end}
{synopt:{cmd:r(Fit0)}}fitted (reconstructed) values, assuming independence of
	row and column variables{p_end}
{synopt:{cmd:r(Obs)}}correspondence table{p_end}
{p2colreset}{...}
