{smcl}
{p 0 4}
{help contents:Top}
> {help contents_basics:Basics}
{bind:> {bf:Memory considerations}}
{p_end}
{hline}

{title:Help and category listings}

{p 4 8 4}
{bf:{help contents_flavor:Flavors of Stata}}{break}
    Stata comes in four different editions, based on the number of variables
    datasets can have and the number of cores Stata can use

{p 4 8 4}
{bf:{help memory:Displaying and changing memory settings}}{break}
    display a report of Stata's memory usage and adjust settings related
    to memory usage

{p 4 8 4}
{bf:{help statase:Setting the maximum number of variables (Stata/SE and Stata/MP only)}}{break}
    the default maximum is 2,048;
    {help statase:Stata/SE} and {help statamp:Stata/MP} allow more

{p 4 8 4}
{bf:{help matsize:Setting the maximum dimension of matrices}}{break}
    which controls the maximum number of variables allowed in a model

{p 4 8 4}
{bf:{help data_types:Data and storage types}}{break}
    {cmd:byte}s, {cmd:int}s, {cmd:long}s, {cmd:float}s, {cmd:double}s,
    and {cmd:str}{it:#}

{p 4 8 4}
{bf:{help compress:Optimize data storage types}}{break}
    make your dataset smaller by automatically setting optimal
    storage types for existing variables

{p 4 8 4}
{bf:{help recast:Change storage type of variable}}{break}
    explicitly change variable storage type

{p 4 8 4}
{bf:{help limits:Maximum size limits}}{break}
    maximum number of variables, observations, characters in a command, ...

{p 4 8 4}
{bf:{help set_processors:Set the number of cores for Stata/MP to use}}{break}
    restrict the number of cores to fewer than the default

{hline}
