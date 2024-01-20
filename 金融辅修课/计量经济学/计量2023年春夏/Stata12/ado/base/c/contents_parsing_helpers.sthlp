{smcl}
{p 0 4}
{help contents:Top}
> {help contents_programming_matrices:Programming and matrices}
> {help contents_programming:Programming}
> {help contents_subroutines:Subroutines}
{bind:> {bf:Parsing helpers}}
{p_end}
{hline}

{title:Help file listings}

{p 4 8 4}
{bf:{help opts_exclusive:Error message for mutually exclusive options}}{break}
    display an appropriate message and return code when mutually exclusive
    options are encountered

{p 4 8 4}
{bf:{help mlopts:Parsing tool for {cmd:ml} commands}}{break}
    assists in syntax checking and parsing

{p 4 8 4}
{bf:{help _prefix:Parsing tools for prefix commands}}{break}
    helps parse prefix commands

{p 4 8 4}
{bf:{help _stubstar2names:Parsing new variable lists}}{break}
    turns {it:stub*} into a list of names that begins with {it:stub}

{p 4 8 4}
{bf:{help _parse:Extended parsing for graph commands}}{break}
    parsing of complicated syntaxes (like the {cmd:graph} command)

{p 4 8 4}
{bf:{help _get_gropts:Parsing tool for graph commands}}{break}
    assists in syntax checking and parsing of commands that generate graphs

{p 4 8 4}
{bf:{help _check4gropts:Parsing tool for error checking in graph commands}}{break}
    will produce error if presented with {cmd:by()}, {cmd:name()},
    or {cmd:saving()} when these are inappropriate

{p 4 8 4}
{bf:{help _get_eqspec:Parsing tool for generating scores}}{break}
    helps identify the equation elements from a coefficient vector

{p 4 8 4}
{bf:{help _score_spec:Parsing tool for generating scores}}{break}
    helps with parsing the standard syntax for generating score variables

{p 4 8 4}
{bf:{help _mkvec:Create vector using from(initspecs)}}{break}
    turns a {cmd:from()} specification into a row vector

{p 4 8 4}
{bf:{help _get_eformopts:Parsing the {cmd:eform()} option}}{break}
    helps parse the multiple forms of the {cmd:eform()} option

{p 4 8 4}
{bf:{help _get_offopt:Parsing the {cmd:offset()} or {cmd:exposure()} options}}{break}
    identifies which option was used in specifying an offset

{p 4 8 4}
{bf:{help _getcovcorr:Parsing correlation and covariance matrix options}}{break}
    helps parse options related to correlation or covariance matrices

{p 4 8 4}
{bf:{help parse_dissim:Parse similarity and dissimilarity measures}}{break}
    helps parse similarity and dissimilarity measures

{p 4 8 4}
{bf:{help _confirm_date:Confirm a date string is valid}}{break}
    helps parse dates by verifying a given date string is valid

{p 4 8 4}
{bf:{help _vce_parse:Parsing the {cmd:vce()} option}}{break}
    helps parse and validate the contents of the {cmd:vce()} option


{title:Related categories}

{p 4 8}
{help contents_programming:Programming}
> {help contents_programming_language:Language}
> {bf:{help contents_parsing:Parsing and program arguments}}
{p_end}

{hline}
