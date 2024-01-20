{smcl}
{* *! version 1.1.4  11feb2011}{...}
{viewerdialog pkcollapse "dialog pkcollapse"}{...}
{vieweralsosee "[R] pkcollapse" "mansection R pkcollapse"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] pk" "help pk"}{...}
{viewerjumpto "Syntax" "pkcollapse##syntax"}{...}
{viewerjumpto "Description" "pkcollapse##description"}{...}
{viewerjumpto "Options" "pkcollapse##options"}{...}
{viewerjumpto "Examples" "pkcollapse##examples"}{...}
{title:Title}

{p2colset 5 23 25 2}{...}
{p2col :{manlink R pkcollapse} {hline 2}}Generate pharmacokinetic measurement dataset{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 19 2}
{cmd:pkcollapse} {it:time} {it:concentration} [{it:{help if}}] {cmd:,}
 {opt id(id_var)} [{it:options}]

{synoptset 18 tabbed}{...}
{synopthdr}
{synoptline}
{syntab :Main}
{p2coldent :* {opt id(id_var)}}subject ID variable{p_end}
{synopt :{opth "stat(pkcollapse##measures:measures)"}}create specified
{it:measures}; default is all{p_end}
{synopt :{opt t:rapezoid}}use trapezoidal rule; default is cubic splines{p_end}
{synopt :{opt fit(#)}}use {it:#} points to estimate AUC; default is
{cmd:fit(3)}{p_end}
{synopt :{opth keep(varlist)}}keep variables in {it:varlist}{p_end}
{synopt :{opt force}}force collapse{p_end}
{synopt :{opt nod:ots}}suppress dots during calculation{p_end}
{synoptline}
{p2colreset}{...}
{p 4 6 2}*{opt id(id_var)} is required.

{synoptset 18}{...}
{marker measures}{...}
{synopthdr :measures}
{synoptline}
{synopt :{opt auc}}area under the concentration-time curve (AUC){p_end}
{synopt :{opt aucline}}area under the concentration-time curve from 0 to
 infinity using a linear extension{p_end}
{synopt :{opt aucexp}}area under the concentration-time curve from 0 to infinity
using an exponential extension{p_end}
{synopt :{opt auclog}}area under the log-concentration-time curve extended with 
a linear fit{p_end}
{synopt :{opt half}}half-life of the drug{p_end}
{synopt :{opt ke}}elimination rate{p_end}
{synopt :{opt cmax}}maximum concentration{p_end}
{synopt :{opt tmax}}time at last concentration{p_end}
{synopt :{opt tomc}}time of maximum concentration{p_end}
{synoptline}
{p2colreset}{...}


{title:Menu}

{phang}
{bf:Statistics > Epidemiology and related > Other >}
    {bf:Generate pharmacokinetic measurement dataset}


{marker description}{...}
{title:Description}

{pstd}
{cmd:pkcollapse} generates new variables with the pharmacokinetic summary
measures of interest.
 
{pstd}
{cmd:pkcollapse} is one of the pk commands.  Please read {helpb pk} before
reading this entry.


{marker options}{...}
{title:Options}

{dlgtab:Main}

{phang}
{opt id(id_var)} is required and specifies the variable that contains
the subject ID over which {cmd:pkcollapse} is to operate.

{phang}
{opth stat:(pkcollapse##measures:measures)} specifies the measures to be
generated.  The default is to generate all the measures.

{phang}
{opt trapezoid} tells Stata to use the trapezoidal rule when calculating the
AUC.  The default is to use cubic splines, which give better results for most
functions.  When the curve is irregular, {opt trapezoid} may give better
results.

{phang}
{opt fit(#)} specifies the number of points to use in estimating the AUC.  The
default is {cmd:fit(3)}, the last three points.  This number should be viewed
as a minimum; the appropriate number of points will depend on your data.

{phang}
{opth keep(varlist)} specifies the variables to be kept during the collapse.
Variables not specified with the {opt keep()} option will be dropped.  When
{opt keep()} is specified, the keep variables are checked to ensure that all
values of the variables are the same within {it:id_var}.

{phang}
{opt force} forces the collapse, even when the values of
the {opt keep()} variables are different within the {it:id_var}.

{phang}
{opt nodots} suppresses the display of dots during calculation.


{marker examples}{...}
{title:Examples}

    {hline}
{pstd}Setup{p_end}
{phang2}{cmd:. webuse pkdata}{p_end}

{pstd}Create dataset containing all summary pharmacokinetic measures{p_end}
{phang2}{cmd:. pkcollapse time concA concB, id(id)}

    {hline}
{pstd}Setup{p_end}
{phang2}{cmd:. webuse pkdata, clear}{p_end}

{pstd}Create dataset containing the AUC measure, and keep the variable
{cmd:seq}{p_end}
{phang2}{cmd:. pkcollapse time concA concB, id(id) keep(seq) stat(auc)}{p_end}
    {hline}
