{smcl}
{* *! version 1.2.7  15mar2011}{...}
{viewerdialog dstdize "dialog dstdize"}{...}
{viewerdialog istdize "dialog istdize"}{...}
{vieweralsosee "[R] dstdize" "mansection R dstdize"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[ST] epitab" "help epitab"}{...}
{viewerjumpto "Syntax" "dstdize##syntax"}{...}
{viewerjumpto "Description" "dstdize##description"}{...}
{viewerjumpto "Options for dstdize" "dstdize##options_dstdize"}{...}
{viewerjumpto "Options for istdize" "dstdize##options_istdize"}{...}
{viewerjumpto "Examples" "dstdize##examples"}{...}
{viewerjumpto "Saved results" "dstdize##saved_results"}{...}
{title:Title}

{p2colset 5 20 22 2}{...}
{p2col :{manlink R dstdize} {hline 2}}Direct and indirect standardization{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{phang}
Direct standardization

{p 8 16 2}
{cmd:dstdize} {it:charvar} {it:popvar} {it:stratavars} {ifin}{cmd:,}
{opth by:(varlist:groupvars)} 
[{it:{help dstdize##dstdize_options:dstdize_options}}]

{phang}
Indirect standardization

{p 8 16 2}{cmd:istdize} {it:casevar_s} {it:popvar_s} {it:stratavars} {ifin}
{opt using} {it:{help filename}}{cmd:,} {{opt pop:vars(casevar_p popvar_p)} |
{opt rate(ratevar_p{#|crudevar_p})}} 
[{it:{help dstdize##istdize_options:istdize_options}}]

{synoptset 31 tabbed}{...}
{marker dstdize_options}{...}
{synopthdr :dstdize_options}
{synoptline}
{syntab :Main}
{p2coldent: * {opth "by(varlist:groupvars)"}}study populations{p_end}
{synopt :{opth us:ing(filename)}}use standard population from Stata dataset{p_end}
{synopt :{opt ba:se(#|string)}}use standard population from a value of grouping
variable{p_end}
{synopt :{opt l:evel(#)}}set confidence level; default is {cmd:level(95)}{p_end}

{syntab :Options}
{synopt :{opth sav:ing(filename)}}save computed standard population distribution
as a Stata dataset{p_end}
{synopt :{opth f:ormat(%fmt)}}final summary table display format; default is
{cmd:%10.0g}{p_end}
{synopt :{opt pr:int}}include table summary of standard population in output{p_end}
{synopt :{opt nores}}suppress saving results in {opt r()}{p_end}
{synoptline}
{p2colreset}{...}
{p 4 6 2}* {opt by(groupvars)} is required.{p_end}

{synoptset 31 tabbed}{...}
{marker istdize_options}{...}
{synopthdr :istdize_options}
{synoptline}
{syntab :Main}
{p2coldent: * {opt pop:vars(casevar_p popvar_p)}}for standard population,
{it:casevar_p} is number of cases and {it:popvar_p} is number of individuals{p_end}
{p2coldent : * {opt rate(ratevar_p{#|crudevar_p})}}{it:ratevar_p} is stratum-specific rates and {it:#} or {it:crudevar_p} is the crude case rate value or variable{p_end}
{synopt :{opt l:evel(#)}}set confidence level; default is {cmd:level(95)}{p_end}

{syntab :Options}
{synopt :{opth "by(varlist:groupvars)"}}variables identifying study populations{p_end}
{synopt :{opth f:ormat(%fmt)}}final summary table display format; default is 
{cmd:%10.0g}{p_end}
{synopt :{opt pr:int}}include table summary of standard population in output{p_end}
{synoptline}
{p2colreset}{...}
{p 4 6 2} * Either {opt popvars(casevar_p popvar_p)} or 
{opt rate(ratevar_p{#|crudevar_p})} must be specified.


{title:Menu}

    {title:dstdize} 

{phang2}
{bf:Statistics > Epidemiology and related > Other > Direct standardization}

    {title:istdize}

{phang2}
{bf:Statistics > Epidemiology and related > Other > Indirect standardization}


{marker description}{...}
{title:Description}

{pstd}
{cmd:dstdize} produces standardized rates for {it:charvar}, which are
defined as a weighted average of the stratum-specific rates.  These rates can
be used to compare the characteristic {it:charvar} across different
populations identified by {it:{help varlist:groupvars}}.  Weights used in the
standardization are given by {it:popvar}; the strata across which the weights
are to be averaged are defined by {it:stratavars}.

{pstd}
{cmd:istdize} produces indirectly standardized rates for a study population
based on a standard population.  This standardization method is appropriate
when the stratum-specific rates for the population being studied are either 
unavailable or based on small samples and thus are unreliable.  The
standardization uses the stratum-specific rates of a standard population to
calculate the expected number of cases in the study population(s), sums
them, and then compares them with the actual number of cases observed.  The
standard population is in another Stata data file specified by
{opt using} {it:{help filename}}, and it must contain
{it:popvar} and {it:stratavars}.

{pstd}
In addition to calculating rates, the indirect standardization command
produces point estimates and exact confidence intervals of the study
population's standardized mortality ratio (SMR), if death is the event of
interest, or the standardized incidence ratio (SIR) for studies of incidence.
Here we refer to both ratios as SMR.

{pstd}
{it:casevar_s} is the variable name for the study population's number of
cases (usually deaths).  It must contain integers, and for each group, defined
by {it:groupvar}, each subpopulation identified by {it:stratavars} must have
the same values or missing.

{pstd}
{it:popvar_s} identifies the number of subjects represented by each
observation in the study population.

{pstd}
{it:stratavars} define the strata.


{marker options_dstdize}{...}
{title:Options for dstdize}

{dlgtab:Main}

{phang}
{opth "by(varlist:groupvars)"} is required for the {cmd:dstdize} command; it
specifies the variables identifying the study populations.  If {opt base()} is
also specified, there must be only one variable in the {opt by()} group.  If
you do not have a variable for this option, you can generate one by using
something like {cmd:gen newvar=1} and then use {cmd:newvar} as the argument to
this option.

{phang}
{opth using(filename)} or {opt base(#|string)} may be used to specify the
standard population.  You may not specify both options.  {opt using(filename)}
supplies the name of a {cmd:.dta} file containing the standard population.
The standard population must contain the {it:popvar} and the {it:stratavars}.
If {opt using()} is not specified, the standard population distribution will
be obtained from the data.  {opt base(#|string)} lets you specify one of
the values of {it:{help varlist:groupvar}} -- either a numeric value or a 
string -- to be used as the standard population.  If neither {opt base()}
nor {opt using()} is specified, the entire dataset is used to determine an
estimate of the standard population.

{phang}
{opt level(#)} specifies the confidence level, as a percentage, for a
confidence interval of the adjusted rate.  The default is {cmd:level(95)} or
as set by {helpb set level}.

{dlgtab:Options}

{phang}
{opth saving(filename)} saves the computed standard population distribution as
a Stata dataset that can be used in further analyses.

{phang}
{opth format(%fmt)} specifies the format in which to display the final summary
table.  The default is {cmd:%10.0g}.

{phang}
{opt print} includes a table summary of the standard population before
displaying the study population results.

{phang}
{opt nores} suppresses saving results in {opt r()}.  This option is seldom
specified.  Some saved results are stored in matrices.  If there are more
groups than {cmd:matsize}, {cmd:dstdize} will report "matsize too
small".  Then you can either increase {cmd:matsize} or specify 
{opt nores}.  The {opt nores} option does not change how results are
calculated but specifies that results need not be left behind for use by other
programs.


{marker options_istdize}{...}
{title:Options for istdize}

{dlgtab:Main}

{phang}
{opt popvars(casevar_p popvar_p)} or
{opt rate(ratevar_p #|ratevar_p crudevar_p)} must be specified with 
{cmd:istdize}.  Only one of these two options is allowed.  These options are
used to describe the standard population's data.

{pmore}
With {opt popvars(casevar_p popvar_p)}, {it:casevar_p} records the
number of cases (deaths) for each stratum in the standard population, and
{it:popvar_p} records the total number of individuals in each stratum
(individuals at risk).

{pmore}
With {opt rate(ratevar_p{#|crudevar_p})}, {it:ratevar_p} contains the
stratum-specific rates.  {it:#}|{it:crudevar_p} specifies the crude case rate
either by a variable name or by the crude case rate value.  If a
crude rate variable is used, it must be the same for all observations,
although it could be missing for some.

{phang}
{opt level(#)} specifies the confidence level, as a percentage, for a
confidence interval of the adjusted rate.  The default is {cmd:level(95)} or
as set by {helpb set level}.


{dlgtab:Options}

{phang}
{opth "by(varlist:groupvars)"} specifies variables identifying study
populations when more than one exists in the data.  If this option is not
specified, the entire study population is treated as one group.

{phang} {opth format(%fmt)} specifies the format in which to display the final
summary table.  The default is {cmd:%10.0g}.

{phang}
{opt print} outputs a table summary of the standard population before
displaying the study population results.


{marker examples}{...}
{title:Examples}

    {hline}
{pstd}Setup{p_end}
{phang2}{cmd:. webuse hbp}{p_end}
{phang2}{cmd:. generate pop = 1}{p_end}

{pstd}Obtain standardized rates of {cmd:hbp} by {cmd:city} and {cmd:year},
using the {cmd:age}, {cmd:race}, and {cmd:sex} distribution of the cities
and years combined as the standard{p_end}
{phang2}{cmd:. dstdize hbp pop age race sex, by(city year)}{p_end}

    {hline}
{pstd}Setup{p_end}
{phang2}{cmd:. webuse kahn, clear}{p_end}

{pstd}Obtain mortality rates by {cmd:state} using the standard population
saved in {cmd:popkahn.dta}{p_end}
{phang2}{cmd:. istdize death pop age using}
       {cmd:http://www.stata-press.com/data/r12/popkahn,}
       {cmd:by(state) pop(deaths pop) print}{p_end}
    {hline}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:dstdize} saves the following in {cmd:r()}:

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Scalars}{p_end}
{synopt:{cmd:r(k)}}number of populations{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Macros}{p_end}
{synopt:{cmd:r(by)}}variable names specified in {cmd:by()}{p_end}
{synopt:{cmd:r(c}{it:#}{cmd:)}}values of {cmd:r(by)} for {it:#}th group{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Matrices}{p_end}
{synopt:{cmd:r(se)}}standard errors of adjusted rates{p_end}
{synopt:{cmd:r(ub)}}upper bounds of confidence intervals for adjusted
	rates{p_end}
{synopt:{cmd:r(lb)}}lower bounds of confidence intervals for adjusted
	rates{p_end}
{synopt:{cmd:r(Nobs)}}1 x k vector of number of observations{p_end}
{synopt:{cmd:r(crude)}}1 x k vector of crude rates (*){p_end}
{synopt:{cmd:r(adj)}}1 x k vector of adjusted rates (*){p_end}
{synopt:}{space 2}(*) If, in a group, the number of observations is 0, then 9
	is stored for the corresponding crude and adjusted rates.{p_end}
{p2colreset}{...}
