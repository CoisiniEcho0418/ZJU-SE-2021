{smcl}
{p 0 4}
{help contents:Top}
> {help contents_statistics:Statistics}
> {help contents_estimation:Estimation}
{bind:> {bf:Overview}}
{p_end}
{hline}

{title:Help and category listings}

{p 4 8 4}
{bf:{help estcom:Overview}}{break}
    there are many features in common

{p 4 8 4}
{bf:{help estimation_commands:Index}}{break}
    an index of the estimation commands

{p 4 8 4}
{bf:{help estimation_options:Estimation options}}{break}
    options common to many estimation commands

{p 4 8 4}
{bf:{help fvvarlist:Factor variables}}{break}
    include factor variables and interaction terms in varlists

{p 4 8 4}
{bf:{help tsvarlist:Time-series opeartors}}{break}
    include time-series operators in varlists

{p 4 8 4}
{bf:{help vce_option:Variance-covariance estimators}}{break}
    the {cmd:vce()} option for estimating the variance-covariance matrix

{p 4 8 4}
{bf:{help weight:Weighted estimation}}{break}
    most estimation commands allow weights

{p 4 8 4}
{bf:{help constraint:Constrained estimation}}{break}
    most estimation commands allow constrained estimation

{p 4 8 4}
{bf:{help mi_estimate:Multiple imputation}}{break}
    the {cmd:mi estimate} prefix may be used with many estimation commands to
    fit models on multiply imputed missing data

{p 4 8 4}
{bf:{help svy:Survey estimation}}{break}
    the {cmd:svy} prefix may be used with many estimation commands to fit
    models for complex survey data

{p 4 8 4}
{bf:{help nestreg:Nested model statistics}}{break}
    the {cmd:nestreg} prefix fits nested models by sequentially adding
    blocks of variables to an estimation command

{p 4 8 4}
{bf:{help stepwise:Stepwise estimation}}{break}
    the {cmd:stepwise} prefix can be used with many estimation commands

{p 4 8 4}
{bf:{help contents_postestimation:Postestimation commands}}{break}
    after estimation you can test linear and nonlinear hypotheses,
    obtain VCE, display marginal effects, obtain predictions, and more

{p 4 8 4}
{bf:{help maximize:Details of iterative maximization}}{break}
    specifying common options with estimators obtained by maximum likelihood

{p 4 8 4}
{bf:{help mkspline:Linear and restricted cubic spline construction}}{break}
    {cmd:mkspline age1 40 age2 55 age3 65 = age} creates new variables
    age1, age2, and age3 containing a linear spline of age

{hline}
