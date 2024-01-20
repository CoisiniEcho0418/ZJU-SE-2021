{smcl}
{p 0 4}
{help contents:Top}
> {help contents_basics:Basics}
> {help contents_syntax:Syntax}
{bind:> {bf:Repeating commands}}
{p_end}
{hline}

{title:Help file listings}

{p 4 8 4}
{bf:{help foreach:foreach:  Repeat Stata command}}{break}
    {cmd:foreach} {it:lname} {cmd:of} {it:list} {cmd:{c -(}}{break}
    {space 8}...{break}
    {cmd:{c )-}}

{p 4 8 4}
{bf:{help forvalues:forvalues:  Repeat Stata command}}{break}
    {cmd:forvalues} {it:lname} {cmd:=} {it:range} {cmd:{c -(}}{break}
    {space 8}...{break}
    {cmd:{c )-}}


{title:Related categories}

{p 4 8}
{help contents_programming:Programming}
> {help contents_programming_language:Language}
> {help contents_program_control:Program control and looping}
> {bf:{help contents_looping:Looping}}
{p_end}

{hline}
