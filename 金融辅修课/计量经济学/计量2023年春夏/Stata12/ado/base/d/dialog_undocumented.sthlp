{smcl}
{* *! version 1.0.11  11feb2011}{...}
{vieweralsosee undocumented "help undocumented"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[P] dialog programming" "help dialog_programming"}{...}
{viewerjumpto "Built-in member functions for dialog boxes" "dialog_undocumented##dialog_boxes"}{...}
{viewerjumpto "Built-in member functions for dialogs" "dialog_undocumented##dialogs"}{...}
{viewerjumpto "Properties" "dialog_undocumented##properties"}{...}
{viewerjumpto "Miscellaneous dialog tools" "dialog_undocumented##misc"}{...}
{title:Title}

{p2colset 5 31 33 2}{...}
{p2col:{hi:[P] dialog programming} {hline 2}}Dialog programming{p_end}
{p2colreset}{...}


{marker dialog_boxes}{...}
{title:Built-in member functions for dialog boxes}

{pstd}
The built-in functions below operate on a dialog resource, otherwise
known as a dialog box.

{pstd}
The built-in functions are

{phang}
{cmd:.Submit}{break}
	Causes the dialog box to submit its current command string to Stata.
	This is equivalent to clicking on the {hi:Submit} button in the dialog
        box.

{phang}
{cmd:.GetSubmit}{break}
	Causes the dialog box to process the u-action associated with
	the {hi:Submit} button and display the contents of the command string.
	Alternatively, the name of a previously declared {cmd:STRING} property
	can be supplied to receive the contents of the command string.
	
{phang}
{cmd:.Ok}{break}
	Causes the dialog box to submit its current command string to Stata and
	close.  This is equivalent to clicking on the {hi:Ok} button in the
        dialog box.  

{phang}
{cmd:.Reset}{break}
	Causes the dialog box to reset.  This is equivalent to clicking on the 
	{hi:(R)} button in the dialog box.
	
{phang}
{cmd:.Cancel}{break}
	Causes the dialog box to close.  This is equivalent to clicking on the 
	{hi:Cancel} button in the dialog box.
	
{phang}
{cmd:.Execute} {it:executionstring}{break}
	Causes the dialog box to execute some task named specified by 
	{it:executionstring}.  Usually this is a {cmd:script}
	or {cmd:program} defined in the dialog box.
	
{p 8 8 2}
	{hi:Example:}
	
{p 12 12 2}	
	{it:dlgresource}{cmd:.Execute "program main_hide_controls"}

{phang}
{cmd:.SaveState}{break}
	Causes the dialog box to save its current state.  This
	happens automatically when the {hi:Submit} or {hi:OK} button is
        clicked in the dialog box.

	
{marker dialogs}{...}
{title:Built-in member functions for dialogs}

{pstd}
The built-in functions below operate on dialogs, otherwise
known as dialog tabs.

{pstd}
The built-in functions are

{phang}
{cmd:.setactive}{break}
	Causes a tab to become active.  This is equivalent to clicking on
	the button associated with a dialog tab.

	
{marker properties}{...}
{title:Properties}

{pstd}
{opt SVECTOR} is a vector property that can store up to 1000 string values.

{phang}
Member functions:

{p2colset 8 32 34 2}{...}
{p2col :type}member functions{p_end}
{p2line}
{p2col :{opt SVECTOR}}{it:propertyname}{opt .dropall}{p_end}
{p2col :}{it:propertyname}{opt .copyFromArray} {it:classArrayName}{p_end}
{p2col :}{it:propertyname}{opt .copyToArray} {it:classArrayName}{p_end}
{p2col :}{it:propertyname}{opt .copyToString} {it:stringPropertyName}{p_end}
{p2col :}{it:propertyname}{opt .findstr} {it:{help dialogs##specialdefs.:strvalue}}{p_end}
{p2col :}{it:propertyname}{opt .store} {it:#} {it:{help dialogs##specialdefs.:strvalue}}{p_end}
{p2col :}{it:propertyname}{opt .swap} {it:#} {it:#}{p_end}
{p2line}
{p 7 14 2}Note:  {it:propertyname}{opt .findstr} sets the {opt position} data 
member to the index of the first matching {it:{help dialogs##specialdefs.:strvalue}}, 
or 0 if the {it:{help dialogs##specialdefs.:strvalue}} is not found. 
{p2colreset}{...}


{marker misc}{...}
{title:Miscellaneous dialog tools}

{phang}
{cmd:_dialog discard [{it:objectname}]}{break}
	Causes the dialog specified by {it:dlgname} and all of its class system
	objects	to be destroyed.  If a {it:dlgname} is not specified, all 
	dialogs and their class system objects will be destroyed.
{p_end}
