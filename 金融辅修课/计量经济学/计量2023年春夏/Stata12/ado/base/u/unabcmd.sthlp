{smcl}
{* *! version 1.1.1  11feb2011}{...}
{vieweralsosee "[P] unabcmd" "mansection P unabcmd"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[P] findfile" "help findfile"}{...}
{vieweralsosee "[R] which" "help which"}{...}
{viewerjumpto "Syntax" "unabcmd##syntax"}{...}
{viewerjumpto "Description" "unabcmd##description"}{...}
{viewerjumpto "Examples" "unabcmd##examples"}{...}
{title:Title}

{p2colset 5 20 22 2}{...}
{p2col: {manlink P unabcmd} {hline 2}}Unabbreviate command name{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 16 2}
{cmd:unabcmd}
{it:commandname_or_abbreviation}


{marker description}{...}
{title:Description}

{pstd}
{cmd:unabcmd} verifies that {it:commandname_or_abbreviation} is a
Stata command name or an abbreviation of a Stata command name.  {cmd:unabcmd}
makes this determination by looking at both built-in commands and ado-files.
If {it:commandname_or_abbreviation} is a valid command, {cmd:unabcmd} returns
in local {cmd:r(cmd)} the unabbreviated name.  If it is not a
valid command, {cmd:unabcmd} displays an appropriate error message.


{marker examples}{...}
{title:Examples}

    {cmd:. unabcmd gen}
    {cmd:. return list}

    {cmd:. unabcmd kappa}
    {cmd:. return list}

    {cmd:. unabcmd ka}
