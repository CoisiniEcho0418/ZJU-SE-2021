{smcl}
{* *! version 1.0.1  03may2011}{...}
{viewerdialog "return/ereturn list" "dialog return_list"}{...}
{vieweralsosee "[R] saved results" "mansection R savedresults"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[P] ereturn" "help ereturn"}{...}
{vieweralsosee "[P] return" "help return"}{...}
{viewerjumpto "Syntax" "saved_results##syntax"}{...}
{viewerjumpto "Description" "saved_results##description"}{...}
{viewerjumpto "Option" "saved_results##option"}{...}
{viewerjumpto "Remarks" "saved_results##remarks"}{...}
{viewerjumpto "Examples" "saved_results##examples"}{...}
{title:Title}

{p2colset 5 26 28 2}{...}
{p2col :{manlink R saved results} {hline 2}}Saved results{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{pstd}List results from general commands, stored in r()

{p 8 15 2}{opt ret:urn} {opt li:st} [{cmd:,} {cmd:all}]


{pstd}List results from estimation commands, stored in e()

{p 8 15 2}{opt eret:urn} {opt li:st} [{cmd:,} {cmd:all}]


{pstd}List results from parsing commands, stored in s()

{p 8 15 2}{opt sret:urn} {opt li:st}


{marker description}{...}
{title:Description}

{pstd}
Results of calculations are saved by many Stata commands so that they can 
be easily accessed and substituted into later commands.

{pstd}
{opt return} {opt list} lists results stored in {opt r()}.

{pstd}
{opt ereturn} {opt list} lists results stored in {opt e()}.

{pstd}
{opt sreturn} {opt list} lists results stored in {opt s()}.

{pstd}
This entry discusses using saved results.  Programmers wishing to save 
results should see {helpb return:[P] return} and {helpb ereturn:[P] ereturn}.


{marker option}{...}
{title:Option}

{phang}
{opt all} is for use with {opt return list} and {opt ereturn list}.  {opt all}
specifies that hidden and historical saved results be listed along with the
usual saved results.  This option is seldom used.  See
{mansection P returnRemarksUsinghiddenandhistoricalsavedresults:{it:Using hidden and historical saved results}}
and
{mansection P returnRemarksProgramminghiddenandhistoricalsavedresults:{it:Programming hidden and historical saved results}}
under {it:Remarks} of {helpb return:[P] return} for more information.  These
sections are written in terms of {cmd:return list}, but everything said there
applies equally to {cmd:ereturn list}.

{pmore}
{cmd:all} is not allowed with {cmd:sreturn list} because {cmd:s()} does not
allow hidden or historical results.


{marker remarks}{...}
{title:Remarks}

{pstd}
Stata commands are classified as being

        r-class  general commands that save results in {cmd:r()}
        e-class  estimation commands that save results in {cmd:e()}
        s-class  parsing commands that save results  in {cmd:s()}
        n-class  commands that do not save in {cmd:r()}, {cmd:e()}, or {cmd:s()}

{pstd}
There is also a c-class, {cmd:c()}, containing the values of system
parameters and settings, along with certain constants, such as the value of
pi; see {helpb creturn:[P] creturn}.  A program, however, cannot be c-class.

{pstd}
You can look at the {it:Saved results} section of the manual entry of 
a command to determine whether it is r-, e-, s-, or n-class, but it is easy 
enough to guess.  

{pstd}
Commands producing statistical results are either r-class or e-class.
They are e-class if they present estimation results and r-class otherwise.
s-class is a class used by programmers and is primarily used in subprograms
performing parsing.  n-class commands explicitly state where the result is to
go.  For instance, {cmd:generate} and {cmd:replace} are n-class because their
syntax is {cmd:generate} {it:varname} {cmd:=} ... and {cmd:replace}
{it:varname} {cmd:=} ....

{pstd}
After executing a command, you can type {cmd:return} {cmd:list}, 
{cmd:ereturn} {cmd:list}, or {cmd:sreturn} {cmd:list} to see what has 
been saved.


{marker examples}{...}
{title:Examples}

    {hline}
{pstd}Setup{p_end}
{phang2}{cmd:. webuse auto}

{pstd}Display summary statistics for {cmd:mpg}{p_end}
{phang2}{cmd:. summarize mpg}

{pstd}List results saved by {cmd:summarize}{p_end}
{phang2}{cmd:. return list}

{pstd}Create standardized {cmd:mpg} variable{p_end}
{phang2}{cmd:. generate double mpgstd = (mpg-r(mean))/r(sd)}

    {hline}
{pstd}Setup{p_end}
{phang2}{cmd:. webuse auto, clear}

{pstd}Fit a model of {cmd:mpg} on {cmd:weight} and {cmd:displacement} using
linear regression{p_end}
{phang2}{cmd:. regress mpg weight displacement}

{pstd}List results saved by {cmd:regress}{p_end}
{phang2}{cmd:. ereturn list}

    {hline}
{pstd}Setup{p_end}
{phang2}{cmd:. webuse auto}

{pstd}Describe data in memory{p_end}
{phang2}{cmd:. describe}

{pstd}List results saved by {cmd:describe}{p_end}
{phang2}{cmd:. return list}

{pstd}List results saved by {cmd:describe}, including historical results{p_end}
{phang2}{cmd:. return list, all}{p_end}

    {hline}
