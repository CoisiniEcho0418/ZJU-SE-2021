{smcl}
{* *! version 1.0.1  07jul2011}{...}
{viewerdialog lrtest "dialog lrtest"}{...}
{vieweralsosee "[SEM] lrtest " "mansection SEM lrtest"}{...}
{findalias assemmimic}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[SEM] estat eqtest" "help sem_estat_eqtest"}{...}
{vieweralsosee "[SEM] estat stdize" "help sem_estat_stdize"}{...}
{vieweralsosee "[SEM] sem" "help sem_command"}{...}
{vieweralsosee "[SEM] sem postestimation" "help sem_postestimation"}{...}
{vieweralsosee "[SEM] test" "help sem_test"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] lrtest" "help lrtest"}{...}
{viewerjumpto "Syntax" "sem_lrtest##syntax"}{...}
{viewerjumpto "Description" "sem_lrtest##description"}{...}
{viewerjumpto "Remarks" "sem_lrtest##remarks"}{...}
{viewerjumpto "Examples" "sem_lrtest##examples"}{...}
{viewerjumpto "Saved results" "sem_lrtest##saved_results"}{...}
{title:Title}

{p2colset 5 21 23 2}{...}
{p2col:{manlink SEM lrtest} {hline 2}}Likelihood-ratio test of linear
hypothesis{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

        {cmd:sem ..., ...}{right:(fit constrained or unconstrained model)       }

{phang2}{cmd:estimates store } {it:modelname1}

        {cmd:sem ..., ...}{right:(fit unconstrained or constrained model)       }

{phang2}{cmd:estimates store } {it:modelname2}

{phang2}{cmd:lrtest} {it:modelname1} {it:modelname2}

{pstd}{it:Warning:}  The two models being compared must include the same
observed and latent variables.  Place constraints if necessary to achieve your
goals.  This feature of {cmd:lrtest} is unique when {cmd:lrtest} is used
after {cmd:sem}.


{title:Menu}

{phang}
{bf:Statistics > Structural equation modeling (SEM) > Testing and CIs > Likelihood-ratio tests}


{marker description}{...}
{title:Description}

{pstd}    
{cmd:lrtest} performs a likelihood-ratio test comparing two models. 

{pstd}    
{cmd:lrtest} is a standard postestimation command and works after {cmd:sem}
just as it does after any other estimation command.  See 
{helpb lrtest:[R] lrtest}.


{marker remarks}{...}
{title:Remarks}
    
{pstd}
See {findalias semmimic}.

{pstd}
When using {cmd:lrtest} after {cmd:sem}, you must be careful that the models
being compared have the same observed and latent variables.  For instance, the
following is allowed:


{phang2}{cmd:. sem (L1 -> x1 x2 x3) (L1 <- x4 x5) (x1 <- x4) (x2 <- x5)}{p_end}

{phang2}{cmd:. estimates store m1}{p_end}

{phang2}{cmd:. sem (L1 -> x1 x2 x3) (L1 <- x4 x5)}{p_end}

{phang2}{cmd:. estimates store m2}{p_end}

{phang2}{cmd:. lrtest m1 m2}{p_end}

{pstd}
The above is allowed because both models have the variables {cmd:L1},
{cmd:x1}, ..., {cmd:x5}.  

{pstd}
The following would produce invalid results:
    
{phang2}{cmd:. sem (L1 -> x1 x2 x3) (L1 <- x4 x5) (x1 <- x4) (x2 <- x5)}{p_end}

{phang2}{cmd:. estimates store m1}{p_end}

{phang2}{cmd:. sem (L1 -> x1 x2 x3) (L1 <- x4)}{p_end}

{phang2}{cmd:. estimates store m2}{p_end}

{phang2}{cmd:. lrtest m1 m2}{p_end}

{pstd}
The second model does not include {cmd:x5}, whereas the first
model does.   To run this test correctly, you type 

   
{phang2}{cmd:. sem (L1 -> x1 x2 x3) (L1 <- x4 x5) (x1 <- x4) (x2 <- x5)}{p_end}

{phang2}{cmd:. estimates store m1}{p_end}

{phang2}{cmd:. sem (L1 -> x1 x2 x3) (L1 <- x4 x5@0)}{p_end}

{phang2}{cmd:. estimates store m2}{p_end}

{phang2}{cmd:. lrtest m1 m2}{p_end}


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse sem_mimic1}{p_end}

{pstd}Fit reduced model{p_end}
{phang2}{cmd:. sem (SubjSES -> s_income s_occpres s_socstat)}{break}
	{cmd: (SubjSES <- income occpres)}{p_end}

{pstd}Store results{p_end}
{phang2}{cmd:. estimates store mimic1}{p_end}

{pstd}Fit full model{p_end}
{phang2}{cmd:. sem (SubjSES -> s_income s_occpres s_socstat)}{break}
	{cmd: (SubjSES <- income occpres) (s_income <- income)}{break}
	{cmd: (s_occpres <- occpres)}{p_end}

{pstd}Perform likelihood-ratio test{p_end}
{phang2}{cmd:. lrtest mimic1 .}{p_end}


{marker saved_results}{...}
{title:Saved results}

{pstd}
See {it:{help lrtest##saved_results:Saved results}} in
{helpb lrtest:[R] lrtest}.
{p_end}
