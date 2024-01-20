{smcl}
{p 0 4}
{help contents:Top}
> {help contents_statistics:Statistics}
> {help contents_estimation:Estimation}
> {help contents_regression:Regression models}
> {help contents_binary:Binary outcome data}
{bind:> {bf:Logit and logistic regression}}
{p_end}
{hline}

{title:Help and category listings}

{p 4 8 4}
{bf:{help logistic:Logistic regression command}}{break}
    maximum-likelihood logistic regression

{p 4 8 4}
{bf:{help logit:Logit estimation command}}{break}
    same as above but reports coefficients

{p 4 8 4}
{bf:{help exlogistic:Exact logistic regression}}{break}
    logistic regression offering more accurate inference in small samples

{p 4 8 4}
{bf:{help logistic_postestimation:Postestimation commands for use after logistic or logit}}{break}
    classification table, goodness-of-fit test, ROC curve,
    graphs ... after logistic or logit

{p 4 8 4}
{bf:{help glogit:Logit estimation on grouped data}}{break}
    logit estimation on grouped (blocked) data; weighted least-squares logit

{p 4 8 4}
{bf:{help scobit:Skewed logit estimation}}{break}
    maximum-likelihood skewed logit regression

{p 4 8 4}
{bf:{help roctab:Receiver Operating Characteristic (ROC) analysis}}{break}
    nonparametric ROC analyses; ROC curves
    with confidence bands; test equality of ROC areas

{p 4 8 4}
{bf:{help rocfit:Receiver Operating Characteristic (ROC) models}}{break}
    maximum-likelihood ROC models

{p 4 8 4}
{bf:{help brier:Brier score decomposition}}{break}
    Computes Yates, Sanders, and Murphy decompositions of the Brier
    mean probability score

INCLUDE help ypostnote
{hline}
