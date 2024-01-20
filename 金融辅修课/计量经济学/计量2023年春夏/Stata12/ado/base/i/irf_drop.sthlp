{smcl}
{* *! version 1.1.3  11feb2011}{...}
{viewerdialog "irf drop" "dialog irf_drop"}{...}
{vieweralsosee "[TS] irf drop" "mansection TS irfdrop"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[TS] irf" "help irf"}{...}
{vieweralsosee "[TS] var intro" "help var_intro"}{...}
{vieweralsosee "[TS] vec intro" "help vec_intro"}{...}
{viewerjumpto "Syntax" "irf_drop##syntax"}{...}
{viewerjumpto "Description" "irf_drop##description"}{...}
{viewerjumpto "Option" "irf_drop##option"}{...}
{viewerjumpto "Example" "irf_drop##example"}{...}
{title:Title}

{p2colset 5 22 24 2}{...}
{p2col:{manlink TS irf drop} {hline 2}}Drop IRF results from the active IRF file{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 20 2}
{cmd:irf}
{opt drop}
{it:irf_resultslist}
[{cmd:,} {opth set(filename)}]


{title:Menu}

{phang}
{bf:Statistics > Multivariate time series > Manage IRF results and files >}
    {bf:Drop IRF results}


{marker description}{...}
{title:Description}

{pstd}
{opt irf drop} removes IRF results from the active IRF file.


{marker option}{...}
{title:Option}

{phang}
{opth set(filename)} specifies the file to be made active; see
{manhelp irf_set TS:irf set}.
   If {opt set()} is not specified, the active file is used.


{marker example}{...}
{title:Example}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse lutkepohl2}

{pstd}Fit a VAR model{p_end}
{phang2}{cmd:. var dln_inv dln_inc dln_consump if qtr<=tq(1978q4), lags(1/2)}
           {cmd:dfk}

{pstd}Create IRF results {cmd:order1}, {cmd:order2}, and {cmd:order3} using
various orderings of the endogenous variables{p_end}
{phang2}{cmd:. irf create order1, set(myirfs, replace)}{p_end}
{phang2}{cmd:. irf create order2, order(dln_inc dln_inv dln_consump)}{p_end}
{phang2}{cmd:. irf create order3, order(dln_inc dln_consump dln_inv)}

{pstd}Display short summary of IRF results{p_end}
{phang2}{cmd:. irf describe}

{pstd}Drop IRF results {cmd:order1} and {cmd:order2}{p_end}
{phang2}{cmd:. irf drop order1 order2}

{pstd}Display summary of IRF results{p_end}
{phang2}{cmd:. irf describe}{p_end}
