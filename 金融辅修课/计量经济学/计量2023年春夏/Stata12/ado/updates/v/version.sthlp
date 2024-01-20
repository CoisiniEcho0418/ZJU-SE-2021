{smcl}
{* *! version 1.4.13  28jul2011}{...}
{vieweralsosee "[P] version" "mansection P version"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[D] functions" "help functions"}{...}
{vieweralsosee "[R] set seed" "help seed"}{...}
{vieweralsosee "[R] which" "help which"}{...}
{vieweralsosee "whatsnew" "help whatsnew"}{...}
{viewerjumpto "Syntax" "version##syntax"}{...}
{viewerjumpto "Description" "version##description"}{...}
{viewerjumpto "Options" "version##options"}{...}
{viewerjumpto "Remarks" "version##remarks"}{...}
{viewerjumpto "Summary of version changes" "version##summary"}{...}
{title:Title}

{p2colset 5 20 22 2}{...}
{p2col :{manlink P version} {hline 2}}Version control{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

    Show version number to which command interpreter is set

	{cmdab:vers:ion}


    Set command interpreter to version {it:#}

	{cmdab:vers:ion} {it:#}[{cmd:,} {cmd:born(}{it:ddMONyyyy}{cmd:)} {cmdab:mis:sing}]


    Execute command under version {it:#}

	{cmdab:vers:ion} {it:#}[{cmd:,} {cmd:born(}{it:ddMONyyyy}{cmd:)} {cmdab:mis:sing}]{cmd::}  {it:command}


{marker description}{...}
{title:Description}

{pstd}
Problem:  Stata is continually being improved, meaning that programs and
do-files written for older versions might stop working.

{pstd}
Solution:  Specify the version of Stata that you are using at the top of
programs and do-files that you write:

	{hline 33} begin myprog.do {hline 3}
	{cmd:version {ccl stata_version}}

	use mydata, clear
	regress ...
	...
	{hline 35} end myprog.do {hline 3}


	{hline 31} begin example.ado {hline 3}
	program myprog
		{cmd:version {ccl stata_version}}
		...
	end
	{hline 33} end example.ado {hline 3}

{pstd}
Future versions of Stata will then continue to interpret your programs
correctly.

{pstd}
In the first syntax,

	{cmdab:vers:ion}

{pstd}
{cmd:version} shows the current version number to which the command
interpreter is set.

{pstd}
In the second syntax,

	{cmdab:vers:ion} {it:#}

{pstd}
{cmd:version} sets the command interpreter to internal
version number {it:#}.  {cmd:version} {it:#} allows old programs to
run correctly under more recent versions of Stata and ensures that new
programs will run correctly under future versions of Stata.

{pstd}
In the third syntax,

	{cmdab:vers:ion} {it:#}{cmd::} {it:command}

{pstd}
{cmd:version} executes {it:command} under version {it:#} and then resets the
version to what it was before the {cmd:version} {it:#}{cmd::} {it:...}
command was given.


{marker options}{...}
{title:Options}

{phang}
{cmd:born(}{it:ddMONyyyy}{cmd:)} is rarely specified and indicates that the
Stata executable must be dated {it:ddMONyyyy} (for example, 13Jul2011) or later.
StataCorp and users sometimes write programs in ado-files that require the
Stata executable to be of a certain date.  The {cmd:born()} option allows us or
the author of an ado-file to ensure that ado-code that requires a certain
updated executable is not run with an older executable.

{pmore}
    Generally all that matters is the version number, so you would
    not use the {cmd:born()} option.  You use {cmd:born()} in the rare case
    that you are exploiting a feature added to the executable after the
    initial release of that version of Stata.  See {help whatsnew} to browse
    the features added to the current version of Stata since its original
    release.

{phang}
{cmd:missing} requests the modern treatment of missing values.  {cmd:missing}
is allowed only when {it:#} is less than 8 (because otherwise, modern
treatment of missing values is implied).

{pmore}
Before version 8, there was only one missing value ({cmd:.}).  To keep old
programs working, when {cmd:version} is less than 8, Stata acts as if {cmd:.}
= {cmd:.a} = {cmd:.b} = ... = {cmd:.z}.  Thus old lines, such as
"...{cmd:if x!=.}", continue to exclude all missing observations.

{pmore}
Specifying {cmd:missing} will cause old programs to break.  The only reason
to specify {cmd:missing} is that you want to update the old program to 
distinguish between missing-value codes and you do you want to update it to
be modern in other ways.  Few, if any, programs need this.


{marker remarks}{...}
{title:Remarks}

{pstd}
All programs and do-files written using this version of Stata should include
"{cmd:version {ccl stata_version}}" as the first executable statement. For
example:

	    {cmd:program mypgm}
		    {cmd:version {ccl stata_version}}
		    {it:etc.}
	    {cmd:end}

{pstd}
Programs and do-files written as of earlier releases should include the
appropriate {cmd:version} line at the top.  All programs distributed by
StataCorp have this.  Thus old programs work even if Stata has changed.


{marker summary}{...}
{title:Summary of version changes}

{pstd}
There have been many changes made to Stata over the years.  Most do not
matter in the sense that they will not break old programs even if the version
is not set correctly.  However, some changes in Stata will break old programs
unless the version number is set back to the appropriate version number.  The
list below outlines these important changes.  This list is probably of
interest only to those trying to update an old program to a new version's
syntax -- most people will just set the version number appropriately
instead and not worry about any of this.


    {title:If you set version to less than 12.0}

{phang2}1.  {helpb xtmixed} will report restricted maximum-likelihood (REML) 
            results.  If you want maximum likelihood (ML) results, you must
            specify the {cmd:mle} option.

{phang2}2.  {helpb poisson_postestimation##estatgof:estat gof} after
            {helpb poisson} will report only the deviance statistic by
            default.  To get the Pearson statistic, you must specify the
            {cmd:pearson} option.

{phang2}3.  {helpb cnsreg} will not check for collinear variables prior to
            estimation even if the {opt collinear} option is not specified.

{phang2}4.  {helpb margins} behaves as if {cmd:estimtolerance(1e-7)} was
	    specified even if a different value is specified.

{phang2}5.  {helpb sfrancia} uses the Box-Cox transformation instead of an
            algorithm based on the log transformation for approximating the
            sampling distribution of the W' statistic for testing normality.

{phang2}6.  {helpb mi estimate} computes fractions of missing information
            and relative efficiencies using large-sample degrees of freedom
            rather than using a small-sample adjustment.

{phang2}7.  {helpb mi impute monotone} omits imputation variables that
            do not contain any missing values in the imputation sample from
            the imputation model.


    {title:If you set version to less than 11.2}

{phang2}
1.  {helpb drawnorm} produces different results because of changes in
    the {cmd:rnormal()} function, which are described below.

{phang2}
2.  {helpb mi impute} produces different results because of changes in
    the {cmd:rnormal()} function, which are described below.  The statistical
    properties of these results are neither better nor worse than modern
    results, but they are different.

{phang2}
3.  Function {helpb rnormal()}, the Gaussian random-number generation
    function, produces different values.  These pseudo-random number sequences
    were found to be insufficiently random for certain applications.

{phang2}
4.  {it:Aside:} Version control for all random-number generators is specified
    at the time the {helpb set seed} command is given, not at the time the
    random-number generation function such as {cmd:rnormal()} is used.  For
    instance, typing

		. {it:(assume version is set to be 11.2 or later)}

		. {cmd:set seed 123456789}

		. {it:any_command ...}

{p 12 12 2}
    causes {it:any_command} to use the modern version of {cmd:rnormal()} even
    if {it:any_command} is an ado-file containing an explicit {cmd:version}
    statement setting the version to less than 11.2.  This occurs because the
    version of {cmd:rnormal()} that is used was determined at the time the
    seed was set, and the seed was set under version 11.2 or later.

{p 12 12 2}
    This works in both directions.  Consider

		. {cmd:version 11.1: set seed 123456789}

		. {it:any_command ...}

{p 12 12 2}
    In this case, {it:any_command} uses the older version of {cmd:rnormal()}
    because the seed was set under version 11.1, before {cmd:rnormal()} was
    updated.  {it:any_command} uses the older version of {cmd:rnormal()} even
    if {it:any_command} itself includes an explicit {cmd:version} statement
    setting the version to 11.2 or later.

{p 12 12 2}
    Thus both older and newer ado-files can use the newer or older
    {cmd:rnormal()}, and they can do so without modification.  The only case
    in which you need to modify a do-file or ado-file is when it is older, it
    contains {cmd:set seed}, and you now want it to use the new
    {cmd:rnormal()}.  In that case, find the {cmd:set seed} command in the
    do-file or ado-file,

		  {cmd:version 10}              // {it:for example}
		  ...
		  {cmd:set seed 123456789}
		  ...

{p 12 12 2}
     and change it to read

		  {cmd:version 10}              // {it:for example}
		  ...
		  {cmd:version 11.2: set seed 123456789}
		  ...

{p 12 12 2}
    You need to change only the one line.

{phang2}
5.  {it:Aside, continued:}
    Everything written above about prefixing {cmd:set seed} with a
    {cmd:version} is irrelevant if you are restoring the seed to a state
    previously obtained from {helpb set_seed##state:c(seed)}:

		  {cmd:set seed X075bcd151f123bb5159a55e50022865700023e53}

{p 12 12 2}
    The string state {cmd:X075bcd151f123bb5159a55e50022865700023e53} includes
    the version number at the time the seed was set.  Prefixing the above
    with {cmd:version}, whether older or newer, will do no harm but
    is unnecessary.  The version under which {cmd:set seed} was called is
    available in {cmd:c(version_rng)}; see {helpb creturn:[P] creturn}.


    {title:If you set version to less than 11.1}

{phang2}1.  {helpb xtnbreg:xtnbreg, re} returns {cmd:xtn_re} in {cmd:e(cmd2)},
            and {helpb xtnbreg:xtnbreg, fe} returns {cmd:xtn_fe} in
            {cmd:e(cmd2)}.  As of version 11.1, {cmd:xtnbreg} instead returns
            the {cmd:e(model)} macro, containing {cmd:re}, {cmd:fe}, or
            {cmd:pa}, indicating which model was specified.


    {title:If you set version to less than 11.0}

{phang2}1.  {helpb anova} reverts to pre-Stata 11 syntax.  Options
            {cmd:category()}, {cmd:class()}, {cmd:continuous()},
            {cmd:regress}, {cmd:anova}, {cmd:noanova}, and {cmd:detail} are
            allowed, while factor-variable notation (the {cmd:i.} and {cmd:c.}
            operators) is not allowed.  The {cmd:*} symbol indicates
            interaction (instead of {cmd:#}), and therefore {cmd:*}, {cmd:-},
            and {cmd:?} are not allowed for variable-name expansion.
            Noninteger and negative values are allowed as category levels.

{phang2}2.  {helpb correlate}'s {cmd:_coef} option is allowed.

{phang2}3.  {helpb ereturn display} ignores the scalars in {cmd:e()}.  As of
	    version 11, {cmd:ereturn} {cmd:display} checks that the value of
	    scalar {cmd:e(k_eq)} contains the number of equations in
	    {cmd:e(b)} if it is set.

{phang2}4.  {helpb manova} reverts to pre-Stata 11 syntax.  Options
            {cmd:category()}, {cmd:class()}, {cmd:continuous()}, and
            {cmd:detail} are allowed, while factor-variable notation (the
            {cmd:i.} and {cmd:c.} operators) is not allowed.  The {cmd:*}
            symbol indicates interaction (instead of {cmd:#}), and therefore
            {cmd:*}, {cmd:-}, and {cmd:?} are not allowed for variable-name
            expansion.  Noninteger and negative values are allowed as category
            levels.

{phang2}5.  {helpb odbc insert} will insert data by constructing an SQL insert
            statement and will not use parameterized inserts.

{phang2}6.  {helpb odbc load} will quote the table name used in the SQL
            SELECT statement that loads your data unless the {opt noquote}
            option is used.

{phang2}7.  {helpb outfile} will not export date-formatted variables as
            strings.

{phang2}8.  {helpb predict} options {cmd:scores} and {cmd:csnell} after
            {helpb stcox} will produce partial, observation-level diagnostics
            instead of subject-level diagnostics.  This matters only if you
            have multiple records per subject in your survival data.

{phang2}9.  Abbreviating {helpb predict} option {cmd:scores} with {cmd:sc}
            after {helpb stcox} is allowed.  Modern syntax requires {cmd:sco}
            minimally.

{p 7 12 2}
       10.  {helpb predict} options {cmd:mgale} and {cmd:csnell} after
            {helpb streg} will produce partial, observation-level diagnostics
            instead of subject-level diagnostics.  This matters only if you
            have multiple records per subject in your survival data.

{p 7 12 2}
       11.  Abbreviating {helpb predict} option {cmd:csnell} with {cmd:cs}
            after {helpb streg} is allowed.  Modern syntax requires {cmd:csn}
            minimally.

{p 7 12 2}
       12.  {helpb xtreg:xtreg, re vce(robust)} uses the 
            Huber/White/sandwich estimator of the variance-covariance of the
            estimator (VCE).  As of version 11, {cmd:xtreg, re vce(robust)}
            is equivalent to  
            {cmd:xtreg, re vce(cluster }{it:panelvar}{cmd:)},
            where {it:panelvar} identifies the panels.

{p 7 12 2}
       13.  {helpb logistic}, {helpb logit}, {helpb blogit}, and
            {helpb mlogit} will not display the exponentiated constant when
            coefficients are displayed in "eform", for example, odds-ratios
            instead of coefficients in logistic regression.


    {title:If you set version to less than 10.1}

{phang2}1.  Function {helpb Binomial()} is allowed.  The modern replacement
            for {cmd:Binomial()} is {helpb binomialtail()}.

{phang2}2.  {helpb canon} will display raw coefficients and conditionally
	    estimated standard errors and confidence intervals in a standard
	    estimation table by default, rather than raw coefficients in
	    matrix form.

{phang2}3.  {helpb drawnorm} uses {cmd:invnormal(uniform())} to generate
            normal random variates instead of using {helpb rnormal()}.

{phang2}4.  {helpb egen} function {cmd:mode()} with option {cmd:missing} will
            not treat missing values as a category.

{phang2}5.  The {helpb reshape} J variable value and variable labels and all
            xij variable labels, when reshaping from long to wide and back to
            long, will not be preserved.

{phang2}6.  {helpb xtmixed}, {helpb xtmelogit}, and {helpb xtmepoisson},
            without an explicit level variable (or {cmd:_all}) followed by a
            colon in the random-effects specification, assume a specification
            of {cmd:_all:}.


    {title:If you set version to less than 10}

{phang2}1.  {helpb ca} and {helpb camat}, instead of reporting percent
            inertias, report inertias such that their sums equal the total
            inertia.

{phang2}2.  {helpb cf}{cmd:, verbose} produces the same output as {cmd:cf, all}.

{phang2}3.  {helpb clear} will perform the same list of actions as
            {cmd:clear all}, except for 
            {helpb program:program drop _all}.

{phang2}4.  {helpb cnreg} and {helpb tobit} will no longer accept the
            {opt vce()} option.

{phang2}5.  {helpb datasignature} runs {helpb _datasignature}, which is what
            the {cmd:datasignature} command was in Stata 9.

{phang2}6.  Functions {cmd:norm()}, {cmd:normd()}, {cmd:normden()},
            {cmd:invnorm()}, and {cmd:lnfact()}, which were
            renamed in Stata 9, are allowed.  The corresponding modern
            functions are  {helpb normal()}, {helpb normalden()},
            {helpb normalden()}, {helpb invnormal()}, and
            {helpb lnfactorial()}.

{phang2}7.  {helpb graph use} will name the graph and window Graph, rather
            than naming after the filename, unless the {cmd:name()} option is
            specified.

{phang2}8.  {helpb mdslong}'s {cmd:force} option corrects problems with the
            supplied proximity information and multiple measurements on (i,j)
            are averaged.  In version 10, measurements for (i,j) and (j,i) are
	    averaged if {cmd:force} is specified, but additional multiple
	    measurements result in an error even if {cmd:force} is specified.

{phang2}9.  {helpb mkspline} calculates percentiles for linear splines using
            {helpb egen}'s {cmd:pctile()} function instead of using the 
            {helpb centile} command.  In addition, {helpb fweight}s are not
            allowed for linear splines.

{p 7 12 2}
       10.  {helpb mlogit} had the following name changes in its
            {cmd:e()} results:

   		Old name	 	  New name
		{hline 37}
		{cmd:e(basecat)}		{cmd:e(baseout)}
		{cmd:e(ibasecat)}		{cmd:e(ibaseout)}
		{cmd:e(k_cat)}			{cmd:e(k_out)}
		{cmd:e(cat)}			{cmd:e(out)}

{p 7 12 2}
       11.  {helpb odbc load} will import date-and-time variables as {cmd:%td}
            instead of {cmd:%tc}, and TIME data types will be imported as
            strings.

{p 7 12 2}
       12.  {cmd:score}, a command associated with the {cmd:factor} command of
            Stata 8, is allowed.

{p 7 12 2}
       13.  {helpb sts graph}'s {opt risktable()} option and
            {helpb sts list}'s {opt survival} option are not allowed.

{p 7 12 2}
       14.  {cmd:syntax} {cmd:[,} {it:whatever}{cmd:(real} {it:...}{cmd:)]}
            uses a {cmd:%9.0g} format instead of a {cmd:%18.0g} format for
            the number placed in the {it:whatever} local macro.

{p 7 12 2}
       15.  {helpb xtabond} will use the version 9 {cmd:xtabond} instead of
            {helpb xtdpd} to perform the computations, the output will be in
            differences instead of levels, and the constant will be a time
            trend instead of a constant in levels.  {cmd:estat abond} and
            {cmd:estat sargan} will not work, and {cmd:predict} will have the
            version 9 syntax.

{p 7 12 2}
       16.  {helpb xtlogit}, {helpb xtprobit}, {helpb xtcloglog},
            {helpb xtintreg}, {helpb xttobit}, and
            {helpb xtpoisson:xtpoisson, normal} random-effects models will
            use default {cmd:intmethod(aghermite)}.


    {title:If you set version to less than 9.2}

{phang2}1.  Mata {help m2_struct:structures} introduced in Stata 9.2 are
            available even if you set version to less than 9.2.  The only
            version control issue is that the format of {cmd:.mlib} libraries
            is different.  You do not need to recompile old Mata code.
            However, because of the format change, you will not be able to add
            new members to old libraries.  Libraries cannot contain a mix of
            old and new code.  To add new members, you must first rebuild the
            old library.


    {title:If you set version to less than 9.1}

{phang2}1.  {helpb logit}, {helpb probit}, and {helpb dprobit} will accept
            {helpb aweight}s.  Support for {cmd:aweight}s was removed from
	    these commands because the interpretation of {cmd:aweight}ed data
            is nonsensical for these models.

{phang2}2.  {helpb nl} will not allow the {opt vce()} option; no longer
            reports each parameter as its own equation; reports the previous
            sum of squares after each iteration instead of the new sum of
            squares in the iteration log; reports an overall model F test;
            allows fewer {cmd:predict} options; and will not allow {helpb mfx}
            or {helpb lrtest} postestimation commands.

{phang2}3.  {helpb permute} uses one random uniform variable (instead of two)
            to generate Monte Carlo permutations of the permute variable.

{phang2}4.  {helpb xtreg:xtreg, fe} adjusts the robust-cluster VCE for
            the within transform. 

{phang2}5.  {helpb xtreg:xtreg, fe} and {helpb xtreg:xtreg, re} do not
            require that the panels are nested within the clusters when
            computing the cluster-robust VCE.


    {title:If you set version to less than 9}

{phang2}1.  {helpb svyset} reverts to pre-Stata 9 syntax and logic.
            The dataset must be {cmd:svyset} by the pre-Stata 9 {cmd:svyset}
            command to use the pre-Stata 9 estimation commands 
		{cmd:svygnbreg},
		{cmd:svyheckman},
		{cmd:svyheckprob},
		{cmd:svyivreg},
		{cmd:svylogit},
		{cmd:svymlogit},
		{cmd:svynbreg},
		{cmd:svyologit},
		{cmd:svyoprobit},
		{cmd:svypoisson},
		{cmd:svyprobit},
		and
		{cmd:svyregress}.

{phang2}2.  {helpb factor}, {helpb pca}, and related commands 
            revert to pre-Stata 9 behavior.

{p 12 12 2}
            To begin with, {cmd:factor} and {cmd:pca} store things differently.
            Before Stata 9, these commands were a strange mix of e-class and
            r-class; they set {cmd:e(sample)} but otherwise mostly saved
            results in {cmd:r()}.  They also stored secret matrices under odd
            names that everyone knew about and fetched via {cmd:matrix get()}.
            All of that is restored.

{p 12 12 2}
            Second, {cmd:factor,} {cmd:ml} {cmd:protect} uses a 
            different random-number generator, one that is not 
            settable by the more modern {cmd:factor}'s {cmd:seed()} option.

{p 12 12 2}
            Third, {helpb rotate} reverts to pre-Stata 9 syntax and logic.

{p 12 12 2}
            Fourth, 
            old command {cmd:score} stops issuing warning messages that it is
            out of date.

{p 12 12 2}
            Finally, 
            old command {cmd:greigen} works as it used to work, syntax 
            and logic.  (As of Stata 9, {cmd:greigen} was undocumented and
            configured to call through to the modern {cmd:screeplot}.)

{phang2}3.  {helpb nl} reverts to pre-Stata 9 syntax.

{phang2}4.  {helpb bootstrap}, {helpb bstat}, and {helpb jknife} 
            revert to pre-Stata 9 syntax and logic.

{phang2}5.  {helpb rocfit} reverts to pre-Stata 9 syntax and logic.

{phang2}6.  {helpb sw} reverts to pre-Stata 9 syntax and logic.

{phang2}7.  {helpb cluster dendrogram}
            reverts to pre-Stata 9 syntax and logic.

{phang2}8.  Pre-Stata 8 {it:[sic]} command {cmd:xthausman} 
            will work.  {cmd:xthausman} was replaced by {helpb hausman} in 
            Stata 8.

{p 8 12 2}
        9.  {helpb irf graph} and {helpb xtline} allow the 
            {cmd:byopts()} option to be
            abbreviated {cmd:by()} rather than requiring at least 
            {cmd:byop()}.

{p 7 12 2}
       10.  {helpb dotplot} will allow the {cmd:by()} option as
            a synonym for the {cmd:over()} option.

{p 7 12 2}
       11.  {helpb glm} defaults the {cmd:iterate()} option to 50 
            rather than {cmd:c(maxiter)}.

{p 7 12 2}
       12.  {helpb histogram} places white space below 
            the horizontal axis.

{p 7 12 2}
       13.  {helpb ml:ml display} changes the look of 
            survey results.

{p 7 12 2}
       14.  {helpb ologit} and {helpb oprobit}  revert 
	    to pre-Stata 9 logic in how {cmd:e(b)} and {cmd:e(V)} are 
            stored.  Results were stored in two equations, with all 
            cutpoints stored in the second.

{p 7 12 2}
       15.  {helpb tobit} and {helpb cnreg}  revert 
	    to pre-Stata 9 logic in how {cmd:e(b)} and {cmd:e(V)} are 
            stored.  Results were stored in one equation
            containing both coefficients and the ancillary variance 
            parameter.

{p 7 12 2}
       16.  {helpb tabstat} returns a result in matrix 
            {cmd:r(StatTot)} rather than {cmd:r(StatTotal)}.
 
{p 7 12 2}
       17.  {helpb glogit} and {helpb gprobit}, 
            the 
            weighted-least-squares estimators, 
            use a different formula for the weights.
            In Stata 9, a
            new (better) formula was adopted, see 
            Greene (1997, 
            {it:Econometric Analysis, 3rd ed.}, 
	    Prentice Hall, 896).

{p 7 12 2}
       18.  {helpb xtintreg},
		{helpb xtlogit}, 
		{helpb xtprobit}, 
		{helpb xtcloglog}, 
		{helpb xtpoisson}, 
		and
		{helpb xttobit}
	     revert to using nonadaptive Gauss-Hermite quadrature rather 
             than adaptive quadrature.  Also, the {cmd:quad()} option
             (modern name {cmd:intpoints()}) comes back to life.

{p 7 12 2}
       19.  {cmd:set help} will be allowed (but it will not do 
            anything).

{p 7 12 2}
       20.  In input, {cmd:\\} will be substituted to {cmd:\}
            always, not just after 
            the macro-substitution characters {cmd:$} and {cmd:`}.


    {title:If you set version to 8.1 or less}

{phang2}1.  {helpb graph twoway} default axis titles show the
		labels or variable names for all variables plotted on an axis
		instead of leaving the axis title blank when the axis
		represents multiple variables.{p_end}

{phang2}2.  {helpb clogit} will not allow the {cmd:vce()} option nor many of
                the {cmd:ml} {helpb maximize} options.


    {title:If you set version to 8.0 or less}

{phang2}1.  {helpb ml} ignores the {cmd:constraint()} option if there are no
		predictors in the first equation.{p_end}

{phang2}2.  {helpb outfile} automatically includes the extended missing-value
		codes ({cmd:.a}, {cmd:.b}, ..., {cmd:.z}) in its output.  With
		version 8.1 or later, extended missing-value codes are treated
		like the system missing value {cmd:.} and are changed to null
		strings ({cmd:""}) unless the {cmd:missing} and {cmd:comma}
		options are specified.


    {title:If you set version to 7.0 or less}

{phang2}1.  {helpb graph} uses the old syntax; see {helpb graph7}.{p_end}

{phang2}2.  {helpb estimates} reverts to the previous interpretation and
		syntax, and {helpb _estimates} and {helpb ereturn} are not
		recognized as Stata commands.{p_end}

{phang2}3.  The {helpb svy} commands allow the {helpb svyset} parameters to
		be specified as part of the command.{p_end}

{phang2}4.  Also, the following commands revert to their old
		syntax: {helpb ac}, {helpb acprplot}, {helpb avplot},
		{helpb avplots}, {helpb bootstrap}, {helpb bs}, {helpb bsample},
		{helpb bstat}, {helpb cchart}, {helpb cprplot}, {helpb cumsp},
		{helpb cusum}, {helpb dotplot}, {helpb findit}, {helpb fracplot},
		{helpb gladder}, {helpb greigen}, {helpb grmeanby},
		{helpb histogram}, {helpb intreg}, {helpb kdensity},
		{helpb lowess}, {helpb lroc}, {helpb lsens}, {helpb ltable},
		{helpb lvr2plot}, {helpb newey}, {helpb pac}, {helpb pchart},
		{helpb pchi}, {helpb pergram}, {helpb pkexamine}, {helpb pksumm},
		{helpb pnorm}, {helpb qchi}, {helpb qladder}, {helpb qnorm},
		{helpb qqplot}, {helpb quantile}, {helpb rchart}, {helpb roccomp},
		{helpb rocplot}, {helpb roctab}, {helpb rvfplot}, {helpb rvpplot},
		{helpb serrbar}, {helpb shewhart}, {helpb simulate},
		{helpb spikeplot}, {helpb stci}, {helpb stcoxkm}, {helpb stcurve},
		{helpb stphplot}, {helpb stphtest}, {helpb strate}, {helpb sts},
		{helpb symplot}, {helpb tabodds}, {helpb test}, {helpb wntestb},
		{helpb xchart}, and {helpb xcorr}.  Most of these are
                because of the change of the {helpb graph} command.{p_end}

{phang2}5.  Throughout Stata,
		{cmd:.} == {cmd:.a} == {cmd:.b} == ... == {cmd:.z}.{p_end}

{phang2}6.  Missing values in matrices are less likely to be accepted.{p_end}

{phang2}7.  {cmd:generate} {it:x} {cmd:=} {it:string_expression} will
		produce an error; you are required to specify the type; see
		{manhelp generate D}.{p_end}

{phang2}8.  {helpb ifcmd:if}, {helpb while}, {helpb foreach}, {helpb forvalues},
		and other commands that use the open and close braces,
		{cmd:{c -(}} and {cmd:{c )-}}, often allow the item
		enclosed in the braces to appear on the same line as the
		braces.{p_end}

{phang2}9.  {helpb test} allows the coefficient names not to match 1 to 1
		(regardless of order) when testing equality of coefficients of
		two equations.  The test is performed on the coefficients
		in common.{p_end}

{p 7 12 2}10.  {helpb list} allows the {cmd:doublespace} option, which is then
		treated as if it were the {cmd:separator(1)} option.  Also,
		even with the version set to 7.0 or less, {cmd:list} uses the
		new style of listing unless the {cmd:clean} option is specified
		to remove the dividing and separating lines.{p_end}

{p 7 12 2}11.  {helpb outfile} uses right justification for strings.{p_end}

{p 7 12 2}12.  {helpb reldif():reldif}{cmd:(}{it:x}{cmd:,}{it:y}{cmd:)} with
		{it:x} and {it:y} as equal missing values, such as
		{cmd:reldif(.r,.r)}, returns system missing ({cmd:.}) instead
		of 0.{p_end}

{p 7 12 2}13.  {helpb query}, in addition to showing all the settings normally
		shown, shows the values of {helpb set} parameters that apply
		only to the earlier versions.{p_end}

{p 7 12 2}14.  {helpb matrix score}, when looking up variable names
		associated with the elements of the specified vector, expands
		variable name abbreviations.{p_end}

{p 7 12 2}15.  {helpb xthausman} continues to work (for one more release) but
		recommends the use of {helpb hausman} instead.{p_end}


    {title:If you set version to 6.0 or less}

{phang2}1.  Macro substitution is made on the basis of the first seven (local)
		or eight (global) characters of the name;
                {cmd:`thisthatwhat'} is the same as {cmd:`thistha'}.{p_end}

{phang2}2.  {helpb syntax} returns the result of parsing a long option name in
		the local macro formed from the first seven characters of the
		option name.{p_end}

{phang2}3.  {helpb display} starts in non-SMCL mode; the {cmd:in smcl}
		directive may be used to set smcl mode on.{p_end}

{phang2}4.  {cmd:invt()} works; {cmd:invttail(}{it:a}{cmd:,(1-}{it:b}{cmd:)/2)}
		is a new alternative to {cmd:invt(}{it:a}{cmd:,}{it:b}{cmd:)}.
		{p_end}

{phang2}5.  {cmd:invchi()} works; {cmd:invchi2(}{it:a}{cmd:,1-}{it:b}{cmd:)}
		is a new alternative to {cmd:invchi(}{it:a}{cmd:,}{it:b}{cmd:)}.
		{p_end}

{phang2}6.  {helpb post} will allow expressions that are not bound in
		parentheses.{p_end}

{phang2}7.  Option {cmd:basehazard()} is allowed in {helpb cox} and
	    {helpb stcox}; it has been renamed to {cmd:basehc()},
	    which is understood regardless of version setting.{p_end}

{phang2}8.  {helpb log:log using} can have a {cmd:noproc} option.{p_end}

{phang2}9.  {cmd:log close}, {cmd:log off}, and {cmd:log on} will close, turn
		off, or turn on a {helpb cmdlog} if present and a {helpb log} is
		not.{p_end}

{p 7 12 2}10.  {cmd:set log linesize}, {cmd:set log pagesize},
		{cmd:set display linesize}, and {cmd:set display pagesize}
		are allowed.{p_end}

{p 7 12 2}11.  Extended {helpb macro} functions {cmd:log},
	       {cmd:set log linesize}, and {cmd:set log pagesize} enabled.
	       {p_end}

{p 7 12 2}12.  {helpb insheet} will recognize only the first eight characters of
		variable names and will provide default names for variables
		if the first eight characters are not unique.{p_end}

{p 7 12 2}13.  {helpb jackknife} (or {cmd:jknife}) will call the older
		{help stb:STB} version of the command.{p_end}


    {title:If you set version to 5.0 or less}

{phang2}1.  {cmd:date()} defaults to twentieth century for two-digit
	    years.{p_end}

{phang2}2.  {helpb predict} becomes the built-in command equivalent to
		{helpb _predict}.{p_end}

{phang2}3.  {cmd:,} & {cmd:\} matrix operators allow the first matrix to not
  	    exist; now use {cmd:nullmat()}.{p_end}

{phang2}4.  {helpb matrix} ...{cmd:=get(_b)} returns a matrix instead of a row
		vector after {helpb mlogit}.{p_end}

{phang2}5.  {helpb test} after {helpb anova} understands the {cmd:error()}
	       option instead of the new "{cmd:/}" syntax.{p_end}

{phang2}6.  {helpb ologit} and {helpb oprobit} default weight types are
		{cmd:aweight}s.{p_end}

{phang2}7.  {helpb heckman} default weight type is {cmd:fweight}s.{p_end}

{phang2}8.  {helpb svyregress}, {helpb svylogit}, and {helpb svyprobit} compute
		meff and meft by default.{p_end}

{p 8 16 2}[Note:  For {helpb xtgee}, {helpb xtpoisson}, and {helpb xtprobit},
	  the default will not be {cmd:aweight}s as you would expect under
		version control; {cmd:iweight}s is the default despite setting
		the version number back to 5.0.]{p_end}


    {title:If you set version to 4.0 or less}

{phang2}1.  -2^2 = (-2)^2 = 4{space 7}(After 4.0: -2^2 = -(2^2) = -4){p_end}

{phang2}2.  {helpb describe} sets the contents of {cmd:_result()}
	    differently.{p_end}

{phang2}3.  {helpb merge} does not automatically promote variables.{p_end}

{phang2}4.  {helpb logit} and {helpb probit} default weight types are
		{cmd:aweight}s.{p_end}

{phang2}5.  {cmd:set prefix} is shown by {helpb query}.{p_end}

{phang2}6.  {cmd:hareg}, {cmd:hereg}, {cmd:hlogit}, {cmd:hprobit}, and
	    {cmd:hreg} work.{p_end}

{phang2}7.  {helpb collapse} has the old syntax.{p_end}


    {title:If you set version to 3.1 or less}

{phang2}1.  {cmd:uniform()} refers to the old random-number generator.{p_end}

{phang2}2.  {cmd:set seed} sets the old random-number seed.{p_end}

{phang2}3.  {helpb replace} defaults to {cmd:nopromote} behavior.{p_end}

{phang2}4.  The old %macro notation is allowed (it no longer is).{p_end}


    {title:If you set version to 3.0 or less}

{phang2}1.  {help tempfile}s are not automatically erased.{p_end}


    {title:If you set version to 2.5 or less}

{phang2}1.  Missing strings are stored as {hi:"."} by {helpb infile}.{p_end}


    {title:If you set version to 2.1 or less}

{phang2}1.  {helpb display} does not respect {helpb quietly}.{p_end}

{phang2}2.  Macros hold numbers in short format.{p_end}


{title:Using the old Stata 3.1 random-number generator}

{pstd}
{cmd:uniform()} and {cmd:set seed} refer to the old Stata 3.1 random-number
generator if you set version 3.1 or earlier.  You can also access
the old random-number generator even with version set to {ccl stata_version}
by referring to {cmd:uniform0()}.  You can set the old random-number
generator's seed by typing {cmd:set seed0} -- it works just like
{cmd:set seed}; see {helpb seed}.  The initial seed of the old
random-number generator is {cmd:set seed0 1001}.

{pstd}
There is no reason you should want to use the old random-number generator.
It was satisfactory but the new one is better.
{p_end}
