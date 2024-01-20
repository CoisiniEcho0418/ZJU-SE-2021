{smcl}
{* *! version 1.0.0  07jul2011}{...}
{vieweralsosee "[SEM] sem option noxconditional" "mansection SEM semoptionnoxconditional"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[SEM] sem" "help sem_command"}{...}
{vieweralsosee "[SEM] sem postestimation" "help sem_postestimation"}{...}
{viewerjumpto "Syntax" "sem_option_noxconditional##syntax"}{...}
{viewerjumpto "Description" "sem_option_noxconditional##description"}{...}
{viewerjumpto "Option" "sem_option_noxconditional##option"}{...}
{viewerjumpto "Remarks" "sem_option_noxconditional##remarks"}{...}
{viewerjumpto "Examples" "sem_option_noxconditional##examples"}{...}
{title:Title}

{p2colset 5 40 42 2}{...}
{p2col:{manlink SEM sem option noxconditional} {hline 2}}Computing
means, etc. of observed exogenous variables{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{cmd:sem} {cmd:... }[{cmd:, ...} {opt noxconditional} {cmd:...}]


{marker description}{...}
{title:Description}

{pstd}
{cmd:sem} has an {opt noxconditional} option, which you may rarely wish to
specify.  The option is described below. 


{marker option}{...}
{title:Option}

{phang}
{opt noxconditional} states that you wish to include the means, variances, and
covariances of the observed exogenous variables among the parameters to be
estimated by {cmd:sem}.
 
 
{marker remarks}{...}
{title:Remarks}

{pstd}
In many cases, {cmd:sem} does not include the means, variances, and
covariances of observed exogenous variables among the parameters to be
estimated.  When {cmd:sem} omits them, the estimator of the model is said to
be x conditional.  Rather than estimating the values of the means, variances,
and covariances, {cmd:sem} uses the separately calculated observed values of
those statistics.  {cmd:sem} does this to save time and memory.

{pstd}
{cmd:sem} does not use the x-conditional calculation when it would be
inappropriate.

{pstd}
The {opt noxconditional} option prevents {cmd:sem} from using the x-conditional
calculation.  You specify {opt noxconditional} on the {cmd:sem} command:

{phang2}{cmd:. sem ..., ... noxconditional}{p_end}

{pstd}
Do not confuse the x-conditional calculation with the assumption of
conditional normality discussed in 
{it:{mansection SEM intro3RemarksConditionalnormalitymightbesufficient:Conditional normality might be sufficient}}
in {manlink SEM intro 3}.  The x-conditional calculation is appropriate even
when the assumption of conditional normality is inappropriate.

{pstd}
For further information, see

{phang2}
{mansection SEM semoptionnoxconditionalRemarksWhentospecifynoxconditional:When to specify noxconditional}{p_end}
{phang2}
{mansection SEM semoptionnoxconditionalRemarksOptionforcexconditional(atechnicalnote):Option forcexconditional (a technical note)}{p_end}


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse sem_sm1}{p_end}

{pstd}Fit model using the default x-conditional calculations{p_end}
{phang2}{cmd:. sem (r_occasp <- f_occasp r_intel r_ses f_ses)}{break}
	{cmd: (f_occasp <- r_occasp f_intel f_ses r_ses),}{break}
	{cmd: cov(e.r_occasp*e.f_occasp)}{p_end}

{pstd}Fit means, variances, and covariances of observed exogenous variables{p_end}
{phang2}{cmd:. sem (r_occasp <- f_occasp r_intel r_ses f_ses)}{break}
	{cmd: (f_occasp <- r_occasp f_intel f_ses r_ses),}{break}
	{cmd: cov(e.r_occasp*e.f_occasp) noxconditional}{p_end}
