{smcl}
{* *! version 1.1.10  10jun2011}{...}
{viewerdialog predict "dialog mca_p"}{...}
{viewerdialog estat "dialog mca_estat"}{...}
{viewerdialog mcaplot "dialog mcaplot"}{...}
{viewerdialog mcaprojection "dialog mcaprojection"}{...}
{viewerdialog screeplot "dialog screeplot"}{...}
{vieweralsosee "[MV] mca postestimation" "mansection MV mcapostestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[MV] mca" "help mca"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[MV] ca" "help ca"}{...}
{vieweralsosee "[MV] ca postestimation" "help ca_postestimation"}{...}
{viewerjumpto "Description" "mca postestimation##description"}{...}
{viewerjumpto "Special-interest postestimation commands" "mca postestimation##special"}{...}
{viewerjumpto "" "--"}{...}
{viewerjumpto "Syntax for predict" "mca postestimation##syntax_predict"}{...}
{viewerjumpto "Options for predict" "mca postestimation##options_predict"}{...}
{viewerjumpto "" "--"}{...}
{viewerjumpto "Syntax for estat coordinates" "mca postestimation##syntax_estat_coordinates"}{...}
{viewerjumpto "Options for estat coordinates" "mca postestimation##options_estat_coordinates"}{...}
{viewerjumpto "Syntax for estat subinertia" "mca postestimation##syntax_estat_subinertia"}{...}
{viewerjumpto "Syntax for estat summarize" "mca postestimation##syntax_estat_summarize"}{...}
{viewerjumpto "Options for estat summarize" "mca postestimation##options_estat_summarize"}{...}
{viewerjumpto "" "--"}{...}
{viewerjumpto "Syntax for mcaplot" "mca postestimation##syntax_mcaplot"}{...}
{viewerjumpto "Options for mcaplot" "mca postestimation##options_mcaplot"}{...}
{viewerjumpto "Syntax for mcaprojection" "mca postestimation##syntax_mcaprojection"}{...}
{viewerjumpto "Options for mcaprojection" "mca postestimation##options_mcaprojection"}{...}
{viewerjumpto "" "--"}{...}
{viewerjumpto "Examples" "mca postestimation##examples"}{...}
{viewerjumpto "Saved results" "mca postestimation##saved_results"}{...}
{title:Title}

{p 4 32 2}
{manlink MV mca postestimation} {hline 2} Postestimation tools for {cmd:mca}


{marker description}{...}
{title:Description}

{pstd}
The following postestimation commands are of special interest after {cmd:mca}:

{synoptset 21}{...}
{p2coldent:Command}Description{p_end}
{synoptline}
{synopt:{helpb mca postestimation##mcaplot:mcaplot}}plot of category coordinates{p_end}
{synopt:{helpb mca postestimation##mcaprojection:mcaprojection}}MCA dimension projection plot{p_end}
{synopt:{helpb mca postestimation##estatcoo:estat coordinates}}display of category coordinates{p_end}
{synopt:{helpb mca postestimation##estatsub:estat subinertia}}matrix of inertias of the active variables (after JCA only){p_end}
{synopt:{helpb mca postestimation##estatsum:estat summarize}}estimation sample summary{p_end}
{synopt:{helpb screeplot}}plot principal inertias (eigenvalues){p_end}
{synoptline}
{p 4 6 2}


{pstd}
The following standard postestimation commands are also available:

{synoptset 21 tabbed}{...}
{p2coldent:Command}Description{p_end}
{synoptline}
{p2coldent:* {helpb estimates}}cataloging estimation results{p_end}
{synopt:{helpb mca postestimation##predict:predict}}row and category coordinates{p_end}
{synoptline}
{p2colreset}{...}
{p 4 6 2}
* All {cmd:estimates} subcommands except {opt table} and {opt stats} are
available.
{p_end}


{marker special}{...}
{title:Special-interest postestimation commands}

{pstd}
{cmd:mcaplot} produces a scatterplot of category points of the MCA variables
in two dimensions.

{pstd}
{cmd:mcaprojection} produces a projection plot of the coordinates of the
categories of the MCA variables.

{pstd}
{cmd:estat coordinates}
displays the category coordinates, optionally with column statistics.

{pstd}
{cmd:estat subinertia}
displays the matrix of inertias of the active variables (after JCA only).

{pstd}
{cmd:estat summarize}
displays summary information of MCA variables over the estimation sample.


{marker syntax_predict}{...}
{marker predict}{...}
{title:Syntax for predict}

{p 8 16 2}
{cmd:predict} {dtype} {it:{help newvar}} {ifin} [{cmd:,} {it:statistic} {opt norm:alize(norm)} {opt dim:ensions(#)}]

{p 8 16 2}
{cmd:predict} {dtype} {{it:stub*}|{it:{help varlist:newvarlist}}} {ifin} [{cmd:,}
{it:statistic} {opt norm:alize(norm)} {opth dim:ensions(numlist)}]

{synoptset 22 tabbed}{...}
{synopthdr:statistic}
{synoptline}
{syntab:Main}
{synopt:{opt row:scores}}row scores (coordinates), the default{p_end}
{synopt:{opth sc:ore(varname)}}scores (coordinates) for MCA variable
{it:varname}{p_end}
{synoptline}
{p2colreset}{...}

{synoptset 22}{...}
{synopthdr:norm}
{synoptline}
{synopt:{opt st:andard}}use standard normalization{p_end}
{synopt:{opt p:rincipal}}use principal normalization{p_end}
{synoptline}
{p2colreset}{...}


INCLUDE help menu_predict


{marker options_predict}{...}
{title:Options for predict}

{dlgtab:Main}

{phang}{opt rowscores}
specifies that row scores (row coordinates) be computed.  The row scores
returned are based on the indicator matrix approach to multiple
correspondence analysis, even if another method was specified in the
original {cmd:mca} estimation.  The sample for which row scores are computed
may exceed the estimation sample; for example, it may include supplementary
rows (variables).  {cmd:score()} and {cmd:rowscores} are mutually exclusive.
{cmd:rowscores} is the default.

{phang}{opth score(varname)}
specifies the name of a variable from the preceding MCA for which scores
should be computed.  The variable may be a regular categorical variable,
a crossed variable, or a supplementary variable.
{cmd:score()} and {cmd:rowscores} are mutually exclusive.

{dlgtab:Options}

{phang}{opt normalize(norm)}
specifies the normalization of the scores (coordinates).
{cmd:normalize(}{cmdab:s:tandard}{cmd:)}
returns coordinates in standard normalization.
{cmd:normalize(}{cmdab:p:rincipal}{cmd:)}
returns principal scores.  The default is
the normalization method specified with {cmd:mca} during estimation,
or {cmd:normalize(standard)} if no method was specified.

{phang}{opt dimensions(#)} or {opth dimensions(numlist)}
specifies the dimensions for which scores (coordinates) are computed.
The number of dimensions specified should equal the number of variables
in {it:{help newvarlist}}.  If {cmd:dimensions()} is not specified, scores for
dimensions 1,...,{it:k} are returned, where {it:k} is the number of variables
in {it:newvarlist}.  The number of variables in {it:newvarlist} should not
exceed the number of dimensions extracted during estimation.


{marker syntax_estat_coordinates}{...}
{marker estatcoo}{...}
{title:Syntax for estat coordinates}

{p 8 14 2}
{cmd:estat} {opt co:ordinates} [{varlist}] [{cmd:,}
{opt norm:alize(norm)} {opt st:ats} {opth for:mat(%fmt)}]

{pstd}
Note: variables in {it:varlist} must be from the preceding
{cmd:mca} and may refer to either a regular categorical variable or
a crossed variable.  The variables in {it:varlist} may also be chosen
from the supplementary variables.

{synoptset 22}{...}
{synopthdr}
{synoptline}
{synopt:{cmdab:norm:alize(}{cmdab:s:tandard)}}standard coordinates{p_end}
{synopt:{cmdab:norm:alize(}{cmdab:p:rincipal)}}principal coordinates{p_end}
{synopt:{opt st:ats}}include mass, distance, and inertia{p_end}
{synopt:{opth for:mat(%fmt)}}display format; default is {cmd:format(%9.4f)}{p_end}
{synoptline}
{p2colreset}{...}


{title:Menu}

{phang}
{bf:Statistics > Postestimation > Reports and statistics}


{marker options_estat_coordinates}{...}
{title:Options for estat coordinates}

{phang}{opt normalize(norm)}
specifies the normalization of the scores (coordinates).
{cmd:normalize(standard)} returns coordinates in standard
normalization.  {cmd:normalize(principal)} returns principal scores.
The default is the normalization method specified with {cmd:mca} during
estimation, or {cmd:normalize(standard)} if no method was specified.

{phang}{opt stats}
includes the column mass, the distance of the columns to the centroid, and the
column inertias in the table.

{phang}{opth format(%fmt)}
specifies the display format for the matrix, for example, {cmd:format(%8.3f)}.
The default is {cmd:format(%9.4f)}.


{marker syntax_estat_subinertia}{...}
{marker estatsub}{...}
{title:Syntax for estat subinertia}

{p 8 14 2}
{cmd:estat} {opt sub:inertia}


{title:Menu}

{phang}
{bf:Statistics > Postestimation > Reports and statistics}


{marker syntax_estat_summarize}{...}
{marker estatsum}{...}
{title:Syntax for estat summarize}

{p 8 14 2}
{cmd:estat} {opt su:mmarize} [{cmd:,} {opt c:rossed}
{opt lab:els} {opt nohea:der} {opt nowei:ghts} ]

{synoptset 22 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:Main}
{synopt:{opt c:rossed}}summarize crossed and uncrossed variables as used{p_end}
{synopt:{opt lab:els}}display variable labels{p_end}
{synopt:{opt nohea:der}}suppress the header{p_end}
{synopt:{opt nowei:ghts}}ignore weights{p_end}
{synoptline}
{p2colreset}{...}


{title:Menu}

{phang}
{bf:Statistics > Postestimation > Reports and statistics}


{marker options_estat_summarize}{...}
{title:Options for estat summarize}

{dlgtab:Main}

{phang}{opt crossed}
specifies summarizing the crossed variables if crossed variables are used in
the MCA, rather than the crossing variables from which they are formed.  The
default is to summarize the crossing variables and single categorical variables
used in the MCA.

{phang}{opt labels}
displays variable labels.

{phang}{opt noheader}
suppresses the header.

{phang}{opt noweights}
ignores the weights, if any.  The default when weights are present is to
perform a weighted summarize on all variables except the weight variable
itself.  An unweighted summarize is performed on the weight variable.


{marker syntax_mcaplot}{...}
{marker mcaplot}{...}
{title:Syntax for mcaplot}

{p 8 17 2}
{cmd:mcaplot} [{it:speclist}]  [{cmd:,} 
    {help mca postestimation##options:{it:options}}]

    where

{p 8 17 2}
{it:speclist} = {it:spec} [{it:spec} ...]

    and

{p 8 17 2}
{it:spec} = {varlist} | {cmd:(}{varname} [{cmd:,} 
   {help mca postestimation##plot_options:{it:plot_options}}]{cmd:)}

{p 4 4 2}
and variables in {it:varlist} or {it:varname} must be from the preceding
{cmd:mca} and may refer to either a regular categorical variable or 
a crossed variable.  The variables may also be supplementary.

{marker options}{...}
{synoptset 26 tabbed}{...}
{synopthdr:options}
{synoptline}
{syntab:Options}
{synopt:{it:{help graph_combine:combine_options}}}affect the rendition of
	the combined graphs{p_end}
{synopt:{opt over:lay}}overlay the plots of the variables; default is to produce separate plots{p_end}
{synopt:{opt dim:ensions(#_1 #_2)}}display dimensions {it:#_1} and {it:#_2}; {bind:default is {cmd:dimension(2 1)}}{p_end}
{synopt:{cmdab:norm:alize(}{cmdab:s:tandard)}}display standard coordinates{p_end}
{synopt:{cmdab:norm:alize(}{cmdab:p:rincipal)}}display principal coordinates{p_end}
{synopt:{opt max:length(#)}}use {it:#} as maximum number of characters for labels; default is {cmd:maxlength(12)}{p_end}
{synopt:{opt xneg:ate}}negate the coordinates relative to the {it:x} axis{p_end}
{synopt:{opt yneg:ate}}negate the coordinates relative to the {it:y} axis{p_end}
{synopt:{opt or:igin}}mark the origin and draw origin axes{p_end}
{synopt:{opth or:iginlopts(line_options)}}affect the rendition of the origin axes{p_end}

{syntab:Y axis, X axis, Titles, Legend, Overall}
{synopt:{it:twoway_options}}any options other than {opt by()} documented in 
   {manhelpi twoway_options G-3}{p_end}
{synoptline}
{p2colreset}{...}

{marker plot_options}{...}
{synoptset 26}{...}
{synopthdr:plot_options}
{synoptline}
{synopt:{it:{help marker_options}}}change look of markers (color, size, etc.){p_end}
{synopt:{it:{help marker_label_options}}}add marker labels; change look or position{p_end}
{synopt:{it:{help twoway_options}}}titles, legends, axes, added lines and
     text, regions, etc.{p_end}
{synoptline}


{title:Menu}

{phang}
{bf:Statistics > Multivariate analysis > Correspondence analysis >}
     {bf:Postestimation after MCA or JCA > Plot of category coordinates}


{marker options_mcaplot}{...}
{title:Options for mcaplot}

{dlgtab:Plots}

{phang}
{it:plot_options} affect the rendition of markers, including their shape,
size, color, and outline (see {manhelpi marker_options G-3}) and specify
if and how the markers are to be labeled
(see {manhelpi marker_label_options G-3}).  These
options may be specified for each variable.  If the {cmd:overlay} option
is not specified, then for each variable you may also specify many of the
{it:twoway_options} excluding {cmd:by()}, {cmd:name()}, and
{cmd:aspectratio()}; see {manhelpi twoway_options G-3}.  See 
{it:{help mca postestimation##twoway_options:twoway_options}} below for a
warning against using options such as {cmd:xlabel()}, {cmd:xscale()},
{cmd:ylabel()}, and {cmd:yscale()}.

{dlgtab:Options}

{phang}{it:combine_options}
affect the rendition of the combined plot; see
{manhelp graph_combine G-2:graph combine}.  {it:combine_options} may not be
specified with {cmd:overlay}.

{phang}{cmd:overlay}
overlays the biplot graphs for the variables.  The default is to produce
a combined graph of the biplot graphs.

{phang}{opt dimension(#_1 #_2)}
identifies the dimensions to be displayed.  For instance,
{bind:{cmd:dimension(3 2)}} plots the third dimension (vertically) versus the
second dimension (horizontally).  The dimension number cannot exceed the
number of extracted dimensions.  The default is {cmd:dimension(2 1)}.

{phang}{opt normalize(norm)}
specifies the normalization of the coordinates.  {cmd:normalize(standard)}
returns coordinates in standard normalization.  {cmd:normalize(principal)}
returns principal coordinates.  The default is the normalization method
specified with {cmd:mca} during estimation, or {cmd:normalize(standard)}
if no method was specified.

{phang}{opt maxlength(#)}
specifies the maximum number of characters for row and column labels;
the default is {cmd:maxlength(12)}.

{phang}{opt xnegate}
specifies that the {it:x}-axis coordinates be negated
(multiplied by -1).

{phang}{opt ynegate}
specifies that the {it:y}-axis coordinates be negated
(multiplied by -1).

{phang}{cmd:origin}
marks the origin and draws the origin axes.

{phang}{opt originlopts(line_options)}
affect the rendition of the origin axes.  See {manhelpi line_options G-3}.

{dlgtab:Y axis, X axis, Titles, Legend, Overall}

{marker twoway_options}{...}
{phang}{it:twoway_options}
are any of the options documented in {manhelpi twoway_options G-3} excluding
{cmd:by()}.

{pmore}
{cmd:mcaplot} automatically adjusts the aspect ratio on the basis of the range
of the data and ensures that the axes are balanced.  As an alternative, the
{it:twoway_option} {helpb aspect_option:aspectratio()} can be used to override
the default aspect ratio.  {cmd:mcaplot} accepts the {cmd:aspectratio()}
option as a suggestion only and will override it when necessary to produce
plots with balanced axes; that is, distance on the {it:x} axis equals distance
on the {it:y} axis.

{pmore}
{it:{help twoway_options}} such as {cmd:xlabel()},
{cmd:xscale()}, {cmd:ylabel()}, and {cmd:yscale()} should be used with
caution.  These {it:{help axis_options}} are accepted but may have unintended
side effects on the aspect ratio.


{marker syntax_mcaprojection}{...}
{marker mcaprojection}{...}
{title:Syntax for mcaprojection}

{p 8 19 2}
{cmd:mcaprojection} [{it:speclist}]  [{cmd:,} 
      {help mca postestimation##mcaproj_options:{it:options}}]

    where

{p 8 19 2}
{it:speclist} = {it:spec} [{it:spec} ...]

    and

{p 8 19 2}
{it:spec} = {varlist} | {cmd:(}{varname} [{cmd:,} 
    {help mca postestimation##mcaproj_plot_options:{it:plot_options}}]{cmd:)}

{p 4 4 2}
and variables in {it:varlist} or {it:varname} must be from the preceding
{cmd:mca} and may refer to either a regular categorical variable or 
a crossed variable.  The variables may also be supplementary.

{marker mcaproj_options}{...}
{synoptset 24 tabbed}{...}
{synopthdr:options}
{synoptline}
{syntab:Options}
{synopt:{opth dim:ensions(numlist)}}display {it:numlist} dimensions; default is all{p_end}
{synopt:{cmdab:norm:alize(}{cmdab:p:rincipal)}}scores (coordinates) should be in principal normalization{p_end}
{synopt:{cmdab:norm:alize(}{cmdab:s:tandard)}}scores (coordinates) should be in standard normalization{p_end}
{synopt:{opt alt:ernate}}alternate labels{p_end}
{synopt:{opt max:length(#)}}use {it:#} as maximum number of characters for
        labels; default is {cmd:maxlength(12)}{p_end}
{synopt:{it:{help graph_combine:combine_options}}}affect the rendition of
	the combined graphs{p_end}

{syntab:Y axis, X axis, Titles, Legend, Overall}
{synopt:{it:twoway_options}}any options other than {opt by()}
	documented in {manhelpi twoway_options G-3}{p_end}
{synoptline}
{p2colreset}{...}

{marker mcaproj_plot_options}{...}
{synoptset 24}{...}
{synopthdr:plot_options}
{synoptline}
{synopt:{it:{help marker_options}}}change look of markers (color, size, etc.){p_end}
{synopt:{it:{help marker_label_options}}}add marker labels; change look or position{p_end}
{synopt:{it:{help twoway_options}}}titles, legends, axes, added lines and 
     text, regions, etc.{p_end}
{synoptline}


{title:Menu}

{phang}
{bf:Statistics > Multivariate analysis > Correspondence analysis >}
    {bf:Postestimation after MCA or JCA > Dimension projection plot}


{marker options_mcaprojection}{...}
{title:Options for mcaprojection}

{dlgtab:Plots}

{phang}
{it:plot_options} affect the rendition of markers, including their shape,
size, color, and outline (see {manhelpi marker_options G-3}) and specify
if and how the markers are to be labeled
(see {manhelpi marker_label_options G-3}).  These
options may be specified for each variable.  If the {cmd:overlay} option
is not specified then for each variable you may also specify
{it:twoway_options} excluding {cmd:by()} and {cmd:name()}; see
{manhelpi twoway_options G-3}.

{dlgtab:Options}

{phang}{opth dimensions(numlist)}
identifies the dimensions to be displayed.  By default all dimensions are
displayed.

{phang}{opt normalize(norm)}
specifies the normalization of the coordinates.  {cmd:normalize(standard)}
returns coordinates in standard normalization.  {cmd:normalize(principal)}
returns principal coordinates.  The default is the normalization method
specified with {cmd:mca} during estimation, or {cmd:normalize(standard)}
if no method was specified.

{phang}{opt alternate}
causes adjacent labels to alternate sides.

{phang}{opt maxlength(#)}
specifies the maximum number of characters for row and column labels;
the default is {cmd:maxlength(12)}.

{phang}{it:combine_options}
affect the rendition of the combined plot; see
{manhelp graph_combine G-2:graph combine}.
These options may not be used if only one variable is specified.

{dlgtab:Y axis, X axis, Titles, Legend, Overall}

{phang}{it:twoway_options}
are any of the options documented in {manhelpi twoway_options G-3}, excluding
{cmd:by()}.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse issp93}{p_end}
{phang2}{cmd:. mca A B C D, dimensions(2) suppl(age edu) method(joint)}{p_end}

{pstd}Predict column coordinates and row coordinates{p_end}
{phang2}{cmd:. predict a1 a2, score(A)}{p_end}
{phang2}{cmd:. predict r1 r2, rowscores norm(principal)}{p_end}

{pstd}View the coordinates and the subinertia{p_end}
{phang2}{cmd:. estat coord, stats}{p_end}
{phang2}{cmd:. estat subinertia}{p_end}

{pstd}Biplots{p_end}
{phang2}{cmd:. mcaplot}{p_end}
{phang2}{cmd:. mcaplot A B C, ynegate}{p_end}
{phang2}{cmd:. mcaplot (A, mcolor(red) mlabcolor(red)) (B, mcolor(blue)), overlay}{p_end}

{pstd}Dimension projection plots{p_end}
{phang2}{cmd:. mcaprojection}{p_end}
{phang2}{cmd:. mcaprojection A B C, alternate}{p_end}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:estat summarize} saves the following in {cmd:r()}:

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Matrices}{p_end}
{synopt:{cmd:r(stats)}}k x 4 matrix of means, standard deviations, minimums, and maximums{p_end}

{pstd}
{cmd:estat coordinates} saves the following in {cmd:r()}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Macros}{p_end}
{synopt:{cmd:r(norm)}}the normalization method of the coordinates{p_end}

{p2col 5 20 24 2: Matrices}{p_end}
{synopt:{cmd:r(Coord)}}column coordinates{p_end}
{synopt:{cmd:r(Stats)}}column statistics: mass, distance, and inertia
           (option {cmd:stats} only){p_end}

{pstd}
{cmd:estat subinertia} saves the following in {cmd:r()}:

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Matrices}{p_end}
{synopt:{cmd:r(inertia_sub)}}variable-by-variable inertias{p_end}
