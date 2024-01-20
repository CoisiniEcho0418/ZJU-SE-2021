{smcl}
{p 0 4}
{help contents:Top}
> {help contents_programming_matrices:Programming and matrices}
> {help contents_programming:Programming}
{bind:> {bf:do-files}}
{p_end}
{hline}

{title:Help file listings}

{p 4 8 4}
{bf:{help do:Execute commands stored in a text file}}{break}
    {cmd:do} and {cmd:run} execute commands stored in {it:filename}
    just as if they were entered from the keyboard

{p 4 8 4}
{bf:{help include:Include commands from file}}{break}
    {cmd:include} differs from {cmd:do} and {cmd:run} in that any local
    macros created by executing the file are not dropped or reset when
    execution of the file concludes

{p 4 8 4}
{bf:{help doedit:Edit do-files and other text files}}{break}
    {cmd:doedit} opens a text editor that allows you to edit do-files
    and other text files

{p 4 8 4}
{bf:{help assert:Useful command for use inside do-files for certifying data}}{break}
    {cmd:assert sex==1 | sex==2} would verify that the statement is true,
    and would stop the do-file if it is not

{p 4 8 4}
{bf:{help comments:Placing comments in do-files}}{break}
    there are several ways to add comments in your do-file

{hline}
