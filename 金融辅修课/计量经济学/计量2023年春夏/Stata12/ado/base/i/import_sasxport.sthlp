{smcl}
{* *! version 1.3.3  07jul2011}{...}
{viewerdialog "import sasxport" "dialog import_sasxport"}{...}
{viewerdialog "export sasxport" "dialog export_sasxport"}{...}
{vieweralsosee "[D] import sasxport" "mansection D importsasxport"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[D] export" "help export"}{...}
{vieweralsosee "[D] import" "help import"}{...}
{viewerjumpto "Syntax" "import_sasxport##syntax"}{...}
{viewerjumpto "Description" "import_sasxport##description"}{...}
{viewerjumpto "Options for export sasxport" "import_sasxport##options_export"}{...}
{viewerjumpto "Options for import sasxport" "import_sasxport##options_import"}{...}
{viewerjumpto "Option for import sasxport, describe" "import_sasxport##option_describe"}{...}
{viewerjumpto "Remarks" "import_sasxport##remarks"}{...}
{viewerjumpto "Saved results" "import_sasxport##saved_results"}{...}
{title:Title}

{p2colset 5 28 30 2}{...}
{p2col :{manlink D import sasxport} {hline 2}}Import and export datasets in SAS XPORT
format{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{phang}
Import SAS XPORT Transport file into Stata

{p 8 31 2}
{cmd:import sasxport}
{it:{help filename}}
[{cmd:,} {it:{help import_sasxport##import_options:import_options}}]


{phang}
Describe contents of SAS XPORT Transport file

{p 8 31}
{cmd:import sasxport}
{it:{help filename}}
{cmd:,} {opt d:escribe} [{opt m:ember(mbrname)}]


{phang}
Export data in memory to a SAS XPORT Transport file

{p 8 32 2}
{cmd:export sasxport}
{it:{help filename}}
{ifin}
[{cmd:,} {it:{help import_sasxport##export_options:export_options}}]

{p 8 32 2}
{cmd:export sasxport}
{varlist}
{cmd:using}
{it:{help filename}}
{ifin}
[{cmd:,} {it:{help import_sasxport##export_options:export_options}}]


{synoptset 23 tabbed}{...}
{marker import_options}{...}
{synopthdr :import_options}
{synoptline}
{syntab :Main}
{synopt :{opt clear}}replace data in memory{p_end}
{synopt :{opt noval:labels}}ignore accompanying {opt formats.xpf} file if it
exists{p_end}
{synopt :{opt m:ember(mbrname)}}member to use; seldom used{p_end}
{synoptline}
{p2colreset}{...}

{synoptset 23 tabbed}{...}
{marker export_options}{...}
{synopthdr :export_options}
{synoptline}
{syntab :Main}
{synopt :{opt ren:ame}}rename variables and value labels to meet SAS XPORT
restrictions{p_end}
{synopt :{opt replace}}overwrite files if they already exist{p_end}
{synopt :{cmdab:val:labfile:(xpf)}}save value labels in
{opt formats.xpf}{p_end}
{synopt :{cmdab:val:labfile:(}{cmdab:sas:code)}}save value labels in SAS command
file{p_end}
{synopt :{cmdab:val:labfile:(both)}}save value labels in {opt formats.xpf} and in
a SAS command file{p_end}
{synopt :{cmdab:val:labfile:(none)}}do not save value labels{p_end}
{synoptline}
{p2colreset}{...}


{title:Menu}

    {title:import sasxport}

{phang2}
{bf:File > Import > SAS XPORT}

    {title:export sasxport}

{phang2}
{bf:File > Export > SAS XPORT}


{marker description}{...}
{title:Description}

{pstd}
{cmd:import sasxport} and {cmd:export sasxport} convert datasets from and
to SAS XPORT Transport format.  The U.S. Food and Drug Administration uses
SAS XPORT Transport format as the format for datasets submitted with new
drug and new device applications (NDAs).

{pstd}
To save the data in memory as a SAS XPORT Transport file, type

	{cmd:. export sasxport} {it:filename}

{pstd}
although sometimes you will want to type

	{cmd:. export sasxport} {it:filename}{cmd:, rename}

{pstd}
It never hurts to specify the {opt rename} option.  In any case, Stata
will create {it:{help filename}}{opt .xpt} as an XPORT file containing the data and,
if needed, will also create {opt formats.xpf} -- an additional XPORT
file -- containing the value-label definitions.  These files can be easily
read into SAS.

{pstd}
To read a SAS XPORT Transport file into Stata, type

	{cmd:. import sasxport} {it:filename}

{pstd}
Stata will read into memory the XPORT file {it:filename}{opt .xpt} containing
the data and, if available, will also read the value-label definitions stored
in {opt formats.xpf} or {opt FORMATS.xpf}.

{pstd}
{cmd:import sasxport, describe} describes the contents of a SAS XPORT Transport
file.  The
display is similar to that produced by {helpb describe}.  To {cmd:describe}
a SAS XPORT Transport file, type

	{cmd:. import sasxport} {it:filename}{cmd:, describe}

{pstd}
If {it:filename} is specified without an extension, {opt .xpt} is assumed.


{marker options_import}{...}
{title:Options for import sasxport}

{dlgtab:Main}

{phang}
{opt clear}
permits the data to be loaded, even if there is a dataset already in
memory and even if that dataset has changed since the data were last saved.

{phang}
{opt novallabels}
specifies that value-label definitions stored in {opt formats.xpf} or
{opt FORMATS.xpf} not be looked for or loaded.  By default, if
variables are labeled in {it:{help filename}}{opt .xpt}, then
{cmd:import sasxport}
looks for {opt formats.xpf} to obtain and load the value-label definitions.  If
the file is not found, Stata looks for {opt FORMATS.xpf}.  If that file is not
found, a warning message is issued.

{pmore}
{cmd:import sasxport} can use only a {opt formats.xpf} or
{opt FORMATS.xpf} file to obtain value-label definitions.
{cmd:import sasxport} cannot understand value-label definitions from a SAS
command
file.

{phang}
{opt member(mbrname)}
is a rarely specified option indicating which member of the {opt .xpt}
file is to be loaded.  It is not used much anymore, but the original XPORT
definition allowed multiple datasets to be placed in one file.  The 
{opt member()} option allows you to read these old files.  You can obtain a
list of member names using {cmd:import sasxport, describe}.  If {opt member()}
is not
specified -- and it usually is not -- {cmd:import sasxport} reads the first
(and usually
only) member.


{marker option_describe}{...}
{title:Option for import sasxport, describe}

{dlgtab:Main}

{phang}
{opt member(mbrname)}
is a rarely specified option indicating which member of the {opt .xpt}
file is to be described.  See the description of {opt member()} option for
{cmd:import sasxport} directly above.  If {opt member()} is not specified, all
members are described, one after the other.  It is rare for an XPORT file
to have more than one member.


{marker options_export}{...}
{title:Options for export sasxport}

{dlgtab:Main}

{phang}
{opt rename} specifies that {cmd:export sasxport} may rename variables and
value
labels to meet the SAS XPORT restrictions, which are that names be no more
than eight characters long and that there be no distinction between uppercase
and lowercase letters.

{pmore}
    We recommend specifying the {opt rename} option.  If this option is
    specified, any name violating the restrictions is changed to a different
    but related name in the file.  The name changes are listed.  The new names
    are used only in the file; the names of the variables and value labels in
    memory remain unchanged.

{pmore}
If {opt rename} is not specified and one or more names violate the
XPORT restrictions, an error message will be issued and no file will be
saved.  The alternative to the {opt rename} option is that you can rename
variables yourself with the {helpb rename} command:

{pin2}{cmd:. rename mylongvariablename myname}

{pmore}
See {manhelp rename D}.  Renaming value labels yourself is more difficult.
The easiest way to rename value labels is to use {helpb label save}, edit the
resulting file to change the name, execute the file by using {helpb do}, and
reassign the new value label to the appropriate variables by using
{opt label values}:

{pin2}{cmd:. label save mylongvaluelabel using myfile.do}{p_end}
            {cmd:. doedit myfile.do}{right:(change mylongvaluelabel to, say, mlvlab)  }
{pin2}{cmd:. do myfile.do}{p_end}
{pin2}{cmd:. label values myvar mlvlab}{p_end}

{pmore}
See {manhelp label D} and {manhelp do R} for more information about renaming
value labels.

{phang}
{opt replace}
permits {cmd:export sasxport} to overwrite existing
{it:{help filename}}{opt .xpt},
{opt formats.xpf}, and {it:filename}{opt .sas} files.

{phang}
{cmd:vallabfile(xpf}|{cmd:sascode}|{cmd:both}|{cmd:none)}
specifies whether and how value labels are to be stored.  SAS XPORT
Transport files do not really have value labels.  Value-label definitions
can be preserved in one of two ways:

{phang2}
1.  In an additional SAS XPORT Transport file whose data contain the
value-label definitions

{phang2}
2.  In a SAS command file that will create the value labels

{pmore}
{cmd:export sasxport} can create either or both of these files.

{pmore}
{cmd:vallabfile(xpf)}, the default,
specifies that value labels be written into a separate SAS
XPORT Transport file named {opt formats.xpf}.  Thus {cmd:export sasxport}
creates two files:  {it:{help filename}}{opt .xpt}, containing the data,
and {opt formats.xpf}, containing the value labels.  No
{opt formats.xpf} file is created if there are no value labels.

{pmore}
	SAS users can easily use the resulting {opt .xpt} and {opt .xpf} XPORT
	files.  See
	{browse "http://www.sas.com/govedu/fda/macro.html"} for SAS-provided
	macros for reading the XPORT files.  The SAS macro {opt fromexp()}
	reads the XPORT files into SAS.  The SAS macro {opt toexp()} creates
	XPORT files.  When obtaining the macros, remember to save the macros
	at SAS's webpage as a plain-text file and to remove the examples at
	the bottom.

{pmore}
If the SAS macro file is saved as {cmd:C:\project\macros.mac}
and the files {opt mydat.xpt} and {opt formats.xpf} created by
{cmd:export sasxport} are in {cmd:C:\project\}, the following SAS commands
would create
the corresponding SAS dataset and format library and list the data:

		{c TLC}{hline 19} SAS commands {hline 20}{c TRC}
		{c |} {cmd:%include "C:\project\macros.mac" ;}{space 18}{c |}
		{c |} {cmd:%fromexp(C:\project, C:\project) ;}{space 18}{c |}
		{c |} {cmd:libname library 'C:\project' ;}{space 22}{c |}
		{c |} {cmd:data _null_ ; set library.mydat ; put _all_ ; run ;} {c |}
		{c |} {cmd:proc print data = library.mydat ;}{space 19}{c |}
		{c |} {cmd:quit ;}{space 46}{c |}
		{c BLC}{hline 53}{c BRC}

{pmore}
{cmd:vallabfile(sascode)}
specifies that the value labels be written into a SAS command
file, {it:filename}{opt .sas}, containing SAS {cmd:proc format} and
related commands.  Thus {cmd:export sasxport} creates two files:
{it:filename}{opt .xpt}, containing the data, and
{it:filename}{opt .sas}, containing the value labels.  SAS users may
wish to edit the resulting {it:filename}{opt .sas} file to change the
"libname datapath" and "libname xptfile xport" lines at the top to
correspond with the location that they desire.  {cmd:export sasxport} sets the
location to the current working directory at the time {cmd:export sasxport}
was issued.  No {opt .sas} file will be created if there are no value
labels.

{pmore}
{cmd:vallabfile(both)}
specifies that both the actions described above be taken and that three
files be created: {it:filename}{opt .xpt}, containing the data;
{opt formats.xpf}, containing the value labels in XPORT format;
and {it:filename}{opt .sas}, containing the value labels in SAS
command-file format.

{pmore}
{cmd:vallabfile(none)}
specifies that value-label definitions not be saved.  Only one
file is created: {it:filename}{opt .xpt}, which contains the data.


{marker remarks}{...}
{title:Remarks}

{p 4 4 2}
All users, of course, may use these commands to transfer data between SAS and
Stata, but there are limitations in the SAS
XPORT Transport format, such as the eight-character limit on the names of
variables (specifying {cmd:export sasxport}'s {opt rename} option works around
that).
For a complete listing of limitations and issues concerning the SAS XPORT
Transport format, and an explanation of how {cmd:export sasxport} and
{cmd:import sasxport}
work around these limitations, see
{mansection D importsasxportTechnicalappendix:{it:Technical appendix}} in 
{bind:{bf:[D] import sasxport}}.  You may find it more convenient to use
translation packages such
as Stat/Transfer; see
{browse "http://www.stata.com/products/transfer.html"}.

{pstd}
Remarks are presented under the following headings:

        {help import_sasxport##remarks1:Saving XPORT files for transferring to SAS}
        {help import_sasxport##remarks2:Determining contents of XPORT files received from SAS}
        {help import_sasxport##remarks3:Using XPORT files received from SAS}


{marker remarks1}{...}
{title:Saving XPORT files for transferring to SAS}

{pstd}
To save the current dataset in {cmd:mydata.xpt} and the value labels in
{cmd:formats.xpf}, type

	{cmd:. export sasxport mydata}

{pstd}
To save the data as above but automatically handle renaming variable names and
value labels that are too long or are case sensitive, type

	{cmd:. export sasxport mydata, rename}

{pstd}
To allow the replacement of any preexisting files, type

	{cmd:. export sasxport mydata, rename replace}

{pstd}
To save the current dataset in {cmd:mydata.xpt} and the value labels in SAS
command file {cmd:mydata.sas} and to automatically handle renaming variable
and value-label names:

	{cmd:. export sasxport mydata, rename vallab(sas)}

{pstd}
To save the data as above but save the value labels in both {cmd:formats.xpf}
and {cmd:mydata.sas}, type

	{cmd:. export sasxport mydata, rename vallab(both)}

{pstd}
To not save the value labels at all, thus creating only {cmd:mydata.xpt},
type

	{cmd:. export sasxport mydata, rename vallab(none)}


{marker remarks2}{...}
{title:Determining contents of XPORT files received from SAS}

{pstd}
To determine the contents of {cmd:testdata.xpt}, you might type

	{cmd:. import sasxport testdata, describe}


{marker remarks3}{...}
{title:Using XPORT files received from SAS}

{pstd}
To read data from {cmd:testdata.xpt} and obtain value labels from
{cmd:formats.xpf} (or {cmd:FORMATS.xpf}), if the file exists, you would type

	{cmd:. import sasxport testdata}

{pstd}
To read the data as above and discard any data in memory, type

	{cmd:. import sasxport testdata, clear}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:import sasxport, describe} saves the following in {cmd:r()}:

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Scalars}{p_end}
{synopt:{cmd:r(N)}}number of observations{p_end}
{synopt:{cmd:r(k)}}number of variables{p_end}
{synopt:{cmd:r(size)}}size of data{p_end}
{synopt:{cmd:r(n_members)}}number of members{p_end}

{p2col 5 20 24 2: Macros}{p_end}
{synopt:{cmd:r(members)}}names of members{p_end}
{p2colreset}{...}
