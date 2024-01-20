{smcl}
{* *! version 1.0.3  20jun2011}{...}
{findalias asfrfilenames}{...}
{title:Title}

{p 4 13 2}
{findalias frfilenames}


{title:Description}

{pstd}
Some commands require that you specify a filename.  Filenames are
specified in the way natural for your operating system:

    Windows                  Unix                     Mac
    {hline 72}
{cmd}    mydata                   mydata                   mydata
    mydata.dta               mydata.dta               mydata.dta
    c:mydata.dta             ~friend/mydata.dta       ~friend/mydata.dta

    "my data"                "my data"                "my data"
    "my data.dta"            "my data.dta"            "my data.dta"

    myproj\mydata            myproj/mydata            myproj/mydata
    "my project\my data"     "my project/my data"     "my project/my data"

    C:\analysis\data\mydata  ~/analysis/data/mydata   ~/analysis/data/mydata
    "C:\my project\my data"  "~/my project/my data"   "~/my project/my data"

    ..\data\mydata           ../data/mydata           ../data/mydata
    "..\my project\my data"  "../my project/my data"  "../my project/my data"
{txt}

{pstd}
In most cases, where {it:filename} is a file that you are loading,
{it:filename} may also be a URL.  For instance, we might specify
{cmd:use http://www.stata-press.com/data/r12/nlswork}.

{pstd}
Usually (the exceptions being {cmd:copy}, {cmd:dir}, {cmd:ls}, {cmd:erase},
{cmd:rm}, and {cmd:type}), Stata automatically provides a file extension if you
do not supply one.  For instance, if you type {cmd:use} {cmd:mydata}, Stata
assumes that you mean {cmd:use} {cmd:mydata.dta} because {cmd:.dta} is the file
extension Stata normally uses for data files.

{pstd}
Stata provides 22 default {help extensions:file extensions}.

{pstd}
You do not have to name your data files with the {cmd:dta} extension -- if
you type an explicit file extension, it will override the default.  For
instance, if your dataset was stored as {cmd:myfile.dat}, you could type
{cmd:use} {cmd:myfile.dat}.  If your dataset was stored as simply {cmd:myfile}
with no file extension, you could type the period at the end of the filename to
indicate that you are explicitly specifying the null extension.  You would type
{cmd:use} {cmd:myfile.} to use this dataset.

{pstd}
All operating systems allow blanks in filenames, and so does Stata.  However,
if the filename includes a blank, you must enclose the filename in double
quotes.  Typing

{phang2}
{cmd:. save "my data"}

{pstd}
would create the file {cmd:my} {cmd:data.dta}.  Typing 

{phang2}
{cmd:. save my data}

{pstd}
would be an error.
{p_end}
