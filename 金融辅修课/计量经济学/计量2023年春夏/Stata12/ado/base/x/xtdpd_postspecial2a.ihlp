{* *! version 1.1.2  11feb2011}{...}
{marker syntax_estat_abond}{...}
{marker estatabond}{...}
{title:Syntax for estat abond}

{p 8 16 2}
{cmd:estat} {cmdab:ab:ond} [{cmd:,} {cmdab:art:ests}{cmd:(}{it:#}{cmd:)}]


INCLUDE help menu_estat


{marker options_estat_abond}{...}
{title:Option for estat abond}

{phang}
{opt artests(#)} specifies the highest order of serial correlation to be tested.
By default, the tests computed during estimation are reported.  The model
will be refit when {opt artests(#)} specifies a higher order than that
computed during the original estimation.  The model can be refit only if the
data have not changed.
