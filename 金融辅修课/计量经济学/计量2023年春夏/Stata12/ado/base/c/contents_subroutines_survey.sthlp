{smcl}
{p 0 4}
{help contents:Top}
> {help contents_programming_matrices:Programming and matrices}
> {help contents_programming:Programming}
> {help contents_subroutines:Subroutines}
{bind:> {bf:Survey}}
{p_end}
{hline}

{title:Help file listings}

{p 4 8 4}
{bf:{help _robust:Robust variance estimates}}{break}
    computes robust (linearization) variance estimator based on scores
    and covariance matrix

{p 4 8 4}
{bf:{help is_svy:Determine if last estimation belongs to the svy class}}{break}
    option allows restricting to regression type svy commands

{p 4 8 4}
{bf:{help svymarkout:Mark observations for exclusion from survey characteristics}}{break}
    reset values in the variable created by {help mark} or {help marksample}
    to contain 0 wherever any of the {help svyset} variables contain
    missing values

{p 4 8 4}
{bf:{help _svy_setup:Retrieve svy settings}}{break}
    and adjusts weights

{p 4 8 4}
{bf:{help _svy_mkdeff:Calculate design effects}}{break}
    computes deff and deft from {cmd:e(V)}, {cmd:e(V_srs)}, and
    {cmd:e(V_srswr)}

{p 4 8 4}
{bf:{help _svy_mkmeff:Calculate misspecification effects}}{break}
    computes meft from {cmd:e(V)} and another specified matrix

{p 4 8 4}
{bf:{help svygen:Generating adjusted sampling weights}}{break}
    generate adjusted weights, BRR replicate weights, jackknife
    replicate weights, ...

{hline}
