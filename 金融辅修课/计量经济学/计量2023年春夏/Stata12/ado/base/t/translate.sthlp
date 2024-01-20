{smcl}
{* *! version 1.1.9  21apr2011}{...}
{vieweralsosee "[R] translate" "mansection R translate"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] log" "help log"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[G-2] graph export" "help graph_export"}{...}
{vieweralsosee "[G-2] graph print" "help graph_print"}{...}
{vieweralsosee "[G-2] graph set" "help graph_set"}{...}
{vieweralsosee "[P] smcl" "help smcl"}{...}
{viewerjumpto "Syntax" "translate##syntax"}{...}
{viewerjumpto "Description" "translate##description"}{...}
{viewerjumpto "Options for print" "translate##options_print"}{...}
{viewerjumpto "Options for translate" "translate##options_translate"}{...}
{viewerjumpto "Technical note for Unix(GUI) users" "translate##technote"}{...}
{viewerjumpto "Examples" "translate##examples"}{...}
{viewerjumpto "Saved results" "translate##saved_results"}{...}
{title:Title}

{p2colset 5 22 24 2}{...}
{p2col :{manlink R translate} {hline 2}}Print and translate logs{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{pstd}
Print log and SMCL files

{p 8 18 2}
{cmd:print} {it:{help filename}}
	    [{cmd:,}
	     {opt like(ext)}
	     {opt name(windowname)}
	     {it:override_options}]


{pstd}
Translate log files to SMCL files and vice versa

{p 8 18 2}
{cmd:translate} {it:{help filename:filename_in}}
		{it:{help filename:filename_out}}
		[{cmd:,} {opt t:ranslator(tname)}
			 {opt name(windowname)}
			 {it:override_options}
			 {opt replace}]


{pstd}
View translator parameter settings

{p 8 19 2}
{cmd:translator} {opt q:uery} [{it:tname}]


{pstd}
Change translator parameter settings

{p 8 19 2}
{cmd:translator} {opt set} [{it:tname} {it:setopt} {it:setval}]


{pstd}
Return translator parameter settings to default values

{p 8 19 2}
{cmd:translator} {opt reset} {it:tname}


{pstd}
List current mappings from one extension to another

{p 8 17 2}
{cmd:transmap} {opt q:uery} [{cmd:.}{it:ext}]


{pstd}
Specify that files with one extension be treated the same as files with
another extension

{p 8 17 2}
{cmd:transmap} {opt def:ine} {cmd:.}{it:ext_new} {cmd:.}{it:ext_old}


{phang}
{it:filename} in {opt print}, in addition to being a filename to be printed, may
   be specified as {cmd:@Results} to mean the Results window and {cmd:@Viewer} to
   mean the Viewer window.

{phang}
{it:filename_in} in {opt translate} may be specified just as {it:filename} in
   {opt print}.

{phang}
{it:tname} in {opt translator} specifies the name of a translator;
   see the {bf:{help translate##translator:translator()}} option under
   {it:Options for translate}.


{marker description}{...}
{title:Description}

{pstd}
{opt print} prints log, SMCL, and text files.  Although there is considerable
flexibility in how {opt print} (and {opt translate}, which {opt print} uses)
can be set to work, they have already been set up and should just work:

{pin}
{cmd:. print mylog.smcl}{break}
{cmd:. print mylog.log}

{pstd}
Unix users may discover that they need to do a bit of setup before {opt print}
works; see
{mansection R translateRemarksPrintingfiles,Unix:{it:Printing files, Unix}}
in {bf:[R] translate}.
International Unix users may also wish to modify the default paper size.
All users can tailor {opt print} and {opt translate} to their needs.

{pstd}
{opt print} may also be used to print the current contents of the Results
window or the Viewer.  For instance, the current contents of the Results
window could be printed by typing

{pin}
{cmd:. print @Results}

{pstd}
{opt translate} translates log and SMCL files from one format to another, the
other typically being suitable for printing.
{opt translate} can also translate SMCL logs (logs created by typing, say,
{cmd:log using mylog}) to ASCII text:

{phang2}
{cmd:. translate mylog.smcl mylog.log}

{pstd}
You can use {opt translate} to recover a log when you have forgotten to start
one.  You may type

{phang2}
{cmd:. translate @Results mylog.txt}

{pstd}
to capture as ASCII text what is currently shown in the Results window.

{pstd}
This entry provides a general overview of {opt print} and {opt translate} and
covers in detail the printing and translation of text (nongraphic) files.

{pstd}
{cmd:translator query}, {cmd:translator set}, and {cmd:translator reset} show,
change, and restore the default values of the settings for each translator.

{pstd}
{cmd:transmap define} and {cmd:transmap query} create and show mappings from
one file extension to another for use with {cmd:print} and {cmd:translate}.

{pstd}
For example, {cmd:print myfile.txt} knows to use a translator appropriate for
printing text files because of the {cmd:.txt} extension.  However, it does not
know what to do with {cmd:.xyz} files.  If you have {cmd:.xyz} files and always
wish to treat them as {cmd:.txt} files, you can type
{cmd:transmap define .xyz .txt}.


{marker options_print}{...}
{title:Options for print}

{phang}
{opt like(ext)} specifies how the file should be translated to a form suitable
for printing.  The default is to determine the translation method from the
extension of {it:{help filename}}.  Thus {cmd:mylog.smcl} is translated
according to the rule for translating {opt smcl} files, {cmd:myfile.txt} is
translated according to the rule for translating {opt txt} files, and so on.
(These rules are, in fact, {opt translate}'s {opt smcl2prn} and {opt txt2prn}
translators, but put that aside for the moment.)

{pmore}
Rules for the following extensions are predefined:

{synoptset 13}{...}
{synopt:{space 8}{opt .txt}}
assume input file contains ASCII text{p_end}
{synopt:{space 8}{opt .log}}
assume input file contains Stata log ASCII text{p_end}
{synopt:{space 8}{opt .smcl}}
assume input file contains SMCL{p_end}
{p2colreset}{...}

{pmore}
To print a file that has an extension different from those listed above, you
can define a new extension, but you do not have to do that.  Assume that you
wish to print the file {cmd:read.me}, which you know to contain ASCII text.
If you were just to type {cmd:print read.me}, you would be told that Stata
cannot translate {cmd:.me} files.  (You would actually be told that the
translator for {opt me2prn} was not found.)  You could type
{cmd:print read.me, like(txt)} to tell {opt print} to print {cmd:read.me} like
a {cmd:.txt} file.  

{pmore}
On the other hand, you could type

{pin2}
{cmd:.transmap define .me .txt}

{pmore}
to tell Stata that {cmd:.me} files are always to be treated like {cmd:.txt}
files.  If you did that, Stata would remember the new rule, even in future
sessions. 

{pmore}
When you specify the {opt like()} option, you override the recorded rules.  So,
if you were to type {cmd:print mylog.smcl, like(txt)}, the file would be
printed as ASCII text (meaning that all the SMCL commands would show).

{phang}
{opt name(windowname)} specifies which window to print when printing a Viewer.
The default is for Stata to print the topmost Viewer [Unix(GUI) users: See
the {help translate##technote:technical note} below].
The {opt name()} option is ignored with printing the Results window.

{pmore}
The window name is located inside the parentheses in the window title.  For
example, if the title for a Viewer window is "Viewer (#1) [help print]",
the name for the window is {opt #1}.

{phang}
{it:override_options} refers to {opt translate}'s options for overriding
default values.  {opt print} uses {opt translate} to translate the file into a
format suitable for sending to the printer, and thus {cmd:translate}'s
{it:override_options} may also be used with {cmd:print}.  The settings
available vary between each translator (for example, {cmd:smcl2ps} will have
different settings than {cmd:smcl2txt}) and may also differ across operating
systems (for example, Windows may have different printing options than
Mac OS X).  To find out what you can override when printing {cmd:.smcl} files,
type

{pin2}
{cmd:. translator query smcl2prn}{break}

{pmore}
In the omitted output, you might learn that there is an {opt rmargin} {it:#}
tunable value, which specifies the right margin in inches.  You could specify
the {it:override_option} {opt rmargin(#)} to temporarily override the default
value, or you could type {bind:{cmd:translator set smcl2prn rmargin} {it:#}}
beforehand to permanently reset the value.

{pmore}
Alternatively, on some computers with some translators, you might discover
that nothing can be set.


{marker options_translate}{...}
{marker translator}{...}
{title:Options for translate}

{phang}
{opt translator(tname)} specifies the name of the translator to
be used to translate the file.  The available translators are

{center:{c TLC}{hline 13}{c TT}{hline 22}{c TT}{hline 24}{c TRC}}
{center:{c |} {it:tname}       {c |} Input                {c |} Output{space 16} {c |}}
{center:{c LT}{hline 13}{c +}{hline 22}{c +}{hline 24}{c RT}}
{center:{c |} {cmd:smcl2ps}     {c |} SMCL                 {c |} PostScript             {c |}}
{center:{c |} {cmd:log2ps}      {c |} Stata ASCII text log {c |} PostScript             {c |}}
{center:{c |} {cmd:txt2ps}      {c |} generic ASCII text   {c |} PostScript             {c |}}
{center:{c |} {cmd:Viewer2ps}   {c |} Viewer window        {c |} PostScript             {c |}}
{center:{c |} {cmd:Results2ps}  {c |} Results window       {c |} PostScript             {c |}}
{center:{c LT}{hline 13}{c +}{hline 22}{c +}{hline 24}{c RT}}
{center:{c |} {cmd:smcl2prn}    {c |} SMCL                 {c |} default printer format {c |}}
{center:{c |} {cmd:log2prn}     {c |} Stata ASCII text log {c |} default printer format {c |}}
{center:{c |} {cmd:txt2prn}     {c |} generic ASCII text   {c |} default printer format {c |}}
{center:{c |} {cmd:Results2prn} {c |} Results window       {c |} default printer format {c |}}
{center:{c |} {cmd:Viewer2prn}  {c |} Viewer window        {c |} default printer format {c |}}
{center:{c LT}{hline 13}{c +}{hline 22}{c +}{hline 24}{c RT}}
{center:{c |} {cmd:smcl2txt}    {c |} SMCL                 {c |} generic ASCII text log {c |}}
{center:{c |} {cmd:smcl2log}    {c |} SMCL                 {c |} Stata ASCII text log   {c |}}
{center:{c |} {cmd:Results2txt} {c |} Results window       {c |} generic ASCII text     {c |}}
{center:{c |} {cmd:Viewer2txt}  {c |} Viewer window        {c |} generic ASCII text     {c |}}
{center:{c LT}{hline 13}{c +}{hline 22}{c +}{hline 24}{c RT}}
{center:{c |} {cmd:smcl2pdf}    {c |} SMCL                 {c |} PDF                    {c |}}
{center:{c |} {cmd:log2pdf}     {c |} Stata ASCII text log {c |} PDF                    {c |}}
{center:{c |} {cmd:txt2pdf}     {c |} generic ASCII text   {c |} PDF                    {c |}}
{center:{c |} {cmd:Results2pdf} {c |} Results window       {c |} PDF                    {c |}}
{center:{c |} {cmd:Viewer2pdf}  {c |} Viewer window        {c |} PDF                    {c |}}
{center:{c BLC}{hline 13}{c BT}{hline 22}{c BT}{hline 24}{c BRC}}

{pmore}
    If {opt translator()} is not specified, {opt translate} determines which
    translator to use from extensions of the filenames specified.  
    Typing {cmd:translate myfile.smcl myfile.ps} would use the {opt smcl2ps}
    translator.  Typing {cmd:translate myfile.smcl myfile.ps, translate(smcl2prn)}
    would override the default and use the {opt smcl2prn} translator.

{pmore}
    Actually, when you type {cmd:translate} {it:a}{cmd:.}{it:b} {it:c}{cmd:.}{it:d},
    {opt translate} looks up {cmd:.}{it:b} in the {opt transmap} extension
    synonym table.  If {cmd:.}{it:b} is not found, the translator
    {it:b}{cmd:2}{it:d} is used.  If {cmd:.}{it:b} is found in the table,
    the mapped extension is used (call it {it:b'}), and then the translator
    {it:b'}{cmd:2}{it:d} is used.  For example,

{synoptset 43}{...}
{synopt:{space 8}Command}Translator used{p_end}
{space 8}{synoptline}
{synopt:{space 8}{cmd:. translate myfile.smcl myfile.ps}}{opt smcl2ps}{p_end}

{synopt:{space 8}{cmd:. translate myfile.odd myfile.ps}}{opt odd2ps}, which does not
exist, so error{p_end}

{synopt:{space 8}{cmd:. transmap define .odd .txt}}{p_end}
{synopt:{space 8}{cmd:. translate myfile.odd myfile.ps}}{opt txt2ps}{p_end}
{space 8}{synoptline}
{p2colreset}{...}

{pmore}
   You can list the mappings that {opt translate} uses by typing {cmd:transmap query}.

{phang}
{opt name(windowname)} specifies which window to translate when translating a
   Viewer.  The default is for Stata to translate the topmost Viewer.  The
   {opt name()} option is ignored when translating the Results window.

{pmore}
   The window name is located inside the parentheses in the window title.  For
   example, if the title for a Viewer window is "Viewer (#1) [help print]",
   the name for the window is {opt #1}.

{phang}
{it:override_options} override any of the default options of the
    specified or implied translator.  To find out what what you can override for,
    say, {cmd:log2ps}, type

{pin2}{cmd:. translator query log2ps}

{pmore}
    In the omitted output, you might learn that there is an {cmd:rmargin} {it:#}
    tunable value, which, for {opt log2ps}, specifies the right
    margin in inches.  You could specify the {it:override_option}
    {opt rmargin(#)} to temporarily override the default value or
    type {bind:{cmd:translator set log2ps rmargin} {it:#}} beforehand to
    permanently reset the value.

{phang}
{opt replace} specifies that {it:{help filename:filename_out}} be replaced if
it already exists.


{marker technote}{...}
{title:Technical note for Unix(GUI) users}

{pstd}
Unix(GUI) users should note that X-Windows does not have a concept of a window
z-order, which prevents Stata from determining which is the topmost
window.  Instead, Stata determines which window is topmost based on which
window has the focus.  However, some window managers will set the focus to a
window without bringing the window to the top.  What Stata considers the
topmost window may not appear topmost visually.  For this reason, you should
always use the {cmd:name()} option to ensure that the correct window is
printed.


{marker examples}{...}
{title:Examples}

{pstd}Translate SMCL log into ASCII text log{p_end}
{phang2}{cmd:. translate mylog.smcl mylog.log}

{pstd}Same as above, but replace {cmd:mylog.log} if it already exists{p_end}
{phang2}{cmd:. translate mylog.smcl mylog.log, replace}

{pstd}Put output from Results window into ASCII{p_end}
{phang2}{cmd:. translate @Results mylog.txt}

{pstd}Translate SMCL log into PostScript file{p_end}
{phang2}{cmd:. translate mylog.smcl mylog.ps}

{pstd}Same as above, but use translator {cmd:txt2ps} and replace
{cmd:mylog.ps} if it already exists{p_end}
{phang2}{cmd:. translate read.me mylog.ps, trans(txt2ps) replace}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:transmap query} .{it:ext} saves in macro {cmd:r(suffix)} the mapped
extension (without the leading period) or saves {it:ext} if the {it:ext} is
not mapped.

{pstd}
{cmd:translator query} {it:translatorname} saves {it:setval} in macro
{cmd:r({it:setopt})} for every {it:setopt}, {it:setval} pair.

{pstd}
{cmd:printer query} {it:printername} (Unix only) saves in macro
{cmd:r(suffix)} the "filetype" of the input that the printer expects
(currently "{cmd:ps}" or "{cmd:txt}") and, in macro {cmd:r(command)}, the
command to send output to the printer.
{p_end}
