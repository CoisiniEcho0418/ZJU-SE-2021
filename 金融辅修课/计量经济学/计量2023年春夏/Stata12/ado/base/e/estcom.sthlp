{smcl}
{* *! version 1.1.8  29jun2011}{...}
{findalias asfrestimate}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[I] estimation commands" "help estimation_commands"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[U] 20 Estimation and postestimation commands (postestimation)" "help postest"}{...}
{viewerjumpto "Description" "estcom##description"}{...}
{viewerjumpto "Remarks" "estcom##remarks"}{...}
{title:Title}

{p 4 13 2}
{findalias frestimate}


{marker description}{...}
{title:Description}

{pstd}For a list of Stata's estimation commands, see
{manhelp estimation_commands I:estimation commands}.  For a discussion of
postestimation commands, see {help postest}.

{pstd}
Properties shared by all estimation commands are listed.


{marker remarks}{...}
{title:Remarks}

{pstd}
Stata commands that fit statistical models -- commands such as
{helpb logit}, {helpb regress}, {helpb logistic}, and
{helpb sureg} -- work similarly.

{pstd}
Remarks are presented under the following headings:

        {help estcom##remarks1: 1. Common syntax}
        {help estcom##remarks2: 2. Estimation on subsamples}
        {help estcom##remarks3: 3. Robust variance estimates}
        {help estcom##remarks4: 4. Prefix commands}
        {help estcom##remarks5: 5. Confidence intervals of parameters}
        {help estcom##remarks6: 6. Format of coefficient table}
        {help estcom##remarks7: 7. Tests of parameters}
        {help estcom##remarks8: 8. Point estimates and CIs of linear and nonlinear combinations}
        {help estcom##remarks9: 9. Predictions}
        {help estcom##remarks10:10. Generalized predictions}
{phang2}{help estcom##remarks11:11. Marginal means, predictive margins, marginal effects, and average marginal effects}{p_end}
        {help estcom##remarks12:12. Plots of margins}
        {help estcom##remarks13:13. Contrasts}
        {help estcom##remarks14:14. Pairwise comparisons}
        {help estcom##remarks15:15. Estimation statistics}
        {help estcom##remarks16:16. Variance-covariance matrix of the estimators (VCE)}
        {help estcom##remarks17:17. Coefficients and standard errors in expressions}
        {help estcom##remarks18:18. Managing and combining estimates}
        {help estcom##remarks19:19. Redisplaying estimates}
        {help estcom##remarks20:20. Factor rotations}
        {help estcom##remarks21:21. Specialized graphs}


{marker remarks1}{...}
{title:1. Common syntax}

{pstd}
Single-equation estimation commands usually have syntax

{p 8 16 2}
{it:command} {varlist} {ifin} {weight} [{cmd:,} {it:options}]

{pstd}
and multiple-equation estimation commands usually have syntax

{p 8 16 2}
{it:command} {cmd:(}{varlist}{cmd:)} {it:...}
{cmd:(}{varlist}{cmd:)} {ifin} {weight}
[{cmd:,} {it:options}]

{pstd}
In single-equation commands, the first variable in {it:varlist} is the
dependent variable and the remaining are the independent variables, although
there can be variations.  For instance, {helpb anova} allows you to specify
both variables and terms as independent variables.


{marker remarks2}{...}
{title:2. Estimation on subsamples}

{pstd}
You can use Stata's standard syntax ({it:{help if}} and {it:{help in}})
to restrict the sample; 
you do not have to make a special dataset.


{marker remarks3}{...}
{title:3. Robust variance estimates}

{pstd}
Most estimation commands allow option {cmd:vce(robust)}, which provides the
Huber/White/sandwich estimator of variance.  Those that do also provide option
{cmd:vce(cluster} {it:clustvar}{cmd:)}, which relaxes the assumption of
independence.  See {findalias frrobust}.


{marker remarks4}{...}
{title:4. Prefix commands}

{pstd}
Prefix commands may be used to modify the estimation command.  The syntax is

{p 8 16 2}
{it:prefix_command} {it:...} {cmd::} {it:command} {it:...}

{pstd}
where

{p2colset 9 31 33 2}{...}
{p2col:{it:prefix_command}}Description{p_end}
{p2line}
{p2col:{helpb statsby:statsby:}}collect results across subsets of the data{p_end}
{p2col:{helpb rolling:rolling:}}collect statistics on moving subsets{p_end}

{p2col:{helpb bootstrap:bootstrap:}}bootstrap estimation{p_end}
{p2col:{helpb jackknife:jackknife:}}jackknife estimation{p_end}

{p2col 7 31 33 2:* {helpb svy:svy:}}estimation with complex survey data{p_end}
{p2col 7 31 33 2:* {helpb mi estimate:mi estimate:}}run command on multiply
         imputed data and adjust results for multiple imputation (MI){p_end}

{p2col 7 31 33 2:* {helpb nestreg:nestreg:}}run command with accumulated blocks
	of regressors and report nested model comparison tests{p_end}
{p2col 7 31 33 2:* {helpb stepwise:stepwise:}}stepwise estimation{p_end}

{p2col 7 31 33 2:* {helpb fracpoly:fracpoly:}}run command with fractional
        polynomials of one regressor{p_end}
{p2col 7 31 33 2:* {helpb mfp:mfp:}}run command with multiple fractional polynomial
       regressors {p_end}
{p2line}
{p2col:* Available for most but not all estimation commands.}{p_end}
{p2col:See help {help prefix} for a full list of {it:prefix_commands}.}{p_end}
{p2colreset}{...}

{pstd}
Before using the {cmd:bootstrap:} or {cmd:jackknife:} prefixes, however, 
check whether the estimation command allows option 
{cmd:vce(bootstrap)} or {cmd:vce(jackknife)}.  If it does, 
using the option rather than the prefix is better.  The option is implemented
in terms of the prefix command, but the option automatically knows to pass all
the appropriate suboptions for the specific estimator you are using.


{marker remarks5}{...}
{title:5. Confidence intervals of parameters}

{pstd}
Estimation commands display confidence intervals of
the coefficients.  Estimation-command option {cmd:level()} specifies the width
of the interval.  The default is {cmd:level(95)}, meaning 95% confidence
intervals.

{pstd}
You can reset the default with {helpb level:set level}.


{marker remarks6}{...}
{title:6. Format of coefficient table}

{pstd}
You can change the formatting of test statistics, p-values, coefficients,
standard errors, and confidence limits in the coefficient table. See
{findalias frcoeftable}.


{marker remarks7}{...}
{title:7. Tests of parameters}

{pstd}
You can perform tests on the estimated parameters by using 

{p 8 12 2}
o{space 2}{helpb test} -- Wald test of linear hypotheses 

{p 8 12 2}
o{space 2}{helpb testnl} -- Wald test of nonlinear hypotheses

{p 8 12 2}
o{space 2}{helpb lrtest} -- likelihood-ratio tests 

{p 8 12 2}
o{space 2}{helpb hausman} -- Hausman specification test

{p 8 12 2}
o{space 2}{helpb suest} -- generalization of the Hausman test


{marker remarks8}{...}
{title:8. Point estimates and CIs of linear and nonlinear combinations}

{pstd}
You can obtain point estimates
and confidence intervals of linear combinations of the estimated parameters
by using {helpb lincom}, and those of nonlinear combinations by using
{helpb nlcom}.


{marker remarks9}{...}
{title:9. Predictions}

{pstd}
You can obtain predictions, residuals, influence
statistics, and the like, either for the data on which you just estimated or
for some other data, by using {cmd:predict}.

{pstd}
The help for {cmd:predict} is found in two places:

{p 8 12 2}
1.
help {helpb predict} -- general information

{p 8 12 2}
2.  help {it:estimation_command} {cmd:postestimation} -- specific 
information and special features following estimation by 
{it:estimation_command}.
For instance, help {helpb regress postestimation}
tells you about {cmd:predict} following {cmd:regress}.

{pstd}
The easy way to access the postestimation help is to see
{manhelp regress R} (or whatever estimation command you are using) 
and then select {it:postestimation}.


{marker remarks10}{...}
{title:10. Generalized predictions}

{pstd}
You can obtain nonlinear predictions, 
standard errors, Wald test statistics, significance levels, and confidence
intervals, either for the data on which you just estimated or for some other
data, by using {helpb predictnl}.

{pstd}
One especially useful feature of {cmd:predictnl} is that you can obtain
standard errors for most predictions available via {cmd:predict}, and
you can obtain standard errors of functions and combinations of these
predictions.


{marker remarks11}{...}
{p 0 4 2}{ul:{bf:11. Marginal means, predictive margins, marginal effects, and average marginal effects}}

{pstd}
Command {helpb margins} estimates marginal means, adjusted
predictions, marginal effects, partial effects, or other expressions at fixed
values for the regressors; or it estimates averages of means, adjusted
predictions, marginal effects, partial effects, or other expressions at fixed
values of some covariates and averaging over the rest, said averaging based on
the data currently in memory.


{marker remarks12}{...}
{p 0 4 2}{ul:{bf:12. Plots of margins}}

{pstd}
Command {helpb marginsplot} graphs the results of the immediately preceding
{cmd:margins} command.


{marker remarks13}{...}
{p 0 4 2}{ul:{bf:13. Contrasts}}

{pstd}
The postestimation command {helpb contrast} estimates and tests contrasts.
Included are ANOVA-style tests of main effects, simple effects, interaction
effects, and nested effects.  You may use the built-in contrast operators, or
define your own custom contrasts.

{pstd}
The command {helpb margins contrast:margins, contrast} extends {cmd:contrast}
to margins of linear and nonlinear responses.


{marker remarks14}{...}
{p 0 4 2}{ul:{bf:14. Pairwise comparisons}}

{pstd}
The postestimation command {helpb pwcompare} performs pairwise comparisons
across the levels of factor variables.  The resulting tests and confidence
intervals may be adjusted for multiple comparisons.

{pstd}
The command {helpb margins pwcompare:margins, pwcompare} extends
{cmd:pwcompare} to margins of linear and nonlinear responses.

{pstd}
To perform pairwise comparisons of means, use {helpb pwmean}.


{marker remarks15}{...}
{title:15. Estimation statistics}

{pstd}
Command {helpb estat} displays 
scalar- and matrix-valued
postestimation statistics such as AIC and BIC.


{marker remarks16}{...}
{title:16. Variance-covariance matrix of the estimators (VCE)}

{pstd}
Command {helpb estat:estat vce} displays the VCE -- either as a 
covariance matrix or as a correlation matrix.

{pstd}
Estimation commands store coefficients in the matrix {cmd:e(b)}
and the VCE in {cmd:e(V)}.

{pstd}
You can obtain the coefficients and VCE into Mata matrices by using 
{cmd:st_matrix("e(b)")}
and
{cmd:st_matrix("e(V)")};
see {helpb mata st_matrix():[M-5] st_matrix()}.


{marker remarks17}{...}
{title:17. Coefficients and standard errors in expressions}

{pstd}
You can refer to the coefficients and standard errors in {help expressions}
by using {cmd:_b[}{it:name}{cmd:]} and {cmd:_se[}{it:name}{cmd:]}, such as

	. {cmd:generate contribution = _b[mpg]*mpg}

{pstd}
See 
{findalias frcoefficients} and see {help _b}.


{marker remarks18}{...}
{title:18. Managing and combining estimates}

{pstd}
You can store estimation results with command 
{helpb estimates:estimates store}.
These estimation results may later be restored and replayed, the coefficients
of one or more may be combined in a table, etc.; see {manhelp estimates R}.

{pstd}
Programmers should also see command {manhelp _estimates P}, which is a
low-level tool that manages stored estimation results.


{marker remarks19}{...}
{title:19. Redisplaying estimates}

{pstd}
You can, at any time, review your most recent estimates by typing the
estimation command without arguments.


{marker remarks20}{...}
{title:20. Factor rotations}

{pstd}
You can rotate loadings after factorlike commands; 
see {manhelp rotate MV}.


{marker remarks21}{...}
{title:21. Specialized graphs}

{pstd}
There are specialized graph commands available after some estimation commands.

{pstd}
For instance, command {helpb lroc} will graph the ROC curve after
{cmd:logistic}, {cmd:logit}, {cmd:probit}, or {cmd:ivprobit}.  Command
{helpb screeplot} will make scree plots after {cmd:factor} or {cmd:pca},
as well as various other multivariate commands.  Command {helpb stcurve} will
plot the survivor, hazard, or cumulative hazard function after {cmd:stcox} or
{cmd:streg} and will plot the cumulative subhazard or cumulative incidence
function after {cmd:stcrreg}.

{pstd}
What is available can always be found in the postestimation section 
of the documentation following the estimator.
{p_end}
