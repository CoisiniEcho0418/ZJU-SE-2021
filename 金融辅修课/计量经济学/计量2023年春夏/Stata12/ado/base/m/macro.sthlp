{smcl}
{* *! version 1.1.4  03jun2011}{...}
{vieweralsosee "[P] macro" "mansection P macro"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[P] char" "help char"}{...}
{vieweralsosee "[P] creturn" "help creturn"}{...}
{vieweralsosee "[P] display" "help display"}{...}
{vieweralsosee "[D] functions" "help functions"}{...}
{vieweralsosee "[P] gettoken" "help gettoken"}{...}
{vieweralsosee "[P] macro lists" "help macrolists"}{...}
{vieweralsosee "[P] matrix" "help matrix"}{...}
{vieweralsosee "[P] numlist" "help nlist"}{...}
{vieweralsosee "[P] preserve" "help preserve"}{...}
{vieweralsosee "[P] program" "help program"}{...}
{vieweralsosee "[P] return" "help return"}{...}
{vieweralsosee "[P] scalar" "help scalar"}{...}
{vieweralsosee "[P] syntax" "help syntax"}{...}
{vieweralsosee "[P] tokenize" "help tokenize"}{...}
{viewerjumpto "Syntax" "macro##syntax"}{...}
{viewerjumpto "Description" "macro##description"}{...}
{title:Title}

{p2colset 5 18 20 2}{...}
{p2col :{manlink P macro} {hline 2}}Macro definition and manipulation{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 17 2}{cmdab:gl:obal}{space 3}{it:mname} {space 1} [{cmd:=}{it:{help exp}} |
		{cmd::}{it:{help extended_fcn}} |
		[{cmd:`}]{cmd:"}[{it:string}]{cmd:"}[{cmd:'}] ]

{p 8 17 2}{cmdab:loc:al}{space 4}{it:lclname} [{cmd:=}{it:{help exp}} |
		{cmd::}{it:{help extended_fcn}} |
		[{cmd:`}]{cmd:"}[{it:string}]{cmd:"}[{cmd:'}] ]

{p 8 17 2}{cmd:tempvar}{space 2}{it:lclname} [{it:lclname} [{it:...}]]

{p 8 17 2}{cmd:tempname} {it:lclname} [{it:lclname} [{it:...}]]

{p 8 17 2}{cmd:tempfile} {it:lclname} [{it:lclname} [{it:...}]]

{p 8 17 2}{cmdab:loc:al} {c -(} {cmd:++}{it:lclname} | {cmd:--}{it:lclname} {c )-}

{p 8 14 2}{cmdab:ma:cro} {cmdab:di:r}

{p 8 14 2}{cmdab:ma:cro} {cmd:drop} {c -(} {it:mname} [{it:mname} [{it:...}]] |
		{it:mname}{cmd:*} | {cmd:_all} {c )-}

{p 8 14 2}{cmdab:ma:cro} {cmdab:l:ist} [ {it:mname} [{it:mname} [{it:...}]] |
		{cmd:_all} ]

{p 8 14 2}{cmdab:ma:cro} {cmdab:s:hift} [{it:#}]

{p 8 14 2} [{it:...}] {cmd:`}{it:expansion_optr}{cmd:'} [{it:...}]


{pstd}
where {it:expansion_optr} is

{pmore}
{it:lclname}{break}
{cmd:++}{it:lclname}{break}
{it:lclname}{cmd:++}{break}
{cmd:--}{it:lclname}{break}
{it:lclname}{cmd:--}{break}
{cmd:=}{it:exp}{break}
{cmd::}{it:{help extended_fcn}}{break}
{cmd:.}{it:class_directive}{break}
{cmd:macval(}{it:lclname}{cmd:)}


{marker description}{...}
{title:Description}

{pstd}
{cmd:global} assigns strings to specified global macro names ({it:mnames}).
{cmd:local} assigns strings to local macro names ({it:lclnames}).  Both
double quotes ({cmd:"} and {cmd:"}) and compound double quotes 
({cmd:`"} and {cmd:"'}) are allowed; see {help quotes}.  If the {it:string}
has embedded quotes, compound double quotes are needed.

{pstd}
{cmd:tempvar} assigns names to the specified local macro names that may be
used as temporary variable names in a dataset.  When the program or do-file
concludes, any variables with these assigned names are dropped.

{pstd}
{cmd:tempname} assigns names to the specified local macro names that may be
used as temporary scalar or matrix names.  When the program or do-file
concludes, any scalars or matrices with these assigned names are dropped.

{pstd}
{cmd:tempfile} assigns names to the specified local macro names that may be
used as names for temporary files.  When the program or do-file concludes, any
datasets created with these assigned names are erased.

{pstd}
{cmd:macro} manipulates global and local macros.

{pstd}
The macro expansion operators {it:expansion_optr} are documented in
{manlink P macro} and {manlink P class}.  
{it:class_directive} is any reference to an ado-class member variable or
function; see {manlink P class} for more information on ado classes.
{p_end}
