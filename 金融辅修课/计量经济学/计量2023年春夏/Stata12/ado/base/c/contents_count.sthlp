{smcl}
{p 0 4}
{help contents:Top}
> {help contents_statistics:Statistics}
> {help contents_estimation:Estimation}
> {help contents_regression:Regression models}
{bind:> {bf:Count data}}
{p_end}
{hline}

{title:Help file listings}

{p 4 8 4}
{bf:{help poisson:Poisson count-data regression}}{break}
    Poisson maximum-likelihood regression

{p 4 8 4}
{bf:{help expoisson:Exact Poisson regression}}{break}
    Poisson regression offering more accurate inference in small samples

{p 4 8 4}
{bf:{help nbreg:Negative binomial regression}}{break}
    negative binomial (Poisson with overdispersion)
    maximum-likelihood regression

{p 4 8 4}
{bf:{help nbreg:Generalized negative binomial regression}}{break}
    the overdispersion parameter can be modeled

{p 4 8 4}
{bf:{help zip:Zero-inflated Poisson regression}}{break}
    maximum-likelihood Poisson estimation when the number of zeros is inflated

{p 4 8 4}
{bf:{help tpoisson:Truncated Poisson regression}}{break}
    maximum-likelihood Poisson estimation with left-truncation

{p 4 8 4}
{bf:{help zinb:Zero-inflated negative binomial regression}}{break}
    maximum-likelihood negative binomial estimation when the number
    of zeros is inflated

{p 4 8 4}
{bf:{help tnbreg:Truncated negative binomial regression}}{break}
    maximum-likelihood negative binomial regression with left-truncation

{p 4 8 4}
{bf:{help glm:Generalized linear model}}{break}
    Poisson and negative binomial families with many choices for link

INCLUDE help ypostnote
{hline}
