{smcl}
{* *! version 1.0.1  07jul2011}{...}
{viewerdialog nlcom "dialog nlcom"}{...}
{vieweralsosee "[SEM] nlcom " "mansection SEM nlcom"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[SEM] estat stdize" "help sem_estat_stdize"}{...}
{vieweralsosee "[SEM] nlcom" "help sem_nlcom"}{...}
{vieweralsosee "[SEM] sem" "help sem_command"}{...}
{vieweralsosee "[SEM] sem postestimation" "help sem_postestimation"}{...}
{vieweralsosee "[SEM] test" "help sem_test"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] nlcom" "help nlcom"}{...}
{viewerjumpto "Syntax" "sem_nlcom##syntax"}{...}
{viewerjumpto "Description" "sem_nlcom##description"}{...}
{viewerjumpto "Options" "sem_nlcom##options"}{...}
{viewerjumpto "Remarks" "sem_nlcom##remarks"}{...}
{viewerjumpto "Examples" "sem_nlcom##examples"}{...}
{viewerjumpto "Saved results" "sem_nlcom##saved_results"}{...}
{title:Title}

{p2colset 5 20 22 2}{...}
{p2col:{manlink SEM nlcom} {hline 2}}Nonlinear combinations of parameters{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

        {cmd:sem ..., ...}{right:(fit constrained or unconstrained model)       }

{phang2}{cmd:nlcom} {it:{help exp:exp}} [{cmd:,}
      {it:{help nlcom:options}}]


{title:Menu}

{phang}
{bf:Statistics > Structural equation modeling (SEM) > Testing and CIs > Nonlinear combinations of parameters}


{marker description}{...}
{title:Description}

{pstd}
{cmd:nlcom} computes point estimates, standard errors, z statistics, p-values,
and confidence intervals for (possibly) nonlinear combinations of the
estimated parameters.

{pstd}
{cmd:nlcom} is a standard postestimation command and works after {cmd:sem}
just as it does after any other estimation command.

{pstd}
See {helpb nlcom:[R] nlcom}.


{marker options}{...}
{title:Options}

{pstd}    
See {it:{help nlcom##options:Options}} in {helpb nlcom:[R] nlcom}.


{marker remarks}{...}
{title:Remarks}

{pstd}    
{cmd:nlcom} works in the metric of SEM, which is to say, path coefficients,
variances, and covariances.  If you want to frame your nonlinear combinations
in terms of standardized coefficients and correlations, prefix {cmd:nlcom}
with {cmd:estat stdize:}; see {helpb sem_estat_stdize:[SEM] estat stdize}.

{pstd}    
{cmd:estat stdize:} is, strictly speaking, unnecessary because everywhere you
wanted a standardized coefficient or correlation, you could just type the
formula.  If you did that, you would get the same results but for numerical
precision.  The answer produced with the 
{cmd:estat stdize:} prefix will be a little more accurate because 
{cmd:estat stdize:} is able to substitute an analytic derivative in one part of
the calculation where {cmd:nlcom}, doing the whole thing itself, would be
forced to use a numeric derivative. 


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse sem_2fmm}{p_end}
{phang2}{cmd:. sem (Affective -> a1 a2 a3 a4 a5) (Cognitive -> c1 c2 c3 c4 c5)}{p_end}

{pstd}Show coefficient legend{p_end}
{phang2}{cmd:. sem, coeflegend}{p_end}

{pstd}Estimate the product of the coefficients for {cmd:a2} and {cmd:a3}{p_end}
{phang2}{cmd:. nlcom _b[a2:Affective]*_b[a3:Affective]}{p_end}

{pstd}Estimate the ratio of the coefficients for {cmd:a2} and {cmd:a3}{p_end}
{phang2}{cmd:. nlcom _b[a2:Affective] / _b[a3:Affective]}{p_end}


{marker saved_results}{...}
{title:Saved results}

{pstd}
See {it:{help nlcom##saved_results:Saved results}} in
{helpb nlcom:[R] nlcom}.
{p_end}
