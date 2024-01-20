{smcl}
{p 0 4}
{help contents:Top}
> {help contents_data_management:Data management}
> {help contents_data_reorganization:Data reorganization}
{bind:> {bf:Expand or fill in data}}
{p_end}
{hline}

{title:Help file listings}

{p 4 8 4}
{bf:{help expand:Duplicate observations}}{break}
    replace each obs. with n copies, where n is equal to specified expression

{p 4 8 4}
{bf:{help obs:Increase number of observations}}{break}
    adds additional observations with any variables set to missing;
    can be used as first step in creating artificial data;
    an odd transformation not to be confused with {help append}

{p 4 8 4}
{bf:{help fillin:Rectangularize dataset}}{break}
    dataset contains observations on men and women, age categories
    20-30, 30-50, 50-70, and 70+; perhaps some sex-age combinations are
    missing; {cmd:fillin} fills them in placing missing values where
    appropriate

{p 4 8 4}
{bf:{help expandcl:Duplicate clustered observations}}{break}
    replaces each cluster in the current dataset with n copies of the
    cluster

{hline}
