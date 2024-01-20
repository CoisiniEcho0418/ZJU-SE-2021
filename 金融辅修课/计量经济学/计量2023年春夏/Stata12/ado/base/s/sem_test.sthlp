{smcl}
{* *! version 1.0.1  07jul2011}{...}
{viewerdialog test "dialog test"}{...}
{vieweralsosee "[SEM] test" "mansection SEM test"}{...}
{findalias assembequal}{...}
{findalias assemcorr}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[SEM] estat eqtest" "help sem_estat_eqtest"}{...}
{vieweralsosee "[SEM] estat stdize" "help sem_estat_stdize"}{...}
{vieweralsosee "[SEM] lincom" "help sem_lincom"}{...}
{vieweralsosee "[SEM] lrtest" "help sem_lrtest"}{...}
{vieweralsosee "[SEM] sem" "help sem_command"}{...}
{vieweralsosee "[SEM] sem postestimation" "help sem_postestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] test" "help test"}{...}
{viewerjumpto "Syntax" "sem_test##syntax"}{...}
{viewerjumpto "Description" "sem_test##description"}{...}
{viewerjumpto "Options" "sem_test##options"}{...}
{viewerjumpto "Remarks" "sem_test##remarks"}{...}
{viewerjumpto "Examples" "sem_test##examples"}{...}
{viewerjumpto "Saved results" "sem_test##saved_results"}{...}
{title:Title}

{p2colset 5 19 21 2}{...}
{p2col:{manlink SEM test} {hline 2}}Wald test of linear hypothesis{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

        {cmd:sem ..., ...}{right:(fit constrained or unconstrained model)       }

{phang2}
{cmdab:te:st}
{it:{help test##coeflist:coeflist}}

{phang2}
{cmdab:te:st}
{it:{help test##exp:exp}} {cmd:=} {it:{help test##exp:exp}} [{cmd:=} ...]

{phang2}
{cmdab:te:st}
{cmd:[}{it:{help test##eqno:eqno}}{cmd:]}
[{cmd::} {it:{help test##coeflist:coeflist}}]

{phang2}
{cmdab:te:st}
{cmd:[}{it:{help test##eqno:eqno}} {cmd:=}
            {it:{help test##eqno:eqno}} [{cmd:=} ...]{cmd:]}
[{cmd::} {it:{help test##coeflist:coeflist}}]

{p 8 14 2}
{cmdab:te:st}
{cmd:(}{it:{help test##spec:spec}}{cmd:)}
[{cmd:(}{it:{help test##spec:spec}}{cmd:)} ...]
[{cmd:,} {it:{help test:test_options}}]


{title:Menu}

{phang}
{bf:Statistics > Structural equation modeling (SEM) > Testing and CIs > Wald tests of linear hypotheses}


{marker description}{...}
{title:Description}

{pstd}
{cmd:test} performs the Wald test of the hypothesis or hypotheses that you
specify.

{pstd}
{cmd:test} is a standard postestimation command and works after {cmd:sem} just
as it does after any other estimation command except that you must use the
{cmd:_b[]} coefficient notation; you cannot refer to variables using shortcuts
to obtain coefficients on variables. 

{pstd}
See {helpb test:[R] test}.  Also documented there is {cmd:testparm}.  That
command is not relevant after estimation by {cmd:sem} because its syntax
hinges on use of shortcuts for referring to coefficients.


{marker options}{...}
{title:Options}

{phang}
See {it:{help test##options_test:Options for test}} in {helpb test:[R] test}.


{marker remarks}{...}
{title:Remarks}

{pstd}    
See {findalias sembequal} and {findalias semcorr}.

{pstd}    
{cmd:test} works in the metric of SEM, which is to say, path
coefficients, variances, and covariances.  If you want to frame your tests
in terms of standardized coefficients and correlations, prefix {cmd:test}
with {cmd:estat stdize:}; see {helpb sem_estat_stdize:[SEM] estat stdize}.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse sem_2fmm}{p_end}
{phang2}{cmd:. sem (Affective -> a1 a2 a3 a4 a5) (Cognitive -> c1 c2 c3 c4 c5)}{p_end}

{pstd}Show coefficient legend{p_end}
{phang2}{cmd:. sem, coeflegend}{p_end}

{pstd}Test that all coefficients for Affective are zero{p_end}
{phang2}{cmd:. test _b[a1:Affective] = _b[a2:Affective] = _b[a3:Affective]}{break}
	{cmd: = _b[a4:Affective] = _b[a5:Affective]}{p_end}

{pstd}Test that the error variances for {cmd:a1} and {cmd:a2} are equal{p_end}
{phang2}{cmd:. test _b[var(e.a1):_cons] =  _b[var(e.a2):_cons]}{p_end}


{marker saved_results}{...}
{title:Saved results}

{pstd}
See {it:{help test##saved_results:Saved results}} in
{helpb test:[R] test}.{p_end}
