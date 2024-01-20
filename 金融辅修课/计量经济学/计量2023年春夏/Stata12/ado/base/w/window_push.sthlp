{smcl}
{* *! version 1.0.7  11feb2011}{...}
{vieweralsosee "[R] #review" "help review"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[P] window programming" "help window_programming"}{...}
{viewerjumpto "Syntax" "window_push##syntax"}{...}
{viewerjumpto "Description" "window_push##description"}{...}
{viewerjumpto "Remarks" "window_push##remarks"}{...}
{title:Title}

{p2colset 5 20 22 2}{...}
{p2col :{hi:window push} {hline 2}}Copy command into Review window{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 18 2}
{opt win:dow} {opt push} {it:command-line}


{marker description}{...}
{title:Description}

{pstd}
{cmd:window} {cmd:push} copies the specified {it:command-line} onto the
end of the command history.  {it:command-line} will appear as the most
recent command in the {cmd:#review} list and will appear as the last command
in the Review window.


{marker remarks}{...}
{title:Remarks}

{pstd}
{cmd:window} {cmd:push} is useful when one Stata command creates another Stata
command and executes it.  Normally, commands inside ado-files are not added to
the command history, but an ado-file such as a dialog interface to a Stata
command might exist solely to create and execute another Stata command.

{pstd}
{cmd:window} {cmd:push} allows the interface to add the created command to the
command history (and therefore to the Review window) after executing the
command.

     {hline 50} begin example.do {hline 4}
     {cmd}program example
         version 12
         display "This display command is not added to the command history"
         display "This display command is added to the command history"
         window push display "This display command is added to the command /*
             */ history"
     end{txt}
     {hline 50} end example.do {hline 6}

     {cmd}. example
     This display command is not added to the command history
     This display command is added to the command history

     . #review
     3
     2 example
     1 display "This display command is added to the command history"

     .{txt}
