{smcl}
{* *! version 1.0.1  29jun2011}{...}
{vieweralsosee "[SEM] sem option constraints()" "mansection SEM semoptionconstraints()"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[SEM] sem" "help sem_command"}{...}
{vieweralsosee "[SEM] sem model description options" "help sem_model_options"}{...}
{vieweralsosee "[SEM] sem path notation" "help sem_path_notation"}{...}
{vieweralsosee "[SEM] sem postestimation" "help sem_postestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] constraint" "help constraint"}{...}
{viewerjumpto "Syntax" "sem_option_constraints##syntax"}{...}
{viewerjumpto "Description" "sem_option_constraints##description"}{...}
{viewerjumpto "Remarks" "sem_option_constraints##remarks"}{...}
{viewerjumpto "Examples" "sem_option_constraints##examples"}{...}
{title:Title}

{p2colset 5 39 41 2}{...}
{p2col:{manlink SEM sem option constraints()} {hline 2}}Specifying constraints{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{cmd:sem} {cmd:...} [{cmd:, ...} {cmd:constraints(}{it:#} [{it:#} {cmd:...}
]{cmd:) ...}] 

{pstd}
where {it:#} are constraint numbers.  Constraints are defined by the
{cmd:constraint} command; see {helpb constraint:[R] constraint}. 


{marker description}{...}
{title:Description}

{pstd}
Constraints refer to constraints to be imposed on the estimated parameters of
a model.  These constraints usually come in one of three forms:

{phang2}
1.  Constraints that a parameter such as a path coefficient or variance is
equal to a fixed value such as 1.

{phang2}
2.  Constraints that two or more parameters are equal.

{phang2}
3.  Constraints that two or more parameters are related by a linear equation. 

{pstd}
It is usually easier to specify constraints using {cmd:sem}'s path notation;
see {helpb sem_path_notation##constraints:[SEM] sem path notation}.

{pstd}
{cmd:sem}'s {cmd:constraints()} option provides an alternative way of
specifying constraints. 


{marker remarks}{...}
{title:Remarks}

{pstd}
There is only one case where {cmd:constraints()} might be easier to use than
specifying constraints in the path notation.  You wish to specify that two or
more parameters are related, and then decide you would like to fix the value at
which they are related. 

{pstd}
For example, if you wanted to specify that parameters are equal, you could
type 

{phang2}{cmd:. sem ... (y1 <- x@}{it:c1}{cmd:) (y2 <- x@}{it:c1}{cmd:)     (y3 <- x@}{it:c1}{cmd:)      ...}{p_end}

{pstd}
Using the path notation, you can specify more general relationships, too, such
as 

{phang2}{cmd:. sem ... (y1 <- x@}{it:c1}{cmd:) (y2 <- x@(2*}{it:c1}{cmd:)) (y3 <- x@(3*}{it:c1}{cmd:+1)) ...}{p_end}

{pstd}
Say you now decide you want to fix {it:c1} at value 1.  Using the path
notation, you modify what you previously typed: 

{phang2}{cmd:. sem ... (y1 <- x@1) (y2 <- x@2)     (y3 <- x@4)      ...}{p_end}

{pstd}
Alternatively, you could do the following:

{phang2}{cmd:. constraint 1 _b[y2:x] = 2*_b[y1:x]}{p_end}

{phang2}{cmd:. constraint 2 _b[y3:x] = 3*_b[y1:x] + 1}{p_end}

{phang2}{cmd:. sem ..., ... constraints(1 2)}{p_end}

{phang2}{cmd:. constraint 3 _b[y1:x] = 1}{p_end}

{phang2}{cmd:. sem .., ... constraints(1 2 3)}{p_end}

{pstd}
See {helpb constraint:[R] constraint}.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse sem_2fmm}{p_end}

{pstd}Two-factor measurement model{p_end}
{phang2}{cmd:. sem (Affective -> a1 a2 a3 a4 a5) (Cognitive -> c1 c2 c3 c4 c5)}{p_end}

{pstd}Constrain parameters with the {cmd:@} notation{p_end}
{phang2}{cmd:. sem (Affective -> a1 a2@c1 a3@c1 a4 a5)}{break}
	{cmd: (Cognitive -> c1 c2@c2 c3@c2 c4 c5)}{p_end}

{pstd}Specify same model with the {cmd:constraints()} option{p_end}
{phang2}{cmd:. constraint 1 _b[a2:Affective] = _b[a3:Affective]}{p_end}

{phang2}{cmd:. constraint 2 _b[c2:Cognitive] = _b[c3:Cognitive]}{p_end}

{phang2}{cmd:. sem (Affective -> a1 a2 a3 a4 a5)}{break}
	{cmd: (Cognitive -> c1 c2 c3 c4 c5), constraints(1 2)}{p_end}
