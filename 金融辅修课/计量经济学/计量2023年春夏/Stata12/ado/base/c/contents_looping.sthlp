{smcl}
{p 0 4}
{help contents:Top}
> {help contents_programming_matrices:Programming and matrices}
> {help contents_programming:Programming}
> {help contents_programming_language:Language}
> {help contents_program_control:Program control and looping}
{bind:> {bf:Looping}}
{p_end}
{hline}

{title:Help file listings}

{p 4 8 4}
{bf:{help foreach:foreach looping}}{break}
    {cmd:foreach} {it:lname} {cmd:of} {it:list} {cmd:{c -(}}{break}
    {space 8}...{break}
    {cmd:{c )-}}

{p 4 8 4}
{bf:{help forvalues:forvalues looping}}{break}
    {cmd:forvalues} {it:lname} {cmd:=} {it:range} {cmd:{c -(}}{break}
    {space 8}...{break}
    {cmd:{c )-}}

{p 4 8 4}
{bf:{help while:Generic looping}}{break}
    {cmd:while} {it:exp} {cmd:{c -(}}{break}
    {space 8}...{break}
    {cmd:{c )-}}

{p 4 8 4}
{bf:{help continue:Loop breaking}}{break}
    {cmd:continue} -- break out of current iteration or entire loop

{p 4 8 4}
{bf:{help levelsof:Obtain levels of a variable}}{break}
    use with {cmd:foreach} to loop over levels of a variable

{p 4 8 4}
{bf:{help ds:Describe variables in memory in compact form}}{break}
    use with {cmd:foreach} to loop over particular variables

{hline}
