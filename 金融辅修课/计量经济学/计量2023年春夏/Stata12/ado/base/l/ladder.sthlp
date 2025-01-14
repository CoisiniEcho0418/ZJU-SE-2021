{smcl}
{* *! version 1.1.8  10jun2011}{...}
{viewerdialog ladder "dialog ladder"}{...}
{viewerdialog gladder "dialog gladder"}{...}
{viewerdialog qladder "dialog qladder"}{...}
{vieweralsosee "[R] ladder" "mansection R ladder"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] diagnostic plots" "help diagnostic_plots"}{...}
{vieweralsosee "[R] lnskew0" "help lnskew0"}{...}
{vieweralsosee "[R] lv" "help lv"}{...}
{vieweralsosee "[R] sktest" "help sktest"}{...}
{viewerjumpto "Syntax" "ladder##syntax"}{...}
{viewerjumpto "Description" "ladder##description"}{...}
{viewerjumpto "Options for ladder" "ladder##options_ladder"}{...}
{viewerjumpto "Options for gladder" "ladder##options_gladder"}{...}
{viewerjumpto "Options for qladder" "ladder##options_qladder"}{...}
{viewerjumpto "Examples" "ladder##examples"}{...}
{viewerjumpto "Saved results" "ladder##saved_results"}{...}
{viewerjumpto "Reference" "ladder##reference"}{...}
{title:Title}

