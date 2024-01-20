{smcl}
{* *! version 1.0.8  27jun2011}{...}
{vieweralsosee "[P] dialog programming" "help dialog_programming"}{...}
{viewerjumpto "Syntax" "window programming##syntax"}{...}
{viewerjumpto "Description" "window programming##description"}{...}
{viewerjumpto "Remarks" "window programming##remarks"}{...}
{title:Title}

{p2colset 5 31 33 2}{...}
{p2col :{manlink P window programming} {hline 2}}Programming menus and windows{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p2colset 5 35 37 2}{...}
{p2col :{helpb window fopen} ...}Display open dialog box{p_end}
{p2col :{helpb window fsave} ...}Display save dialog box{p_end}
{p2col :{helpb window manage} {it:subcmd} ...}Manage window characteristics{p_end}
{p2col :{helpb window menu} {it:subcmd} ...}Create menus{p_end}
{p2col :{helpb window push} "{it:command_line}"}Copy command into Review window{p_end}
{p2col :{helpb window stopbox} {it:subcmd} ...}Display message box{p_end}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
The {cmd:window} command lets you open, close, and manage the windows in
Stata's interface.  Using the subcommands of {bind:{cmd:window menu}}, you
can also add and delete menu items from the {hi:User} menu from Stata's main
menu bar.  {bind:{cmd:window push}} adds "{it:command_line}" to the Review
window.


{marker remarks}{...}
{title:Remarks}

{pstd}
Complete documentation for programming windows and menus is provided in the
online help.

{pstd}
For documentation on creating dialog boxes, see
{manhelp dialog_programming P:dialog programming}.
{p_end}
