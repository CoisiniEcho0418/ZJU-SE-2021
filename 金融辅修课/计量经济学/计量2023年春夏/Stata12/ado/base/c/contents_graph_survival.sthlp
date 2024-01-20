{smcl}
{p 0 4}
{help contents:Top}
> {help contents_graphics:Graphics}
> {help contents_graph_types:Graph types}
> {help contents_other_graph_commands:Other graph drawing commands}
{bind:> {bf:Survival, epidemiological, and pharmacokinetic}}
{p_end}
{hline}

{title:Help file listings}

{p 4 8 4}
{bf:{help logistic_postestimation:Sensitivity and specificity vs. P cutoff}}{break}
    see {cmd:lsens} after {cmd:logistic}, {cmd:logit}, or {cmd:probit}

{p 4 8 4}
{bf:{help logistic_postestimation:ROC curve after probit}}{break}
    see {cmd:lroc} after {cmd:logistic}, {cmd:logit}, or {cmd:probit}

{p 4 8 4}
{bf:{help roctab:ROC curve analysis}}{break}
    including confidence bands and ROC curve comparison

{p 4 8 4}
{bf:{help rocfit:ROC models}}{break}
    maximum-likelihood ROC models assuming a binormal distribution
    of the latent variable

{p 4 8 4}
{bf:{help epitab:Odds of failure vs. categories}}{break}
    see the {cmd:graph} option of the {cmd:tabodds} command

{p 4 8 4}
{bf:{help ltable:Life tables graph}}{break}
    for individual-level or aggregate data

{p 4 8 4}
{bf:{help strate:Failure rate vs. exposure}}{break}
    failures divided by person-years by levels of categorical variable

{p 4 8 4}
{bf:{help sts_graph:Survivor or Nelson-Aalen cumulative hazard function}}{break}
    entered, at risk, lost, and censored; confidence bands; ...

{p 4 8 4}
{bf:{help stcurve:Survival, hazard and cumulative hazard}}{break}
    at the mean or other values of the covariates after {cmd:streg}

{p 4 8 4}
{bf:{help stci:Exponentially extended survivor function}}{break}
    curve exponentially extended to zero

{p 4 8 4}
{bf:{help stcox_diagnostics:Cox proportional-hazards assumption plot}}{break}
    -ln(-ln(survival)) and Kaplan-Meier observed survival curves

{p 4 8 4}
{bf:{help stcox_postestimation:Cox proportional-hazards assumption plot}}{break}
    smoothed plot of scaled Schoenfeld residuals vs. time; see {cmd:estat phtest}

{p 4 8 4}
{bf:{help pkexamine:Area under a plasma concentration curve}}{break}
    a pharmacokinetic graph

{p 4 8 4}
{bf:{help pksumm:Distribution of pharmacokinetic measure}}{break}
    AUC, half life, elimination rate, maximum concentration, ...

INCLUDE help ypostnote
{hline}
