{smcl}
{* *! version 1.1.1  11feb2011}{...}
{vieweralsosee "[M-5] dir()" "mansection M-5 dir()"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-4] io" "help m4_io"}{...}
{viewerjumpto "Syntax" "mf_dir##syntax"}{...}
{viewerjumpto "Description" "mf_dir##description"}{...}
{viewerjumpto "Remarks" "mf_dir##remarks"}{...}
{viewerjumpto "Conformability" "mf_dir##conformability"}{...}
{viewerjumpto "Diagnostics" "mf_dir##diagnostics"}{...}
{viewerjumpto "Source code" "mf_dir##source"}{...}
{title:Title}

{p 4 8 2}
{manlink M-5 dir()} {hline 2} File list


{marker syntax}{...}
{title:Syntax}

{p 8 8 2}
{it:string colvector}{bind:  }
{cmd:dir(}{it:dirname}{cmd:,}
{it:filetype}{cmd:,}
{it:pattern}{cmd:)}

{p 8 8 2}
{it:string colvector}{bind:  }
{cmd:dir(}{it:dirname}{cmd:,}
{it:filetype}{cmd:,}
{it:pattern}{cmd:,}
{it:prefix}{cmd:)}

{p 4 4 2}
where

	 {it:dirname}:  {it:string scalar} containing directory name

	{it:filetype}:  {it:string scalar} containing {cmd:"files"}, {cmd:"dirs"}, or {cmd:"other"}

	 {it:pattern}:  {it:string scalar} containing match pattern

	  {it:prefix}:  {it:real scalar}   containing 0 or 1


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:dir(}{it:dirname}{cmd:,} {it:filetype}{cmd:,} {it:pattern}{cmd:)}
returns a column vector containing the names of the files in {it:dir} 
that match {it:pattern}.

{p 4 4 2}
{cmd:dir(}{it:dirname}{cmd:,} {it:filetype}{cmd:,} {it:pattern}{cmd:,}
{it:prefix}{cmd:)} does the same thing but allows you to specify whether 
you want a simple list of files ({it:prefix}=0) or a list of filenames
prefixed with {it:dirname} ({it:prefix}!=0).  {cmd:dir(}{it:dirname}{cmd:,}
{it:filetype}{cmd:,} {it:pattern}{cmd:)} is equivalent to
{cmd:dir(}{it:dirname}{cmd:,} {it:filetype}{cmd:,} {it:pattern}{cmd:, 0)}.

{p 4 4 2}
{it:pattern} is interpreted by {bf:{help mf_strmatch:[M-5] strmatch()}}.


{marker remarks}{...}
{title:Remarks}

{p 4 4 2}
Examples:

{p 8 12 2}
{cmd:dir(".", "dirs", "*")}{break}
returns a list of all directories in the current directory.

{p 8 12 2}
{cmd:dir(".", "files", "*")}{break}
returns a list of all regular files in the current directory.

{p 8 12 2}
{cmd:dir(".", "files", "*.sthlp")}{break}
returns a list of all {cmd:*.sthlp} files 
found in the current directory.


{marker conformability}{...}
{title:Conformability}

    {cmd:dir(}{it:dirname}{cmd:,} {it:filetype}{cmd:,} {it:pattern}{cmd:,} {it:prefix}{cmd:)}:
	  {it:dirname}:  1 {it:x} 1
	 {it:filetype}:  1 {it:x} 1
	  {it:pattern}:  1 {it:x} 1
	   {it:prefix}:  1 {it:x} 1    (optional)
	   {it:result}:  {it:k x} 1, {it:k} number of files matching pattern


{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:dir(}{it:dirname}{cmd:,} {it:filetype}{cmd:,} {it:pattern}{cmd:,}
{it:prefix}{cmd:)} returns {cmd:J(0,1,"")} if 

{p 8 12 2}
1.  no files matching {it:pattern} are found,

{p 8 12 2}
2.  directory {it:dirname} does not exist, or

{p 8 12 2}
3.  {it:filetype} is misspecified (is not equal to {cmd:"files"},
    {cmd:"dirs"}, or {cmd:"others"}).

{p 4 4 2}
{it:dirname} may be specified with or without the directory separator on 
the end.  

{p 4 4 2}
{it:dirname} = {cmd:""} is interpreted the same as {it:dirname} = {cmd:"."};
the current directory is searched.


{marker source}{...}
{title:Source code}

{p 4 4 2}
Function is built in.
{p_end}
