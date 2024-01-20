{smcl}
{p 0 4}
{help contents:Top}
> {help contents_statistics:Statistics}
> {help contents_special_topics:Special topics}
> {help contents_survival:Survival analysis}
> {help contents_survival_setup:Basic setup}
> {help contents_survival_setting:Inputting and setting}
{bind:> {bf:Convert count-time data to time-span data}}
{p_end}
{hline}

{title:Help file listings}

{p 4 8 4}
{bf:{help ct:Description of count-time (ct) data}}{break}
    data on populations with observations recording the number of units
    under test at time t (subjects alive) and the number of subjects that
    failed or were lost due to censoring

{p 4 8 4}
{bf:{help ctset:Declare data to be count-time data}}{break}
    first step in process of going from count-time to
    survival-time (time-span) data

{p 4 8 4}
{bf:{help cttost:Convert count-time data to survival-time data}}{break}
    so that you can use Stata's survival analysis routines on the data

{p 4 8 4}
{bf:{help sttoct:Convert survival-time data to count-time data}}{break}
    rarely used (mostly of interest to programmers)

{hline}
