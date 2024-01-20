{smcl}
{p 0 4}
{help contents:Top}
> {help contents_statistics:Statistics}
> {help contents_estimation:Estimation}
> {help contents_regression:Regression models}
> {help contents_linear_regression:Linear regression and related}
> {help contents_linear_regression2:Linear regression}
{bind:> {bf:Linear regression}}
{p_end}
{hline}

{title:Help and category listings}

{p 4 8 4}
{bf:{help regress:Linear regression}}{break}
    linear regression, robust standard errors, ...

{p 4 8 4}
{bf:{help nestreg:Nested model statistics}}{break}
    the {cmd:nestreg} prefix fits nested regression models by sequentially
    adding blocks of variables

{p 4 8 4}
{bf:{help stepwise:Stepwise estimation}}{break}
    the {cmd:stepwise} prefix may be used with {cmd:regress}

{p 4 8 4}
{bf:{help fvvarlist:Factor variables}}{break}
    include factor variables and interaction terms in varlists

{p 4 8 4}
{bf:{help regress_postestimation:Postestimation tests and diagnostics}}{break}
    tests for heteroskedasticity, omitted variables, variance
    inflation factors ...

{p 4 8 4}
{bf:{help regress_postestimation:Postestimation diagnostic plots}}{break}
    added-variable plots, component-plus-residual plots, ...

{p 4 8 4}
{bf:{help corr2data:Create dataset with specified correlation structure}}{break}
    what to do when all you have are correlations

INCLUDE help ypostnote
{hline}
