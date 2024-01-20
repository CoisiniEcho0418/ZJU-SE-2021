{smcl}
{* *! version 1.1.15  22jun2011}{...}
{viewerdialog predict "dialog regres_p"}{...}
{viewerdialog test "dialog testanova"}{...}
{viewerdialog dfbeta "dialog dfbeta"}{...}
{viewerdialog estat "dialog anova_estat"}{...}
{viewerdialog acprplot "dialog acprplot"}{...}
{viewerdialog avplots "dialog avplot"}{...}
{viewerdialog cprplot "dialog cprplot"}{...}
{viewerdialog lvr2plot "dialog lvr2plot"}{...}
{viewerdialog rvfplot "dialog rvfplot"}{...}
{viewerdialog rvpplot "dialog rvpplot"}{...}
{vieweralsosee "[R] anova postestimation" "mansection R anovapostestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] anova" "help anova"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] regress postestimation" "help regress_postestimation"}{...}
{viewerjumpto "Description" "anova postestimation##description"}{...}
{viewerjumpto "Special-interest postestimation commands" "anova postestimation##special"}{...}
{viewerjumpto "Syntax for predict" "anova postestimation##syntax_predict"}{...}
{viewerjumpto "Syntax for test after anova" "anova postestimation##syntax_test"}{...}
{viewerjumpto "Options for test after anova" "anova postestimation##options_test"}{...}
{viewerjumpto "Examples" "anova postestimation##examples"}{...}
{title:Title}

{p2colset 5 33 35 2}{...}
{p2col:{manlink R anova postestimation} {hline 2}}Postestimation tools for anova
{p_end}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
The following postestimation commands are of special interest after {opt anova}:

