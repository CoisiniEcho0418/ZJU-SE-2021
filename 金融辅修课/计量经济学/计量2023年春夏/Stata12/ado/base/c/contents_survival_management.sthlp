{smcl}
{p 0 4}
{help contents:Top}
> {help contents_statistics:Statistics}
> {help contents_special_topics:Special topics}
> {help contents_survival:Survival analysis}
> {help contents_survival_setup:Basic setup}
{bind:> {bf:Data management}}
{p_end}
{hline}

{title:Help file listings}

{p 4 8 4}
{bf:{help stfill:Fill in by carrying forward values of covariates}}{break}
    change variables to contain the value at the earliest time each
    subject was observed or instead fill in missing values with most recent
    observation

{p 4 8 4}
{bf:{help stgen:Generate variables reflecting entire histories}}{break}
    intended for use with multiple-record survival data

{p 4 8 4}
{bf:{help stsplit:Split time-span records}}{break}
    split episodes into two or more episodes at the implied time points
    since being at risk or after a particular time point or at the failure
    times

{p 4 8 4}
{bf:{help stsplit:Join time-span records}}{break}
    join episodes back together when that can be done without loss of
    information

{p 4 8 4}
{bf:{help stbase:Form baseline dataset}}{break}
    produce related st dataset with every variable set to its value at
    baseline, or alternatively, produce a related cross-sectional dataset

{hline}
