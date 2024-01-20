{smcl}
{p 0 4}
{help contents:Top}
> {help contents_statistics:Statistics}
> {help contents_mi:Multiple imputation}
{bind:> {bf:Utility commands}}
{p_end}
{hline}

{title:Help file listings}

{p 4 8 4}
{bf:{help mi_convert:Change style of MI data}}{break}
    convert MI data from one style to another
    replace original dataset with another then carry out changes to
    imputed datasets to make resulting MI data consistent

{p 4 8 4}
{bf:{help mi_extract:Extract original data or one imputation from MI data}}{break}
    create a dataset containing just one dataset from a {cmd:mi}
    dataset for closer examination

{p 4 8 4}
{bf:{help mi_copy:Copy MI data}}{break}
    create and name a copy of MI data in memory and make new copy active

{p 4 8 4}
{bf:{help mi_erase:Erase MI datasets from disk}}{break}
    erase MI dataset from disk including all imputed datasets

{p 4 8 4}
{bf:{help mi_update:Ensure MI data are consistent}}{break}
    verify that MI data are consistent and correct inconsistencies

{p 4 8 4}
{bf:{help mi_reset:Reset imputed or passive variables}}{break}
    reset variables specified to their values in the original dataset


{title:Related categories}

{p 4 8}
{help contents_mi:Multiple imputation}
> {bf:{help contents_mi_dm:Data management}}
{p_end}

{p 4 8}
{help contents_mi:Multiple imputation}
> {bf:{help contents_mi_intro:Introduction}}
{p_end}

{hline}
