{smcl}
{p 0 4}
{help contents:Top}
> {help contents_statistics:Statistics}
> {help contents_estimation:Estimation}
> {help contents_panel:Longitudinal/Panel data}
> {help contents_panel_largen_smallt:Appropriate for use with large n, small T}
{bind:> {bf:Categorical, count, and limited-dependent variable regression}}
{p_end}
{hline}

    Notation
        {bf:FE}   Fixed effects
        {bf:RE}   Random effects
        {bf:PA}   Population averaged


{title:Help file listings}

{p 4 8 4}
{bf:{help xtlogit:Logit:  FE, RE, and PA}}{break}
    binary outcome, panel data

{p 4 8 4}
{bf:{help xtmelogit:Multilevel mixed-effects logistic regression}}{break}
    binary outcome, panel or multilevel data

{p 4 8 4}
{bf:{help xtcloglog:Conditional log-log:  RE and PA}}{break}
    binary outcome, panel data

{p 4 8 4}
{bf:{help xtprobit:Probit:  RE and PA}}{break}
    binary outcome, panel data

{p 4 8 4}
{bf:{help xtpoisson:Poisson regression:  FE, RE, and PA}}{break}
    count outcome, panel data

{p 4 8 4}
{bf:{help xtmepoisson:Multilevel mixed-effects Poisson regression}}{break}
    count outcome, panel or multilevel data

{p 4 8 4}
{bf:{help xtnbreg:Negative binomial regression:  FE, RE, and PA}}{break}
    count outcome, panel data

{p 4 8 4}
{bf:{help quadchk:Check sensitivity of quadrature approximation}}{break}
    verify solution in cases where RE estimated
    by quadrature approximation

INCLUDE help ypostnote
{hline}
