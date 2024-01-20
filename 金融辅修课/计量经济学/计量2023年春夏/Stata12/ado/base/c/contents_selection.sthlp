{smcl}
{p 0 4}
{help contents:Top}
> {help contents_statistics:Statistics}
> {help contents_estimation:Estimation}
> {help contents_regression:Regression models}
{bind:> {bf:Selection models}}
{p_end}
{hline}

{title:Help file listings}

{p 4 8 4}
{bf:{help heckman:Linear regression estimation with selection}}{break}
    Heckman selection model; both two-step consistent estimator and
    full maximum likelihood available

{p 4 8 4}
{bf:{help heckprob:Probit estimation with selection}}{break}
    maximum likelihood estimator

{p 4 8 4}
{bf:{help treatreg:Treatment effects model}}{break}
    Endogenously chosen binary treatment on another endogenously chosen
    binary treatment or another endogenous continuous variable;
    Heckman's two-step
    consistent estimator and full maximum likelihood

{p 4 8 4}
{bf:{help tobit:Tobit regression}}{break}
    left-censored, right-censored, or left- and right-censored
    with fixed censoring values

{p 4 8 4}
{bf:{help intreg:Interval regression}}{break}
    a generalization of tobit regression, linear regression with data
    recorded in intervals or bins

INCLUDE help ypostnote
{hline}
