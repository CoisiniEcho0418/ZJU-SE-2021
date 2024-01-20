{smcl}
{p 0 4}
{help contents:Top}
> {help contents_statistics:Statistics}
> {help contents_mi:Multiple imputation}
{bind:> {bf:Exploratory tools}}
{p_end}
{hline}

{title:Help file listings}

{p 4 8 4}
{bf:{help mi_describe:Describe MI data}}{break}
    report whether data in memory are {cmd:mi} data and, if they are,
    list style of data, complete and incomplete observations, registered variables, ...

{p 4 8 4}
{bf:{help mi_xeq:Execute a single command on each MI dataset}}{break}
    perform commands like {cmd:summarize} or {cmd:replace} on the original
    dataset as well as each imputation dataset

{p 4 8 4}
{bf:{help mi_varying:Identify variables that vary over imputations}}{break}
    list names of variables that are unexpectedly varying or supervarying

{p 4 8 4}
{bf:{help mi_misstable:Tabulate missing values}}{break}
    run Stata's {cmd:misstable} command on one of the imputed datasets


{title:Related categories}

{p 4 8}
{help contents_mi:Multiple imputation}
> {bf:{help contents_mi_intro:Introduction}}
{p_end}

{hline}
