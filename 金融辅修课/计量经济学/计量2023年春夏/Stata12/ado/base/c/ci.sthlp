{smcl}
{* *! version 1.1.5  11feb2011}{...}
{viewerdialog ci "dialog ci"}{...}
{viewerdialog "cii (binomial)" "dialog cii_binomial"}{...}
{viewerdialog "cii (normal)" "dialog cii_normal"}{...}
{viewerdialog "cii (poisson)" "dialog cii_poisson"}{...}
{vieweralsosee "[R] ci" "mansection R ci"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] ameans" "help ameans"}{...}
{vieweralsosee "[R] bitest" "help bitest"}{...}
{vieweralsosee "[R] centile" "help centile"}{...}
{vieweralsosee "[D] pctile" "help pctile"}{...}
{vieweralsosee "[R] prtest" "help prtest"}{...}
{vieweralsosee "[R] summarize" "help summarize"}{...}
{vieweralsosee "[R] ttest" "help ttest"}{...}
{viewerjumpto "Syntax" "ci##syntax"}{...}
{viewerjumpto "Description" "ci##description"}{...}
{viewerjumpto "Options" "ci##options"}{...}
{viewerjumpto "Examples" "ci##examples"}{...}
{viewerjumpto "Saved results" "ci##saved_results"}{...}
{viewerjumpto "References" "ci##references"}{...}
{title:Title}

