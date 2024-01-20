{smcl}
{* *! version 1.0.1  29jun2011}{...}
{viewerdialog lincom "dialog lincom"}{...}
{vieweralsosee "[SEM] lincom " "mansection SEM lincom"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[SEM] estat stdize" "help sem_estat_stdize"}{...}
{vieweralsosee "[SEM] nlcom" "help sem_nlcom"}{...}
{vieweralsosee "[SEM] sem" "help sem_command"}{...}
{vieweralsosee "[SEM] sem postestimation" "help sem_postestimation"}{...}
{vieweralsosee "[SEM] test" "help sem_test"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] lincom" "help lincom"}{...}
{viewerjumpto "Syntax" "sem_lincom##syntax"}{...}
{viewerjumpto "Description" "sem_lincom##description"}{...}
{viewerjumpto "Options" "sem_lincom##options"}{...}
{viewerjumpto "Remarks" "sem_lincom##remarks"}{...}
{viewerjumpto "Examples" "sem_lincom##examples"}{...}
{viewerjumpto "Saved results" "sem_lincom##saved_results"}{...}
{title:Title}

{p2colset 5 21 23 2}{...}
{p2col:{manlink SEM lincom} {hline 2}}Linear combinations of parameters{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

        {cmd:sem ..., ...}{right:(fit constrained or unconstrained model)       }

{phang2}{cmd:lincom } {it:{help exp:exp}} [{cmd:,}
          {it:{help lincom:options}}]


{title:Menu}

{phang}
{bf:Statistics > Structural equation modeling (SEM) > Testing and CIs > Linear combinations of parameters}


{marker description}{...}
{title:Description}

{pstd}    
{cmd:lincom} computes point estimates, standard errors, z statistics,
p-values, and confidence intervals for linear combinations of the estimated
parameters. 

{pstd}    
{cmd:lincom} is a standard postestimation command and works after {cmd:sem}
just as it does after any other estimation command except that you must use
the {cmd:_b[]} coefficient notation; you cannot use shortcuts of referring to
variables to obtain coefficients on variables. 

{pstd}    
See {helpb lincom:[R] lincom}.


{marker options}{...}
{title:Options}

{pstd}    
See {it:{help lincom##options:Options}} in {helpb lincom:[R] lincom}.


{marker remarks}{...}
{title:Remarks}

{pstd}    
{cmd:lincom} works in the metric of SEM, which is to say, path coefficients,
variances, and covariances.  If you want to frame your linear combinations in
terms of standardized coefficients and correlations, prefix {cmd:lincom} with
{cmd:estat stdize:}; see {helpb sem_estat_stdize:[SEM] estat stdize}.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse sem_2fmm}{p_end}
{phang2}{cmd:. sem (Affective -> a1 a2 a3 a4 a5) (Cognitive -> c1 c2 c3 c4 c5)}{p_end}

{pstd}Show coefficient legend{p_end}
{phang2}{cmd:. sem, coeflegend}{p_end}

{pstd}Estimate linear combination of coefficients{p_end}
{phang2}{cmd:. lincom _b[a1:Affective]*2 - _b[a2:Affective]}{p_end}
{phang2}{cmd:. lincom _b[a5:Affective] - _b[a4:Affective]}{p_end}


{marker saved_results}{...}
{title:Saved results}

{pstd}
See {it:{help lincom##saved_results:Saved results}} in
{helpb lincom:[R] lincom}.
