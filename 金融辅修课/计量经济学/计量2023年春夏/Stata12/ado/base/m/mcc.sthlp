{smcl}
{* *! version 1.0.9  10jun2011}{...}
{viewerdialog mcc "dialog mcc"}{...}
{viewerdialog mcci "dialog mcci"}{...}
{vieweralsosee "[ST] epitab" "mansection ST epitab"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] bitest" "help bitest"}{...}
{vieweralsosee "[R] ci" "help ci"}{...}
{vieweralsosee "[R] clogit" "help clogit"}{...}
{vieweralsosee "[R] symmetry" "help symmetry"}{...}
{vieweralsosee "[R] tabulate twoway" "help tabulate_twoway"}{...}
{vieweralsosee "[U] 19 Immediate commands" "help immed"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[ST] Glossary" "help st_glossary"}{...}
{viewerjumpto "Syntax" "mcc##syntax"}{...}
{viewerjumpto "Description" "mcc##description"}{...}
{viewerjumpto "Options" "mcc##options"}{...}
{viewerjumpto "Examples" "mcc##examples"}{...}
{viewerjumpto "Saved results" "mcc##saved_results"}{...}
{viewerjumpto "Reference" "mcc##reference"}{...}
{title:Title}

{p2colset 5 20 22 2}{...}
{p2col :{manlink ST epitab} {hline 2}}Tables for epidemiologists (mcc and mcci)
{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 14 2}{cmd:mcc} {it:var_exposed_case} {it:var_exposed_control} {ifin} 
{weight} [{cmd:, tb} {opt l:evel(#)}]

{p 8 14 2}{cmd:mcci} {it:#a #b #c #d} [{cmd:, tb} {opt l:evel(#)}]

{pstd}{opt fweight}s are allowed; see {help weight}.


{title:Menu}

    {title:mcc}

{phang2}
{bf:Statistics > Epidemiology and related > Tables for epidemiologists >}
       {bf:Matched case-control studies}

    {title:mcci}

{phang2}
{bf:Statistics > Epidemiology and related > Tables for epidemiologists >}
        {bf:Matched case-control calculator}


{marker description}{...}
{title:Description}

{pstd}
{cmd:mcc} is used with matched case-control data.  It calculates McNemar's 
chi-squared; point estimates and confidence intervals for the difference, ratio,
and relative difference of the proportion with the factor; and the odds ratio
and its confidence interval.  {cmd:mcci} is the immediate form of {cmd:mcc};
see {help immed}.  Also see {manhelp clogit R} and {manhelp symmetry R} for
related commands.


{marker options}{...}
{title:Options}

{dlgtab:Options}

{phang}
{opt tb} requests that test-based confidence intervals
({help mcc##M1976:Miettinen 1976}) be calculated wherever
appropriate in place of confidence intervals based on other approximations or
exact confidence intervals.  We recommend that test-based confidence intervals
be used only for pedagogical purposes and never for research work.

{phang}
{opt level(#)} specifies the confidence level, as a 
percentage, for confidence intervals.  The default is {cmd:level(95)} or as 
set by {helpb set level}.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse mccxmpl}

{pstd}List the data{p_end}
{phang2}{cmd:. list}

{pstd}Calculate odds ratio, etc.{p_end}
{phang2}{cmd:. mcc case control [fw=pop]}

{pstd}Immediate form of above command{p_end}
{phang2}{cmd:. mcci 8 8 3 8}

{pstd}Same as above command, but report 90% confidence intervals rather than
95%{p_end}
{phang2}{cmd:. mcci 8 8 3 8, level(90)}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:mcc} and {cmd:mcci} save the following in {cmd:r()}:

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Scalars}{p_end}
{synopt:{cmd:r(p_exact)}}two-sided significance{p_end}
{synopt:{cmd:r(or)}}odds ratio{p_end}
{synopt:{cmd:r(lb_or)}}lower bound of CI for {cmd:or}{p_end}
{synopt:{cmd:r(ub_or)}}upper bound of CI for {cmd:or}{p_end}
{synopt:{cmd:r(D_f)}}difference in proportion with factor{p_end}
{synopt:{cmd:r(lb_D_f)}}lower bound of CI for {cmd:D_f}{p_end}
{synopt:{cmd:r(ub_D_f)}}upper bound of CI for {cmd:D_f}{p_end}
{synopt:{cmd:r(R_f)}}ratio of proportion with factor{p_end}
{synopt:{cmd:r(lb_R_f)}}lower bound of CI for {cmd:R_f}{p_end}
{synopt:{cmd:r(ub_R_f)}}upper bound of CI for {cmd:R_f}{p_end}
{synopt:{cmd:r(RD_f)}}relative difference in proportion with factor{p_end}
{synopt:{cmd:r(lb_RD_f)}}lower bound of CI for {cmd:RD_f}{p_end}
{synopt:{cmd:r(ub_RD_f)}}upper bound of CI for {cmd:RD_f}{p_end}
{synopt:{cmd:r(chi2)}}chi-squared{p_end}
{p2colreset}{...}


{marker reference}{...}
{title:Reference}

{marker M1976}{...}
{phang}
Miettinen, O. S. 1976. Estimability and estimation in case-referent studies.
{it:American Journal of Epidemiology} 103: 226-235.
Reprinted in 
{it:Evolution of Epidemiologic Ideas: Annotated Readings on Concepts and Methods},
ed. S. Greenland, pp. 181-190. Newton Lower Falls, MA: Epidemiology Resources.
{p_end}
