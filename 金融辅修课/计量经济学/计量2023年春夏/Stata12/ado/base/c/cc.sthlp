{smcl}
{* *! version 1.1.7  10jun2011}{...}
{viewerdialog cc "dialog cc"}{...}
{viewerdialog cci "dialog cci"}{...}
{vieweralsosee "[ST] epitab" "mansection ST epitab"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] bitest" "help bitest"}{...}
{vieweralsosee "[R] ci" "help ci"}{...}
{vieweralsosee "[R] dstdize" "help dstdize"}{...}
{vieweralsosee "[R] glogit" "help glogit"}{...}
{vieweralsosee "[R] logistic" "help logistic"}{...}
{vieweralsosee "[R] tabulate twoway" "help tabulate_twoway"}{...}
{vieweralsosee "[U] 19 Immediate commands" "help immed"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[ST] Glossary" "help st_glossary"}{...}
{viewerjumpto "Syntax" "cc##syntax"}{...}
{viewerjumpto "Description" "cc##description"}{...}
{viewerjumpto "Options for cc" "cc##options_cc"}{...}
{viewerjumpto "Options for cci" "cc##options_cci"}{...}
{viewerjumpto "Examples" "cc##examples"}{...}
{viewerjumpto "Saved results" "cc##saved_results"}{...}
{viewerjumpto "References" "cc##references"}{...}
{title:Title}

{p2colset 5 20 22 2}{...}
{p2col :{manlink ST epitab} {hline 2}}Tables for epidemiologists (cc and cci)
{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 14 2}{cmd:cc} {it:var_case var_exposed} {ifin} {weight} 
[{cmd:,} {it:{help cc##cc_options:cc_options}}]

{p 8 14 2}{cmd:cci} {it:#a #b #c #d} [{cmd:,} {it:{help cc##cci_options:cci_options}}]

{synoptset 24 tabbed}{...}
{marker cc_options}{...}
{synopthdr:cc_options}
{synoptline}
{syntab:Options}
{synopt :{cmd:by(}{varname} [{cmd:,} {opt mis:sing}]{cmd:)}}stratify on {it:varname}{p_end}
{synopt :{opt es:tandard}}combine external weights with within-stratum statistics{p_end}
{synopt :{opt is:tandard}}combine internal weights with within-stratum statistics{p_end}
{synopt :{opth s:tandard(varname)}}combine user-specified weights with within-stratum statistics{p_end}
{synopt :{opt p:ool}}display pooled estimate{p_end}
{synopt :{opt noc:rude}}do not display crude estimate{p_end}
{synopt :{opt noh:om}}do not display homogeneity test{p_end}
{synopt :{opt bd}}perform Breslow-Day homogeneity test{p_end}
{synopt :{opt tarone}}perform Tarone's homogeneity test{p_end}
{synopt :{opth b:inomial(varname)}}number of subjects variable{p_end}
{synopt :{opt co:rnfield}}use Cornfield approximation to calculate CI of the odds ratio{p_end}
{synopt :{opt w:oolf}}use Woolf approximation to calculate SE and CI of the odds ratio{p_end}
{synopt :{opt tb}}calculate test-based confidence intervals{p_end}
{synopt :{opt e:xact}}calculate Fisher's exact p{p_end}
{synopt :{opt l:evel(#)}}set confidence level; default is {cmd:level(95)}{p_end}
{synoptline}
{p2colreset}{...}

{synoptset 21}{...}
{marker cci_options}{...}
{synopthdr :cci_options}
{synoptline}
{synopt :{opt co:rnfield}}use Cornfield approximation to calculate CI of the odds ratio{p_end}
{synopt :{opt w:oolf}}use Woolf approximation to calculate SE and CI of the odds ratio{p_end}
{synopt :{opt tb}}calculate test-based confidence intervals{p_end}
{synopt :{opt e:xact}}calculate Fisher's exact p{p_end}
{synopt :{opt l:evel(#)}}set confidence level; default is {cmd:level(95)}{p_end}
{synoptline}
{p2colreset}{...}
{p 4 6 2}{opt fweight}s are allowed; see {help weight}.


{title:Menu}

    {title:cc}

{phang2}
{bf:Statistics > Epidemiology and related > Tables for epidemiologists >}
      {bf:Case-control odds ratio}

    {title:cci}

{phang2}
{bf:Statistics > Epidemiology and related > Tables for epidemiologists >}
       {bf:Case-control odds-ratio calculator}


{marker description}{...}
{title:Description}

{pstd}
{cmd:cc} is used with case-control and cross-sectional data.  Point estimates
and confidence intervals for the odds ratio are calculated, along with
attributable or prevented fractions for the exposed and total population.
{cmd:cci} is the immediate form of {cmd:cc}; see {help immed}.  Also see
{manhelp logistic R} and {manhelp glogit R} for related commands.


{marker options_cc}{...}
{title:Options for cc}

{dlgtab:Options}

{phang}
{cmd:by(}{it:varname} [{cmd:,} {opt missing}]{cmd:)} specifies that the tables
be stratified on {it:varname}.  Missing categories in {it:varname} are omitted
from the stratified analysis, unless option {cmd:missing} is specified within
{cmd:by()}.  Within-stratum statistics are shown and then combined with
Mantel-Haenszel weights.  If {opt estandard}, {opt istandard}, or
{cmd:standard()} is also specified (see below), the weights specified are used
in place of Mantel-Haenszel weights.

{phang}
{opt estandard}, {opt istandard}, and {opth standard(varname)}
request that within-stratum statistics be combined with 
external, internal, or user-specified weights to produce a standardized 
estimate.  These options are mutually exclusive and can be used only when 
{opt by()} is also specified.  (When {opt by()} is specified without one of 
these options, Mantel-Haenszel weights are used.)

{pmore}
{opt estandard} external weights are the number of unexposed controls.

{pmore}
{cmd:istandard} internal weights are the number of exposed
controls.  {opt istandard} can be used to produce, among other things,
standardized mortality ratios (SMRs).

{pmore}
{opt standard(varname)} allows user-specified weights.  {it:varname} 
must contain a constant within stratum and be nonnegative.  The scale of 
{it:varname} is irrelevant.

{phang}
{opt pool} specifies that, in a stratified 
analysis, the directly pooled estimate also be displayed.  The pooled estimate 
is a weighted average of the stratum-specific estimates using inverse-variance 
weights, which are the inverse of the variance of the stratum-specific estimate.
{opt pool} is relevant only if {opt by()} is also specified.

{phang}
{opt nocrude} specifies that in a stratified
analysis the crude estimate -- an estimate obtained without regard to 
strata -- not be displayed.  {opt nocrude} is relevant only if {opt by()} 
is also specified.

{phang}
{opt nohom} specifies that a chi-squared 
test of homogeneity not be included in the output of a stratified analysis.  
This tests whether the exposure effect is the same across strata and can be 
performed for any pooled estimate -- directly pooled or Mantel-Haenszel.  
{opt nohom} is relevant only if {opt by()} is also specified.

{phang}
{opt bd} specifies that Breslow and Day's chi-squared test of 
homogeneity be included in the output of a stratified analysis.  This tests 
whether the exposure effect is the same across strata.  {opt bd} is relevant 
only if {opt by()} is also specified.

{phang}
{opt tarone} specifies that Tarone's chi-squared test of homogeneity, which is
a correction to the Breslow-Day test, be included in the output of a
stratified analysis.  This tests whether the exposure effect is the same
across strata.  {opt tarone} is relevant only if {opt by()} is also specified.

{phang}
{opth binomial(varname)} supplies the 
number of subjects (cases plus controls) for binomial frequency records.  For 
individual and simple frequency records, this option is not used.

{phang}
{opt cornfield} requests that the 
{help cc##C1956:Cornfield (1956)} approximation be used to calculate the
confidence interval of the odds ratio.  By default, {cmd:cc} reports an exact
interval. 

{phang}
{opt woolf} requests that the
{help cc##W1955:Woolf (1955)} approximation, also known as the Taylor
expansion, be used for calculating the standard error and confidence interval
for the odds ratio.  By default, {cmd:cc} reports an exact interval.

{phang}
{opt tb} requests that test-based confidence intervals
({help cc##M1976:Miettinen 1976}) be calculated wherever
appropriate in place of confidence intervals based on other approximations or
exact confidence intervals.  We recommend that test-based confidence intervals
be used only for pedagogical purposes and never for research work.

{phang}
{opt exact} requests that Fisher's exact 
p be calculated rather than the chi-squared and its significance level.  We
recommend specifying {opt exact} whenever samples are small.
When the least-frequent cell contains 1,000 cases or more, there will be no
appreciable difference between the exact significance level and the
significance level based on the chi-squared, but the exact significance level
will take considerably longer to calculate.  {opt exact} does not affect
whether exact confidence intervals are calculated.  Commands always calculate
exact confidence intervals where they can, unless {opt cornfield}, {opt woolf},
or {opt tb} is specified.

{phang}
{opt level(#)} specifies the confidence level, as a 
percentage, for confidence intervals.  The default is {cmd:level(95)} or as 
set by {helpb set level}.


{marker options_cci}{...}
{title:Options for cci}

{phang}
{opt cornfield} requests that the 
{help cc##C1956:Cornfield (1956)} approximation be used to calculate the
confidence interval of the odds ratio.  By default, {cmd:cci} reports an exact
interval. 

{phang}
{opt woolf} requests that the
{help cc##W1955:Woolf (1955)} approximation, also known as the Taylor
expansion, be used for calculating the standard error and confidence interval
for the odds ratio.  By default, {cmd:cci} reports an exact interval.

{phang}
{opt tb} requests that test-based confidence intervals
({help cc##M1976:Miettinen 1976}) be calculated wherever
appropriate in place of confidence intervals based on other approximations or
exact confidence intervals.  We recommend that test-based confidence intervals
be used only for pedagogical purposes and never for research work.

{phang}
{opt exact} requests that Fisher's exact 
p be calculated rather than the chi-squared and its significance level.  We
recommend specifying {opt exact} whenever samples are small.  
When the least-frequent cell contains 1,000 cases or more, there will be no
appreciable difference between the exact significance level and the
significance level based on the chi-squared, but the exact significance level
will take considerably longer to calculate.  {opt exact} does not affect
whether exact confidence intervals are calculated.  Commands always calculate
exact confidence intervals where they can, unless {opt cornfield}, {opt woolf},
or {opt tb} is specified.

{phang}
{opt level(#)} specifies the confidence level, as a 
percentage, for confidence intervals.  The default is {cmd:level(95)} or as 
set by {helpb set level}.


{marker examples}{...}
{title:Examples}

    {hline}
{pstd}Setup{p_end}
{phang2}{cmd:. webuse ccxmpl}

{pstd}List the data{p_end}
{phang2}{cmd:. list}

{pstd}Calculate odds ratio, etc.{p_end}
{phang2}{cmd:. cc case exposed [fw=pop]}

{pstd}Immediate form of above command{p_end}
{phang2}{cmd:. cci 4 386 4 1250}

{pstd}Same as above, but calculate Fisher's exact p rather than the
chi-squared{p_end}
{phang2}{cmd:. cci 4 386 4 1250, exact}

    {hline}
{pstd}Setup{p_end}
{phang2}{cmd:. webuse downs}

{pstd}List the data{p_end}
{phang2}{cmd:. list}

{pstd}Perform stratified analysis of the odds ratio{p_end}
{phang2}{cmd:. cc case exposed [fw=pop], by(age)}

{pstd}Same as above, but report test-based confidence intervals{p_end}
{phang2}{cmd:. cc case exposed [fw=pop], by(age) tb}

{pstd}Same as above, but also report Tarone's chi-squared test of
homogeneity{p_end}
{phang2}{cmd:. cc case exposed [fw=pop], by(age) tb tarone}{p_end}
    {hline}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:cc} and {cmd:cci} save the following in {cmd:r()}:

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Scalars}{p_end}
{synopt:{cmd:r(p)}}two-sided p-value{p_end}
{synopt:{cmd:r(p1_exact)}}chi-squared or one-sided exact significance{p_end}
{synopt:{cmd:r(p_exact)}}two-sided significance{p_end}
{synopt:{cmd:r(or)}}odds ratio{p_end}
{synopt:{cmd:r(lb_or)}}lower bound of CI for {cmd:or}{p_end}
{synopt:{cmd:r(ub_or)}}upper bound of CI for {cmd:or}{p_end}
{synopt:{cmd:r(afe)}}attributable (prev.) fraction among exposed{p_end}
{synopt:{cmd:r(lb_afe)}}lower bound of CI for {cmd:afe}{p_end}
{synopt:{cmd:r(ub_afe)}}upper bound of CI for {cmd:afe}{p_end}
{synopt:{cmd:r(afp)}}attributable fraction for the population{p_end}
{synopt:{cmd:r(chi2_p)}}pooled heterogeneity chi-squared{p_end}
{synopt:{cmd:r(chi2_bd)}}Breslow-Day chi-squared{p_end}
{synopt:{cmd:r(df_bd)}}degrees of freedom for Breslow-Day chi-squared{p_end}
{synopt:{cmd:r(chi2_t)}}Tarone chi-squared{p_end}
{synopt:{cmd:r(df_t)}}degrees of freedom for Tarone chi-squared{p_end}
{synopt:{cmd:r(df)}}degrees of freedom{p_end}
{synopt:{cmd:r(chi2)}}chi-squared{p_end}


{marker references}{...}
{title:References}

{marker C1956}{...}
{phang}
Cornfield, J. 1956. A statistical problem arising from retrospective studies.
In Vol. 4 of {it:Proceedings of the Third Berkeley Symposium}, ed.
J. Neyman, 135-148. Berkeley, CA: University of California Press.

{marker M1976}{...}
{phang}
Miettinen, O. S. 1976. Estimability and estimation in case-referent studies.
{it:American Journal of Epidemiology} 103: 226-235.
Reprinted in 
{it:Evolution of Epidemiologic Ideas: Annotated Readings on Concepts and Methods},
ed. S. Greenland, pp. 181-190. Newton Lower Falls, MA: Epidemiology Resources.

{marker W1955}{...}
{phang}
Woolf, B. 1955. On estimating the relation between blood group disease.
{it:Annals of Human Genetics} 19: 251-253.
Reprinted in
{it:Evolution of Epidemiologic Ideas: Annotated Readings on Concepts and Methods},
ed. S. Greenland, pp. 108-110. Newton Lower Falls, MA: Epidemiology Resources.
{p_end}
