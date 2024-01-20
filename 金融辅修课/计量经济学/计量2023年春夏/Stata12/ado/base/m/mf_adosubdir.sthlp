{smcl}
{* *! version 1.1.2  11feb2011}{...}
{vieweralsosee "[M-5] adosubdir()" "mansection M-5 adosubdir()"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-4] io" "help m4_io"}{...}
{viewerjumpto "Syntax" "mf_adosubdir##syntax"}{...}
{viewerjumpto "Description" "mf_adosubdir##description"}{...}
{viewerjumpto "Remarks" "mf_adosubdir##remarks"}{...}
{viewerjumpto "Conformability" "mf_adosubdir##conformability"}{...}
{viewerjumpto "Diagnostics" "mf_adosubdir##diagnostics"}{...}
{viewerjumpto "Source code" "mf_adosubdir##source"}{...}
{title:Title}

{phang}
{manlink M-5 adosubdir()} {hline 2} Determine ado-subdirectory for file


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:string scalar}{bind:   }
{cmd:adosubdir(}{it:string scalar {help filename}}{cmd:)}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:adosubdir(}{it:{help filename}}{cmd:)}
returns the subdirectory in which Stata would search for
{it:filename}.  Typically the subdirectory name will be simply
the first letter of {it:filename}.  However, certain files may
result in a different subdirectory, depending on their extension.


{marker remarks}{...}
{title:Remarks}

{p 4 4 2}
{cmd:adosubdir("xyz.ado")} returns "{cmd:x}" because Stata ado-files 
are located in subdirectories with name given by their first letter.

{p 4 4 2}
{cmd:adosubdir("xyz.style")} returns "{cmd:style}" because Stata 
style files are located in subdirectories named {cmd:style}.


{marker conformability}{...}
{title:Conformability}

{p 4 4 2}
    {cmd:adosubdir(}{it:filename}{cmd:)}:
{p_end}
	 {it:filename}:  1 {it:x} 1
	   {it:result}:  1 {it:x} 1


{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:adosubdir()} returns the first letter of the filename if the 
filetype is unknown to Stata, thus treating unknown filetypes 
as if they were ado-files.

{p 4 4 2}
{cmd:adosubdir()} aborts with error if the filename is too long
for the operating system; nothing else causes abort with error.


{marker source}{...}
{title:Source code}

{p 4 4 2}
Function is built in.
{p_end}
