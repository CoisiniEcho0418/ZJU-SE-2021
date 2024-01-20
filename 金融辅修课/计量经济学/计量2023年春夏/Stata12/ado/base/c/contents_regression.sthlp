{smcl}
{p 0 4}
{help contents:Top}
> {help contents_statistics:Statistics}
> {help contents_estimation:Estimation}
{bind:> {bf:Regression models}}
{p_end}
{hline}

{title:Help and category listings}

{p 4 8 4}
{bf:{help contents_linear_regression:Linear regression and related}}{break}
    OLS, 2SLS, 3SLS, multivariate regression, quantile regression, Box-Cox, ...;
    the outcome variable is continuous

{p 4 8 4}
{bf:{help contents_binary:Binary outcome data}}{break}
    probit, logit, nested logit...;
    the outcome variable is 0 or 1, meaning failure or success

{p 4 8 4}
{bf:{help contents_multiple_outcome:Multiple outcome data}}{break}
    conditional logistic regression, ordered probit or logit, ...;
    the outcome variable is 1, 2, ..., indicating the category of the outcome,
    which might be ordered

{p 4 8 4}
{bf:{help contents_count:Count data}}{break}
    Poisson regression, negative binomial regression, ...;
    the outcome variable is 0, 1, 2, ..., and that records the number
    of occurrences of an event

{p 4 8 4}
{bf:{help contents_choice:Choice models}}{break}
    McFadden's choice, nested logit, ...

{p 4 8 4}
{bf:{help contents_selection:Selection models}}{break}
    Heckman selection models;
    linear regression with selection, probit with selection

{p 4 8 4}
{bf:{help glm:Generalized linear models (GLM)}}{break}
    GLM for continuous, binary, and count data; estimates using IRLS
    or maximum likelihood

{p 4 8 4}
{bf:{help gmm:Generalized method of moments (GMM)}}{break}
    GMM for linear and nonlinear models; use with cross-sectional,
    time-series, and panel/longitudinal data; interactive and
    programmable versions

{p 4 8 4}
{bf:{help logistic_estimation_commands:Index of logistic estimation commands}}

INCLUDE help ypostnote
{hline}
