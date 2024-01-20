{smcl}
{p 0 4}
{help contents:Top}
> {help contents_statistics:Statistics}
> {help contents_multivariate:Multivariate analysis}
{bind:> {bf:Discriminant analysis}}
{p_end}
{hline}

{title:Help file listings}

{p 4 8 4}
{bf:{help discrim:Overview}}{break}
    quick reference for {cmd:discrim}

{p 4 8 4}
{bf:{help discrim_lda:Linear discriminant analysis (LDA)}}{break}
    assumes groups are multivariate normal with equal covariance matrices

{p 4 8 4}
{bf:{help candisc:Canonical linear discriminant analysis}}{break}
    same as above, but with default output showing descriptive LDA instead
    of predictive LDA

{p 4 8 4}
{bf:{help discrim_qda:Quadratic discriminant analysis (QDA)}}{break}
    assumes groups are multivariate normal with unequal covariance matrices

{p 4 8 4}
{bf:{help discrim_logistic:Logistic discriminant analysis}}{break}
    uses the multinomial logistic model for discriminant analysis

{p 4 8 4}
{bf:{help discrim_knn:kth nearest neighbor (KNN) discriminant analysis}}{break}
    nonparametric method that examines closest observations for
    discrimination

{p 4 8 4}
{bf:{help discrim_estat:Postestimation commands for use after {cmd:discrim} and {cmd:candisc}}}{break}
    group classification, posterior probabilities,
    classification (confusion) tables, classification listing,
    error-rate tables, summaries by group, ...

INCLUDE help ypostnote
{hline}
