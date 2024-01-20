{smcl}
{p 0 4}
{help contents:Top}
> {help contents_statistics:Statistics}
> {help contents_estimation:Estimation}
> {help contents_panel:Longitudinal/Panel data}
> {help contents_panel_largen_smallt:Appropriate for use with large n, small T}
{bind:> {bf:Linear regression and related}}
{p_end}
{hline}

    Notation
        {bf:FE}   Fixed effects
        {bf:RE}   Random effects
        {bf:BE}   Between effects
        {bf:PA}   Population averaged


{title:Help file listings}

{p 4 8 4}
{bf:{help xtreg:Linear regression:  FE, BE, RE, and PA}}{break}
    {cmd:xtreg} includes both GLS and MLE estimators

{p 4 8 4}
{bf:{help xtmixed:Multilevel mixed-effects linear regression}}{break}
    {cmd:xtmixed} fits linear mixed models.

{p 4 8 4}
{bf:{help xtregar:Linear regression with AR(1) disturbances:  FE and RE}}{break}
    handles unbalanced, unequally spaced data

{p 4 8 4}
{bf:{help xtivreg:Instrumental variables (two-stage least squares):  FE, BE, and RE}}{break}
    estimates BE, FE, and RE; RE by G2SLS or ECSLS

{p 4 8 4}
{bf:{help xtabond:Arellano-Bond estimation}}{break}
    linear dynamic panel-data estimator using moments conditions based
    on differenced errors

{p 4 8 4}
{bf:{help xtdpdsys:Arellano-Bover/Blundell-Bond estimation}}{break}
    linear dynamic panel-data estimator using moments conditions based
    on differenced and level errors

{p 4 8 4}
{bf:{help xtdpd:More flexible linear dynamic panel data estimation}}{break}
    more general versions of Arellano-Bond and
    Arellano-Bover/Blundell-Bond estimators at the cost of more
    complicated syntax

{p 4 8 4}
{bf:{help xthtaylor:Hausman-Taylor estimator for error-components models}}{break}
    covariates correlated with individual-level random effect

{p 4 8 4}
{bf:{help xtfrontier:Stochastic frontier models for panel-data}}{break}
    stochastic production or cost frontier models for panel data

{p 4 8 4}
{bf:{help xtrc:Random-coefficients regression}}{break}
    Swamy's random-coefficients linear regression model for panel data

INCLUDE help ypostnote
{hline}
