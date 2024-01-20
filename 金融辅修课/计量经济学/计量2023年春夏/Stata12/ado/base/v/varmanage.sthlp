{smcl}
{* *! version 1.0.4  11feb2011}{...}
{viewerdialog "Variables Manager" "stata varmanage"}{...}
{vieweralsosee "[D] varmanage" "mansection D varmanage"}{...}
{vieweralsosee "" "--"}{...}
{findalias asgsmvarman}{...}
{findalias asgsuvarman}{...}
{findalias asgswvarman}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[D] drop" "help drop"}{...}
{vieweralsosee "[D] edit" "help edit"}{...}
{vieweralsosee "[D] format" "help format"}{...}
{vieweralsosee "[D] label" "help label"}{...}
{vieweralsosee "[D] notes" "help notes"}{...}
{vieweralsosee "[D] rename" "help rename"}{...}
{viewerjumpto "Syntax" "varmanage##syntax"}{...}
{viewerjumpto "Description" "varmanage##description"}{...}
{viewerjumpto "Remarks" "varmanage##remarks"}{...}
{title:Title}

{p2colset 5 22 24 2}{...}
{p2col :{manlink D varmanage} {hline 2}}Manage variable labels, formats, and other properties{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 13 2}
{opt varm:anage}


{title:Menu}

{phang}
{bf:Data > Variables Manager}


{marker description}{...}
{title:Description}

{pstd} {cmd:varmanage} opens the Variables Manager.  The Variables Manager
allows for the sorting and filtering of variables for the purpose of 
setting properties on one or more variables at a time.  Variable properties
include the name, label, storage type, format, value label, and notes.  The
Variables Manager also can be used to create {varlist}s for the Command window.


{marker remarks}{...}
{title:Remarks}

{pstd}
A tutorial discussion of {cmd:varmanage} can be found in the 
{it:Getting Started with Stata} manual.
{p_end}
