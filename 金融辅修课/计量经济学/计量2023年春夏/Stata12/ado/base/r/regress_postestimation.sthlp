{smcl}
{* *! version 1.2.20  10may2011}{...}
{viewerdialog predict "dialog regres_p"}{...}
{viewerdialog dfbeta "dialog dfbeta"}{...}
{viewerdialog estat "dialog regress_estat"}{...}
{viewerdialog acprplot "dialog acprplot"}{...}
{viewerdialog avplots "dialog avplot"}{...}
{viewerdialog cprplot "dialog cprplot"}{...}
{viewerdialog lvr2plot "dialog lvr2plot"}{...}
{viewerdialog rvfplot "dialog rvfplot"}{...}
{viewerdialog rvpplot "dialog rvpplot"}{...}
{vieweralsosee "[R] regress postestimation" "mansection R regresspostestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] regress" "help regress"}{...}
{vieweralsosee "[R] regress postestimation ts" "help regress postestimation ts"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[TS] tsset" "help tsset"}{...}
{viewerjumpto "Description" "regress postestimation##description"}{...}
{viewerjumpto "Special-interest postestimation commands" "regress postestimation##special"}{...}
{viewerjumpto "" "--"}{...}
{viewerjumpto "Syntax and options for predict" "regress postestimation##syntax_predict"}{...}
{viewerjumpto "" "--"}{...}
{viewerjumpto "Syntax and options for dfbeta" "regress postestimation##syntax_dfbeta"}{...}
{viewerjumpto "" "--"}{...}
{viewerjumpto "Syntax and options for estat hettest" "regress postestimation##syntax_estat_hettest"}{...}
{viewerjumpto "Syntax and options for estat imtest" "regress postestimation##syntax_estat_imtest"}{...}
{viewerjumpto "Syntax and options for estat ovtest" "regress postestimation##syntax_estat_ovtest"}{...}
{viewerjumpto "Syntax and options for estat szroeter" "regress postestimation##syntax_estat_szroeter"}{...}
{viewerjumpto "Syntax and options for estat vif" "regress postestimation##syntax_estat_vif"}{...}
{viewerjumpto "" "--"}{...}
{viewerjumpto "Syntax and options for acprplot" "regress postestimation##syntax_acprplot"}{...}
{viewerjumpto "Syntax and options for avplot" "regress postestimation##syntax_avplot"}{...}
{viewerjumpto "Syntax and options for avplots" "regress postestimation##syntax_avplots"}{...}
{viewerjumpto "Syntax and options for cprplot" "regress postestimation##syntax_cprplot"}{...}
{viewerjumpto "Syntax and options for lvr2plot" "regress postestimation##syntax_lvr2plot"}{...}
{viewerjumpto "Syntax and options for rvfplot" "regress postestimation##syntax_rvfplot"}{...}
{viewerjumpto "Syntax and options for rvpplot" "regress postestimation##syntax_rvpplot"}{...}
{viewerjumpto "" "--"}{...}
{viewerjumpto "Examples" "regress postestimation##examples"}{...}
{viewerjumpto "Saved results" "regress postestimation##saved_results"}{...}
{viewerjumpto "References" "regress postestimation##references"}{...}
{title:Title}

{p2colset 5 35 37 2}{...}
{p2col :{manlink R regress postestimation} {hline 2}}Postestimation tools 
for regress{p_end}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
The following postestimation commands are of special interest after {cmd:regress}: 

{synoptset 17}{...}
{p2coldent :Command}Description{p_end}
{synoptline}
{synopt :{helpb regress postestimation##syntax_dfbeta:dfbeta}}DFBETA influence statistics{p_end}
{synopt :{helpb regress postestimation##estathett:estat hettest}}tests for heteroskedasticity{p_end}
{synopt :{helpb regress postestimation##estatimtest:estat imtest}}information matrix test{p_end}
{synopt :{helpb regress postestimation##estatovt:estat ovtest}}Ramsey regression specification-error test for 
omitted variables{p_end}
{synopt :{helpb regress postestimation##estatszroeter:estat szroeter}}Szroeter's rank test for heteroskedasticity{p_end}
{synopt :{helpb regress postestimation##estatvif:estat vif}}variance inflation factors for the independent
variables{p_end}
{synopt :{helpb regress postestimation##acprplot:acprplot}}augmented component-plus-residual plot{p_end}
{synopt :{helpb regress postestimation##avplot:avplot}}added-variable plot{p_end}
{synopt :{helpb regress postestimation##avplots:avplots}}all added-variable plots in one image{p_end}
{synopt :{helpb regress postestimation##cprplot:cprplot}}component-plus-residual plot{p_end}
{synopt :{helpb regress postestimation##lvr2plot:lvr2plot}}leverage-versus-squared-residual plot{p_end}
{synopt :{helpb regress postestimation##rvfplot:rvfplot}}residual-versus-fitted plot{p_end}
{synopt :{helpb regress postestimation##rvpplot:rvpplot}}residual-versus-predictor plot{p_end}
{synoptline}
{p2colreset}{...}
{p 4 6 2}
These commands are not appropriate after the {cmd:svy} prefix.
{p_end}

{pstd}
The following standard postestimation commands are also available:

{synoptset 17 notes}{...}
{p2coldent :Command}Description{p_end}
{synoptline}
INCLUDE help post_contrast
INCLUDE help post_estat
INCLUDE help post_svy_estat
INCLUDE help post_estimates
INCLUDE help post_hausman
INCLUDE help post_lincom
INCLUDE help post_linktest
INCLUDE help post_lrtest_star
INCLUDE help post_margins
INCLUDE help post_marginsplot
INCLUDE help post_nlcom
{synopt :{helpb regress postestimation##predict:predict}}predictions,
residuals, influence statistics, and other diagnostic measures{p_end}
INCLUDE help post_predictnl
INCLUDE help post_pwcompare
INCLUDE help post_suest
INCLUDE help post_test
INCLUDE help post_testnl
{synoptline}
{p2colreset}{...}
INCLUDE help post_lrtest_star_msg

{p 4 6 2}For postestimation tests specific to time series, see 
{manhelp regress_postestimation_ts R:regress postestimation ts}.


{marker special}{...}
{title:Special-interest postestimation commands}

{pstd}
These commands provide tools for diagnosing sensitivity to individual
observations, analyzing residuals, and assessing specification.

{pstd}
{opt dfbeta} will calculate one, more than one, or all the DFBETAs after 
{cmd:regress}.  Although {opt predict} will also calculate DFBETAs, 
{cmd:predict} can do this for only one variable at a time.  {opt dfbeta} is
a convenience tool for those who want to calculate DFBETAs for multiple
variables.  The names for the new variables created are chosen automatically
and begin with the letters {cmd:_dfbeta_}.

{pstd}
{opt estat hettest} performs three versions of the 
{help regress postestimation##BP1979:Breusch-Pagan (1979)} and
{help regress postestimation##CW1983:Cook-Weisberg (1983)}
test for heteroskedasticity.  All three
versions of this test present evidence against the null hypothesis that
t=0 in Var(e)=sigma^2 exp(zt).  In
the {cmd:normal} version, performed by default, the null hypothesis also
includes the assumption that the regression disturbances are
independent-normal draws with variance sigma^2.  The normality assumption
is dropped from the null hypothesis in the {cmd:iid} and {cmd:fstat}
versions, which respectively produce the score and F tests discussed in
{mansection R regresspostestimationMethodsandformulas:{it:Methods and formulas}} in {bf:[R] regress postestimation}.
If {varlist} is not specified, the fitted values are used for z.  If
{it:varlist} or the {opt rhs} option is specified, the variables specified are
used for z.

{pstd}
{opt estat imtest} performs an information matrix test for the regression
model and an orthogonal decomposition into tests for heteroskedasticity,
skewness, and kurtosis due to 
{help regress postestimation##CT1990:Cameron and Trivedi (1990)};
White's test for homoskedasticity against unrestricted forms of
heteroskedasticity ({help regress postestimation##W1980:1980}) is
available as an option.  White's test is usually similar to the first term of
the Cameron-Trivedi decomposition.

{pstd}
{opt estat ovtest} performs two versions of the 
{help regress postestimation##R1969:Ramsey (1969)} regression
specification-error test (RESET) for omitted variables.  This test amounts to
fitting {bind:y=xb+zt+u} and then testing {bind:t=0}.  If the {opt rhs} option
is not specified, powers of the fitted values are used for z.  If {opt rhs} is
specified, powers of the individual elements of x are used.

{pstd}
{opt estat szroeter} performs Szroeter's rank test for heteroskedasticity for
each of the variables in {it:varlist} or for the explanatory variables of the
regression if {opt rhs} is specified.

{pstd}
{opt estat vif} calculates the centered or uncentered variance inflation
factors (VIFs) for the independent variables specified in a linear regression
model.

{pstd}
{opt acprplot} graphs an augmented component-plus-residual plot (a.k.a.
augmented partial residual plot) as described by 
{help regress postestimation##M1986:Mallows (1986)}.  This seems
to work better than the component-plus-residual plot for identifying
nonlinearities in the data.

{pstd}
{opt avplot} graphs an added-variable plot (a.k.a. partial-regression leverage
plot, partial regression plot, or adjusted partial residual plot) after
{cmd:regress}.  {it:indepvar} may be an independent variable (a.k.a.
predictor, carrier, or covariate) that is currently in the model or not.

{pstd}
{opt avplots} graphs all the added-variable plots in one image.

{pstd}
{opt cprplot} graphs a component-plus-residual plot (a.k.a. partial residual
plot) after {cmd:regress}.  {it:indepvar} must be an independent variable that
is currently in the model. 

{pstd}
{opt lvr2plot} graphs a leverage-versus-squared-residual plot (a.k.a. L-R
plot).

{pstd}
{opt rvfplot} graphs a residual-versus-fitted plot, a graph of the residuals
against the fitted values.

{pstd}
{opt rvpplot} graphs a residual-versus-predictor plot (a.k.a. independent
variable plot or carrier plot), a graph of the residuals against the specified
predictor.


{marker predict}{...}
{marker syntax_predict}{...}
{title:Syntax for predict}

{p 8 19 2}
{cmd:predict} {dtype} {newvar} {ifin} [{cmd:,} {it:statistic}]

{marker statistic}{...}
{synoptset 19 tabbed}{...}
{synopthdr:statistic}
{synoptline}
{syntab:Main}
{synopt :{opt xb}}linear prediction; the default{p_end}
{synopt :{opt r:esiduals}}residuals{p_end}
{synopt :{opt sc:ore}}score; equivalent to {opt residuals}{p_end}
{synopt :{opt rsta:ndard}}standardized residuals{p_end}
{synopt :{opt rstu:dent}}Studentized (jackknifed) residuals{p_end}
{synopt :{opt c:ooksd}}Cook's distance{p_end}
{synopt :{opt l:everage} | {opt h:at}}leverage (diagonal elements of 
hat matrix){p_end}
{synopt :{opt p:r}{cmd:(}{it:a}{cmd:,}{it:b}{cmd:)}}Pr(y | {it:a} < y < {it:b}){p_end}
{synopt :{opt e(a,b)}}{it:E}(y | {it:a} < y < {it:b}){p_end}
{synopt :{opt ys:tar(a,b)}}{it:E}(y*), y* = max{cmd:(}{it:a},min(y,{it:b}){cmd:)}{p_end}
{p2coldent:* {opth dfb:eta(varname)}}DFBETA for {it:varname}{p_end}
{synopt :{opt stdp}}standard error of the linear prediction{p_end}
{synopt :{opt stdf}}standard error of the forecast{p_end}
{synopt :{opt stdr}}standard error of the residual{p_end}
{p2coldent:* {opt cov:ratio}}COVRATIO{p_end}
{p2coldent:* {opt dfi:ts}}DFITS{p_end}
{p2coldent:* {opt w:elsch}}Welsch distance{p_end}
{synoptline}
{p2colreset}{...}
{p 4 6 2}Unstarred statistics are available both in and out of sample; 
{cmd:type predict ... if e(sample) ...} if wanted only for the estimation
sample.  Starred statistics are calculated only for the estimation sample,
even when if {cmd:e(sample)} is not specified.{p_end}
{p 4 6 2}
{opt rstandard},
{opt rstudent},
{opt cooksd},
{opt leverage},
{opt dfbeta()},
{opt stdf},
{opt stdr},
{opt covratio},
{opt dfits},
and {opt welsch} are not available if any
{opt vce()} other than {cmd:vce(ols)} was specified with {cmd:regress}.
{p_end}
{p 4 6 2}
{opt xb},
{opt residuals},
{opt score},
and
{opt stdp}
are the only options allowed with {cmd:svy} estimation results.
{p_end}

INCLUDE help whereab


INCLUDE help menu_predict


{marker options_predict}{...}
{title:Options for predict}

{dlgtab:Main}

{phang}
{opt xb}, the default, calculates the linear prediction.

{phang}
{opt residuals} calculates the residuals.

{phang}
{opt score} is equivalent to {opt residuals} in linear regression.

{phang}
{opt rstandard} calculates the standardized residuals.

{phang}
{opt rstudent} calculates the Studentized (jackknifed) residuals.

{phang}
{opt cooksd} calculates the Cook's D influence statistic
({help regress postestimation##C1977:Cook 1977}).

{phang}
{opt leverage} or {opt hat} calculates the diagonal elements of the
projection hat matrix.

INCLUDE help pr_opt

{phang}
{cmd:e(}{it:a}{cmd:,}{it:b}{cmd:)} calculates
{bind:{it:E}(xb+u | {it:a} < xb+u < {it:b})}, the expected value of y|x
conditional on y|x being in the interval ({it:a},{it:b}), meaning, y|x is
truncated.{break} {it:a} and {it:b} are specified as they are for {cmd:pr()}.

{phang}
{cmd:ystar(}{it:a}{cmd:,}{it:b}{cmd:)} calculates {it:E}(y*),
where {bind:y* = {it:a}} if {bind:xb+u {ul:<} {it:a}}, {bind:y* = {it:b}} if
{bind:xb+u {ul:>} {it:b}}, and {bind:y* = xb+u} otherwise, meaning y* is
censored.{break}
{it:a} and {it:b} are specified as they are for {cmd:pr()}.

{phang}
{opth dfbeta(varname)} calculates the DFBETA for {it:varname}, the difference
between the regression coefficient when the jth observation is included and
excluded, said difference being scaled by the estimated standard error of the
coefficient.  {it:varname} must have been included among the regressors in the
previously fitted model.  The calculation is automatically restricted to the
estimation subsample.

{phang}
{opt stdp} calculates the standard error of the prediction, which can be
thought of as the standard error of the predicted expected value or mean for
the observation's covariate pattern.  The standard error of the prediction is
also referred to as the standard error of the fitted value.

{phang}
{opt stdf} calculates the standard error of the forecast, which is the
standard error of the point prediction for 1 observation.  It is
commonly referred to as the standard error of the future or forecast value.
By construction, the standard errors produced by {opt stdf} are always larger
than those produced by {opt stdp}; see
{mansection R regresspostestimationMethodsandformulas:{it:Methods and formulas}} in {bf:[R] regress postestimation}.

{phang}
{opt stdr} calculates the standard error of the residuals.

{phang}
{opt covratio} calculates COVRATIO
({help regress postestimation##BKW1980:Belsley, Kuh, and Welsch 1980}),
a measure
of the influence of the jth observation based on considering the effect on the
variance-covariance matrix of the estimates.  The calculation is automatically
restricted to the estimation subsample.

{phang}
{opt dfits} calculates DFITS
({help regress postestimation##WK1977:Welsch and Kuh 1977})
and attempts to summarize
the information in the leverage versus residual-squared plot into one
statistic.  The calculation is automatically restricted to the estimation
subsample.

{phang}
{opt welsch} calculates Welsch distance
({help regress postestimation##W1982:Welsch 1982}) and is a variation on
{opt dfits}.  The calculation is automatically restricted to the estimation
subsample.


{marker syntax_dfbeta}{...}
{title:Syntax for dfbeta}

{p 8 18 2}
{cmd:dfbeta} [{it:{help indepvars:indepvar}}
		[{it:{help indepvars:indepvar}} [...]]]
		[{cmd:,} {opt stub(name)}]


{title:Menu}

{phang}
{bf:Statistics > Linear models and related > Regression diagnostics >}
            {bf:DFBETAs}


{marker option_dfbeta}{...}
{title:Option for dfbeta}

{phang}
{opt stub(name)} specifies the leading characters {cmd:dfbeta} uses to name
the new variables to be generated.  The default is {cmd:stub(_dfbeta_)}.


{marker estathett}{...}
{marker syntax_estat_hettest}{...}
{title:Syntax for estat hettest}

{p 8 17 2}
{cmd:estat} {opt hett:est} [{varlist}] 
   [{cmd:,} {opt r:hs} [{opt no:rmal} | {opt ii:d} | 
   {opt fs:tat}] {opt m:test}[{cmd:(}{it:spec}{cmd:)}]]


INCLUDE help menu_estat
 

{title:Options for estat hettest}

{phang}
{opt rhs} specifies that tests for heteroskedasticity be performed for the
right-hand-side (explanatory) variables of the fitted regression model.
The {opt rhs} option may be combined with a {varlist}.

{phang}
{opt normal}, the default, causes {opt estat hettest} to compute the
original Breusch-Pagan/Cook-Weisberg test, which assumes that the regression
disturbances are normally distributed.

{phang}
{opt iid} causes {opt estat hettest} to compute the N*R2 version of the
score test that drops the normality assumption.

{phang}
{opt fstat} causes {opt estat hettest} to compute the F-statistic version
that drops the normality assumption.

{phang}
{opt mtest}[{cmd:(}{it:spec}{cmd:)}] specifies that multiple testing be
performed.  The argument specifies how p-values are adjusted.  The following
specifications, {it:spec}, are supported:

        {opt b:onferroni}    Bonferroni's multiple testing adjustment
        {opt h:olm}          Holm's multiple testing adjustment
        {opt s:idak}         Sidak's multiple testing adjustment
        {opt noadj:ust}      no adjustment is made for multiple testing

{pmore}
{opt mtest} may be specified without an argument.  This is equivalent to
specifying {cmd:mtest(noadjust)}; that is, tests for the individual variables
should be performed with unadjusted p-values.  By default, {opt estat hettest}
does not perform multiple testing.
{opt mtest} may not be specified with {opt iid} or {opt fstat}.


{marker estatimtest}{...}
{marker syntax_estat_imtest}{...}
{title:Syntax for estat imtest}

{p 8 17 2}
{cmd:estat} {opt imt:est} [{cmd:,} {opt p:reserve} {opt wh:ite}]


INCLUDE help menu_estat
 

{title:Options for estat imtest}

{phang}
{opt preserve} specifies that the data in memory be preserved, all variables
and cases that are not needed in the calculations be dropped, and at the
conclusion the original data be restored.  This option is costly for large
datasets.  However, because {opt estat imtest} has to perform an auxiliary
regression on k(k+1)/2 temporary variables, where k is the number of
regressors, it may not be able to perform the test otherwise.

{phang}
{opt white} specifies that White's original heteroskedasticity test also be
performed.


{marker estatovt}{...}
{marker syntax_estat_ovtest}{...}
{title:Syntax for estat ovtest}

{p 8 17 2}
{cmd:estat} {opt ovt:est} [{cmd:,} {opt r:hs}]


INCLUDE help menu_estat
 

{title:Option for estat ovtest}

{phang}
{opt rhs} specifies that powers of the right-hand-side (explanatory) variables
be used in the test rather than powers of the fitted values.


{marker estatszroeter}{...}
{marker syntax_estat_szroeter}{...}
{title:Syntax for estat szroeter}

{p 8 17 2}
{cmd:estat} {opt szr:oeter} [{varlist}] 
   [{cmd:,} {opt r:hs} {opt m:test}{cmd:(}{it:spec}{cmd:)}]

{phang}
Either {it:varlist} or {cmd:rhs} must be specified.


INCLUDE help menu_estat
 

{title:Options for estat szroeter}

{phang}
{opt rhs} specifies that tests for heteroskedasticity be performed for the
right-hand-side (explanatory) variables of the fitted regression model.
The {opt rhs} option may be combined with a {varlist}.

{phang}
{opt mtest}{cmd:(}{it:spec}{cmd:)} specifies that multiple testing be
performed.  The argument specifies how p-values are adjusted.  The following
specifications, {it:spec}, are supported:

        {opt b:onferroni}    Bonferroni's multiple testing adjustment
        {opt h:olm}          Holm's multiple testing adjustment
        {opt s:idak}         Sidak's multiple testing adjustment
        {opt noadj:ust}      no adjustment is made for multiple testing

{pmore}
{opt estat szroeter} always performs multiple testing.  By default, it does
not adjust the p-values.


{marker estatvif}{...}
{marker syntax_estat_vif}{...}
{title:Syntax for estat vif}

{p 8 17 2}
{cmd:estat vif} [{cmd:,} {opt unc:entered}]


INCLUDE help menu_estat
 

{title:Option for estat vif}

{phang}
{opt uncentered} requests the computation of the uncentered variance inflation
factors.  This option is often used to detect the collinearity of the
regressors with the constant.  {cmd:estat vif, uncentered} may be used after
regression models fit without the constant term.


{marker acprplot}{...}
{marker syntax_acprplot}{...}
{title:Syntax for acprplot}

{p 8 19 2}
{cmd:acprplot} {it:{help indepvars:indepvar}} [{cmd:,} {it:acprplot_options}]

{synoptset 27 tabbed}{...}
{synopthdr:acprplot_options}
{synoptline}
{syntab:Plot}
INCLUDE help gr_markopt

{syntab:Reference line}
{synopt :{opth rlop:ts(cline_options)}}affect rendition of the reference
line{p_end}

{syntab:Options}
{synopt :{opt low:ess}}add a lowess smooth of the plotted points{p_end}
{synopt :{opth lsop:ts(lowess:lowess_options)}}affect rendition of the lowess
smooth{p_end}
{synopt :{opt msp:line}}add median spline of the plotted points{p_end}
{synopt :{opth msop:ts(twoway_mspline:mspline_options)}}affect rendition of the spline{p_end}

{syntab:Add plots}
{synopt :{opth "addplot(addplot_option:plot)"}}add other plots to the generated graph{p_end}

{syntab:Y axis, X axis, Titles, Legend, Overall}
{synopt :{it:twoway_options}}any options other than {opt by()}
  documented in {manhelpi twoway_options G-3}{p_end}
{synoptline}
{p2colreset}{...}


{title:Menu}

{phang}
{bf:Statistics > Linear models and related > Regression diagnostics >}
    {bf:Augmented component-plus-residual plot}


{title:Options for acprplot}

{dlgtab:Plot}

INCLUDE help gr_markoptf

{dlgtab:Reference line}

{phang}
{opt rlopts(cline_options)} affects the rendition of the reference line.
See {manhelpi cline_options G-3}.

{dlgtab:Options}

{phang}
{opt lowess} adds a lowess smooth of the plotted points to assist in
detecting nonlinearities.

{phang}
{opt lsopts(lowess_options)} affects the rendition of the lowess smooth.  For
an explanation of these options, especially the {opt bwidth()} option, see
{manhelp lowess R}.  Specifying {opt lsopts()} implies the {opt lowess} option.

{phang}
{opt mspline} adds a median spline of the plotted points to assist in
detecting nonlinearities.

{phang}
{opt msopts(mspline_options)} affects the rendition of the spline.  For an
explanation of these options, especially the {opt bands()} option, see 
{manhelp twoway_mspline G-2:graph twoway mspline}.  Specifying {opt msopts()}
implies the {opt mspline} option.

{dlgtab:Add plots}

{phang}
{opt addplot(plot)} provides a way to add other plots to the generated graph.
See {manhelpi addplot_option G-3}.

{dlgtab:Y axis, X axis, Titles, Legend, Overall}

{phang}
{it:twoway_options} are any of the options documented in 
{manhelpi twoway_options G-3}, excluding {opt by()}.  These include options for
titling the graph (see {manhelpi title_options G-3}) and for saving the 
graph to disk (see {manhelpi saving_option G-3}).


{marker avplot}{...}
{marker syntax_avplot}{...}
{title:Syntax for avplot}

{p 8 18 2}
{cmd:avplot} {it:{help indepvars:indepvar}} [{cmd:,} {it:avplot_options}]

{synoptset 25 tabbed}{...}
{synopthdr:avplot_options}
{synoptline}
{syntab:Plot}
INCLUDE help gr_markopt

{syntab:Reference line}
{synopt :{opth rlop:ts(cline_options)}}affect rendition of the reference line
{p_end}

{syntab:Add plots}
{synopt :{opth "addplot(addplot_option:plot)"}}add other plots to the generated graph{p_end}

{syntab:Y axis, X axis, Titles, Legend, Overall}
{synopt :{it:twoway_options}}any options other than {opt by()}
  documented in {manhelpi twoway_options G-3}{p_end}
{synoptline}
{p2colreset}{...}


{title:Menu}

{phang}
{bf:Statistics > Linear models and related > Regression diagnostics >}
      {bf:Added-variable plot}


{title:Options for avplot}

{dlgtab:Plot}

INCLUDE help gr_markoptf

{dlgtab:Reference line}

{phang}
{opt rlopts(cline_options)} affect the rendition of the reference line.  See 
{manhelpi cline_options G-3}.

{dlgtab:Add plots}

{phang}
{opt addplot(plot)} provides a way to add other plots to the generated graph.
See {manhelpi addplot_option G-3}.

{dlgtab:Y axis, X axis, Titles, Legend, Overall}

{phang}
{it:twoway_options} are any of the options documented in 
{manhelpi twoway_options G-3}, excluding {opt by()}.  These include the options
for titling the graph (see {manhelpi title_options G-3}) and for saving
the graph to disk (see {manhelpi saving_option G-3}).


{marker avplots}{...}
{marker syntax_avplots}{...}
{title:Syntax for avplots}

{p 8 18 2}
{cmd:avplots} [{cmd:,} {it:avplots_options}]

{synoptset 25 tabbed}{...}
{synopthdr:avplots_options}
{synoptline}
{syntab:Plot}
INCLUDE help gr_markopt
{synopt :{it:combine_options}}any of the options
documented in {manhelp graph_combine G-2:graph combine}{p_end}

{syntab:Reference line}
{synopt :{opth rlop:ts(cline_options)}}affect rendition of the reference
line{p_end}

{syntab:Y axis, X axis, Titles, Legend, Overall}
{synopt :{it:twoway_options}}any options other than {opt by()}
  documented in {manhelpi twoway_options G-3}{p_end}
{synoptline}
{p2colreset}{...}


{title:Menu}

{phang}
{bf:Statistics > Linear models and related > Regression diagnostics >}
         {bf:Added-variable plot}


{title:Options for avplots}

{dlgtab:Plot}

INCLUDE help gr_markoptf

{phang}
{it:combine_options} are any of the options documented in 
{helpb graph combine:[G-2] graph combine}.  These include options for titling
the graph (see {manhelpi title_options G-3}) and for saving the graph to disk
(see {manhelpi saving_option G-3}).

{dlgtab:Reference line}

{phang}
{opt rlopts(cline_options)} affect the rendition of the reference line.  See 
{manhelpi cline_options G-3}.  

{dlgtab:Y axis, X axis, Titles, Legend, Overall}

{phang}
{it:twoway_options} are any of the options documented in 
{manhelpi twoway_options G-3}, excluding {opt by()}.  These include the options
for titling the graph (see {manhelpi title_options G-3}) and for saving
the graph to disk (see {manhelpi saving_option G-3}).


{marker cprplot}{...}
{marker syntax_cprplot}{...}
{title:Syntax for cprplot}

{p 8 18 2}
{cmd:cprplot} {it:{help indepvars:indepvar}} 
[{cmd:,} {it:cprplot_options}]

{synoptset 27 tabbed}{...}
{synopthdr:cprplot_options}
{synoptline}
{syntab:Plot}
INCLUDE help gr_markopt

{syntab:Reference line}
{synopt :{opth rlop:ts(cline_options)}}affect rendition of the reference 
line{p_end}

{syntab:Options}
{synopt :{opt low:ess}}add a lowess smooth of the plotted points{p_end}
{synopt :{opth lsop:ts(lowess:lowess_options)}}affect rendition of the lowess smooth
{p_end}
{synopt :{opt msp:line}}add median spline of the plotted points{p_end}
{synopt :{opth msop:ts(twoway_mspline:mspline_option)}}affect rendition of the spline{p_end}

{syntab:Add plots}
{synopt :{opth "addplot(addplot_option:plot)"}}add other plots to the generated graph{p_end}

{syntab:Y axis, X axis, Titles, Legend, Overall}
{synopt :{it:twoway_options}}any options other than {opt by()} documented in 
{manhelpi twoway_options G-3}{p_end}
{synoptline}
{p2colreset}{...}


{title:Menu}

{phang}
{bf:Statistics > Linear models and related > Regression diagnostics >}
        {bf:Component-plus-residual plot}


{title:Options for cprplot}

{dlgtab:Plot}

INCLUDE help gr_markoptf

{dlgtab:Reference line}

{phang}
{opt rlopts(cline_options)} affects the rendition of the reference line.  
See {manhelpi cline_options G-3}.

{dlgtab:Options}

{phang}
{opt lowess} adds a lowess smooth of the plotted points to assist in
detecting nonlinearities.

{phang}
{opt lsopts(lowess_options)} affects the rendition of the lowess smooth.  For
an explanation of these options, especially the {opt bwidth()} option, see
{manhelp lowess R}.  Specifying {opt lsopts()} implies the {opt lowess} option.

{phang}
{opt mspline} adds a median spline of the plotted points to assist in
detecting nonlinearities.

{phang}
{opt msopts(mspline_options)} affects the rendition of the spline.  For an
explanation of these options, especially the {opt bands()} option, see 
{manhelp twoway_mspline G-2:graph twoway mspline}.  Specifying {opt msopts()}
implies the {opt mspline} option.

{dlgtab:Add plots}

{phang}
{opt addplot(plot)} provides a way to add other plots to the generated graph.  
See {manhelpi addplot_option G-3}.

{dlgtab:Y axis, X axis, Titles, Legend, Overall}

{phang}
{it:twoway_options} are any of the options documented in 
{manhelpi twoway_options G-3}, excluding {opt by()}.  These include options for
titling the graph (see {manhelpi title_options G-3}) and for saving 
the graph to disk (see {manhelpi saving_option G-3}).


{marker lvr2plot}{...}
{marker syntax_lvr2plot}{...}
{title:Syntax for lvr2plot}

{p 8 20 2}
{cmd:lvr2plot} 
[{cmd:,} {it:lvr2plot_options}]

{synoptset 24 tabbed}{...}
{synopthdr:lvr2plot_options}
{synoptline}
{syntab:Plot}
INCLUDE help gr_markopt

{syntab:Add plots}
{synopt :{opth "addplot(addplot_option:plot)"}}add other plots to the generated graph{p_end}

{syntab:Y axis, X axis, Titles, Legend, Overall}
{synopt :{it:twoway_options}}any options other than {opt by()}
   documented in {manhelpi twoway_options G-3}{p_end}
{synoptline}
{p2colreset}{...}


{title:Menu}

{phang}
{bf:Statistics > Linear models and related > Regression diagnostics >}
        {bf:Leverage-versus-squared-residual plot}


{title:Options for lvr2plot}

{dlgtab:Plot}

INCLUDE help gr_markoptf

{dlgtab:Add plots}

{phang}
{opt addplot(plot)} provides a way to add other plots to the generated graph.
See {manhelpi addplot_option G-3}.

{dlgtab:Y axis, X axis, Titles, Legend, Overall}

{phang}
{it:twoway_options} are any of the options documented in 
{manhelpi twoway_options G-3}, excluding {opt by()}.  These include options for
titling the graph (see {manhelpi title_options G-3}) and for saving the
graph to disk (see {manhelpi saving_option G-3}).


{marker rvfplot}{...}
{marker syntax_rvfplot}{...}
{title:Syntax for rvfplot}

{p 8 19 2}
{cmd:rvfplot} 
[{cmd:,} {it:rvfplot_options}]

{synoptset 23 tabbed}{...}
{synopthdr:rvfplot_options}
{synoptline}
{syntab:Plot}
INCLUDE help gr_markopt

{syntab:Add plots}
{synopt :{opth "addplot(addplot_option:plot)"}}add plots to the generated graph{p_end}

{syntab:Y axis, X axis, Titles, Legend, Overall}
{synopt :{it:twoway_options}}any options other than {opt by()}
 documented in {manhelpi twoway_options G-3}{p_end}
{synoptline}
{p2colreset}{...}


{title:Menu}

{phang}
{bf:Statistics > Linear models and related > Regression diagnostics >}
        {bf:Residual-versus-fitted plot}


{title:Options for rvfplot}

{dlgtab:Plot}

INCLUDE help gr_markoptf

{dlgtab:Add plots}

{phang}
{opt addplot(plot)} provides a way to add plots to the generated graph.  
See {manhelpi addplot_option G-3}.

{dlgtab:Y axis, X axis, Titles, Legend, Overall}

{phang}
{it:twoway_options} are any of the options documented in
{manhelpi twoway_options G-3}, excluding {opt by()}.  These include options for
titling the graph (see {manhelpi title_options G-3}) and for saving the
graph to disk (see {manhelpi saving_option G-3}).


{marker rvpplot}{...}
{marker syntax_rvpplot}{...}
{title:Syntax for rvpplot}

{p 8 19 2}
{cmd:rvpplot} {it:{help indepvars:indepvar}}
[{cmd:,} {it:rvpplot_options}]

{synoptset 23 tabbed}{...}
{synopthdr:rvpplot_options}
{synoptline}
{syntab:Plot}
INCLUDE help gr_markopt

{syntab:Add plots}
{synopt :{opth "addplot(addplot_option:plot)"}}add plots to the generated graph{p_end}

{syntab:Y axis, X axis, Titles, Legend, Overall}
{synopt :{it:twoway_options}}any options other than {opt by()}
 documented in {manhelpi twoway_options G-3}{p_end}
{synoptline}
{p2colreset}{...}


{title:Menu}

{phang}
{bf:Statistics > Linear models and related > Regression diagnostics >}
         {bf:Residual-versus-predictor plot}


{title:Options for rvpplot}

{dlgtab:Plot}

INCLUDE help gr_markoptf

{dlgtab:Add plots}

{phang}
{opt addplot(plot)} provides a way to add plots to the generated graph.
See {manhelpi addplot_option G-3}.

{dlgtab:Y axis, X axis, Titles, Legend, Overall}

{phang}
{it:twoway_options} are any of the options documented in
{manhelpi twoway_options G-3}, excluding {opt by()}.  These include options for
titling the graph (see {manhelpi title_options G-3}) and for saving the
graph to disk (see {manhelpi saving_option G-3}).


{marker examples}{...}
{title:Examples}

    {hline}
    Setup
{phang2}{cmd:. sysuse auto}{p_end}
{phang2}{cmd:. regress mpg weight c.weight#c.weight foreign}{p_end}

{pstd}Obtain predicted values{p_end}
{phang2}{cmd:. predict pmpg}{p_end}
{phang2}{cmd:. summarize pmpg mpg}{p_end}

    {hline}
    Setup
{phang2}{cmd:. webuse newautos, clear}{p_end}

{pstd}Obtain out-of-sample prediction{p_end}
{phang2}{cmd:. predict mpg}{p_end}

{pstd}Obtain standard error of the forecast{p_end}
{phang2}{cmd:. predict se_mpg, stdf}{p_end}

    {hline}
    Setup
{phang2}{cmd:. sysuse auto, clear}{p_end}
{phang2}{cmd:. regress price weight foreign##c.mpg}{p_end}

{pstd}Residual-versus-fitted plot{p_end}
{phang2}{cmd:. rvfplot, yline(10)}{p_end}

{pstd}Added-variable plot{p_end}
{phang2}{cmd:. avplot mpg}{p_end}

{pstd}Added-variable plots for every regressor{p_end}
{phang2}{cmd:. avplots}{p_end}

    {hline}
    Setup
{phang2}{cmd:. webuse auto1}{p_end}
{phang2}{cmd:. regress price mpg weight}{p_end}

{pstd}Component-plus-residual plot{p_end}
{phang2}{cmd:. cprplot mpg, mspline msopts(bands(13))}{p_end}

{pstd}Augmented component-plus-residual plot{p_end}
{phang2}{cmd:. acprplot mpg, mspline msopts(bands(13))}{p_end}

{pstd}Residual-versus-predictor plot{p_end}
{phang2}{cmd:. rvpplot mpg, yline(0)}{p_end}

    {hline}
    Setup
{phang2}{cmd:. sysuse auto}{p_end}
{phang2}{cmd:. regress mpg weight c.weight#c.weight foreign}{p_end}

{pstd}Diagonal elements of projection matrix{p_end}
{phang2}{cmd:. predict xdist, hat}{p_end}

    {hline}
    Setup
{phang2}{cmd:. sysuse auto, clear}{p_end}
{phang2}{cmd:. regress price weight foreign##c.mpg}{p_end}

{pstd}Leverage-versus-residual-squared plot{p_end}
{phang2}{cmd:. lvr2plot}{p_end}

{pstd}Standardized residuals{p_end}
{phang2}{cmd:. predict esta if e(sample), rstandard}{p_end}

{pstd}Studentized residuals{p_end}
{phang2}{cmd:. predict estu if e(sample), rstudent}{p_end}

    {hline}
    Setup
{phang2}{cmd:. sysuse auto, clear}{p_end}
{phang2}{cmd:. regress price weight foreign##c.mpg}{p_end}

{pstd}DFITS influence measure{p_end}
{phang2}{cmd:. predict dfits, dfits}{p_end}

{pstd}Cook's distance{p_end}
{phang2}{cmd:. predict cooksd if e(sample), cooksd}{p_end}

{pstd}Welsch distance{p_end}
{phang2}{cmd:. predict wd, welsch}{p_end}

{pstd}COVRATIO influence measure{p_end}
{phang2}{cmd:. predict covr, covratio}{p_end}

{pstd}DFBETAs influence measure{p_end}
{phang2}{cmd:. sort foreign make}{p_end}
{phang2}{cmd:. predict dfor, dfbeta(1.foreign)}{p_end}

{pstd}DFBETAs for all variables in regression{p_end}
{phang2}{cmd:. dfbeta}{p_end}

{pstd}Ramsey's test for omitted variables{p_end}
{phang2}{cmd:. estat ovtest}{p_end}

{pstd}Test for heteroskedasticity{p_end}
{phang2}{cmd:. estat hettest}{p_end}
{phang2}{cmd:. estat hettest weight foreign##c.mpg, mtest(b)}{p_end}

{pstd}Rank test for heteroskedasticity{p_end}
{phang2}{cmd:. estat szroeter, rhs mtest(holm)}{p_end}

{pstd}Tests for heteroskedasticity, skewness, and kurtosis{p_end}
{phang2}{cmd:. estat imtest}{p_end}

    {hline}
    Setup
{phang2}{cmd:. webuse bodyfat, clear}{p_end}
{phang2}{cmd:. regress bodyfat tricep thigh midarm}{p_end}

{pstd}Variance inflation factors{p_end}
{phang2}{cmd:. estat vif}{p_end}

    {hline}
{pstd}Setup{p_end}
{phang2}{cmd:. webuse nhanes2}

{pstd}Regress systolic blood pressure on age group, sex, and their interaction{p_end}
{phang2}{cmd:. regress bpsystol agegrp##sex}

{pstd}Predictive margins of blood pressure for age groups{p_end}
{phang2}{cmd:. margins agegrp}

{pstd}Profile plot of margins{p_end}
{phang2}{cmd:. marginsplot}

{pstd}Margins for interaction between age group and sex{p_end}
{phang2}{cmd:. margins agegrp#sex}

{pstd}Interaction plot{p_end}
{phang2}{cmd:. marginsplot}

{pstd}Estimate for each age group a contrast comparing men and women{p_end}
{phang2}{cmd:. margins r.sex@agegrp}

{pstd}Plot contrasts and confidence intervals against age group{p_end}
{phang2}{cmd:. marginsplot}

    {hline}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:estat hettest} saves the following results for the (multivariate) score
test in {cmd:r()}:

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Scalars}{p_end}
{synopt:{cmd:r(chi2)}}chi-squared test statistic{p_end}
{synopt:{cmd:r(df)}}#df for the asymptotic chi-squared distribution under
	H_0{p_end}
{synopt:{cmd:r(p)}}p-value{p_end}

{pstd}
{cmd:estat hettest, fstat} saves the results for the (multivariate) score test
in {cmd:r()}:

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Scalars}{p_end}
{synopt:{cmd:r(F)}}test statistic{p_end}
{synopt:{cmd:r(df_m)}}#df of the test for the F distribution under H_0{p_end}
{synopt:{cmd:r(df_r)}}#df of the residuals for the F distribution under
        H_0{p_end}
{synopt:{cmd:r(p)}}p-value{p_end}

{pstd}
{cmd:estat hettest} (if {cmd:mtest} is specified) and {cmd:estat szroeter}
save the following in {cmd:r()}:

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Matrices}{p_end}
{synopt:{cmd:r(mtest)}}a matrix of test results, with rows corresponding to
the univariate tests{p_end}

       {cmd:mtest[.,1]}    chi-squared test statistic
       {cmd:mtest[.,2]}    #df
       {cmd:mtest[.,3]}    unadjusted p-value
       {cmd:mtest[.,4]}    adjusted p-value (if an {cmd:mtest()} adjustment
                             method is specified)

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Macros}{p_end}
{synopt:{cmd:r(mtmethod)}}adjustment method for p-value{p_end}

{pstd}
{cmd:estat imtest} saves the following in {cmd:r()}:

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Scalars}{p_end}
{synopt:{cmd:r(chi2_t)}}IM-test statistic (= {cmd:r(chi2_h)} + {cmd:r(chi2_s)}
+ {cmd:r(chi2_k)}){p_end}
{synopt:{cmd:r(df_t)}}df for limiting chi-squared distribution under H_0 (=
{cmd:r(df_h)} + {cmd:r(df_s)} + {cmd:r(df_k)}){p_end}
{synopt:{cmd:r(chi2_h)}}heteroskedasticity test statistic{p_end}
{synopt:{cmd:r(df_h)}}df for limiting chi-squared distribution under H_0{p_end}
{synopt:{cmd:r(chi2_s)}}skewness test statistic{p_end}
{synopt:{cmd:r(df_s)}}df for limiting chi-squared distribution under H_0{p_end}
{synopt:{cmd:r(chi2_k)}}kurtosis test statistic{p_end}
{synopt:{cmd:r(df_k)}}df for limiting chi-squared distribution under H_0{p_end}
{synopt:{cmd:r(chi2_w)}}White's heteroskedasticity test (if {cmd:white}
specified){p_end}
{synopt:{cmd:r(df_w)}}df for limiting chi-squared distribution under H_0{p_end}

{pstd}
{cmd:estat ovtest} saves the following in {cmd:r()}:

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Scalars}{p_end}
{synopt:{cmd:r(p)}}two-sided p-value{p_end}
{synopt:{cmd:r(F)}}F statistic{p_end}
{synopt:{cmd:r(df)}}degrees of freedom{p_end}
{synopt:{cmd:r(df_r)}}residual degrees of freedom{p_end}
{p2colreset}{...}


{marker references}{...}
{title:References}

{marker BKW1980}{...}
{phang}
Belsley, D. A., E. Kuh, and R. E. Welsch. 1980. {it:Regression Diagnostics:}
{it:Identifying Influential Data and Sources of Collinearity}.
New York: Wiley.

{marker BP1979}{...}
{phang}
Breusch, T. S., and A. R. Pagan. 1979. A simple test for heteroscedasticity and
random coefficient variation. {it:Econometrica} 47: 1287-1294.

{marker CT1990}{...}
{phang}
Cameron, A. C., and P. K. Trivedi. 1990. The information matrix test and its
applied alternative hypotheses. Working Paper 372, University of
California-Davis, Institute of Governmental Affairs.

{marker C1977}{...}
{phang}
Cook, R. D. 1977. Detection of influential observations in linear regression.
{it:Technometrics} 19: 15-18.

{marker CW1983}{...}
{phang}
Cook, R. D., and S. Weisberg. 1983.  Diagnostics for heteroscedasticity in
regression. {it:Biometrika} 70: 1-10.

{marker M1986}{...}
{phang}
Mallows, C. L. 1986. Augmented partial residuals. {it:Technometrics} 28:
313-319.

{marker R1969}{...}
{phang}
Ramsey, J. B. 1969.  Tests for specification errors in classical linear
least-squares regression analysis.  {it:Journal of the Royal Statistical}
{it:Society, Series B} 31: 350-371.

{marker W1982}{...}
{phang}
Welsch, R. E. 1982. Influence functions and regression diagnostics. In 
{it:Modern Data Analysis}, ed. R. L. Launer and A. F. Siegel, 149-169.
New York: Academic Press.

{marker WK1977}{...}
{phang}
Welsch, R. E., and E. Kuh. 1977.  Linear Regression Diagnostics.
Technical Report 923-77, Massachusetts Institute of Technology,
Cambridge, MA.

{marker W1980}{...}
{phang}
White, H. 1980. A heteroskedasticity-consistent covariance matrix estimator and
a direct test for heteroskedasticity. {it:Econometrica} 48: 817-838.
{p_end}
