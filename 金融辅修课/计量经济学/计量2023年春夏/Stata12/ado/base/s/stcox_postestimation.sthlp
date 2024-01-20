{smcl}
{* *! version 2.2.15  11feb2011}{...}
{viewerdialog predict "dialog stcox_p"}{...}
{viewerdialog estat "dialog stcox_estat"}{...}
{viewerdialog stcurve "dialog stcurve"}{...}
{vieweralsosee "[ST] stcox postestimation" "mansection ST stcoxpostestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[ST] stcox" "help stcox"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[ST] stcox PH-assumption tests" "help stcox_diagnostics"}{...}
{vieweralsosee "[ST] stcurve" "help stcurve"}{...}
{viewerjumpto "Description" "stcox postestimation##description"}{...}
{viewerjumpto "Special-interest postestimation commands" "stcox postestimation##special"}{...}
{viewerjumpto "Syntax for predict" "stcox postestimation##syntax_predict"}{...}
{viewerjumpto "Options for predict" "stcox postestimation##options_predict"}{...}
{viewerjumpto "Predictions after stcox with the tvc() option" "stcox postestimation##remarks1"}{...}
{viewerjumpto "Predictions after stcox with the shared() option" "stcox postestimation##remarks2"}{...}
{viewerjumpto "Syntax for estat concordance" "stcox postestimation##syntax_estat_con"}{...}
{viewerjumpto "Options for estat concordance" "stcox postestimation##options_estat_con"}{...}
{viewerjumpto "Examples" "stcox postestimation##examples"}{...}
{viewerjumpto "Saved results" "stcox postestimation##saved_results"}{...}
{title:Title}

{p2colset 5 34 36 2}{...}
{p2col :{manlink ST stcox postestimation} {hline 2}}Postestimation tools for
stcox{p_end}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
The following postestimation commands are of special interest after {cmd:stcox}:

{synoptset 19}{...}
{p2coldent :Command}Description{p_end}
{synoptline}
{synopt :{helpb stcox postestimation##estatcon:estat concordance}}compute the concordance probability{p_end}
{synopt :{helpb stcurve}}plot the survivor, hazard, and cumulative hazard functions{p_end}
{synoptline}
{p2colreset}{...}
{p 4 6 2}
{cmd:estat} {cmd:concordance} is not appropriate after estimation with {cmd:svy}.
{p_end}


{pstd}
The following standard postestimation commands are also available:

{synoptset 19 notes}{...}
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
{p2col :{helpb stcox postestimation##predict:predict}}predictions, residuals, influence statistics, and other diagnostic measures{p_end}
INCLUDE help post_predictnl
INCLUDE help post_pwcompare
INCLUDE help post_test
INCLUDE help post_testnl
{synoptline}
{p2colreset}{...}
INCLUDE help post_lrtest_star_msg


{marker special}{...}
{title:Special-interest postestimation commands}

{pstd}
{cmd:estat concordance} calculates the concordance probability, which is
defined as the probability that predictions and outcomes are concordant.
{cmd:estat concordance} provides two measures of the concordance probability:
Harrell's C and G{c o:}nen and Heller's K concordance coefficients.  
{cmd:estat concordance} also reports the Somers' D rank correlation, which is
obtained by calculating 2C-1 or 2K-1.


{marker syntax_predict}{...}
{marker predict}{...}
{title:Syntax for predict}

{p 8 16 2}
{cmd:predict} {dtype} {newvar} {ifin}
[{cmd:,} {it:sv_statistic} {opt nooff:set} {opt part:ial}]

{p 8 16 2}
{cmd:predict} {dtype} {c -(}{it:stub}{cmd:*}|{it:{help newvarlist}}{c )-} {ifin}
{cmd:,} {it:mv_statistic} [{opt part:ial}]

{synoptset 14 tabbed}{...}
{synopthdr :sv_statistic}
{synoptline}
{syntab:Main}
{synopt :{opt hr}}predicted hazard ratio, also known as the relative hazard; the default{p_end}
{synopt :{opt xb}}linear prediction xb{p_end}
{synopt :{opt stdp}}standard error of the linear prediction; SE(xb){p_end}
{p2coldent :* {opt bases:urv}}baseline survivor function{p_end}
{p2coldent :* {opt basec:hazard}}baseline cumulative hazard function{p_end}
{p2coldent :* {opt basehc}}baseline hazard contributions{p_end}
{p2coldent :* {opt mg:ale}}martingale residuals{p_end}
{p2coldent :* {opt csn:ell}}Cox-Snell residuals{p_end}
{p2coldent :* {opt dev:iance}}deviance residuals{p_end}
{p2coldent :* {opt ld:isplace}}likelihood displacement values{p_end}
{p2coldent :* {opt lm:ax}}LMAX measures of influence{p_end}
{p2coldent :* {opt eff:ects}}log-frailties{p_end}
{synoptline}

{synoptset 14 tabbed}{...}
{synopthdr :mv_statistic}
{synoptline}
{syntab:Main}
{p2coldent :* {opt sco:res}}efficient score residuals{p_end}
{p2coldent :* {opt esr}}synonym for {opt scores}{p_end}
{p2coldent :* {opt dfb:eta}}DFBETA measures of influence{p_end}
{p2coldent :* {opt sch:oenfeld}}Schoenfeld residuals{p_end}
{p2coldent :* {opt sca:ledsch}}scaled Schoenfeld residuals{p_end}
{synoptline}
{p2colreset}{...}
{p 4 6 2} 
Unstarred statistics are available both in and out of sample; type
{cmd:predict} ... {cmd:if e(sample)} ... if wanted for only the estimation
sample.  Starred statistics are calculated for only the estimation sample,
even when {cmd:e(sample)} is not specified.  {opt nooffset} is allowed 
only with unstarred statistics.
{p_end}
{p 4 6 2}
{cmd:mgale}, {cmd:csnell}, {cmd:deviance}, {cmd:ldisplace}, {cmd:lmax}, 
{cmd:dfbeta}, {cmd:schoenfeld}, and {cmd:scaledsch} are not allowed with
{cmd:svy} estimation results.  {p_end}


INCLUDE help menu_predict


{marker options_predict}{...}
{title:Options for predict}

{dlgtab:Main}

{phang}
{opt hr}, the default, calculates the relative hazard (hazard ratio),
that is, the exponentiated linear prediction.

{phang}
{opt xb} calculates the linear prediction from the fitted model. That is,
you fit the model by estimating a set of parameters b0, b1, b2, ..., bk,
and the linear prediction is xb.

{pmore}
The x used in the calculation is obtained from the data
currently in memory and need not correspond to the data on the independent
variables used in estimating b.

{phang}
{opt stdp} calculates the standard error of the prediction, that is,
the standard error of xb.

{phang}
{opt basesurv} calculates the baseline survivor function.  In the null model,
this is equivalent to the Kaplan-Meier product-limit estimate.  If 
{cmd:stcox}'s {helpb stcox##strata():strata()} option was specified, baseline
survivor functions for each stratum are provided.

{phang}
{opt basechazard} calculates the cumulative baseline hazard. If
{cmd:stcox}'s {helpb stcox##strata():strata()} option was specified, cumulative
baseline hazards for each stratum are provided.

{phang}
{opt basehc} calculates the baseline hazard contributions.  These are used to
construct the product-limit type estimator for the baseline survivor function
generated by {opt basesurv}.  If {cmd:stcox}'s {helpb stcox##strata():strata()}
option was specified, baseline hazard contributions for each stratum are
provided.

{phang}
{opt mgale} calculates the martingale residuals.  For
multiple-record-per-subject data, by default only one value per subject is
calculated, and it is placed on the last record for the subject.  

{pmore} Adding the {opt partial} option will produce partial martingale
residuals, one for each record within subject; see
{helpb stcox_postestimation##partial:partial} below.
Partial martingale residuals are the additive contributions to a subject's
overall martingale residual.  In single-record-per-subject data, the partial
martingale residuals are the martingale residuals.

{phang}
{opt csnell} calculates the Cox-Snell generalized residuals.  For
multiple-record data, by default only one value per subject is calculated,
and it is placed on the last record for the subject.  

{pmore} 
Adding the {opt partial} option will produce partial Cox-Snell residuals, one
for each record within subject; see 
{helpb stcox_postestimation##partial:partial} below.
Partial Cox-Snell residuals are the additive contributions to a subject's
overall Cox-Snell residual.  In single-record data, the partial Cox-Snell
residuals are the Cox-Snell residuals.

{phang}
{opt deviance} calculates the deviance residuals.  Deviance residuals are 
martingale residuals that have been transformed to be more symmetric about 
zero.  For multiple-record data, by default only one value per subject is
calculated, and it is placed on the last record for the subject.

{pmore} 
Adding the {opt partial} option will produce partial deviance residuals, one for
each record within subject; see 
{helpb stcox_postestimation##partial:partial} below.
Partial deviance residuals are transformed partial martingale residuals.  In
single-record data, the partial deviance residuals are the deviance residuals.

{phang}
{opt ldisplace} calculates the likelihood displacement values.  A
likelihood displacement value is an influence measure of the effect of
deleting a subject on the overall coefficient vector.  For multiple-record
data, by default only one value per subject is calculated, and it is placed on
the last record for the subject.

{pmore} 
Adding the {opt partial} option will produce partial likelihood displacement
values, one for each record within subject; see 
{helpb stcox_postestimation##partial:partial} below.
Partial displacement values are interpreted as effects due to deletion of
individual records rather than deletion of individual subjects.  In
single-record data, the partial likelihood displacement values are the
likelihood displacement values.

{phang}
{opt lmax} calculates the LMAX measures of influence.  LMAX values are
related to likelihood displacement values because they also measure the effect
of deleting a subject on the overall coefficient vector.  For multiple-record
data, by default only one LMAX value per subject is calculated, and it is
placed on the last record for the subject.

{pmore} 
Adding the {opt partial} option will produce partial LMAX values, one for each
record within subject; see 
{helpb stcox_postestimation##partial:partial} below.
Partial LMAX values are interpreted as effects due to deletion of individual
records rather than deletion of individual subjects.  In single-record data,
the partial LMAX values are the LMAX values.

{phang}
{opt effects} is for use after {opt stcox, shared()} and provides estimates of
the log frailty for each group. The log frailties are random group-specific
offsets to the linear predictor that measure the group effect on the
log relative-hazard.

{phang}
{cmd:scores} calculates the efficient score residuals for each
regressor in the model.  For multiple-record data, by default only one 
score per subject is calculated, and it is placed on the last record for 
the subject.

{pmore} 
Adding the {opt partial} option will produce partial efficient score residuals,
one for each record within subject; see 
{helpb stcox_postestimation##partial:partial} below.
Partial efficient score residuals are the additive contributions to a subject's
overall efficient score residual.  In single-record data, the partial efficient
score residuals are the efficient score residuals.

{pmore}
One efficient score residual variable is created for each regressor in the
model; the first new variable corresponds to the first regressor, the second
to the second, and so on.

{phang}
{opt esr} is a synonym for {opt scores}.

{phang}
{cmd:dfbeta} calculates the DFBETA measures of influence for each regressor
in the model.  The DFBETA value for a subject estimates the change
in the regressor's coefficient due to deletion of that subject.
For multiple-record data, by default only one value per subject is
calculated, and it is placed on the last record for the subject.

{pmore} 
Adding the {opt partial} option will produce partial DFBETAs, one for each
record within subject; see {helpb stcox_postestimation##partial:partial} below.
Partial DFBETAs are interpreted as effects due to deletion of individual
records rather than deletion of individual subjects.  In single-record data,
the partial DFBETAs are the DFBETAs.

{pmore}
One DFBETA variable is created for each regressor in the model; the first new
variable corresponds to the first regressor, the second to the second, and so
on.

{phang}
{opt schoenfeld} calculates the Schoenfeld residuals.  This option may not be
used after {opt stcox} with the {opt exactm} or {opt exactp} option.
Schoenfeld residuals are calculated and reported only at failure times.

{pmore}
One Schoenfeld residual variable is created for each regressor in the model;
the first new variable corresponds to the first regressor, the second to the
second, and so on.

{phang}
{opt scaledsch} calculates the scaled Schoenfeld residuals.  This option may
not be used after {opt stcox} with the {opt exactm} or {opt exactp} option.
Scaled Schoenfeld residuals are calculated and reported only at failure times.

{pmore}
One scaled Schoenfeld residual variable is created for each regressor in the
model; the first new variable corresponds to the first regressor, the second
to the second, and so on.

{phang}
Note: The easiest way to use the preceding four options is, for example, 

{phang2}{cmd:. predict double} {it:stub}{cmd:*, scores} 

{pmore}
where {it:stub} is a short name of your
choosing.  Stata then creates variables {it:stub}{cmd:1}, {it:stub}{cmd:2},
etc.  You may also specify each variable name explicitly, in which case there
must be as many (and no more) variables specified as there are regressors
in the model.

{phang}
{opt nooffset} is allowed only with {opt hr}, {opt xb}, and {opt stdp}, and is
relevant only if you specified {opth offset(varname)} for {cmd:stcox}.  It
modifies the calculations made by {cmd:predict} so that they ignore the offset
variable; the linear prediction is treated as xb rather than xb + offset.

{phang}
{marker partial}{...}
{opt partial} is relevant only for multiple-record data and is valid with
{opt mgale}, {opt csnell}, {opt deviance}, {opt ldisplace}, {opt lmax},
{opt scores}, {opt esr}, and {opt dfbeta}.  Specifying {opt partial} will
produce "partial" versions of these statistics, where one value is calculated
for each record instead of one for each subject.  The subjects are determined
by the {helpb stset##id():id()} option to {cmd:stset}.

{pmore}
Specify {opt partial} if you wish to perform diagnostics on individual
records rather than on individual subjects.  For example, a partial DFBETA 
would be interpreted as the effect on a coefficient due to deletion of one 
record, rather than the effect due to deletion of all records for a given 
subject.


{marker remarks1}{...}
{title:Predictions after stcox with the tvc() option}

{pstd} 
The only {cmd:predict} options supported after {cmd:stcox} with the 
{opt tvc()} option are the {opt hr}, {opt xb}, and {opt stdp} options.  The
other predictions require that you {cmd:stsplit} your data to draw out
the time-varying covariates inferred by {opt tvc()}; see
{help tvc_note:tvc note}.


{marker remarks2}{...}
{title:Predictions after stcox with the shared() option}

{pstd}
All {cmd:predict} options described above are supported for shared-frailty
models fit using {cmd:stcox} with the {cmd:shared()} option.  Predictions
are conditional on the estimated frailty variance, theta, and the definition 
of baseline is extended to represent covariates equal to 0 and
a frailty value of 1 (log frailty of 0).


{marker syntax_estat_con}{...}
{marker estatcon}{...}
{title:Syntax for estat concordance}

{p 8 17 2}
{cmd:estat} {opt con:cordance} {ifin} [{cmd:,} {it:concordance_options}]

{synoptset 20 tabbed}{...}
{synopthdr :concordance_options}
{synoptline}
{syntab:Main}
{synopt :{opt h:arrell}}compute Harrell's C coefficient; the default{p_end}
{synopt :{opt gh:eller}}compute G{c o:}nen and Heller's concordance coefficient
{p_end}
{synopt :{opt se}}compute asymptotic standard error of G{c o:}nen and Heller's coefficient{p_end}
{synopt :{opt all}}compute statistic for all observations in the data{p_end}
{synopt :{opt nosh:ow}}do not show st setting information{p_end}
{synoptline}
{p2colreset}{...}


INCLUDE help menu_estat


{marker options_estat_con}{...}
{title:Options for estat concordance}

{dlgtab: Main}

{phang}
{opt harrell}, the default, calculates Harrell's C coefficient, which is
defined as the proportion of all usable subject pairs in which the predictions
and outcomes are concordant.

{phang}
{opt gheller} calculates G{c o:}nen and Heller's K concordance coefficient
instead of Harrell's C coefficient.  The {opt harrell} and {opt gheller}
options may be specified together to obtain both concordance measures.

{phang}
{opt se} calculates the smoothed version of G{c o:}nen and Heller's K
concordance coefficient and its asymptotic standard error.  The {opt se}
option requires the {opt gheller} option.

{phang}
{opt all} requests that the statistic be computed for all observations in the
data.  By default, {cmd:estat concordance} computes over the estimation
subsample.

{phang}
{opt noshow} prevents {cmd:estat concordance} from displaying the identities of
the key st variables above its output.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse drugtr}

{pstd}Declare data to be survival-time data{p_end}
{phang2}{cmd:. stset studytime, failure(died)}

{pstd}Fit Cox model{p_end}
{phang2}{cmd:. stcox drug age}

{pstd}Obtain martingale residuals{p_end}
{phang2}{cmd:. predict double mg, mgale}

{pstd}Obtain Cox-Snell residuals{p_end}
{phang2}{cmd:. predict double cs, csnell}

{pstd}Obtain deviance residuals{p_end}
{phang2}{cmd:. predict double dev, deviance}

{pstd}Calculate Harrell's C{p_end}
{phang2}{cmd:. estat concordance}

{pstd}Calculate G{c o:}nen and Heller's concordance coefficient{p_end}
{phang2}{cmd:. estat concordance, gheller}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:estat concordance} saves the following in {cmd:r()}:

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Scalars}{p_end}
{synopt:{cmd:r(N)}}number of observations{p_end}
{synopt:{cmd:r(n_P)}}number of comparison pairs{p_end}
{synopt:{cmd:r(n_E)}}number of orderings as expected{p_end}
{synopt:{cmd:r(n_T)}}number of tied predictions{p_end}
{synopt:{cmd:r(C)}}Harrell's C coefficient{p_end}
{synopt:{cmd:r(K)}}G{c o:}nen and Heller's K coefficient{p_end}
{synopt:{cmd:r(K_s)}}smoothed G{c o:}nen and Heller's K coefficient{p_end}
{synopt:{cmd:r(K_s_se)}}standard error of the smoothed K coefficient{p_end}
{synopt:{cmd:r(D)}}Somers' D coefficient for Harrell's C{p_end}
{synopt:{cmd:r(D_K)}}Somers' D coefficient for G{c o:}nen and Heller's K{p_end}

{pstd}
{cmd:r(n_P)}, {cmd:r(n_E)}, and {cmd:r(n_T)} are returned only when strata are
not specified.
{p_end}
