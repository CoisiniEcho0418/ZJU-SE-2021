{smcl}
{* *! version 1.1.13  03may2011}{...}
{viewerdialog predict "dialog logit_p"}{...}
{viewerdialog estat "dialog logit_estat"}{...}
{viewerdialog lroc "dialog lroc"}{...}
{viewerdialog lsens "dialog lsens"}{...}
{vieweralsosee "[R] logistic postestimation" "mansection R logisticpostestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] logistic" "help logistic"}{...}
{viewerjumpto "Description" "logistic postestimation##description"}{...}
{viewerjumpto "Special-interest postestimation commands" "logistic postestimation##special"}{...}
{viewerjumpto "" "--"}{...}
{viewerjumpto "Syntax for predict" "logistic postestimation##syntax_predict"}{...}
{viewerjumpto "Options for predict" "logistic postestimation##options_predict"}{...}
{viewerjumpto "" "--"}{...}
{viewerjumpto "Syntax for estat classification" "logistic postestimation##syntax_estat_class"}{...}
{viewerjumpto "Options for estat classification" "logistic postestimation##options_estat_class"}{...}
{viewerjumpto "Syntax for estat gof" "logistic postestimation##syntax_estat_gof"}{...}
{viewerjumpto "Options for estat gof" "logistic postestimation##options_estat_gof"}{...}
{viewerjumpto "Syntax for lroc" "logistic postestimation##syntax_lroc"}{...}
{viewerjumpto "Options for lroc" "logistic postestimation##options_lroc"}{...}
{viewerjumpto "Syntax for lsens" "logistic postestimation##syntax_lsens"}{...}
{viewerjumpto "Options for lsens" "logistic postestimation##options_lsens"}{...}
{viewerjumpto "" "--"}{...}
{viewerjumpto "Examples" "logistic postestimation##examples"}{...}
{viewerjumpto "Saved results" "logistic postestimation##saved_results"}{...}
{viewerjumpto "References" "logistic postestimation##references"}{...}
{title:Title}

{p2colset 5 36 38 2}{...}
{p2col :{manlink R logistic postestimation} {hline 2}}Postestimation tools for
logistic{p_end}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
The following postestimation commands are of special interest after
{cmd:logistic}:

