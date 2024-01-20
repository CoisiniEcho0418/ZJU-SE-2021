{smcl}
{* *! version 1.1.9  27jun2011}{...}
{vieweralsosee "[G-2] graph other" "mansection G-2 graphother"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[G-1] graph intro" "help graph_intro"}{...}
{viewerjumpto "Syntax" "graph other##syntax"}{...}
{viewerjumpto "Description" "graph other##description"}{...}
{viewerjumpto "Remarks" "graph other##remarks"}{...}
{title:Title}

{p2colset 5 26 28 2}{...}
{p2col :{manlink G-2 graph other} {hline 2}}Other graphics commands{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{pstd}
Distributional diagnostic plots:

{p2colset 9 31 33 2}{...}
{p2col :Command}Description{p_end}
{p2line}
{p2col :{helpb histogram}}histograms{p_end}
{p2col :{helpb diagnostic plots:symplot}}symmetry plots{p_end}
{p2col :{helpb diagnostic plots:quantile}}quantile plots{p_end}
{p2col :{helpb diagnostic plots:qnorm}}quantile{hline 1}normal plots{p_end}
{p2col :{helpb diagnostic plots:pnorm}}normal probability plots, standardized{p_end}
{p2col :{helpb diagnostic plots:qchi}}chi-squared quantile plots{p_end}
{p2col :{helpb diagnostic plots:pchi}}chi-squared probability plots{p_end}
{p2col :{helpb diagnostic plots:qqplot}}quantile{hline 1}quantile plots{p_end}

{p2col :{helpb gladder}}ladder-of-powers plots{p_end}
{p2col :{helpb qladder}}ladder-of-powers quantiles{p_end}

{p2col :{helpb spikeplot}}spikeplots and rootograms{p_end}
{p2col :{helpb dotplot}}means or medians by group{p_end}
{p2col :{helpb sunflower}}density-distribution sunflower plots{p_end}
{p2line}

{pstd}
Smoothing and densities:

{p2col :Command}Description{p_end}
{p2line}
{p2col :{helpb kdensity}}kernel density estimation, univariate{p_end}
{p2col :{helpb lowess}}lowess smoothing{p_end}
{p2col :{helpb lpoly}}local polynomial smoothing{p_end}
{p2line}

{pstd}
Regression diagnostics:

{p2col :Command}Description{p_end}
{p2line}
{p2col :{helpb avplot}}added-variable (leverage) plots{p_end}
{p2col :{helpb cprplot}}component-plus-residual plots{p_end}
{p2col :{helpb lvr2plot}}L-R (leverage versus squared residual) plots{p_end}
{p2col :{helpb rvfplot}}residual-versus-fitted plots{p_end}
{p2col :{helpb rvpplot}}residual-versus-predicted plots{p_end}
{p2line}

{pstd}
Time series:

{p2col :Command}Description{p_end}
{p2line}
{p2col :{helpb ac}}correlograms{p_end}
{p2col :{helpb pac}}partial correlograms{p_end}
{p2col :{helpb pergram}}periodograms{p_end}
{p2col :{helpb cumsp}}spectral distribution plots, cumulative{p_end}
{p2col :{helpb xcorr}}cross-correlograms for bivariate time series{p_end}
{p2col :{helpb wntestb}}Bartlett's periodogram-based white-noise test{p_end}
{p2line}

{pstd}
Vector autoregressive (VAR, SVAR, VECM) models:

{p2col :Command}Description{p_end}
{p2line}
{p2col :{helpb fcast graph}}{cmd:var}, {cmd:svar}, and {cmd:vec} forecasts{p_end}
{p2col :{helpb varstable}}eigenvalues of the companion matrix after {cmd:var} and {cmd:svar}{p_end}
{p2col :{helpb vecstable}}eigenvalues of the companion matrix after {cmd:vec}{p_end}
{p2col :{helpb irf graph}}impulse-response functions (IRFs) and forecast-error variance decompositions (FEVDs){p_end}
{p2col :{helpb irf ograph}}overlaid IRFs and FEVDs{p_end}
{p2col :{helpb irf cgraph}}combined IRFs and FEVDs{p_end}
{p2line}

{pstd}
Longitudinal data/panel data:

{p2col :Command}Description{p_end}
{p2line}
{p2col :{helpb xtline}}panel-data line plots{p_end}
{p2line}

{pstd}
Survival analysis:

{p2col :Command}Description{p_end}
{p2line}
{p2col :{helpb sts graph:sts graph}}survivor and cumulative-hazard functions{p_end}
{p2col :{helpb strate}}failure rates and cumulative hazard comparisons{p_end}
{p2col :{helpb ltable}}life tables{p_end}
{p2col :{helpb stci}}means and percentiles of survival time, with CIs{p_end}
{p2col :{helpb stphplot}}log-log plots{p_end}
{p2col :{helpb stcoxkm}}Kaplan{hline 1}Meier observed survival curves{p_end}
{p2col :{helpb estat phtest}}verify proportional-hazards assumption{p_end}
{p2col :{helpb stcurve}}survivor, hazard, cumulative hazard, or cumulative
           incidence function{p_end}
{p2line}

{pstd}
ROC analysis:

{p2col :Command}Description{p_end}
{p2line}
{p2col :{helpb roctab}}ROC curve{p_end}
{p2col :{helpb rocfit_postestimation##rocplot:rocplot}}parametric ROC curve{p_end}
{p2col :{helpb roccomp}}multiple ROC curves, compared{p_end}
{p2col :{helpb rocregplot}}marginal and covariate-specific ROC curves{p_end}
{p2col :{helpb logistic_postestimation##lroc:lroc}}ROC curve after {cmd:logistic}, {cmd:logit}, {cmd:probit}, and {cmd:ivprobit}{p_end}
{p2col :{helpb logistic_postestimation##lsens:lsens}}sensitivity and specificity versus probability cutoff{p_end}
{p2line}

{pstd}
Multivariate analysis:

{p2col:Command}Description{p_end}
{p2line}
{p2col:{helpb biplot}}biplot{p_end}
{p2col :{helpb cluster dendrogram}}dendrograms for hierarchical cluster analysis{p_end}
{p2col:{helpb screeplot}}scree plot of eigenvalues{p_end}
{p2col:{helpb scoreplot}}factor or component score plot{p_end}
{p2col:{helpb loadingplot}}factor or component loading plot{p_end}
{p2col:{helpb procoverlay}}Procrustes overlay plot{p_end}
{p2col:{helpb cabiplot}}correspondence analysis biplot{p_end}
{p2col:{helpb caprojection}}correspondence analysis dimension projection plot{p_end}
{p2col:{helpb mcaplot}}plot of category coordinates{p_end}
{p2col:{helpb mcaprojection}}MCA dimension projection plot{p_end}
{p2col:{helpb mdsconfig}}multidimensional scaling configuration plot{p_end}
{p2col:{helpb mdsshepard}}multidimensional scaling Shepard plot{p_end}
{p2line}

{pstd}
Quality-control charts:

{p2col :Command}Description{p_end}
{p2line}
{p2col :{helpb cusum}}cusum plots{p_end}
{p2col :{helpb cchart}}c charts{p_end}
{p2col :{helpb pchart}}p charts{p_end}
{p2col :{helpb rchart}}r charts{p_end}
{p2col :{helpb xchart}}X-bar charts{p_end}
{p2col :{helpb shewhart}}X-bar charts, vertically aligned{p_end}
{p2col :{helpb serrbar}}standard error bar charts{p_end}
{p2line}

{pstd}
Other statistical graphs:

{p2col :Command}Description{p_end}
{p2line}
{p2col :{helpb marginsplot}}graph of results from {helpb margins} (profile plots, etc.){p_end}
{p2col :{helpb tabodds}}odds-of-failure versus categories{p_end}
{p2col :{helpb pkexamine}}summarize pharmacokinetic data{p_end}
{p2line}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
In addition to {cmd:graph}, there are many other commands that draw graphs.
These are listed above.


{marker remarks}{...}
{title:Remarks}

{pstd}
The other graph commands are implemented in terms of {cmd:graph}, which
provides the following capabilities:

{p2colset 9 35 37 2}{...}
{p2col :Command}Description{p_end}
{p2line}
{p2col :{helpb graph bar}}bar charts{p_end}
{p2col :{helpb graph pie}}pie charts{p_end}
{p2col :{helpb graph dot}}dot charts{p_end}
{p2col :{helpb graph matrix}}scatterplot matrices{p_end}
{p2col :{helpb graph twoway}}twoway ({it:y}-{it:x}) graphs, including{p_end}
{p2col 11 37 39 2:{helpb graph twoway scatter}}scatterplots{p_end}
{p2col 11 37 39 2:{helpb graph twoway line}}line plots{p_end}
{p2col 11 37 39 2:{helpb graph twoway function}}function plots{p_end}
{p2col 11 37 39 2:{helpb graph twoway histogram}}histograms{p_end}
{p2col 11 37 39 2:{helpb twoway:graph twoway *}}more{p_end}
{p2line}
{p2colreset}{...}
