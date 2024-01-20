{smcl}
{* *! version 1.1.5  11feb2011}{...}
{vieweralsosee "[P] tokenize" "mansection P tokenize"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[P] foreach" "help foreach"}{...}
{vieweralsosee "[P] gettoken" "help gettoken"}{...}
{vieweralsosee "[P] macro" "help macro"}{...}
{vieweralsosee "[P] syntax" "help syntax"}{...}
{viewerjumpto "Syntax" "tokenize##syntax"}{...}
{viewerjumpto "Description" "tokenize##description"}{...}
{viewerjumpto "Option" "tokenize##option"}{...}
{viewerjumpto "Remarks" "tokenize##remarks"}{...}
{viewerjumpto "Examples" "tokenize##examples"}{...}
{title:Title}

{p2colset 5 21 23 2}{...}
{p2col :{manlink P tokenize} {hline 2}}Divide strings into tokens{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 17 2}{cmdab:token:ize} [[{cmd:`}]{cmd:"}][{it:string}][{cmd:"}[{cmd:'}]]
	[{cmd:,} {cmdab:p:arse:("}{it:pchars}{cmd:")} ]


{marker description}{...}
{title:Description}

{pstd}
{cmd:tokenize} divides {it:string} into tokens, storing the result
in {hi:`1'}, {hi:`2'}, ... (the positional local macros).  Tokens are
determined based on the parsing characters {it:pchars}, which default to a
space if not specified.


{marker option}{...}
{title:Option}

{phang}{cmd:parse("}{it:pchars}{cmd:")} specifies the parsing characters.  If
{cmd:parse()} is not specified, {cmd:parse(" ")} is assumed, and 
{it:string} is split into words.


{marker remarks}{...}
{title:Remarks}

{pstd}
{cmd:tokenize} may be used as an alternative or supplement to the {helpb syntax}
command for parsing command-line arguments.  Generally, it is used to further
process the local macros created by {cmd:syntax}, as shown below.

    {cmd:program myprog}
            {cmd:version 12}
	    {cmd:syntax [varlist] [if] [in]}
	    {cmd:marksample touse }

	    {cmd:tokenize `varlist'}
	    {cmd:local first `1'}
	    {cmd:macro shift}
	    {cmd:local rest `*'}
	    {it:...}
    {cmd:end}


{marker examples}{...}
{title:Examples}

    {cmd:. tokenize some words}
    {cmd:. di "1=|`1'|, 2=|`2'|, 3=|`3'|"}

    {cmd:. tokenize "some more words"}
    {cmd:. di "1=|`1'|, 2=|`2'|, 3=|`3'|, 4=|`4'|"}

    {cmd:. tokenize `""Marcello Pagano""Rino Bellocco""'}
    {cmd:. di "1=|`1'|, 2=|`2'|, 3=|`3'|"}

    {cmd:. local str "A strange++string"}
    {cmd:. tokenize `str'}
    {cmd:. di "1=|`1'|, 2=|`2'|, 3=|`3'|"}

    {cmd:. tokenize `str', parse(" +")}
    {cmd:. di "1=|`1'|, 2=|`2'|, 3=|`3'|, 4=|`4'|, 5=|`5'|, 6=|`6'|"}

    {cmd:. tokenize `str', parse("+")}
    {cmd:. di "1=|`1'|, 2=|`2'|, 3=|`3'|, 4=|`4'|, 5=|`5'|, 6=|`6'|"}

    {cmd:. tokenize}
    {cmd:. di "1=|`1'|, 2=|`2'|, 3=|`3'|"}
