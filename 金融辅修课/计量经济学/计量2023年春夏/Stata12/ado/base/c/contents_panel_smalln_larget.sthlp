{smcl}
{p 0 4}
{help contents:Top}
> {help contents_statistics:Statistics}
> {help contents_estimation:Estimation}
> {help contents_panel:Longitudinal/Panel data}
{bind:> {bf:Appropriate for use with small n, large T}}
{p_end}
{hline}

    Notation
        {bf:FE}   Fixed effects
        {bf:RE}   Random effects
        {bf:BE}   Between effects
        {bf:PA}   Population averaged


{title:Help file listings}

{p 4 8 4}
{bf:{help xtgls:Generalized least squares (GLS)}}{break}
    GLS with group-level heteroskedasticity and
    optionally contemporaneous correlation

{p 4 8 4}
{bf:{help xtpcse:Panel-corrected standard errors (PCSE)}}{break}
    OLS or Prais-Winsten models with PCSE

{p 4 8 4}
{bf:{help xtreg:Linear regression:  FE, BE, RE, and PA}}{break}
    FE appropriate for small n, but RE or PA are not

{p 4 8 4}
{bf:{help xtmixed:Multilevel mixed-effects linear regression}}{break}
    fixed and random effects

{p 4 8 4}
{bf:{help xtregar:Linear regression with AR(1) disturbances:  FE and RE}}{break}
    FE appropriate for small n, but RE is not

{p 4 8 4}
{bf:{help xtivreg:Instrumental variables (two-stage least squares):  FE, BE, and RE}}{break}
    FE appropriate for small n, but BE and RE are not

{p 4 8 4}
{bf:{help xtrc:Random-coefficients regression}}{break}
    Swamy's random-coefficients linear regression model for panel data

INCLUDE help ypostnote
{hline}
