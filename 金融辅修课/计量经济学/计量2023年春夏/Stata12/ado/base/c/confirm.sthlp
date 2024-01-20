{smcl}
{* *! version 1.1.4  02may2011}{...}
{vieweralsosee "[P] confirm" "mansection P confirm"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[P] capture" "help capture"}{...}
{viewerjumpto "Syntax" "confirm##syntax"}{...}
{viewerjumpto "Description" "confirm##description"}{...}
{viewerjumpto "Option" "confirm##option"}{...}
{viewerjumpto "Examples" "confirm##examples"}{...}
{title:Title}

{p2colset 5 20 22 2}{...}
{p2col :{manlink P confirm} {hline 2}}Argument verification{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 25 2}{cmdab:conf:irm} {cmdab:e:xistence} {it:string}

{p 8 25 2}{cmdab:conf:irm} [{cmd:new}] {cmdab:f:ile} {it:{help filename}}

{p 8 25 2}{cmdab:conf:irm} [ {cmd:numeric} | {cmdab:str:ing} | {cmd:date} ]
{cmdab:fo:rmat} {it:string}

{p 8 25 2}{cmdab:conf:irm} {cmdab:name:s} {it:names}

{p 8 25 2}{cmdab:conf:irm} [{cmd:integer}] {cmdab:n:umber} {it:string}

{p 8 25 2}{cmdab:conf:irm} {cmdab:mat:rix} {it:string}

{p 8 25 2}{cmdab:conf:irm} {cmdab:sca:lar} {it:string}

{p 8 25 2}{cmdab:conf:irm} [ {cmd:new} | {cmd:numeric} | {cmdab:str:ing} |
{it:{help data_type:type}} ] {cmdab:v:ariable} {varlist} [{cmd:,} {opt ex:act}]

{p 4 25 2}where {it:type} is {c -(} {cmd:byte} | {cmd:int} | {cmd:long} |
{cmd:float} | {cmd:double} | {cmd:str}{it:#} {c )-}


{marker description}{...}
{title:Description}

{pstd}
{cmd:confirm} verifies that the arguments following {cmd:confirm ...} are of
the claimed type and issues the appropriate error message and nonzero return
code if they are not.

{pstd}
{cmd:confirm} is useful in do-files and programs when you do not want to bother issuing your own error message.  {cmd:confirm} can also be combined with 
{cmd:capture} to detect and handle error conditions before they arise; see 
{helpb capture:[P] capture}.

{pstd}
See {manlink P confirm} for a complete description of this command.


{marker option}{...}
{title:Option}

{phang}
{opt exact} specifies that a match be declared only if the names specified in
{varlist} match. By default, names that are abbreviations of variables
are considered to be a match.


{marker examples}{...}
{title:Examples}

{pstd}{cmd:. confirm file `"c:\data\mydata.dta"'}

{pstd}{cmd:. confirm numeric variable price trunk rep78}

{pstd}You are writing a command that performs some action on each of the
variables in the local macro {it:varlist}.  The action should be different
for string and numeric variables.  The {cmd:confirm} command can be used
here in combination with the {helpb capture} command to switch between the
different actions:

	{cmd:foreach v of local {it:varlist} {c -(}}
		{cmd:capture confirm string variable `v'}
		{cmd:if !_rc {c -(}}
			{it:action for string variables}
		{cmd:{c )-}}
		{cmd:else {c -(}}
			{it:action for numeric variables}
		{cmd:{c )-}}
	{cmd:{c )-}}

{pstd}An alternative solution using inline expansion of the extended macro
function {cmd::type} (see {help local}) reads

	{cmd:foreach v of local varlist {c -(}}
		{cmd:if substr("`:type `v''",1,3) == "str" {c -(}}
			{it:action for string variables}
		{cmd:{c )-}}
		{cmd:else {c -(}}
			{it:action for numeric variables}
		{cmd:{c )-}}
	{cmd:{c )-}}
