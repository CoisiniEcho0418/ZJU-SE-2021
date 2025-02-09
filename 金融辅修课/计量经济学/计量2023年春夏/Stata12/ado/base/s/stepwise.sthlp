{smcl}
{* *! version 1.1.7  17may2011}{...}
{viewerdialog stepwise "dialog stepwise"}{...}
{vieweralsosee "[R] stepwise" "mansection R stepwise"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] nestreg" "help nestreg"}{...}
{viewerjumpto "Syntax" "stepwise##syntax"}{...}
{viewerjumpto "Description" "stepwise##description"}{...}
{viewerjumpto "Options" "stepwise##options"}{...}
{viewerjumpto "Examples" "stepwise##examples"}{...}
{viewerjumpto "Programming for stepwise" "stepwise##programming"}{...}
{viewerjumpto "Saved results" "stepwise##saved_results"}{...}
{title:Title}

{p2colset 5 21 23 2}{...}
{p2col:{manlink R stepwise} {hline 2}}Stepwise estimation{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 18 2}
{cmd:stepwise}
	[{cmd:,}
		{it:options}]
	{cmd::} {it:{help stepwise##command:command}}

{synoptset 18 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:Model}
{p2coldent:* {opt pr(#)}}significance
	level for removal from the model{p_end}
{p2coldent:* {opt pe(#)}}significance
	level for addition to the model{p_end}

{syntab:Model2}
{synopt:{opt forw:ard}}perform forward-stepwise selection{p_end}
{synopt:{opt hier:archical}}perform hierarchical selection{p_end}
{synopt:{opt loc:kterm1}}keep the first term{p_end}
{synopt:{opt lr}}perform likelihood-ratio test instead of Wald test{p_end}

{syntab:Reporting}
{synopt :{it:{help stepwise##display_options:display_options}}}control
    column formats and line width{p_end}
{synoptline}
{p2colreset}{...}
{p 4 6 2}
* At least one of {opt pr(#)} or {opt pe(#)} must be specified.{p_end}
{p 4 6 2}
{cmd:by} and {cmd:xi} are allowed; see {help prefix}.{p_end}
{p 4 6 2}
Weights are allowed if {it:command} allows them; see {help weight}.{p_end}
{p 4 6 2}
All postestimation commands behave as they would after {it:command} without
the {opt stepwise} prefix; see the postestimation manual entry for
{it:command}.
{p_end}


{title:Menu}

{phang}
{bf:Statistics > Other > Stepwise estimation}


{marker description}{...}
{title:Description}

{pstd}
{opt stepwise} performs stepwise estimation.  Typing

{pin}
{cmd:. stepwise,} {opt pr(#)}{cmd::} {it:command}

{pstd}
performs backward-selection estimation for {it:command}.  The stepwise
selection method is determined by the following option combinations:

{synoptset 24}{...}
{synopthdr}
{synoptline}
{synopt:{opt pr(#)}}backward selection{p_end}
{synopt:{opt pr(#)} {opt hierarchical}}backward hierarchical selection{p_end}
{synopt:{opt pr(#)} {opt pe(#)}}backward stepwise{p_end}

{synopt:{opt pe(#)}}forward selection{p_end}
{synopt:{opt pe(#)} {opt hierarchical}}forward hierarchical selection{p_end}
{synopt:{opt pr(#)} {opt pe(#)} {opt forward}}forward stepwise{p_end}
{synoptline}
{p2colreset}{...}

{marker command}{...}
{pstd}
{it:command} defines the estimation command to be executed.  The following
Stata commands are supported by {cmd:stepwise}.

{pmore}
{helpb clogit},
{helpb cloglog},
{helpb glm},
{helpb intreg},
{helpb logistic},
{helpb logit},
{helpb nbreg},
{helpb ologit},
{helpb oprobit},
{helpb poisson},
{helpb probit},
{helpb qreg},
{helpb regress},
{helpb scobit},
{helpb stcox},
{helpb stcrreg},
{helpb streg},
{helpb tobit}

{pstd}
{cmd:stepwise} expects {it:command} to have the following form:

{p 8 21 2}
{it:command_name} [{depvar}] {it:term} [{it:term} ...] {ifin} {weight}
[{cmd:,} {it:command_options}]

{pstd}
where {it:term} is either {varname} or {opth (varlist)} (a
{it:varlist} in parentheses indicates that this group of variables is to be
included or excluded together).  {it:depvar} is not present when
{it:command_name} is {helpb stcox}, {helpb stcrreg}, or {helpb streg};
otherwise, {it:depvar} is assumed to be present.  For {helpb intreg},
{it:depvar} is actually two dependent variable names ({it:depvar1} and
{it:depvar2}).

{pstd}
{cmd:sw} is a synonym for {cmd:stepwise}.


{marker options}{...}
{title:Options}

{dlgtab:Model}

{phang}
{opt pr(#)} specifies the significance level for removal
from the model; terms with p>={opt pr()} are eligible for removal.

{phang}
{opt pe(#)} specifies the significance level for addition to
the model; terms with p<{opt pe()} are eligible for addition.

{dlgtab:Model2}

{phang}
{opt forward} specifies the forward-stepwise method and may be specified only 
when both {opt pr()} and {opt pe()} are also specified.  Specifying both
{opt pr()} and {opt pe()} without {opt forward} results in backward-stepwise
selection.  Specifying only {opt pr()} results in backward selection, and
specifying only {opt pe()} results in forward selection.

{phang}
{opt hierarchical} specifies hierarchical selection.

{phang}
{opt lockterm1} specifies that the first term be included in the
model and not be subjected to the selection criteria.

{phang}
{opt lr} specifies the test of term significance be the
likelihood-ratio test.  The default is the less computationally expensive Wald
test; that is, the test is based on the estimated variance{c -}covariance
matrix of the estimators.

{dlgtab:Reporting}

{marker display_options}{...}
{phang}
{it:display_options}:
{opth cformat(%fmt)},
{opt pformat(%fmt)},
{opt sformat(%fmt)}, and
{opt nolstretch};
    see {helpb estimation options##display_options:[R] estimation options}.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. sysuse auto}{p_end}
{phang2}{cmd:. generate weight2 = weight^2}

{pstd}Backward selection{p_end}
{phang2}{cmd:. stepwise, pr(.2): regress mpg weight weight2 displ gear turn}
          {cmd:headroom foreign price}{p_end}

{pstd}Backward selection; consider engine displacement and gear ratio
together{p_end}
{phang2}{cmd:. stepwise, pr(.2): regress mpg weight weight2 (displ gear) turn}
          {cmd:headroom foreign price}{p_end}

{pstd}Backward selection; force {cmd:weight} to be included in model{p_end}
{phang2}{cmd:. stepwise, pr(.2) lockterm1: regress mpg weight weight2 displ}
          {cmd:gear turn headroom foreign price}{p_end}

{pstd}Backward selection; force {cmd:weight} and {cmd:weight2} to be included
in model{p_end}
{phang2}{cmd:. stepwise, pr(.2) lockterm1: regress mpg (weight weight2) displ}
         {cmd:gear turn headroom foreign price}{p_end}

{pstd}Backward hierarchical selection{p_end}
{phang2}{cmd:. stepwise, pr(.2) hierarchical: regress mpg weight weight2}
         {cmd:displ gear turn headroom foreign}{p_end}

{pstd}Forward selection{p_end}
{phang2}{cmd:. stepwise, pe(.2): regress mpg weight weight2 displ gear turn}
         {cmd:headroom foreign price}{p_end}

{pstd}Forward hierarchical selection{p_end}
{phang2}{cmd:. stepwise, pe(.2) hierarchical: regress mpg weight weight2 displ}
        {cmd:gear turn headroom foreign price}{p_end}


{marker programming}{...}
{title:Programming for stepwise}

{pstd}
{cmd:stepwise} requires that {it:command_name} follow
{help language:standard Stata syntax} and allow the {helpb if} qualifier.
Furthermore, {it:command_name} must have {opt sw} or {opt swml} as a program
property; see {manhelp program_properties P:program properties}.  If
{it:command_name} has {opt swml} as a property, {it:command_name} must save
the log-likelihood value in {cmd:e(ll)} and model degrees of freedom in
{cmd:e(df_m)}.


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:stepwise} saves whatever is saved by the underlying estimation command.

{pstd}
Also, {cmd:stepwise} saves {cmd:stepwise} in {cmd:e(stepwise)}.
