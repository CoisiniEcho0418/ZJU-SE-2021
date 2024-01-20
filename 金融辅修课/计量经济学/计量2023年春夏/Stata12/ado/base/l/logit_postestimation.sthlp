{smcl}
{* *! version 1.1.10  03may2011}{...}
{viewerdialog predict "dialog logit_p"}{...}
{viewerdialog estat "dialog logit_estat"}{...}
{viewerdialog lroc "dialog lroc"}{...}
{viewerdialog lsens "dialog lsens"}{...}
{vieweralsosee "[R] logit postestimation" "mansection R logitpostestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] logit" "help logit"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] logistic postestimation" "help logistic_postestimation"}{...}
{viewerjumpto "Description" "logit postestimation##description"}{...}
{viewerjumpto "Syntax for predict" "logit postestimation##syntax_predict"}{...}
{viewerjumpto "Options for predict" "logit postestimation##options_predict"}{...}
{viewerjumpto "Examples" "logit postestimation##examples"}{...}
{viewerjumpto "References" "logit postestimation##references"}{...}
{title:Title}

{p2colset 5 33 35 2}{...}
{p2col :{manlink R logit postestimation} {hline 2}}Postestimation tools for
logit{p_end}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
The following postestimation commands are of special interest after {cmd:logit}:

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
{synopt :{helpb logit postestimation##predict:predict}}predictions, residuals, influence statistics, and other diagnostic measures{p_end}
INCLUDE help post_predictnl
INCLUDE help post_pwcompare
INCLUDE help post_suest
INCLUDE help post_test
INCLUDE help post_testnl
{synoptline}
{p2colreset}{...}
INCLUDE help post_lrtest_star_msg


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
{p2coldent :* {opt db:eta}}{help logit postestimation##P1981:Pregibon (1981)} Delta-Beta influence statistic{p_end}
{p2coldent :* {opt de:viance}}deviance residual{p_end}
{p2coldent :* {opt dx:2}}{help logit postestimation##HL2000:Hosmer and Lemeshow (2000)} Delta
chi-squared influence statistic{p_end}
{p2coldent :* {opt dd:eviance}}{help logit postestimation##HL2000:Hosmer and Lemeshow (2000)} Delta-D
influence statistic{p_end}
{p2coldent :* {opt h:at}}{help logit postestimation##P1981:Pregibon (1981)} leverage{p_end}
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
{opt dbeta} calculates the {help logit postestimation##P1981:Pregibon (1981)}
Delta-Beta influence statistic, a standardized measure of the difference in the
coefficient vector that is due to deletion of the observation along with all
others that share the same covariate pattern.  In
{help logit postestimation##HL2000:Hosmer and Lemeshow (2000, 144-145)}
jargon, this statistic is M-asymptotic; that is, it is adjusted for the number
of observations that share the same covariate pattern.

{phang}
{opt deviance} calculates the deviance residual.  

{phang}
{opt dx2} calculates the
{help logit postestimation##HL2000:Hosmer and Lemeshow (2000, 174)} Delta
chi-squared influence statistic, reflecting the decrease in the Pearson
chi-squared that is due to deletion of the observation and all others that
share the same covariate pattern.

{phang}
{opt ddeviance} calculates the
{help logit postestimation##HL2000:Hosmer and Lemeshow (2000, 174)} Delta-D
influence statistic, which is the change in the deviance residual that is due
to deletion of the observation and all others that share the same covariate
pattern.

{phang}
{opt hat} calculates the {help logit postestimation##P1981:Pregibon (1981)}
leverage or the diagonal elements of the hat matrix adjusted for the number of
observations that share the same covariate pattern. 

{phang}
{opt number} numbers the covariate patterns -- observations with the same
covariate pattern have the same number.  Observations not used in estimation
have {opt number} set to missing.  The first covariate pattern is numbered
1, the second 2, and so on. 

{phang}
{opt residuals} calculates the Pearson residual as given by
{help logit postestimation##HL2000:Hosmer and Lemeshow (2000, 145)} and
adjusted for the number of observations that share the same covariate pattern.

{phang}
{opt rstandard} calculates the standardized Pearson residual as given by
{help logit postestimation##HL2000:Hosmer and Lemeshow (2000, 173)} and
adjusted for the number of observations that share the same covariate pattern.

{phang}
{opt score} calculates the equation-level score, the first derivative of the
log likelihood with respect to the linear prediction.

{dlgtab:Options}

{phang}
{opt nooffset} is relevant only if you specified {opth offset(varname)} for
{opt logit}.  It modifies the calculations made by {opt predict} so that
they ignore the offset variable; the linear prediction is treated as xb
rather than xb + offset.

{phang}
{opt rules} requests that Stata use any rules that were used to
identify the model when making the prediction.  By default, Stata calculates
missing for excluded observations.

{phang}
{opt asif} requests that Stata ignore the rules and the exclusion criteria
and calculate predictions for all observations possible by using the estimated
parameter from the model.


{marker examples}{...}
{title:Examples}

    {hline}
{pstd}Setup{p_end}
{phang2}{cmd:. webuse lbw}

{pstd}Fit logistic regression to predict low birth weight{p_end}
{phang2}{cmd:. logit low age lwt i.race smoke ptl ht ui}

{pstd}Calculate fitted probabilities{p_end}
{phang2}{cmd:. predict p}

{pstd}Report classification table and summary statistics{p_end}
{phang2}{cmd:. estat classification}

{pstd}Perform goodness-of-fit test{p_end}
{phang2}{cmd:. estat gof}

    {hline}
{pstd}Setup{p_end}
{phang2}{cmd:. webuse hospital, clear}{p_end}
{phang2}{cmd:. logistic satisfied hospital##illness}

{pstd}ANOVA-style table of tests for main effects and interaction effects
{p_end}
{phang2}{cmd:. contrast hospital##illness}

{pstd}Test differences between illnesses at each hospital{p_end}
{phang2}{cmd:. margins illness, over(hospital) contrast}

    {hline}


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
