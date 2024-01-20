{smcl}
{p 0 4}
{help contents:Top}
> {help contents_basics:Basics}
> {help contents_syntax:Syntax}
{bind:> {bf:Basic command syntax}}
{p_end}
{hline}

{title:Help file listings}

{p 4 8 4}
{bf:{help language:Language syntax}}{break}
    [{it:prefix}{cmd::}]
    {it:command}
    [{it:varlist}]
    [{cmd:=}{it:exp}]
    [{it:if}]
    [{it:in}]
    [{it:weight}]
    [{cmd:using} {it:filename}]
    [{cmd:,} {it:options}]

{p 4 8 4}
{bf:{help by:by:  Repeat command on subsets of data}}{break}
    [{cmd:by} {it:varlist}{cmd::}]
    {it:command} ...

{p 4 8 4}
{bf:{help varlist:Variable lists}}{break}
    ... {it:command} {bf:varlist} ...

{p 4 8 4}
{bf:{help exp:Expressions}}{break}
    ... {it:command} ... [={bf:exp}] [if {bf:exp}] ...

{p 4 8 4}
{bf:{help if:The if qualifier}}{break}
    ... {it:command} ... [{bf:if exp}] ...

{p 4 8 4}
{bf:{help in:The in qualifier}}{break}
    ... {it:command} ... [{bf:in range}] ...

{p 4 8 4}
{bf:{help weight:Weights}}{break}
    ... {it:command} ... {weight} ...

{p 4 8 4}
{bf:{help using:The using modifier}}{break}
    ... {it:command} ... [{bf:using filename}] ...

{p 4 8 4}
{bf:{help filename:Filename}}{break}
    ... {it:command} ... [{bf:using filename}] ...

{p 4 8 4}
{bf:{help options:Options}}{break}
    ... {it:command} ... [{cmd:, options}]

{p 4 8 4}
{bf:{help numlist:Numlists}}{break}
    1/3 means 1 to 3; 1(.5)3 means 1, 1.5, 2, 2.5, 3

{hline}
