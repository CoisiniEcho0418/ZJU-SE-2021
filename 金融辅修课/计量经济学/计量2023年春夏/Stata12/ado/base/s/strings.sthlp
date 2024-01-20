{smcl}
{* *! version 1.0.1  11feb2011}{...}
{findalias asfrstr}{...}
{title:Title}

{p 4 13 2}
{findalias frstr}


{title:Description}

{pstd}
A string is a sequence of printable characters and is typically
enclosed in double quotes.  The quotes are not considered a part of the
string but delimit the beginning and end of the string.  The
following are examples of valid strings:

{cmd}        "Hello, world"
        "String"
        "string"
        " string"
        "string "
        ""
        "x/y+3"
        "1.2"{txt}

{pstd}
All the strings above are distinct; that is, {cmd:"String"} is
different from {cmd:"string"}, which is different from {cmd:" string"}, which
is different from {cmd:"string "}.  Also, {cmd:"1.2"} is a string
and not a number because it is enclosed in quotes.

{pstd}
All strings in Stata are of varying length, which means that Stata internally
records the length of the string and never loses track.  There is never a
circumstance in which a string cannot be delimited by quotes, but there are
rare instances where strings do not have to be delimited by quotes, such as
during data input.  In those cases, nondelimited strings are stripped of their
leading and trailing blanks.  Delimited strings are always accepted as is.

{pstd}
The special string {cmd:""}, often called null string, is considered by
Stata to be a missing.  No special meaning is given to the string
containing one period, {cmd:"."}.

{pstd}
In addition to double quotes for enclosing strings, Stata also allows compound
double quotes:  {cmd:`"} and {cmd:"'}.  You can type {cmd:"}{it:string}{cmd:"}
or you can type {cmd:`"}{it:string}{cmd:"'}, although users seldom type
{cmd:`"}{it:string}{cmd:"'}.  Compound double quotes are of special interest to
programmers because they nest and provide a way for a quoted string to itself
contain double quotes (either simple or compound).  See {findalias frdoubleq}.
{p_end}