{synoptset 17}{...}
{p2coldent:Command}Description{p_end}
{synoptline}
{synopt :{helpb regress postestimation##syntax_dfbeta:dfbeta}}DFBETA influence
	statistics{p_end}
{synopt:{helpb regress_postestimation##estathett:estat hettest}}tests for
	heteroskedasticity{p_end}
{synopt :{helpb regress postestimation##estatimtest:estat imtest}}information
	matrix test{p_end}
{synopt:{helpb regress_postestimation##estatovt:estat ovtest}}Ramsey regression
	specification-error test for omitted variables{p_end}
{synopt :{helpb regress postestimation##estatszroeter:estat szroeter}}Szroeter's
	rank test for heteroskedasticity{p_end}
{synopt :{helpb regress postestimation##estatvif:estat vif}}variance inflation
	factors for the independent variables{p_end}
{synopt :{helpb regress postestimation##acprplot:acprplot}}augmented component-plus-residual plot{p_end}
{synopt :{helpb regress postestimation##avplot:avplot}}added-variable plot{p_end}
{synopt :{helpb regress postestimation##avplots:avplots}}all added-variable plots in one image{p_end}
{synopt :{helpb regress postestimation##cprplot:cprplot}}component-plus-residual plot{p_end}
{synopt :{helpb regress postestimation##lvr2plot:lvr2plot}}leverage-versus-squared-residual plot{p_end}
{synopt :{helpb regress postestimation##rvfplot:rvfplot}}residual-versus-fitted plot{p_end}
{synopt :{helpb regress postestimation##rvpplot:rvpplot}}residual-versus-predictor plot{p_end}
{synoptline}
{p2colreset}{...}

{pstd}
The following standard postestimation commands are also available:

{synoptset 17}{...}
{p2coldent:Command}Description{p_end}
{synoptline}
INCLUDE help post_contrast
INCLUDE help post_estat
INCLUDE help post_estimates
INCLUDE help post_hausman
INCLUDE help post_lincom
INCLUDE help post_linktest
INCLUDE help post_lrtest
INCLUDE help post_margins
INCLUDE help post_marginsplot
INCLUDE help post_nlcom
{synopt:{helpb regress postestimation##predict:predict}}predictions, residuals, influence statistics, and other diagnostic measures{p_end}
INCLUDE help post_predictnl
INCLUDE help post_pwcompare
INCLUDE help post_suest
{synopt:{helpb anova postestimation##test:test}}Wald tests of simple and composite linear hypotheses{p_end}
INCLUDE help post_testnl
{synoptline}
{p2colreset}{...}


{marker special}{...}
{title:Special-interest postestimation commands}

{pstd}
In addition to the common {helpb estat} commands, {cmd:estat hettest},
{cmd:estat imtest}, {cmd:estat ovtest}, {cmd:estat szroeter}, and
{cmd:estat vif} are also available.  {cmd:dfbeta} is also available.  The
syntax for {cmd:dfbeta} and these {cmd:estat} commands is the same as after
{cmd:regress}; see {manhelp regress_postestimation R:regress postestimation}.

{pstd}
In addition to the standard syntax of {helpb test}, {cmd:test} after
{cmd:anova} has three additionally allowed syntaxes; see below.  {cmd:test}
performs Wald tests of expressions involving the coefficients of the
underlying regression model.  Simple and composite linear hypotheses are
possible.


{marker syntax_predict}{...}
{title:Syntax for predict}

{pstd}
{cmd:predict} after {opt anova} follows the same syntax as {opt  predict}
after {opt  regress} and can provide predictions, residuals, standardized
residuals, Studentized residuals, the standard error of the residuals, the
standard error of the prediction, the diagonal elements of the projection (hat)
matrix, and Cook's D.  See
{manhelp regress_postestimation R:regress postestimation} for details.


{marker syntax_test}{...}
{marker test}{...}
{title:Syntax for test after anova}

{pstd}
In addition to the standard syntax of {helpb test}, {cmd:test} after
{cmd:anova} also allows the following:

    {opt te:st,} {opt test(matname)} [{opt m:test}[{opt (opt)}] {opt matvlc(matname)}] {right:syntax a  }

    {opt te:st,} {opt showord:er} {right:syntax b  }

    {opt te:st} [{it:term} [{it:term ...}]] [{cmd:/} {it:term} [{it:term ...}]] [{cmd:,} {opt s:ymbolic}] {right:syntax c  }


{p2colset 5 17 19 2}{...}
{p2col :syntax a}test expression involving the coefficients of the underlying regression model; you provide information as a matrix{p_end}
{p2col :syntax b}show underlying order of design matrix, which is useful when
constructing {it:matname} argument of the {cmd:test()} option{p_end}
{p2col :syntax c}test effects and show symbolic forms{p_end}
{p2colreset}{...}


{title:Menu}

{phang}
{bf:Statistics > Linear models and related > ANOVA/MANOVA >}
   {bf:Test linear hypotheses after anova}


{marker options_test}{...}
{title:Options for test after anova}

{phang}
{opt test(matname)} is required with syntax a of {opt test}.  The
rows of {it:matname} specify linear combinations of the underlying design
matrix of the ANOVA that are to be jointly tested.  The columns correspond to
the underlying design matrix (including the constant if it has not been
suppressed).  The column and row names of {it:matname} are ignored.

{pmore}
A listing of the constraints imposed by the {opt test()} option is presented
before the table containing the tests.  You should examine this table to verify
that you have applied the linear combinations you desired.  Typing
{cmd:test, showorder} allows  you to examine the ordering of the columns for
the design matrix from the ANOVA.

{phang}
{opt mtest}[{opt (opt)}] specifies that tests are performed for each condition
separately.  {it:opt} specifies the method for adjusting p-values for multiple
testing.  Valid values for {it:opt} are

{p2colset 20 34 37 2}{...}
{p2col :{opt b:onferroni}}Bonferroni's method{p_end}
{p2col :{opt h:olm}}Holm's method{p_end}
{p2col :{opt s:idak}}Sidak's method{p_end}
{p2col :{opt noadj:ust}}no adjustment is to be made{p_end}
{p2colreset}{...}

{pmore}
Specifying {opt mtest} without an argument is equivalent to
{cmd:mtest(noadjust)}.

{phang}
{opt matvlc(matname)}, a programmer's option, saves the variance-covariance
matrix of the linear combinations involved in the suite of tests.  For the
test Lb = c, what is returned in {it:matname} is LVL', where V 
is the estimated variance-covariance matrix of b.

{phang}
{opt showorder} causes {opt test} to list the definition of each column in the
design matrix.  {opt showorder} is not allowed with any other option.

{phang}
{opt symbolic} requests the symbolic form of the test rather than the test
statistic.  When this option is specified with no terms
({opt test, symbolic}), the symbolic form of the estimable functions is
displayed.


{marker examples}{...}
{title:Examples}

    {hline}
{pstd}Setup{p_end}
{phang2}{cmd:. webuse sewage}{p_end}
{phang2}{cmd:. anova particulate s / m|s / f|m|s / w|f|m|s /, dropemptycells}
{p_end}

{pstd}Test {cmd:s} with pooled {cmd:m|s} and {cmd:f|m|s} terms{p_end}
{phang2}{cmd:. test s / m|s f|m|s}

{pstd}Test pooled {cmd:m|s} and {cmd:f|m|s} terms with {cmd:w|f|m|s}{p_end}
{phang2}{cmd:. test m|s f|m|s / w|f|m|s}

    {hline}
{pstd}Setup{p_end}
{phang2}{cmd:. webuse systolic}{p_end}
{phang2}{cmd:. anova systolic drug disease drug#disease}{p_end}

{pstd}Symbolic form for the test of the main effect of {cmd:drug}{p_end}
{phang2}{cmd:. test drug, symbolic}

{pstd}Test whether coefficient on first drug is equal to the coefficient on
second drug{p_end}
{phang2}{cmd:. test 1.drug = 2.drug}

{pstd}Calculate linear prediction{p_end}
{phang2}{cmd:. predict yhat}{p_end}

{pstd}Calculate adjusted marginal means for {cmd:drug}{p_end}
{phang2}{cmd:. margins drug, asbalanced}

{pstd}Same as above, but take into account the unequal sample sizes of the cells
{p_end}
{phang2}{cmd:. margins drug}

    {hline}
{pstd}Setup{p_end}
{phang2}{cmd:. webuse manuf, clear}

{pstd}Perform three-way factorial ANOVA{p_end}
{phang2}{cmd:. anova yield temp##chem##method}

{pstd}Calculate predictive margins for {cmd:temperature#method} and
{cmd:method}{p_end}
{phang2}{cmd:. margins temperature#method method}

    {hline}
{pstd}Setup{p_end}
{phang2}{cmd:. webuse t43}{p_end}
{phang2}{cmd:. tabdisp person drug, cellvar(score)}

{pstd}Perform repeated-measures ANOVA{p_end}
{phang2}{cmd:. anova score person drug, repeated(drug)}

{pstd}Calculate predictive marginal mean response time for each of the 4 drugs
{p_end}
{phang2}{cmd:. margins drug}

    {hline}
{pstd}Setup{p_end}
{phang2}{cmd:. webuse bpchange}{p_end}
{phang2}{cmd:. anova bpchange dose##gender}{p_end}

{pstd}Estimate change in blood pressure for each combination of {cmd:dose} and
{cmd:gender}{p_end}
{phang2}{cmd:. margins dose#gender}{p_end}

{pstd}Plot results from {cmd:margins}{p_end}
{phang2}{cmd:. marginsplot}{p_end}

{pstd}Decompose the interaction effect into contrasts{p_end}
{phang2}{cmd:. contrast ar.dose#r.gender}{p_end}

{pstd}Pairwise comparisons, adjusting for multiple comparisons with Tukey's
method{p_end}
{phang2}{cmd:. pwcompare dose#gender, mcompare(tukey) group sort}{p_end}

    {hline}
