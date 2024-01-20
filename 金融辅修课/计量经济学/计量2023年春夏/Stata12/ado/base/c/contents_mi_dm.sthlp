{smcl}
{p 0 4}
{help contents:Top}
> {help contents_statistics:Statistics}
> {help contents_mi:Multiple imputation}
{bind:> {bf:Data management}}
{p_end}
{hline}

{title:Help file listings}

{p 4 8 4}
{bf:{help mi_set:Declare multiple imputation data}}{break}
    set a regular dataset to be a {cmd:mi} dataset or modify an already-set dataset

{p 4 8 4}
{bf:{help mi_import:Import MI data}}{break}
    import data that contain original data and imputed values

{p 4 8 4}
{bf:{help mi_passive:Create passive variables}}{break}
    create variables that are functions of imputed variables

{p 4 8 4}
{bf:{help mi_replace0:Replace original data}}{break}
    replace original dataset with one from disk then change imputed datasets
    to make the resulting {cmd:mi} data consistent

{p 4 8 4}
{bf:{help mi_xxxset:Declare panel, survey, time-series, factor-variable, or survival-time settings}}{break}
    use these commands instead of {cmd:xtset}, {cmd:svyset}, {cmd:tsset}, {cmd:fvset}, or {cmd:stset}
    if you have already {cmd:mi set} your data

{p 4 8 4}
{bf:{help mi_export:Export {cmd:mi} data}}{break}
    export MI data in formats used by NHANES and {cmd:ice}


{title:Category listings}

{p 4 8 4}
{bf:{help contents_mi_dm_man:Manipulate MI data}}{break}
    rename variables, add variables, observations or imputations, merge datasets, reshape, ...


{title:Related categories}

{p 4 8}
{help contents_mi:Multiple imputation}
> {bf:{help contents_mi_util:Utility commands}}
{p_end}

{p 4 8}
{help contents_mi:Multiple imputation}
> {bf:{help contents_mi_intro:Introduction}}
{p_end}

{hline}
