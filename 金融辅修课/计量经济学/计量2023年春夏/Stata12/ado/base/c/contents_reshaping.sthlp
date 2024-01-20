{smcl}
{p 0 4}
{help contents:Top}
> {help contents_data_management:Data management}
> {help contents_data_reorganization:Data reorganization}
{bind:> {bf:Other data reshaping commands}}
{p_end}
{hline}

{title:Help file listings}

{p 4 8 4}
{bf:{help split:Split string variables into parts}}{break}
    split strings into parts based on spaces or other characters

{p 4 8 4}
{bf:{help stack:Stack data}}{break}
    stacks variables vertically

{p 4 8 4}
{bf:{help separate:Create variables with values by groups}}{break}
    {cmd:separate mpg, by(foreign) gen(m)} creates new variables
    m0 and m1 containing mpg for foreign=0 and foreign=1

{p 4 8 4}
{bf:{help xpose:Interchange observations and variables}}{break}
    transpose the data (variables become observations and  vice versa)

{hline}