{synoptset 20}{...}
{p2coldent :Command}Description{p_end}
{synoptline}
{synopt :{helpb logistic postestimation##estatclas:estat classification}}report various summary statistics, including the classification table{p_end}
{synopt :{helpb logistic postestimation##estatgof:estat gof}}Pearson or Hosmer-Lemeshow goodness-of-fit test{p_end}
{synopt :{helpb logistic postestimation##lroc:lroc}}compute area under ROC curve and graph the curve{p_end}
{synopt :{helpb logistic postestimation##lsens:lsens}}graph sensitivity and specificity versus probability cutoff{p_end}
{synoptline}
{p2colreset}{...}
{p 4 6 2}
These commands are not appropriate after the {cmd:svy} prefix.
{p_end}

{pstd}
The following standard postestimation commands are also available:

{synoptset 14 notes}{...}
{p2coldent :Command}Description{p_end}
{synoptline}
INCLUDE help post_contrast
INCLUDE help post_estat
INCLUDE help post_svy_estat
INCLUDE help post_estimates
INCLUDE help post_lincom
INCLUDE help post_linktest
INCLUDE help post_lrtest_star
INCLUDE help post_margins
INCLUDE help post_marginsplot
INCLUDE help post_nlcom
{synopt :{helpb logistic postestimation##predict:predict}}predictions, residuals, influence statistics, and other diagnostic measures{p_end}
INCLUDE help post_predictnl
INCLUDE help post_pwcompare
INCLUDE help post_suest
INCLUDE help post_test
INCLUDE help post_testnl
{synoptline}
{p2colreset}{...}
INCLUDE help post_lrtest_star_msg


{marker special}{...}
{title:Special-interest postestimation commands}

{pstd}
{cmd:estat classification} reports various summary statistics, including the
classification table.

{pstd}
{cmd:estat gof} reports the Pearson goodness-of-fit test or the
Hosmer-Lemeshow goodness-of-fit test.

{pstd}
{cmd:lroc} graphs the ROC curve and calculates the area under the curve.

{pstd}
{cmd:lsens} graphs sensitivity and specificity versus probability cutoff and
optionally creates new variables containing these data.

{pstd}
{cmd:estat classification}, {cmd:estat gof}, {cmd:lroc}, and {cmd:lsens}
produce statistics and graphs either for the estimation sample or for any
set of observations.  However, they always use the estimation sample by
default.  When weights, {opt if}, or {opt in} is used with
{cmd:logistic}, it is not necessary to repeat the qualifier with these
commands when you want statistics computed for the estimation sample.  Specify
{opt if}, {opt in}, or the {opt all} option only when you want statistics
computed for a set of observations other than the estimation sample.  Specify
weights (only {opt fweight}s are allowed with these commands) only when you
want to use a different set of weights.

{pstd}
By default, {cmd:estat classification}, {cmd:estat gof}, {cmd:lroc}, and
{cmd:lsens} use the last model fit by {cmd:logistic}.  You may also
directly specify the model to the {cmd:lroc} and {cmd:lsens} commands by
inputting a vector of coefficients with the {opt beta()} option and passing
the name of the dependent variable {depvar}.

{pstd}
{cmd:estat classification} and {cmd:estat gof} require that the current
estimation results be from {cmd:logistic}, {cmd:logit}, or {cmd:probit}.
{cmd:lroc} and {cmd:lsens} commands may also be used after {cmd:logit} or
{cmd:probit}.


{marker syntax_predict}{...}
{marker predict}{...}
{title:Syntax for predict}

{p 8 16 2}
{cmd:predict} {dtype} {newvar} {ifin} 
[{cmd:,} {it:statistic} {opt nooff:set} {opt rule:s} {opt asif}]

{synoptset 14 tabbed}{...}
{synopthdr :statistic}
{synoptline}
{syntab :Main}
{synopt :{opt p:r}}probability of a positive outcome; the default{p_end}
{synopt :{cmd:xb}}linear prediction{p_end}
{synopt :{cmd:stdp}}standard error of the prediction{p_end}
{p2coldent :* {opt db:eta}}{help logistic postestimation##P1981:Pregibon (1981)} Delta-Beta influence statistic{p_end}
{p2coldent :* {opt de:viance}}deviance residual{p_end}
{p2coldent :* {opt dx:2}}{help logistic postestimation##HL2000:Hosmer and Lemeshow (2000)} Delta
chi-squared influence statistic{p_end}
{p2coldent :* {opt dd:eviance}}{help logistic postestimation##HL2000:Hosmer and Lemeshow (2000)} Delta-D
influence statistic{p_end}
{p2coldent :* {opt h:at}}{help logistic postestimation##P1981:Pregibon (1981)} leverage{p_end}
{p2coldent :* {opt n:umber}}sequential number of the covariate
pattern{p_end}
{p2coldent :* {opt r:esiduals}}Pearson residuals; adjusted for number
sharing covariate pattern{p_end}
{p2coldent :* {opt rs:tandard}}standardized Pearson residuals; adjusted
for number sharing covariate pattern{p_end}
{synopt :{opt sc:ore}}first derivative of the log likelihood with respect to xb{p_end}
{synoptline}
{p2colreset}{...}
INCLUDE help unstarred
{p 4 6 2}
{opt pr}, {opt xb}, {opt stdp}, and {opt score} are the only options allowed
with {cmd:svy} estimation results.


INCLUDE help menu_predict


{marker options_predict}{...}
{title:Options for predict}

{dlgtab:Main}

{phang}
{opt pr}, the default, calculates the probability of a positive outcome.

{phang}
{opt xb} calculates the linear prediction.

{phang}
{opt stdp} calculates the standard error of the linear prediction.

{phang}
{opt dbeta} calculates the {help logistic postestimation##P1981:Pregibon (1981)}
Delta-Beta influence statistic, a standardized measure of the difference in the
coefficient vector that is due to deletion of the observation along with all
others that share the same covariate pattern.  In
{help logistic postestimation##HL2000:Hosmer and Lemeshow (2000, 144-145)}
jargon, this statistic is M-asymptotic; that is, it is adjusted for the number
of observations that share the same covariate pattern.

{phang}
{opt deviance} calculates the deviance residual.  

{phang}
{opt dx2} calculates the
{help logistic postestimation##HL2000:Hosmer and Lemeshow (2000, 174)} Delta
chi-squared influence statistic, reflecting the decrease in the Pearson
chi-squared that is due to deletion of the observation and all others that
share the same covariate pattern.

{phang}
{opt ddeviance} calculates the
{help logistic postestimation##HL2000:Hosmer and Lemeshow (2000, 174)} Delta-D
influence statistic, which is the change in the deviance residual that is due
to deletion of the observation and all others that share the same covariate
pattern.

{phang}
{opt hat} calculates the {help logistic postestimation##P1981:Pregibon (1981)}
leverage or the diagonal elements of the hat matrix adjusted for the number of
observations that share the same covariate pattern. 

{phang}
{opt number} numbers the covariate patterns -- observations with the same
covariate pattern have the same number.  Observations not used in estimation
have {opt number} set to missing.  The first covariate pattern is numbered
1, the second 2, and so on. 

{phang}
{opt residuals} calculates the Pearson residual as given by
{help logistic postestimation##HL2000:Hosmer and Lemeshow (2000, 145)} and
adjusted for the number of observations that share the same covariate pattern.

{phang}
{opt rstandard} calculates the standardized Pearson residual as given by
{help logistic postestimation##HL2000:Hosmer and Lemeshow (2000, 173)} and
adjusted for the number of observations that share the same covariate pattern.

{phang}
{opt score} calculates the equation-level score, the first derivative of the
log likelihood with respect to the linear prediction.

{dlgtab:Options}

{phang}
{opt nooffset} is relevant only if you specified {opth offset(varname)} for
{opt logistic}.  It modifies the calculations made by {opt predict} so that
they ignore the offset variable; the linear prediction is treated as xb
rather than xb + offset.

{phang}
{opt rules} requests that Stata use any rules that were used to
identify the model when making the prediction.  By default, Stata calculates
missing for excluded observations.  See
{mansection R logitpostestimationRemarksex1_logitp:example 1} in
{bf:[R] logit postestimation}.

{phang}
{opt asif} requests that Stata ignore the rules and the exclusion criteria
and calculate predictions for all observations possible by using the estimated
parameter from the model.  See
{mansection R logitpostestimationRemarksex1_logitp:example 1} in
{bf:[R] logit postestimation}.


{marker syntax_estat_class}{...}
{marker estatclas}{...}
{title:Syntax for estat classification}

{p 8 14 2}
{cmd:estat} {opt clas:sification} {ifin} {weight} 
[{cmd:,} {it:class_options}]

{synoptset 13 tabbed}{...}
{synopthdr :class_options}
{synoptline}
{syntab :Main}
{synopt :{opt all}}display summary statistics for all observations in the data{p_end}
{synopt :{opt cut:off(#)}}positive outcome threshold; default is
{cmd:cutoff(0.5)}{p_end}
{synoptline}
{p2colreset}{...}
{p 4 6 2}{opt fweight}s are allowed; see {help weight}.


INCLUDE help menu_estat


{marker options_estat_class}{...}
{title:Options for estat classification}

{dlgtab:Main}

{phang}
{opt all} requests that the statistic be computed for all observations in the
data, ignoring any {opt if} or {opt in} restrictions specified by
{cmd:logistic}.

{phang}
{opt cutoff(#)} specifies the value for determining whether an observation has
a predicted positive outcome.  An observation is classified as positive if its
predicted probability is {ul:>} {it:#}.  The default is 0.5.


{marker syntax_estat_gof}{...}
{marker estatgof}{...}
{title:Syntax for estat gof}

{p 8 14 2}
{cmd:estat gof} {ifin} {weight} [{cmd:,} {it:gof_options}]

{synoptset 13 tabbed}{...}
{synopthdr :gof_options}
{synoptline}
{syntab :Main}
{synopt :{opt g:roup(#)}}perform Hosmer-Lemeshow goodness-of-fit test using
{it:#} quantiles{p_end}
{synopt :{opt all}}execute test for all observations in the data{p_end}
{synopt :{opt out:sample}}adjust degrees of freedom for samples outside
estimation sample{p_end}
{synopt :{opt t:able}}display table of groups used for test{p_end}
{synoptline}
{p2colreset}{...}
{p 4 6 2}{opt fweight}s are allowed; see {help weight}.


INCLUDE help menu_estat


{marker options_estat_gof}{...}
{title:Options for estat gof}

{dlgtab:Main}

{phang}
{opt group(#)} specifies the number of quantiles to be used to group the data
for the Hosmer-Lemeshow goodness-of-fit test.  {cmd:group(10)} is typically
specified.  If this option is not given, the Pearson goodness-of-fit test is
computed using the covariate patterns in the data as groups.

{phang}
{opt all} requests that the statistic be computed for all observations in the
data, ignoring any {opt if} or {opt in} restrictions specified with
{cmd:logistic}.

{phang}
{opt outsample} adjusts the degrees of freedom for the Pearson and
Hosmer-Lemeshow goodness-of-fit tests for samples outside the estimation
sample.  See
{mansection R logisticpostestimationRemarksSamplesotherthantheestimationsample:{it:Samples other than the estimation sample}}
in {bf:[R] logistic postestimation}.

{phang}
{opt table} displays a table of the groups used for the Hosmer-Lemeshow or
Pearson goodness-of-fit test with predicted probabilities, observed and
expected counts for both outcomes, and totals for each group.


{marker syntax_lroc}{...}
{marker lroc}{...}
{title:Syntax for lroc}

{p 8 13 2}
{cmd:lroc} [{depvar}] {ifin} {weight} [{cmd:,} {it:lroc_options}]

{synoptset 23 tabbed}{...}
{synopthdr :lroc_options}
{synoptline}
{syntab :Main}
{synopt :{opt all}}compute area under ROC curve and graph curve for all
observations{p_end}
{synopt :{opt nog:raph}}suppress graph{p_end}

{syntab :Advanced}
{synopt :{opt beta(matname)}}row vector containing coefficients for a logistic
model{p_end}

{syntab :Plot}
INCLUDE help gr_clopt
INCLUDE help gr_markopt2

{syntab :Reference line}
{synopt :{opth rlop:ts(cline_options)}}affect rendition of the reference
line{p_end}

{syntab :Add plots}
{synopt :{opth "addplot(addplot_option:plot)"}}add other plots to the generated graph{p_end}

{syntab :Y axis, X axis, Titles, Legend, Overall}
{synopt :{it:twoway_options}}any options other than {opt by()} documented in 
  {manhelpi twoway_options G-3}{p_end}
{synoptline}
{p2colreset}{...}
{p 4 6 2}{opt fweight}s are allowed; see {help weight}.


{title:Menu}

{phang}
{bf:Statistics > Binary outcomes > Postestimation >}
       {bf:ROC curve after logistic/logit/probit/ivprobit}


{marker options_lroc}{...}
{title:Options for lroc}

{dlgtab:Main}

{phang}
{opt all} requests that the statistic be computed for all observations in the
data, ignoring any {opt if} or {opt in} restrictions specified by
{cmd:logistic}.

{phang}
{opt nograph} suppresses graphical output.

{dlgtab:Advanced}

{phang}
{opt beta(matname)} specifies a row vector containing coefficients for a
logistic model.  The columns of the row vector must be labeled with the
corresponding names of the independent variables in the data.  The dependent
variable {depvar} must be specified immediately after the command name.  See
{mansection R logisticpostestimationRemarksModelsotherthanthelastfittedmodel:{it:Models other than the last fitted model}}
in {bf:[R] logistic postestimation}.


{dlgtab:Plot}

{phang}
{it:cline_options}, {it:marker_options}, and {it:marker_label_options}
affect the rendition of the ROC curve -- the plotted points connected
by lines.  These options affect the size and color of markers,
whether and how the markers are labeled, and whether and how the points are
connected; see {manhelpi cline_options G-3},
{manhelpi marker_options G-3}, and {manhelpi marker_label_options G-3}.

{dlgtab:Reference line}

{phang}
{opt rlopts(cline_options)} affects the rendition of the reference line; see
{manhelpi cline_options G-3}.

{marker addplot()}{...}
{dlgtab:Add plots}

{phang}
{opt addplot(plot)} provides a way to add other plots to the generated graph;
see {manhelpi addplot_option G-3}.

{marker twoway_options}{...}
{dlgtab:Y axis, X axis, Titles, Legend, Overall}

{phang}
{it:twoway_options} are any of the options documented in 
{manhelpi twoway_options G-3}, excluding {opt by()}.  These include options for
titling the graph (see {manhelpi title_options G-3}) and for saving the
graph to disk (see {manhelpi saving_option G-3}).


{marker syntax_lsens}{...}
{marker lsens}{...}
{title:Syntax for lsens}

{p 8 14 2}
{cmd:lsens} [{depvar}] {ifin} {weight} [{cmd:,} {it:lsens_options}]

{synoptset 20 tabbed}{...}
{synopthdr :lsens_options}
{synoptline}
{syntab :Main}
{synopt :{opt all}}graph all observations in the data{p_end}
{synopt :{opth genp:rob(varname)}}create variable containing probability
cutoff{p_end}
{synopt :{opth gense:ns(varname)}}create variable containing sensitivity{p_end}
{synopt :{opth gensp:ec(varname)}}create variable containing specificity{p_end}
{synopt :{opt replace}}overwrite existing variables{p_end}
{synopt :{opt nog:raph}}suppress the graph{p_end}

{syntab :Advanced}
{synopt :{opt beta(matname)}}row vector containing coefficients for the
model{p_end}

{syntab :Plot}
{synopt :{it:{help scatter##connect_options:connect_options}}}affect 
        rendition of the plotted points connected by lines{p_end}

{syntab :Add plots}
{synopt :{opth "addplot(addplot_option:plot)"}}add other plots to the generated graph{p_end}

{syntab :Y axis, X axis, Titles, Legend, Overall}
{synopt :{it:twoway_options}}any options other than {opt by()} documented in
   {manhelpi twoway_options G-3}{p_end}
{synoptline}
{p2colreset}{...}
{p 4 6 2}{opt fweight}s are allowed; see {help weight}.


{title:Menu}

{phang}
{bf:Statistics > Binary outcomes > Postestimation > Sensitivity/specificity plot}


{marker options_lsens}{...}
{title:Options for lsens}

{dlgtab:Main}

{phang}
{opt all} requests that the statistic be computed for all observations in the
data, ignoring any {opt if} or {opt in} restrictions specified with
{cmd:logistic}.

{phang}
{opth genprob(varname)}, {opt gensens(varname)}, and {opt genspec(varname)}
specify the names of new variables created to contain, respectively, the
probability cutoffs and the corresponding sensitivity and specificity.

{phang}
{opt replace} requests that existing variables specified for {opt genprob()},
{opt gensens()}, or {opt genspec()} be overwritten.

{phang}
{opt nograph} suppresses graphical output.

{dlgtab:Advanced}

{phang}
{opt beta(matname)} specifies a row vector containing coefficients for a
logistic model.  The columns of the row vector must be labeled with the
corresponding names of the independent variables in the data.  The dependent
variable {depvar} must be specified immediately after the command name.  See
{mansection R logisticpostestimationRemarksModelsotherthanthelastfittedmodel:{it:Models other than the last fitted model}}
in {bf:[R] logistic postestimation}.

{dlgtab:Plot}

{phang}
{it:connect_options} affect the rendition of the plotted points connected by
lines; see {it:{help scatter##connect_options:connect_options}} in 
{helpb twoway scatter:[G-2] graph twoway scatter}.

{dlgtab:Add plots}

{phang}
{opt addplot(plot)} provides a way to add other plots to the generated graph.
See {manhelpi addplot_option G-3}.

{marker twoway_options}{...}
{dlgtab:Y axis, X axis, Titles, Legend, Overall}

{phang}
{it:twoway_options} are any of the options documented in 
{manhelpi twoway_options G-3}, excluding {opt by()}.  These include options for
titling the graph (see {manhelpi title_options G-3}) and for saving the
graph to disk (see {manhelpi saving_option G-3}).


{marker examples}{...}
{title:Examples}

    {hline}
{pstd}Setup{p_end}
{phang2}{cmd:. webuse lbw}

{pstd}Fit logistic regression to predict low birth weight{p_end}
{phang2}{cmd:. logistic low age lwt i.race smoke ptl ht ui}

{pstd}Graph ROC curve and calculate area under the curve{p_end}
{phang2}{cmd:. lroc}

{pstd}Graph sensitivity and specificity against probability cutoff{p_end}
{phang2}{cmd:. lsens}

{pstd}Report classification table and summary statistics{p_end}
{phang2}{cmd:. estat class}

{pstd}Perform goodness-of-fit test{p_end}
{phang2}{cmd:. estat gof}

{pstd}Calculate fitted probabilities for estimation sample only{p_end}
{phang2}{cmd:. predict phat if e(sample)}

{pstd}Calculate Pearson residuals{p_end}
{phang2}{cmd:. predict r, resid}

    {hline}
{pstd}Setup{p_end}
{phang2}{cmd:. webuse nhanes2, clear}

{pstd}Fit logistic regression with three-way interaction{p_end}
{phang2}{cmd:. logistic highbp sex##agegrp##c.bmi}

{pstd}Estimate for each {cmd:sex} the probability of high blood pressure at
equally spaced values of {cmd:bmi}{p_end}
{phang2}{cmd:. margins sex, at(bmi=(10(5)65))}

{pstd}Plot estimates against {cmd:bmi}{p_end}
{phang2}{cmd:. marginsplot}

{pstd}Estimate for each {cmd:sex} changes in the probability of high blood
pressure associated with five-unit increases in BMI{p_end}
{phang2}{cmd:. margins sex, at(bmi=(10(5)65)) contrast(atcontrast(ar._at)}
   {cmd:marginswithin)}

{pstd}Plot results{p_end}
{phang2}{cmd:. marginsplot}{p_end}

    {hline}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:estat classification} saves the following in {cmd:r()}:

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Scalars}{p_end}
{synopt:{cmd:r(P_corr)}}percent correctly classified{p_end}
{synopt:{cmd:r(P_p1)}}sensitivity{p_end}
{synopt:{cmd:r(P_n0)}}specificity{p_end}
{synopt:{cmd:r(P_p0)}}false-positive rate given true negative{p_end}
{synopt:{cmd:r(P_n1)}}false-negative rate given true positive{p_end}
{synopt:{cmd:r(P_1p)}}positive predictive value{p_end}
{synopt:{cmd:r(P_0n)}}negative predictive value{p_end}
{synopt:{cmd:r(P_0p)}}false-positive rate given classified positive{p_end}
{synopt:{cmd:r(P_1n)}}false-negative rate given classified negative{p_end}

{pstd}
{cmd:estat gof} saves the following in {cmd:r()}:

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Scalars}{p_end}
{synopt:{cmd:r(N)}}number of observations{p_end}
{synopt:{cmd:r(m)}}number of covariate patterns or groups{p_end}
{synopt:{cmd:r(df)}}degrees of freedom{p_end}
{synopt:{cmd:r(chi2)}}chi-squared{p_end}

{pstd}
{cmd:lroc} saves the following in {cmd:r()}:

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Scalars}{p_end}
{synopt:{cmd:r(N)}}number of observations{p_end}
{synopt:{cmd:r(area)}}area under the ROC curve{p_end}

{pstd}
{cmd:lsens} saves the following in {cmd:r()}:

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Scalars}{p_end}
{synopt:{cmd:r(N)}}number of observations{p_end}
{p2colreset}{...}


{marker references}{...}
{title:References}

{marker HL2000}{...}
{phang}
Hosmer, D. W., Jr., and S. Lemeshow. 2000.
{browse "http://www.stata.com/bookstore/alr.html":{it:Applied Logistic Regression}. 2nd ed.}
New York: Wiley.

{marker P1981}{...}
{phang}
Pregibon, D. 1981. Logistic regression diagnostics.
{it:Annals of Statistics} 9: 705-724.
{p_end}
