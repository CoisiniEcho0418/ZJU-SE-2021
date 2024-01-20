{smcl}
{p 0 4}
{help contents:Top}
> {help contents_statistics:Statistics}
{bind:> {bf:Resampling and simulation}}
{p_end}
{hline}

{title:Help file listings}

{p 4 8 4}
{bf:{help bootstrap:Bootstrap sampling and estimation}}{break}
    {cmd:bootstrap} runs the user-specified command, bootstrapping the
    statistics specified

{p 4 8 4}
{bf:{help bstat:Report bootstrap results}}{break}
    computes and displays estimation results from bootstrap statistics

{p 4 8 4}
{bf:{help bsample:Draw a bootstrap sample}}{break}
    draws a bootstrap sample with replacement from the existing data

{p 4 8 4}
{bf:{help jackknife:Jackknife estimation}}{break}
    {cmd:jackknife} performs jackknife estimation

{p 4 8 4}
{bf:{help rolling:Rolling window and recursive estimation}}{break}
    samples on periods of fixed or expanding length

{p 4 8 4}
{bf:{help vce_option:Variance-covariance estimators}}{break}
    the {cmd:vce()} option to many estimation commands for estimating
    the variance-covariance matrix

{p 4 8 4}
{bf:{help simulate:Monte Carlo simulations}}{break}
    {cmd:simulate} eases the programming tasks of performing
    Monte Carlo-type simulations ...

{p 4 8 4}
{bf:{help permute:Monte Carlo permutation tests}}{break}
    {cmd:permute} estimates p-values for permutation tests based on Monte
    Carlo simulations

{p 4 8 4}
{bf:{help random_number_functions:Draw random numbers from specified distribution}}{break}
    draw random numbers from uniform, beta, normal, Poisson, and other distributions

{p 4 8 4}
{bf:{help drawnorm:Draw sample from multivariate normal distribution}}{break}
    draw sample with desired means and covariance

{p 4 8 4}
{bf:{help exp_list:Expression lists in resampling and simulation commands}}{break}
    outlines the type of expression lists that can be used in resampling
    and simulation commands

INCLUDE help ypostnote
{hline}