{p2colset 5 19 21 2}{...}
{p2col :{manlink R ladder} {hline 2}}Ladder of powers{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{phang}
Ladder of powers

{p 8 15 2}
{cmd:ladder} {varname} {ifin} [{cmd:,} {opth g:enerate(newvar)} {opt noa:djust}]


{phang}
Ladder-of-powers histograms

{p 8 16 2}
{cmd:gladder} {varname} {ifin} [{cmd:,}
 {it:{help ladder##histogram_options:histogram_options}}
 {it:{help ladder##combine_options:combine_options}}]


{phang}
Ladder-of-powers quantile-normal plots

{p 8 16 2}
{cmd:qladder} {varname} {ifin} [{cmd:,} 
{it:{help ladder##qnorm_options:qnorm_options}}
{it:{help ladder##combine_options:combine_options}}]


{p 4 6 2}
{cmd:by} is allowed with {cmd:ladder}; see {manhelp by D}.


{title:Menu}

    {title:ladder} 

{phang2}
{bf:Statistics > Summaries, tables, and tests >}
    {bf:Distributional plots and tests > Ladder of powers}

    {title:gladder}

{phang2}
{bf:Statistics > Summaries, tables, and tests >}
     {bf:Distributional plots and tests > Ladder-of-powers histograms}

     {title:qladder}

{phang2}
{bf:Statistics > Summaries, tables, and tests >}
    {bf:Distributional plots and tests > Ladder-of-powers quantile-normal plots}


{marker description}{...}
{title:Description}

{pstd}
{cmd:ladder} searches a subset of the ladder of powers
({help ladder##T1977:Tukey 1977}) for a
transform that converts {varname} into a normally distributed variable.
{cmd:sktest} tests for normality; see {helpb sktest:[R] sktest}.  Also see
{manhelp boxcox R}.

{pstd}
{cmd:gladder} displays nine histograms of transforms of {it:varname} according
to the ladder of powers.  {cmd:gladder} is useful pedagogically, but we do not
advise looking at histograms for research work; {cmd:ladder} or {cmd:qnorm}
(see {helpb diagnostic plots:[R] diagnostic plots}) is preferred.

{pstd}
{cmd:qladder} displays the quantiles of transforms of {it:varname} according
to the ladder of powers against the quantiles of a normal distribution.


{marker options_ladder}{...}
{title:Options for ladder}

{dlgtab:Main}

{phang}
{opth generate(newvar)} saves the transformed values corresponding to the
minimum chi-squared value from the table.  We do not recommend using 
{opt generate()} because it is literal in interpreting the 
minimum, thus ignoring nearly equal but perhaps more interpretable transforms.

{phang}
{opt noadjust} is the {opt noadjust} option to {cmd:sktest}; see
{manhelp sktest R}.


{marker options_gladder}{...}
{title:Options for gladder}

{phang}
{marker histogram_options}
{it:histogram_options} affect the rendition of the histograms across all
relevant transformations; see {manhelp histogram R}.  Here the {opt normal}
option is assumed, so you must supply the {opt nonormal} option to suppress
the overlaid normal density.  Also, {cmd:gladder} does not allow the
{opt width(#)} option of {cmd:histogram}.

{phang}
{marker combine_options}
{it:combine_options} are any of the options documented in 
{helpb graph combine:[G-2] graph combine}.  These include options for titling
the graph (see {manhelpi title_options G-3}) and for saving the graph to disk
(see {manhelpi saving_option G-3}).


{marker options_qladder}{...}
{title:Options for qladder}

{phang}
{marker qnorm_options}
{it:qnorm_options} affect the rendition of the quantile-normal plots across
all relevant transformations.  See {help diagnostic plots##options2:options2}
in {bf:[R] diagnostic plots}.

{phang}
{marker combine_options}
{it:combine_options} are any of the options documented in 
{helpb graph combine:[G-2] graph combine}.  These include options for titling
the graph (see {manhelpi title_options G-3}) and for saving the graph to disk
(see {manhelpi saving_option G-3}).


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. sysuse citytemp}{p_end}

{pstd}Search ladder of powers for a function that transforms {cmd:tempjuly} to
normality{p_end}
{phang2}{cmd:. ladder tempjuly}{p_end}

{pstd}Draw histogram for each transformation; remove axis labels{p_end}
{phang2}{cmd:. gladder tempjuly, l1title("") ylabel(none) xlabel(none)}{p_end}

{pstd}Draw quantile-normal plot for each transformation; remove axis labels
{p_end}
{phang2}{cmd:. qladder tempjuly, ylabel(none) xlabel(none)}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:ladder} saves the following in {cmd:r()}:

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Scalars}{p_end}
{synopt:{cmd:r(N)}}number of observations{p_end}
{synopt:{cmd:r(invcube)}}chi-squared for inverse-cubic transformation{p_end}
{synopt:{cmd:r(P_invcube)}}significance level for inverse-cubic
	transformation{p_end}
{synopt:{cmd:r(invsq)}}chi-squared for inverse-square transformation{p_end}
{synopt:{cmd:r(P_invsq)}}significance level for inverse-square
	transformation{p_end}
{synopt:{cmd:r(inv)}}chi-squared for inverse transformation{p_end}
{synopt:{cmd:r(P_inv)}}significance level for inverse transformation{p_end}
{synopt:{cmd:r(invsqrt)}}chi-squared for inverse-root transformation{p_end}
{synopt:{cmd:r(P_invsqrt)}}significance level for inverse-root
	transformation{p_end}
{synopt:{cmd:r(log)}}chi-squared for log transformation{p_end}
{synopt:{cmd:r(P_log)}}significance level for log transformation{p_end}
{synopt:{cmd:r(sqrt)}}chi-squared for square-root transformation{p_end}
{synopt:{cmd:r(P_sqrt)}}significance level for square-root transformation{p_end}
{synopt:{cmd:r(ident)}}chi-squared for untransformed data{p_end}
{synopt:{cmd:r(P_ident)}}significance level for untransformed data{p_end}
{synopt:{cmd:r(square)}}chi-squared for square transformation{p_end}
{synopt:{cmd:r(P_square)}}significance level for square transformation{p_end}
{synopt:{cmd:r(cube)}}chi-squared for cubic transformation{p_end}
{synopt:{cmd:r(P_cube)}}significance level for cubic transformation{p_end}
{p2colreset}{...}


{marker reference}{...}
{title:Reference}

{marker T1977}{...}
{phang}
Tukey, J. W. 1977. {it:Exploratory Data Analysis}.
Reading, MA: Addison-Wesley.
{p_end}
