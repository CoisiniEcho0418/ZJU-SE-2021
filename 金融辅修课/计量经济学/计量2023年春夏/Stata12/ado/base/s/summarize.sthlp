{smcl}
{* *! version 1.1.6  07apr2011}{...}
{viewerdialog summarize "dialog summarize"}{...}
{vieweralsosee "[R] summarize" "mansection R summarize"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] ameans" "help ameans"}{...}
{vieweralsosee "[R] centile" "help centile"}{...}
{vieweralsosee "[D] codebook" "help codebook"}{...}
{vieweralsosee "[D] describe" "help describe"}{...}
{vieweralsosee "[D] inspect" "help inspect"}{...}
{vieweralsosee "[R] mean" "help mean"}{...}
{vieweralsosee "[R] proportion" "help proportion"}{...}
{vieweralsosee "[R] ratio" "help ratio"}{...}
{vieweralsosee "[ST] stsum" "help stsum"}{...}
{vieweralsosee "[SVY] svy estimation" "help svy_estimation"}{...}
{vieweralsosee "[R] table" "help table"}{...}
{vieweralsosee "[R] tabstat" "help tabstat"}{...}
{vieweralsosee "[R] tabulate, summarize()" "help tabulate_summarize"}{...}
{vieweralsosee "[R] total" "help total"}{...}
{vieweralsosee "[XT] xtsum" "help xtsum"}{...}
{viewerjumpto "Syntax" "summarize##syntax"}{...}
{viewerjumpto "Description" "summarize##description"}{...}
{viewerjumpto "Options" "summarize##options"}{...}
{viewerjumpto "Examples" "summarize##examples"}{...}
{viewerjumpto "Saved results" "summarize##saved_results"}{...}
{title:Title}

{p2colset 5 22 24 2}{...}
{p2col:{manlink R summarize} {hline 2}}Summary statistics{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 18 2}
{cmdab:su:mmarize} [{varlist}]
{ifin}
{weight}
[{cmd:,}
{it:options}]

{synoptset 16 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:Main}
{synopt:{opt d:etail}}display additional statistics{p_end}
{synopt:{opt mean:only}}suppress the display; calculate only the mean; programmer's option{p_end}
{synopt:{opt f:ormat}}use variable's display format{p_end}
{synopt:{opt sep:arator(#)}}draw separator line after every {it:#} variables; default is
{cmd:separator(5)}{p_end}
{synopt :{it:{help summarize##display_options:display_options}}}control spacing
           and base and empty cells{p_end}

{synoptline}
{p2colreset}{...}
{p 4 6 2}
  {it:varlist} may contain factor variables; see {help fvvarlist}.
  {p_end}
{p 4 6 2}
  {it:varlist} may contain time-series operators; see {help tsvarlist}.
  {p_end}
{p 4 6 2}
  {opt by} is allowed; see {manhelp by D}.
  {p_end}
{p 4 6 2}
  {opt aweight}s, {opt fweight}s, and {opt iweight}s are allowed.  However,
  {opt iweight}s may not be used with the {opt detail} option;
  see {help weight}.
  {p_end}


{title:Menu}

{phang}
{bf:Statistics > Summaries, tables, and tests >}
     {bf:Summary and descriptive statistics > Summary statistics}


{marker description}{...}
{title:Description}

{pstd}
{opt summarize} calculates and displays a variety of univariate summary
statistics.  If no {it:{help varlist}} is specified, summary statistics are
calculated for all the variables in the dataset.

{pstd}
Also see {manhelp ci R} for calculating the standard error and confidence
intervals of the mean.


{marker options}{...}
{title:Options}

{dlgtab:Main}

{phang}
{opt detail} produces additional statistics, including skewness,
kurtosis, the four smallest and four largest values, and various
percentiles.

{phang}
{opt meanonly}, which is allowed only when {opt detail} is not specified,
suppresses the display of results and calculation of the variance.  Ado-file
writers will find this useful for fast calls.

{phang}
{opt format} requests that the summary statistics be displayed using
the display formats associated with the variables rather than the default
{opt g} display format; see {manhelp format D}.

{phang}
{opt separator(#)} specifies how often to insert separation lines
into the output.  The default is {cmd:separator(5)}, meaning that a
line is drawn after every five variables.  {cmd:separator(10)} would draw a
line after every 10 variables.  {cmd:separator(0)} suppresses the separation
line.

{marker display_options}{...}
{phang}
{it:display_options}:
{opt vsquish},
{opt noempty:cells},
{opt base:levels},
{opt allbase:levels};
    see {helpb estimation options##display_options:[R] estimation options}.


{marker examples}{...}
{title:Examples}

{phang}{cmd:. sysuse auto}{p_end}
{phang}{cmd:. summarize}{p_end}
{phang}{cmd:. summarize mpg weight}{p_end}
{phang}{cmd:. summarize mpg weight if foreign}{p_end}
{phang}{cmd:. summarize mpg weight if foreign, detail}{p_end}
{phang}{cmd:. summarize i.rep78}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:summarize} saves the following in {cmd:r()}:

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Scalars}{p_end}
{synopt:{cmd:r(N)}}number of observations{p_end}
{synopt:{cmd:r(mean)}}mean{p_end}
{synopt:{cmd:r(skewness)}}skewness ({cmd:detail} only){p_end}
{synopt:{cmd:r(min)}}minimum{p_end}
{synopt:{cmd:r(max)}}maximum{p_end}
{synopt:{cmd:r(sum_w)}}sum of the weights{p_end}
{synopt:{cmd:r(p1)}}1st percentile ({cmd:detail} only){p_end}
{synopt:{cmd:r(p5)}}5th percentile ({cmd:detail} only){p_end}
{synopt:{cmd:r(p10)}}10th percentile ({cmd:detail} only){p_end}
{synopt:{cmd:r(p25)}}25th percentile ({cmd:detail} only){p_end}
{synopt:{cmd:r(p50)}}50th percentile ({cmd:detail} only){p_end}
{synopt:{cmd:r(p75)}}75th percentile ({cmd:detail} only){p_end}
{synopt:{cmd:r(p90)}}90th percentile ({cmd:detail} only){p_end}
{synopt:{cmd:r(p95)}}95th percentile ({cmd:detail} only){p_end}
{synopt:{cmd:r(p99)}}99th percentile ({cmd:detail} only){p_end}
{synopt:{cmd:r(Var)}}variance{p_end}
{synopt:{cmd:r(kurtosis)}}kurtosis ({cmd:detail} only){p_end}
{synopt:{cmd:r(sum)}}sum of variable{p_end}
{synopt:{cmd:r(sd)}}standard deviation{p_end}
{p2colreset}{...}
