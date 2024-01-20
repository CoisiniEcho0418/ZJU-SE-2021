{smcl}
{* *! version 1.1.6  11feb2011}{...}
{viewerdialog serrbar "dialog serrbar"}{...}
{vieweralsosee "[R] serrbar" "mansection R serrbar"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] qc" "help qc"}{...}
{viewerjumpto "Syntax" "serrbar##syntax"}{...}
{viewerjumpto "Description" "serrbar##description"}{...}
{viewerjumpto "Options" "serrbar##options"}{...}
{viewerjumpto "Examples" "serrbar##examples"}{...}
{title:Title}

{p2colset 5 20 22 2}{...}
{p2col:{manlink R serrbar} {hline 2}}Graph standard error bar chart{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 16 2}
{cmd:serrbar}
{it:mvar}
{it:svar}
{it:xvar}
{ifin}
[{cmd:,} {it:options}]

{synoptset 27 tabbed}
{synopthdr}
{synoptline}
{syntab:Main}
{synopt:{opt sc:ale(#)}}scale length of graph bars; default is
{cmd:scale(1)}{p_end}

{syntab:Error bars}
{synopt:{it:{help twoway_rcap:rcap_options}}}affect rendition of capped spikes{p_end}

{syntab:Plotted points}
{synopt:{opth mvop:ts(scatter:scatter_options)}}affect rendition of plotted
points{p_end}

{syntab:Add plots}
{synopt:{opth "addplot(addplot_option:plot)"}}add other plots to generated graph{p_end}

{syntab:Y axis, X axis, Titles, Legend, Overall}
{synopt:{it:twoway_options}}any options other than {opt by()} documented in
    {manhelpi twoway_options G-3}{p_end}
{synoptline}
{p2colreset}{...}


{title:Menu}

{phang}
{bf:Statistics > Other > Quality control > Standard error bar chart}


{marker description}{...}
{title:Description}

{pstd}
{opt serrbar} graphs {it:mvar} +/- {opt scale()} * {it:svar} against
{it:xvar}.  Usually, but not necessarily, {it:mvar} and {it:svar} will contain
means and standard errors or standard deviations of some variable so that a
standard error bar chart is produced.


{marker options}{...}
{title:Options}

{dlgtab:Main}

{phang}
{opt scale(#)} controls the length of the bars. The upper
and lower limits of the bars will be {it:mvar} + {opt scale()} * {it:svar} and
{it:mvar} - {opt scale()} * {it:svar}. The default is {cmd:scale(1)}.

{dlgtab:Error bars}

{phang}
{it:rcap_options} affect the rendition of the plotted error bars (the capped
spikes).  See {manhelp twoway_rcap G-2:graph twoway rcap}.

{dlgtab:Plotted points}

{phang}
{opt mvopts(scatter_options)} affects the rendition of the plotted
points ({it:mvar} versus {it:xvar}).  See
{manhelp scatter G-2:graph twoway scatter}.

{dlgtab:Add plots}

{phang}
{opt addplot(plot)} provides a way to add other plots to the generated
graph; see {manhelpi addplot_option G-3}.

{dlgtab:Y axis, X axis, Titles, Legend, Overall}

{phang}
{it:twoway_options} are any of the options documented in
{manhelpi twoway_options G-3}, excluding {opt by()}.  These include options for
titling the graph (see {manhelpi title_options G-3}) and for saving the
graph to disk (see {manhelpi saving_option G-3}).


{marker examples}{...}
{title:Examples}

{phang}{cmd:. webuse assembly}{p_end}
{phang}{cmd:. serrbar mean std date, scale(2) yline(195)}{p_end}
{phang}{cmd:. serrbar mean std date, scale(2) title("Observed Weight Variation") sub("San Francisco plant, 1/8 to 1/6") yline(195) yaxis(1 2) ylab(195, axis(2)) ytitle("", axis(2))}
{p_end}
