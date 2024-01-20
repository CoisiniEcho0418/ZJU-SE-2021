{smcl}
{* *! version 1.0.1  29jun2011}{...}
{viewerdialog testnl "dialog testnl"}{...}
{vieweralsosee "[SEM] testnl" "mansection SEM testnl"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[SEM] estat eqtest" "help sem_estat_eqtest"}{...}
{vieweralsosee "[SEM] estat stdize" "help sem_estat_stdize"}{...}
{vieweralsosee "[SEM] lrtest" "help sem_lrtest"}{...}
{vieweralsosee "[SEM] nlcom" "help sem_nlcom"}{...}
{vieweralsosee "[SEM] sem" "help sem_command"}{...}
{vieweralsosee "[SEM] sem postestimation" "help sem_postestimation"}{...}
{vieweralsosee "[SEM] test" "help sem_test"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] testnl" "help testnl"}{...}
{viewerjumpto "Syntax" "sem_testnl##syntax"}{...}
{viewerjumpto "Description" "sem_testnl##description"}{...}
{viewerjumpto "Options" "sem_testnl##options"}{...}
{viewerjumpto "Remarks" "sem_testnl##remarks"}{...}
{viewerjumpto "Examples" "sem_testnl##examples"}{...}
{viewerjumpto "Saved results" "sem_testnl##saved_results"}{...}
{title:Title}

{p2colset 5 21 23 2}{...}
{p2col:{manlink SEM testnl} {hline 2}}Wald test of nonlinear hypothesis{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

        {cmd:sem ..., ...}{right:(fit constrained or unconstrained model)       }

{p 8 33 2}
{cmd:testnl} {it:{help testnl##exp:exp}} {cmd:=} {it:{help testnl##exp:exp}}
       [{cmd:=} {it:{help testnl##exp:exp}} ...] [{cmd:,}
        {it:{help testnl:options}}]

{p 8 33 2}
{cmd:testnl} {cmd:(}{it:{help testnl##exp:exp}} {cmd:=} {it:{help testnl##exp:exp}}
     [{cmd:=} {it:{help testnl##exp:exp}}...]{cmd:)}
     [{cmd:(}{it:{help testnl##exp:exp}} {cmd:=} {it:{help testnl##exp:exp}}
     [{cmd:=} {it:{help testnl##exp:exp}} ...]{cmd:)} {it:...}]
[{cmd:,} {it:{help testnl:options}}] 


{title:Menu}

{phang}
{bf:Statistics > Structural equation modeling (SEM) > Testing and CIs > Wald tests of nonlinear hypotheses}


{marker description}{...}
{title:Description}

{pstd}
{cmd:testnl} performs the Wald test of the nonlinear hypothesis or hypotheses
that you specify.

{pstd}
{cmd:testnl} is a standard postestimation command and works after {cmd:sem}
just as it does after any other estimation command except that you must use
the {cmd:_b[]} coefficient notation; you cannot refer to variables using
shortcuts to obtain coefficients on variables. 


{marker options}{...}
{title:Options}

{phang}
See {it:{help testnl##options:Options}} in {helpb testnl:[R] testnl}.


{marker remarks}{...}
{title:Remarks}
   
{pstd} 
{cmd:testnl} works in the metric of SEM, which is to say, path coefficients,
variances, and covariances.  If you want to frame your tests in terms of
standardized coefficients and correlations, prefix {cmd:testnl} with
{cmd:estat stdize:}; see {helpb sem_estat_stdize:[SEM] estat stdize}.

{pstd} 
{cmd:estat stdize:} is unnecessary because, using {cmd:testnl}, everywhere you
wanted a standardized coefficient or correlation, you could just type the
formula.  If you did that, you would get the same answer but for numerical
precision.  In this case, the answer produced with the 
{cmd:estat stdize:} prefix will be a little more accurate because 
{cmd:estat stdize:} is able to substitute an analytic derivative in one part of
the calculation where {cmd:testnl}, doing the whole thing itself, would be
forced to use a numeric derivative. 


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse sem_2fmm}{p_end}
{phang2}{cmd:. sem (Affective -> a1 a2 a3 a4 a5) (Cognitive -> c1 c2 c3 c4 c5)}{p_end}

{pstd}Test one nonlinear constraint{p_end}
{phang2}{cmd:. testnl _b[c3:Cognitive] = 1/_b[c2:Cognitive]}{p_end}

{pstd}Test multiple nonlinear constraints{p_end}
{phang2}{cmd:. testnl (_b[c3:Cognitive] = 1/_b[c2:Cognitive])}{break}
	{cmd: (_b[a3:Affective] = 1/_b[a2:Affective])}{p_end}

{pstd}Test multiple nonlinear constraints separately, and adjust p-values
using Holm's method{p_end}
{phang2}{cmd:. testnl (_b[c3:Cognitive] = 1/_b[c2:Cognitive])}{break}
	{cmd: (_b[a3:Affective] = 1/_b[a2:Affective]), mtest(holm)}{p_end}


{marker saved_results}{...}
{title:Saved results}

{pstd}
See {it:{help testnl##saved_results:Saved results}} in
{helpb testnl:[R] testnl}.{p_end}