{p2colset 5 15 17 2}{...}
{p2col :{manlink R ci} {hline 2}}Confidence intervals for means, proportions,
and counts{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{phang}Syntax for ci

{p 8 11 2}
{cmd:ci} [{varlist}] 
{ifin}
{weight}
[{cmd:,} {it:{help ci##table_options:options}}]


{phang}Immediate command for variable distributed as normal

{p 8 12 2}
{cmd:cii} {it:#obs} {it:#mean} {it:#sd} [{cmd:,} 
{it:{help ci##ciin_option:ciin_option}}] 


{phang}Immediate command for variable distributed as binomial

{p 8 12 2}
{cmd:cii} {it:#obs} {it:#succ} [{cmd:,}
{it:{help ci##ciib_options:ciib_options}}] 


{phang}Immediate command for variable distributed as Poisson

{p 8 12 2}
{cmd:cii} {it:#exposure} {it:#events} {cmd:,} {cmdab:p:oisson} 
[{it:{help ci##ciip_options:ciip_options}}] 


{synoptset 21 tabbed}{...}
{marker table_options}
{synopthdr}
{synoptline}
{syntab:Main}
{synopt :{opt b:inomial}}binomial 0/1 variables; compute exact confidence
intervals{p_end}
{synopt :{opt p:oisson}}Poisson variables; compute exact confidence
intervals{p_end}
{synopt :{opth e:xposure(varname)}}exposure variable; 
implies {opt poisson}{p_end}
{synopt :{opt exa:ct}}calculate exact confidence intervals; the default{p_end}
{synopt :{opt wa:ld}}calculate Wald confidence intervals{p_end}
{synopt :{opt w:ilson}}calculate Wilson confidence intervals{p_end}
{synopt :{opt a:gresti}}calculate Agresti-Coull confidence intervals{p_end}
{synopt :{opt j:effreys}}calculate Jeffreys confidence intervals{p_end}
{synopt :{opt t:otal}}add output for all groups combined (for use with {opt by}
only){p_end}
{synopt :{opt sep:arator(#)}}draw separator line after every {it:#} variables;
default is {cmd:separator(5)}{p_end}
{synopt :{opt l:evel(#)}}set confidence level; default is {cmd:level(95)}{p_end}
{synoptline}
{p2colreset}{...}
{p 4 6 2}
{opt by} is allowed with {cmd:ci}; see {manhelp by D}.{p_end}
{p 4 6 2}
{opt aweight}s and {opt fweight}s are allowed, but {opt aweight}s may not be
specified with the {opt binomial} or {opt poisson} option, see {help weight}.
{p_end}

{synoptset 21}{...}
{marker ciin_option}{...}
{synopthdr :ciin_option}
{synoptline}
{synopt :{opt l:evel(#)}}set confidence level; default is {cmd:level(95)}{p_end}
{p2line}
{p2colreset}{...}

{synoptset 21}{...}
{marker ciib_options}{...}
{synopthdr :ciib_options}
{synoptline}
{synopt :{opt l:evel(#)}}set confidence level; default is {cmd:level(95)}{p_end}
{synopt :{opt exa:ct}}calculate exact confidence intervals; the default{p_end}
{synopt :{opt wa:ld}}calculate Wald confidence intervals{p_end}
{synopt :{opt w:ilson}}calculate Wilson confidence intervals{p_end}
{synopt :{opt a:gresti}}calculate Agresti-Coull confidence intervals{p_end}
{synopt :{opt j:effreys}}calculate Jeffreys confidence intervals{p_end}
{synoptline}
{p2colreset}{...}

{synoptset 21 tabbed}{...}
{marker ciip_options}{...}
{synopthdr :ciip_options}
{synoptline}
{p2coldent :* {opt p:oisson}}numbers are Poisson-distributed counts{p_end}
{synopt :{opt l:evel(#)}}set confidence level; default is {cmd:level(95)}{p_end}
{synoptline}
{p2colreset}{...}
{p 4 6 2}
* {opt poisson} is required.


{title:Menu}

    {title:ci} 

{phang2}
{bf:Statistics > Summaries, tables, and tests >}
     {bf:Summary and descriptive statistics > Confidence intervals}

    {title:cii for variable distributed as normal}

{phang2}
{bf:Statistics > Summaries, tables, and tests >}
      {bf:Summary and descriptive statistics > Normal CI calculator}

    {title:cii for variable distributed as binomial}

{phang2}
{bf:Statistics > Summaries, tables, and tests >}
       {bf:Summary and descriptive statistics > Binomial CI calculator}

    {title:cii for variable distributed as Poisson}

{phang2}
{bf:Statistics > Summaries, tables, and tests >}
        {bf:Summary and descriptive statistics > Poisson CI calculator}


{marker description}{...}
{title:Description}

{pstd}
{cmd:ci} computes standard errors and confidence intervals for each of the
variables in {varlist}.

{pstd}
{cmd:cii} is the immediate form of {cmd:ci}; see {help immed} for a general
discussion of immediate commands.

{pstd}
In the binomial and Poisson variants of {cmd:cii}, the second number specified
({it:#succ} or {it:#events}) must be an integer or between 0 and 1.  If the
number is between 0 and 1, Stata interprets it as the fraction of successes or
events and converts it to an integer number representing the number of
successes or events.  The computation then proceeds as if two integers had
been specified.


{marker options}{...}
{title:Options}

{dlgtab:Main}

{phang}
{opt binomial} tells {cmd:ci} that the variables are 0/1 variables and that
binomial confidence intervals will be calculated. ({cmd:cii} produces binomial
confidence intervals when only two numbers are specified.)

{phang}
{opt poisson} specifies that the variables (or numbers for {cmd:cii}) are
Poisson-distributed counts; exact Poisson confidence intervals will be
calculated.

{phang}
{opth exposure(varname)} is used only with {opt poisson}.  You do not need
to specify {opt poisson} if you specify {opt exposure()};
{opt poisson} is assumed. {it:varname} contains the total exposure (typically a
time or an area) during which the number of events recorded in {varlist} were
observed.

{phang}
{opt exact}, {opt wald}, {opt wilson}, {opt agresti}, and {opt jeffreys}
specify that variables are 0/1 and specify how binomial confidence intervals
are to be calculated.

{pmore}
{opt exact} is the default and specifies exact (also known in the literature
as Clopper-Pearson [{help ci##CP1934:1934}]) binomial confidence intervals.

{pmore}
{opt wald} specifies calculation of Wald confidence intervals.

{pmore}
{opt wilson} specifies calculation of Wilson confidence intervals.

{pmore}
{opt agresti} specifies calculation of Agresti-Coull confidence intervals.

{pmore}
{opt jeffreys} specifies calculation of Jeffreys confidence intervals.

{pmore}
See {help ci##BCD2001:Brown, Cai, and DasGupta (2001)} for a discussion and
comparison of the different binomial confidence intervals.

{phang}
{opt total} is for use with the {opt by} prefix. It requests that, in addition
to output for each by-group, output be added for all groups combined.

{phang}
{opt separator(#)} specifies how often separation lines should be inserted
into the output.  The default is {cmd:separator(5)}, meaning that a line is
drawn after every five variables.  {cmd:separator(10)} would draw the line
after every 10 variables. {cmd:separator(0)} suppresses the separation line.

{phang}
{opt level(#)} specifies the confidence level, as a percentage, for confidence
intervals.  The default is {cmd:level(95)} or as set by {helpb set level}.


{marker examples}{...}
{title:Examples}

    {hline}
{pstd}Setup{p_end}
{phang2}{cmd:. sysuse auto}

{pstd}Obtain normal-approximation 90% confidence intervals for means{p_end}
{phang2}{cmd:. ci mpg price, level(90)}

    {hline}
{pstd}Setup{p_end}
{phang2}{cmd:. webuse promonone}

{pstd}Obtain various binomial confidence intervals for proportions{p_end}
{phang2}{cmd:. ci promoted, binomial}{p_end}
{phang2}{cmd:. ci promoted, binomial wilson}{p_end}
{phang2}{cmd:. ci promoted, binomial agresti}{p_end}
{phang2}{cmd:. ci promoted, binomial jeffreys}

    {hline}
{pstd}Setup{p_end}
{phang2}{cmd:. webuse petri}

{pstd}Obtain exact Poisson confidence interval for a count variable{p_end}
{phang2}{cmd:. ci count, poisson}

    {hline}
{pstd}Setup{p_end}
{phang2}{cmd:. webuse rm}{p_end}

{pstd}Obtain confidence intervals for total exposure variables{p_end}
{phang2}{cmd:. ci deaths, exposure(pyears)}

{pstd}Obtain confidence intervals for mean for data with 166 observations,
mean=19509, and sd=4379{p_end}
{phang2}{cmd:. cii 166 19509 4379}

{pstd}Same as above, but obtain 90% confidence intervals{p_end}
{phang2}{cmd:. cii 166 19509 4379, level(90)}

{pstd}Obtain binomial confidence intervals for data with 10 binomial events
and 1 observed success{p_end}
{phang2}{cmd:. cii 10 1}

{pstd}Same as above, but obtain the Wilson confidence interval{p_end}
{phang2}{cmd:. cii 10 1, wilson}

{pstd}Obtain Poisson confidence intervals for data with 1 exposure and 27
events{p_end}
{phang2}{cmd:. cii 1 27, poisson}{p_end}
    {hline}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:ci} and {cmd:cii} saves the following in {cmd:r()}:

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Scalars}{p_end}
{synopt:{cmd:r(N)}}number of observations or exposure{p_end}
{synopt:{cmd:r(mean)}}mean{p_end}
{synopt:{cmd:r(se)}}estimate of standard error{p_end}
{synopt:{cmd:r(lb)}}lower bound of confidence interval{p_end}
{synopt:{cmd:r(ub)}}upper bound of confidence interval{p_end}
{p2colreset}{...}


{marker references}{...}
{title:References}

{marker BCD2001}{...}
{phang}
Brown, L. D., T. T. Cai, and A. DasGupta. 2001.  
Interval estimation for a binomial proportion. 
{it:Statistical Science} 16: 101-133.

{marker CP1934}{...}
{phang}
Clopper, C. J., and E. S. Pearson. 1934.  The
use of confidence or fiducial limits illustrated in the case of the binomial.  
{it:Biometrika} 26: 404-413.
{p_end}
