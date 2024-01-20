{smcl}
{* *! version 1.0.3  15aug2011}{...}
{vieweralsosee "[D] export" "mansection D export"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[D] import excel" "help import excel"}{...}
{vieweralsosee "[D] import sasxport" "help import sasxport"}{...}
{vieweralsosee "[D] odbc" "help odbc"}{...}
{vieweralsosee "[D] outfile" "help outfile"}{...}
{vieweralsosee "[D] outsheet" "help outsheet"}{...}
{vieweralsosee "[D] xmlsave" "help xmlsave"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[D] import" "help import"}{...}
{viewerjumpto "Description" "export##description"}{...}
{viewerjumpto "Summary of the different methods" "export##summary"}{...}
{title:Title}

{p2colset 5 19 21 2}{...}
{p2col :{manlink D export} {hline 2}}Overview of exporting data from Stata
{p_end}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
This entry provides a quick reference for determining which method to use for
exporting Stata data from memory to other formats.


{marker summary}{...}
{title:Summary of the different methods}


{title:{opt export excel} (see {manhelp import_excel D:import excel})}

{phang}
1.  {opt export excel} creates Microsoft Excel worksheets in {cmd:.xls}
    and {cmd:.xlsx} files.

{phang}
2.  Entire worksheets can be exported, or custom cell ranges can be overwritten.


{title:{opt outsheet} (see {manhelp outsheet D})}

{phang}
1.  {opt outsheet} creates comma-separated (CSV) or tab-delimited files that 
many other programs can read.

{phang}
2.  A custom delimiter may also be specified.

{phang}
3.  The first line of the file can optionally contain the names of the
variables.


{title:{cmd:odbc} (see {manhelp odbc D})}

{phang}
1.  ODBC, an acronym for Open DataBase Connectivity, is a standard for
exchanging data between programs.  Stata supports the ODBC standard for
exporting data via the {opt odbc} command and can write to any ODBC data
source on your computer.


{title:{cmd:outfile} (see {manhelp outfile D})}

{phang}
1.  {cmd:outfile} creates text-format datasets.

{phang}
2.  The data can be written in space-separated or comma-separated format.

{phang}
3.  Alternatively, the data can be written in fixed-column format.


{title:{cmd:export sasxport} (see {manhelp import_sasxport D:import sasxport})}

{phang}
1.  {opt export sasxport} saves SAS XPORT Transport format files.

{phang}
2.  {opt export sasxport} can also write value label information to a
    {opt formats.xpf} XPORT file.


{title:{cmd:xmlsave} (see {manhelp xmlsave D})}

{phang}
1.  {opt xmlsave} writes extensible markup language (XML) files -- highly
adaptable text-format files derived from the standard generalized markup
language (SGML).

{phang}
2.  {opt xmlsave} can write either an Excel-format XML or a Stata-format XML
file.
{p_end}
